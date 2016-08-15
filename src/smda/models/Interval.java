package smda.models;

import smda.Properties;

import java.util.Date;
import java.util.Set;

/**
 * Created by Denis on 14.08.2016.
 */
public class Interval extends MeasurementList {
    private Float mF = null;
    private static float a = Properties.correlation_significance;

    public Interval(Set<Analysis.Parameter> params){
        super();
        considerable = params;
    }

    public Float calculateF() {
        if(considerable.size() < 2){
            //can't calculate F with less then 2 parameters
            return null;
        }

        int size = size();
        Analysis.Parameter[] p = considerable.toArray(new Analysis.Parameter[considerable.size()]);
        int nParams = p.length;

        float[][] matrix = new float[size][nParams];
        for(int i=0; i<size; ++i){
            for(int j=0; j<nParams; ++j){
                Float value = get(i).getParameter(p[j]);
                if(value == null){
                    System.err.println("Can't calculate F for null parameter "+p[j]);
                    return null;
                }
                matrix[i][j] = value;
            }
        }

        mF = 0f;
        for (int i = 0; i < nParams; ++i) {
            for (int j = 0; j < i; ++j) {
                Float corMat_ij = correlation(matrix, i, j);
                if (corMat_ij != null) {
                    mF += (corMat_ij) - a;
                }
                else { // if equal parameters
                    mF += 1 - a;
                }
            }
        }
        mF = Math.abs(mF);
        return mF;
    }

    private Float correlation(float[][] matrix, int a, int b) {
        int n = matrix.length;
        float x_mean = 0, y_mean = 0;
        float sum_xx = 0, sum_yy = 0, sum_xy = 0;
        for (int i = 0; i < n; ++i) {
            x_mean += matrix[i][a];
            y_mean += matrix[i][b];
        }
        x_mean /= n;
        y_mean /= n;
        for (int i = 0; i < n; ++i) {
            sum_xy += (matrix[i][a] - x_mean) * (matrix[i][b] - y_mean);
            sum_xx += (matrix[i][a] - x_mean) * (matrix[i][a] - x_mean);
            sum_yy += (matrix[i][b] - y_mean) * (matrix[i][b] - y_mean);
        }
        if (sum_xx * sum_yy == 0) {
            return null;
        } else {
            return sum_xy / (float) Math.sqrt(sum_xx * sum_yy);
        }
    }

    public float getF() {
        return mF;
    }

    public Date getIntervalDate(){
        return size()>0 ? get(size()-1).getDate() : null;
    }
}
