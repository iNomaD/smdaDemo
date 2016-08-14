package smda.models;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;

/**
 * Created by Denis on 14.08.2016.
 */
public class MeasurementList extends ArrayList<Analysis>{
    // маска (какие параметры учитывать)
    //private byte mask = 0x00;

    public boolean add(Analysis item){
        return add(item, true);
    }

    public boolean add(Analysis item, boolean sort){
        boolean result = super.add(item);
        if(sort){
            Collections.sort(this);
        }
        return result;
    }

    public Date[] getArrayDate(){
        Date[] result = new Date[size()];
        for(int i=0; i<size(); ++i){
            result[i] = get(i).getDate();
        }
        return result;
    }

    public Float[] getArray(Analysis.Parameter parameter){
        Float[] result = new Float[size()];
        for(int i=0; i<size(); ++i){
            result[i] = get(i).getParameter(parameter);
        }
        return result;
    }

    public boolean setArray(Float[] array, Analysis.Parameter parameter){
        for(int i=0; i<size(); ++i){
            get(i).setParameter(parameter, array[i]);
        }
        return true;
    }
}
