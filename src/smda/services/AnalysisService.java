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



    public static MeasurementList getMeasurementList(String patientName, String[] consider){
        MeasurementList result = new MeasurementList(MeasurementList.parseParameters(consider));

        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver").newInstance();
            conn = DriverManager.getConnection("jdbc:postgresql://"+ Properties.host+"/botkin?" + "user="+Properties.db_username+"&password="+Properties.db_password);
            Statement st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select analysis.* from analysis " + (patientName.equals("") ? " " : " where patientid = '" + patientName + "' ORDER BY date ASC");
            ResultSet rs = st.executeQuery(sql);

            while (rs.next()) {
                Analysis analysis = new Analysis();

                Date date = rs.getDate("date");
                if(rs.wasNull()){
                    continue;
                }
                analysis.setDate(date);

                for(Analysis.Parameter parameter : result.getConsiderable()){
                    Float value = rs.getFloat(parameter.name());
                    analysis.setParameter(parameter, rs.wasNull() || value == VALUE_NA ? null : value);
                }

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

        Interval interval = new Interval(measurementList.getConsiderable());
        for(int i=0; i<measurementList.size(); ++i){
            if(i != 0 && i % intervalSize == 0){
                itvs.add(interval);
                interval = new Interval(measurementList.getConsiderable());
            }
            interval.add(measurementList.get(i));
        }
        if(interval.size() > 0) {
            itvs.add(interval);
        }

        return itvs;
    }
}
