package smda.services;

import smda.Properties;
import smda.models.Analysis;
import smda.models.Interval;
import smda.models.MeasurementList;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Denis on 14.08.2016.
 */
public class AnalysisService {
    public static final float VALUE_NA = -1;

    public static MeasurementList getMeasurementList(String patientName){
        MeasurementList result = new MeasurementList();

        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver").newInstance();
            conn = DriverManager.getConnection("jdbc:postgresql://"+ Properties.host+"/botkin?" + "user="+Properties.db_username+"&password="+Properties.db_password);
            Statement st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select analysis.* from analysis " + (patientName.equals("") ? " " : " where pat_id = '" + patientName + "' ORDER BY date ASC");
            ResultSet rs = st.executeQuery(sql);

            while (rs.next()) {
                Analysis analysis = new Analysis();

                Date date = rs.getDate("date");
                if(rs.wasNull()){
                    continue;
                }
                analysis.setDate(date);

                Float hct = rs.getFloat("hct");
                analysis.setHct(rs.wasNull() || hct == VALUE_NA ? null : hct);

                Float hgb = rs.getFloat("hgb");
                analysis.setHgb(rs.wasNull() || hgb == VALUE_NA ? null : hgb);

                Float wbc = rs.getFloat("wbc");
                analysis.setWbc(rs.wasNull() || wbc == VALUE_NA ? null : wbc);

                Float limpho_perc = rs.getFloat("limpho_perc");
                analysis.setLimpho_perc(rs.wasNull() || limpho_perc == VALUE_NA ? null : limpho_perc);

                Float neutrophil_perc = rs.getFloat("neutrophil_perc");
                analysis.setNeutrophil_perc(rs.wasNull() || neutrophil_perc == VALUE_NA ? null : neutrophil_perc);

                Float neutrophil_stick_perc = rs.getFloat("neutrophil_stick_perc");
                analysis.setNeutrophil_stick_perc(rs.wasNull() || neutrophil_stick_perc == VALUE_NA ? null : neutrophil_stick_perc);

                Float neutrophil_sya_perc = rs.getFloat("neutrophil_sya_perc");
                analysis.setNeutrophil_sya_perc(rs.wasNull() || neutrophil_sya_perc == VALUE_NA ? null : neutrophil_sya_perc);

                result.add(analysis);
            }

        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (Exception e){
            e.printStackTrace();
        }
        finally {
            return result;
        }
    }

    public static List<Interval> split(MeasurementList measurementList, final int intervalSize){
        List<Interval> itvs = new ArrayList<>();

        Interval interval = new Interval();;
        for(int i=0; i<measurementList.size(); ++i){
            if(i != 0 && i % intervalSize == 0){
                itvs.add(interval);
                interval = new Interval();
            }
            interval.add(measurementList.get(i));
        }
        itvs.add(interval);

        return itvs;
    }
}
