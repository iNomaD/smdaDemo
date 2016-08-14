package smda.models;

import smda.Properties;

import java.util.Date;

/**
 * Created by Denis on 14.08.2016.
 */
public class Interval extends MeasurementList {
    private Float mF = null;
    private static float a = Properties.correlation_significance;

    public Float calculateF() {
        int size = size();
        Analysis.Parameter[] p = Analysis.Parameter.values();
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
