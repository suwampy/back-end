package com.example.mongodbapp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.example.mongodbapp.MemberDao.MemberDAO;
import com.example.mongodbapp.dto.MemberDTO;
@Component
public class MemberServiceImpl implements MemberService{

    @Autowired  //의존성 주입
    private MemberDAO memberDao;

	@Override
	public MemberDTO loginCheck(String userid, String passwd) {
		 return memberDao.loginCheck(userid, passwd);
	}

	@Override
	public void join(MemberDTO dto) {
		memberDao.join(dto);
		
	}
    

}
