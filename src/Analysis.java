import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

/**
 * Created by m.lapaev on 26.07.16.
 */
@Entity
@Table(name = "analysis")
public class Analysis implements Serializable {
    public float getHct() {
        return hct;
    }

    public float getHgb() {
        return hgb;
    }

    public float getWbc() {
        return wbc;
    }

    public float getLimpho_perc() {
        return limpho_perc;
    }

    public float getNeutrophil_perc() {
        return neutrophil_perc;
    }

    public float getNeutrophil_stick_perc() {
        return neutrophil_stick_perc;
    }

    public float getNeutrophil_sya_perc() {
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

    public void setHct(float hct) {
        this.hct = hct;
    }

    public void setHgb(float hgb) {
        this.hgb = hgb;
    }

    public void setWbc(float wbc) {
        this.wbc = wbc;
    }

    public void setLimpho_perc(float limpho_perc) {
        this.limpho_perc = limpho_perc;
    }

    public void setNeutrophil_perc(float neutrophil_perc) {
        this.neutrophil_perc = neutrophil_perc;
    }

    public void setNeutrophil_stick_perc(float neutrophil_stick_perc) {
        this.neutrophil_stick_perc = neutrophil_stick_perc;
    }

    public void setNeutrophil_sya_perc(float neutrophil_sya_perc) {
        this.neutrophil_sya_perc = neutrophil_sya_perc;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Column(name = "patientId")
    private String patientId;

    @Column(name = "hct")
    private float hct;

    @Column(name = "hgb")
    private float hgb;

    @Column(name = "wbc")
    private float wbc;

    @Column(name = "limpho_perc")
    private float limpho_perc;

    @Column(name = "neutrophil_perc")
    private float neutrophil_perc;

    @Column(name = "neutrophil_stick_perc")
    private float neutrophil_stick_perc;

    @Column(name = "neutrophil_sya_perc")
    private float neutrophil_sya_perc;

    @Id
    @Column(name = "id")
    private int id;

    @Column(name = "date")
    private Date date;
}
