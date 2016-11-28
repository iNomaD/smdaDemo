package smda.models;

import java.util.*;

/**
 * Created by Denis on 14.08.2016.
 */
public class MeasurementList extends ArrayList<Analysis>{
    //parameters to consider
    protected Set<Analysis.Parameter> considerable;

    public MeasurementList(){
        super();
        considerable = parseParameters(null);
    }

    public MeasurementList(Set<Analysis.Parameter> params){
        super();
        considerable = params;
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
        if(size() > 0 && considerable.contains(parameter)) {
            Float[] result = new Float[size()];
            for (int i = 0; i < size(); ++i) {
                result[i] = get(i).getParameter(parameter);
            }
            return result;
        }
        return null;
    }

    public boolean setArray(Float[] array, Analysis.Parameter parameter){
        for(int i=0; i<size(); ++i){
            get(i).setParameter(parameter, array[i]);
        }
        return true;
    }

    // if consider = null -> consider all parameters
    public static Set<Analysis.Parameter> parseParameters(String[] consider){
        Set<Analysis.Parameter> result = new HashSet<>();

        for(Analysis.Parameter p : Analysis.Parameter.values()){
            if(consider == null){
                result.add(p);
            }
            else {
                for (String s : consider) {
                    if(p.name().equals(s)){
                        result.add(p);
                        break;
                    }
                }
            }
        }

        return result;
    }

    public void exclude(Analysis.Parameter p){
        if (considerable.contains(p)) {
            considerable.remove(p);
        }
    }

    public Set<Analysis.Parameter> getConsiderable(){
        return considerable;
    }
}
