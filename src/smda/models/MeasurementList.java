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

    public MeasurementList(){
        super();
    }

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
            switch(parameter){
                case hct:
                    result[i] = get(i).getHct();
                    break;
                case hgb:
                    result[i] = get(i).getHgb();
                    break;
                case wbc:
                    result[i] = get(i).getWbc();
                    break;
                case limpho_perc:
                    result[i] = get(i).getLimpho_perc();
                    break;
                case neutrophil_perc:
                    result[i] = get(i).getNeutrophil_perc();
                    break;
                case neutrophil_stick_perc:
                    result[i] = get(i).getNeutrophil_stick_perc();
                    break;
                case neutrophil_sya_perc:
                    result[i] = get(i).getNeutrophil_sya_perc();
                    break;
                default:
                    return null;
            }
        }
        return result;
    }

    public boolean setArray(Float[] array, Analysis.Parameter parameter){
        for(int i=0; i<size(); ++i){
            switch(parameter){
                case hct:
                    get(i).setHct(array[i]);
                    break;
                case hgb:
                    get(i).setHgb(array[i]);
                    break;
                case wbc:
                    get(i).setWbc(array[i]);
                    break;
                case limpho_perc:
                    get(i).setLimpho_perc(array[i]);
                    break;
                case neutrophil_perc:
                    get(i).setNeutrophil_perc(array[i]);
                    break;
                case neutrophil_stick_perc:
                    get(i).setNeutrophil_stick_perc(array[i]);
                    break;
                case neutrophil_sya_perc:
                    get(i).setNeutrophil_sya_perc(array[i]);
                    break;
                default:
                    return false;
            }
        }
        return true;
    }
}
