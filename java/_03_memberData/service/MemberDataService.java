package _03_memberData.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import _01_register.model.StudentBean_H;
import _01_register.model.TrainerBean_H;
import _03_memberData.dao.MemberDataDao;
import _03_memberData.model.Area_H;
import _03_memberData.model.City_H;
import _03_memberData.model.TrainerLicenseBean_H;
import _09_trainerCourse.model.TrainerCourseBean_H;

@Transactional
@Service
public class MemberDataService {

	@Autowired
	SessionFactory factory;

	@Autowired
	MemberDataDao memberDataDao;

	@Autowired
	AddressService addressService;

	public void updateStudent(StudentBean_H sb) {
		if (sb.getCity() != null && sb.getArea() != null) {
			City_H city = addressService.getCityById(sb.getCity().getId());
			Area_H area = addressService.getAreaById(sb.getArea().getId());
			sb.setCity(city);
			sb.setArea(area);
		}
		memberDataDao.updateStudent(sb);
	}

	public StudentBean_H getStudentById(int id) {
		return memberDataDao.getStudentById(id);
	}

	public void updateTrainer(TrainerBean_H tb) {
		if (tb.getCity() != null && tb.getArea() != null) {
			City_H city = addressService.getCityById(tb.getCity().getId());
			Area_H area = addressService.getAreaById(tb.getArea().getId());
			tb.setCity(city);
			tb.setArea(area);
		}
		memberDataDao.updateTrainer(tb);
	}

	public TrainerBean_H getTrainerById(int id) {
		return memberDataDao.getTrainerById(id);
	}

	public List<TrainerLicenseBean_H> getTrainerLicenseAll(int id) {
		return memberDataDao.getTrainerLicenseAll(id);
	}

	public void delTrainerLicense(TrainerLicenseBean_H tlb) {
		memberDataDao.delTrainerLicense(tlb);
	}

	public TrainerLicenseBean_H getTrainerLicenseById(int id) {
		return memberDataDao.getTrainerLicenseById(id);
	}

	public List<TrainerCourseBean_H> getTrainerAndCourse() {

		// 存放TrainerCourseBean_H內容的集合
		List<TrainerCourseBean_H> list = memberDataDao.getTrainerAndCourse();
		// 存放亂序結果的集合
		ArrayList<TrainerCourseBean_H> result = new ArrayList<>();
		Random random = new Random();
		// 首頁要隨機產生六個推薦教練，若是資料庫沒有六筆以上教練資料，就產生當前資料庫的教練資料筆數
		if (list.size() < 6) {
			for (int i = 0; i < list.size(); i++) {
				// 將取出的這個元素放到存放亂序結果的集合中
				result.add(list.get(i));
			}
		} else {
			for (int i = 0; i < 6; i++) {
				int myRand = random.nextInt(list.size());
				// 將取出的這個元素放到存放亂序結果的集合中
				result.add(list.get(myRand));
				// 從原始集合中刪除該元素防止重複
				list.remove(myRand);
			}
		}
		return result;
	}
}
