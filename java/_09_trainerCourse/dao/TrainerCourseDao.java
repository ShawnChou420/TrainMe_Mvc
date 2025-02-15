package _09_trainerCourse.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import _01_register.model.TrainerBean_H;
import _04_money.model.MoneyBean_H;
import _09_trainerCourse.model.TrainerCourseBean_H;
import _09_trainerCourse.model.TrainerOffBean_H;
import _10_studentCourse.model.StudentCourseBean_H;

@Repository
public class TrainerCourseDao {
	
	@Autowired
	SessionFactory factory;
	
	public TrainerCourseDao() {
	}
	
	public void saveTimeOff(TrainerOffBean_H tob) {
		Session session = factory.getCurrentSession();
		session.save(tob);
	}
	
	public void deleteTimeOff(String dateBegin ,String dateEnd,int trId) {
		Session session = factory.getCurrentSession();
		System.out.println(dateBegin);
		System.out.println(dateEnd);
		System.out.println(trId);
		String hql = "DELETE FROM TrainerOffBean_H WHERE date BETWEEN '" + dateBegin + "' and '" + dateEnd +
					 "' AND tr_id = :mid";
		
		session.createQuery(hql).setParameter("mid", trId).executeUpdate();		
	}
	
	@SuppressWarnings({ "unchecked", "null" })
	public List<String> queryTimeOffList(String dateBegin ,String dateEnd,int trId) {
		Session session = factory.getCurrentSession();
		List<String> list = new ArrayList<>();
		String hql = "FROM TrainerOffBean_H WHERE date BETWEEN '" + dateBegin + "' and '" + dateEnd 
				+ "' AND tr_id = :mid";
		List<TrainerOffBean_H> offTimes = session.createQuery(hql).setParameter("mid", trId).getResultList();
			
		for(TrainerOffBean_H offTime : offTimes) {
			String closeHour = offTime.getDate() + "_" + offTime.getTime();
			list.add(closeHour);
		}
		
		return list;
	}
	
	
	public TrainerBean_H getTrainerById(int trId) {
		Session session = factory.getCurrentSession();
		return session.get(TrainerBean_H.class, trId);
	}
	
	@SuppressWarnings("rawtypes")
	public List<StudentCourseBean_H> getTrainerCourseById(int trId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM StudentCourseBean_H sc WHERE sc.trainerCourseBean_H.trainerBean_H.id= :trid ";
		                                                               
		@SuppressWarnings("unchecked")
		List <StudentCourseBean_H> sc = session.createQuery(hql).setParameter("trid", trId).getResultList();
//		sc.get(0).getTrainerCourseBean_H().getTrainerBean_H().getId()
//		List<StudentCourseBean_H> st=new LinkedList<>();
//		for(TrainerCourseBean_H sc : sclist) {
//			Iterator it = 	sc.getStudentCourseBean_H().iterator();
//			while (it.hasNext()) {
//				st.add((StudentCourseBean_H) it.next());
////				st.get(0).getDate()
//			}			
//		}
//		System.out.println("st="+ st);
		return sc;
	}
	
}
