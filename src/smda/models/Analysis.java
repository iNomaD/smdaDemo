package smda.models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

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

    @Column(name = "hct")
    private Float hct;

    @Column(name = "hgb")
    private Float hgb;

    @Column(name = "wbc")
    private Float wbc;

    @Column(name = "limpho_perc")
    private Float limpho_perc;

    @Column(name = "neutrophil_perc")
    private Float neutrophil_perc;

    @Column(name = "neutrophil_stick_perc")
    private Float neutrophil_stick_perc;

    @Column(name = "neutrophil_sya_perc")
    private Float neutrophil_sya_perc;


    public Float getHct() {
        return hct;
    }

    public Float getHgb() {
        return hgb;
    }

    public Float getWbc() {
        return wbc;
    }

    public Float getLimpho_perc() {
        return limpho_perc;
    }

    public Float getNeutrophil_perc() {
        return neutrophil_perc;
    }

    public Float getNeutrophil_stick_perc() {
        return neutrophil_stick_perc;
    }

    public Float getNeutrophil_sya_perc() {
        return neutrophil_sya_perc;
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

    public void setHct(Float hct) {
        this.hct = hct;
    }

    public void setHgb(Float hgb) {
        this.hgb = hgb;
    }

    public void setWbc(Float wbc) {
        this.wbc = wbc;
    }

    public void setLimpho_perc(Float limpho_perc) {
        this.limpho_perc = limpho_perc;
    }

    public void setNeutrophil_perc(Float neutrophil_perc) {
        this.neutrophil_perc = neutrophil_perc;
    }

    public void setNeutrophil_stick_perc(Float neutrophil_stick_perc) {
        this.neutrophil_stick_perc = neutrophil_stick_perc;
    }

    public void setNeutrophil_sya_perc(Float neutrophil_sya_perc) {
        this.neutrophil_sya_perc = neutrophil_sya_perc;
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
