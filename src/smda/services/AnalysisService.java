package smda.services;

import smda.models.Analysis;
import smda.models.MeasurementList;

import java.sql.*;

/**
 * Created by Denis on 14.08.2016.
 */
public class AnalysisService {

    public static MeasurementList getMeasurementList(String patientName){
        MeasurementList result = new MeasurementList();

        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver").newInstance();
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/botkin?" + "user=postgres&password=12345");
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
                analysis.setHct(rs.wasNull() ? null : hct);

                Float hgb = rs.getFloat("hgb");
                analysis.setHgb(rs.wasNull() ? null : hgb);

                Float wbc = rs.getFloat("wbc");
                analysis.setWbc(rs.wasNull() ? null : wbc);

                Float limpho_perc = rs.getFloat("limpho_perc");
                analysis.setLimpho_perc(rs.wasNull() ? null : limpho_perc);

                Float neutrophil_perc = rs.getFloat("neutrophil_perc");
                analysis.setNeutrophil_perc(rs.wasNull() ? null : neutrophil_perc);

                Float neutrophil_stick_perc = rs.getFloat("neutrophil_stick_perc");
                analysis.setNeutrophil_stick_perc(rs.wasNull() ? null : neutrophil_stick_perc);

                Float neutrophil_sya_perc = rs.getFloat("neutrophil_sya_perc");
                analysis.setNeutrophil_sya_perc(rs.wasNull() ? null : neutrophil_sya_perc);

                result.add(analysis);
            }

            /*
            int count = 0;
            if (rs.last()) {
                count = rs.getRow();
                rs.beforeFirst();
            }
            Date[] tmp = new Date[count];
            count = 0;
            while (rs.next()) {
                tmp[count] = rs.getDate("date");
                count++;
            }
            rs.beforeFirst();

            Date d1 = tmp[0];
            Date d2 = tmp[tmp.length - 1];
            int days = (int) ((d2.getTime() - d1.getTime()) / (1000 * 60 * 60 * 24)) + 2;

            Date[] dates = new Date[days];
            Calendar c = Calendar.getInstance();
            c.setTime(d1);
            for (int i = 0; i < dates.length; i++) {
                c.add(Calendar.DATE, 1);
                dates[i] = new java.sql.Date(c.getTime().getTime());
            }

            hct = new float[days];
            hgb = new float[days];
            wbc = new float[days];
            limpho_perc = new float[days];
            neutrophil_perc = new float[days];
            neutrophil_stick_perc = new float[days];
            neutrophil_sya_perc = new float[days];
            for (int i = 0; i < days; i++) {
                hct[i] = -1;
                hgb[i] = -1;
                wbc[i] = -1;
                limpho_perc[i] = -1;
                neutrophil_perc[i] = -1;
                neutrophil_stick_perc[i] = -1;
                neutrophil_sya_perc[i] = -1;
            }
            int index;

            while (rs.next()) {
                Date date = rs.getDate("date");
                index = find(dates, date);
                if (index > -1) {
                    hct[index] = rs.getFloat("hct");
                    hgb[index] = rs.getFloat("hgb");
                    wbc[index] = rs.getFloat("wbc");
                    limpho_perc[index] = rs.getFloat("limpho_perc");
                    neutrophil_perc[index] = rs.getFloat("neutrophil_perc");
                    neutrophil_stick_perc[index] = rs.getFloat("neutrophil_stick_perc");
                    neutrophil_sya_perc[index] = rs.getFloat("neutrophil_sya_perc");
                }
            }
            */

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

    /*
    private static int find(Date[] array, Date date) {
        for (int i = 0; i < array.length; i++) {

            if (array[i].equals(date)) {
                return i;
            }
        }
        return -1;
    }
    */
}
