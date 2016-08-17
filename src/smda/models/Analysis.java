package smda.models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by m.lapaev on 26.07.16.
 */
@Entity
@Table(name = "analysis")
public class Analysis implements Serializable, Comparable<Analysis> {

    @Id
    @Column(name = "id")
    private int id;

    @Column(name = "patientId")
    private String patientId;

    @Column(name = "date")
    private Date date;

    public enum Parameter{hct, hgb, wbc, limpho_perc, neutrophil_perc, neutrophil_stick_perc, neutrophil_sya_perc};

    private Map<Parameter, Float> values = new HashMap<>();

    public Float getParameter(Analysis.Parameter parameter){
        if(values.containsKey(parameter)) {
            return values.get(parameter);
        }
        return null;
    }

    public void setParameter(Analysis.Parameter parameter, Float value){
        values.put(parameter, value);
    }

    public int getId() {
        return id;
    }

    public Date getDate() {
        return date;
    }

    public String getPatientId() {
        return patientId;
    }

    public void setPatientId(String patientId) {
        this.patientId = patientId;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Override
    public int compareTo(Analysis o) {
        long time1 = date.getTime();
        long time2 = o.getDate().getTime();
        return time1 == time2 ? 0 : (time1 < time2 ? -1 : 1);
    }
}
