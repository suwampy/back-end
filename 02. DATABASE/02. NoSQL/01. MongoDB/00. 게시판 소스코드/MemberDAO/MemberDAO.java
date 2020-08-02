package com.example.mongodbapp.MemberDao;

import com.example.mongodbapp.dto.MemberDTO;

public interface MemberDAO {

	    MemberDTO loginCheck(String userid, String passwd);  //로그인 체크 메소드
	    void join(MemberDTO dto);                            //회원 가입처리 함수

}
