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

    public enum Parameter{hct, hgb, mch, mchc, mcv, mpv, p_lcr, pct, pdw, plt, rbc, rdw, rdw_cv, rdw_sd, adf,
        aptv, actv, wbc, limpho_perc, monocites_perc, neutrophil_perc, neutrophil_stick_perc, neutrophil_sya_perc, esr};

    private Map<Parameter, Float> values = new HashMap<>();

    private static Map<Parameter, String> names = new HashMap<>();

    static{
        setName(Parameter.hct, "Гематокрит");
        setName(Parameter.mch, "Ср.сод. ГГ в ЭЦ");
        setName(Parameter.mchc, "Ср.конц. ГГ в ЭЦ");
        setName(Parameter.mcv, "Средний объём ЭЦ");
        setName(Parameter.mpv, "Средний объём ТЦ");
        setName(Parameter.p_lcr, "Об. круптых ТЦ/ТЦ");
        setName(Parameter.pct, "Тромбокрит");
        setName(Parameter.pdw, "Гетерогенность ТЦ");
        setName(Parameter.plt, "Тромбоциты");
        setName(Parameter.hgb, "Гемоглобин");
        setName(Parameter.rbc, "Эритроциты");
        setName(Parameter.rdw, "Гетерогенность ЭЦ");
        setName(Parameter.rdw_cv, "RDW (коэф. вар.)");
        setName(Parameter.rdw_sd, "RDW (ст. откл.)");
        setName(Parameter.adf, "Агрегация ТЦ");
        setName(Parameter.aptv, "АПТВ");
        setName(Parameter.actv, "АЧТВ");
        setName(Parameter.wbc, "Лейкоциты");
        setName(Parameter.esr, "СОЭ");
        setName(Parameter.monocites_perc, "Моноциты, %");
        setName(Parameter.limpho_perc, "Лимфоциты, %");
        setName(Parameter.neutrophil_perc, "Нейтрофилы, %");
        setName(Parameter.neutrophil_stick_perc, "Нейтрофилы п/я, %");
        setName(Parameter.neutrophil_sya_perc, "Нейтрофилы с/я, %");
    }

    public Float getParameter(Analysis.Parameter parameter){
        if(values.containsKey(parameter)) {
            return values.get(parameter);
        }
        return null;
    }

    public void setParameter(Analysis.Parameter parameter, Float value){
        values.put(parameter, value);
    }

    public static String getName(Analysis.Parameter parameter){
        if(names.containsKey(parameter)) {
            return names.get(parameter);
        }
        return parameter.name();
    }

    public static void setName(Analysis.Parameter parameter, String value){
        names.put(parameter, value);
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
