package smda.services;

import smda.models.Analysis;
import smda.models.MeasurementList;

/**
 * Created by Denis on 14.08.2016.
 */
public class Interpolator {
    //public enum InterpolationMethod{linear, lagrange}

    public static void interpolate(MeasurementList measurementList){
        for(Analysis.Parameter p : measurementList.getConsiderable()){
            System.out.print("Interpolating "+p+" ... ");
            boolean success = interpolate(measurementList, p);
            if(success){
                System.out.println("OK");
            }
            else{
                System.out.println("NO");
                measurementList.exclude(p);
            }

        }
    }

    public static boolean interpolate(MeasurementList measurementList, Analysis.Parameter parameter){
        Float[] p = measurementList.getArray(parameter);
        if(p != null && linear(p)){
            measurementList.setArray(p, parameter);
            return true;
        }
        return false;
    }

    public static boolean linear(Float[] arr){
        for(int i=0; i<arr.length; ++i){
            if(arr[i] == null){
                int j = i+1;
                while(j<arr.length && arr[j] == null){
                    ++j;
                }
                if(j == arr.length){
                    if(i == 0){
                        System.err.println("EMPTY PARAMETER - CAN'T INTERPOLATE");
                        return false;
                    }
                    else{
                        arr[i] = arr[i-1];
                    }
                }
                else{
                    if(i == 0){
                        arr[i] = arr[j];
                    }
                    else{
                        arr[i] = (arr[i-1]+arr[j])/2;
                    }
                }
            }
        }
        return true;
    }
}
