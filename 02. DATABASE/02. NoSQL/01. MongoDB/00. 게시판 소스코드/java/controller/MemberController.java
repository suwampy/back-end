package com.example.mongodbapp.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.mongodbapp.dto.MemberDTO;
import com.example.mongodbapp.service.MemberService;

@Controller //컨트롤러 빈으로 설정
@RequestMapping("/member/*") //공통적인 URL 매핑
public class MemberController {
    @Autowired //의존성주입 (스프링프레임워크에서 지원하는 어노테이션)
    private MemberService memberService;
    
    @RequestMapping("login.do") //세부적인 매핑
    public ModelAndView login() {
        return new ModelAndView("member/login"); //login.jsp로 이동
    }
    
    @RequestMapping("join.do")
    public String join() {
        return "member/join"; 
        //join.jsp 회원가입페이지로 이동
    }
 
    
    //회원가입페이지에서 회원가입 내용을 다 작성한뒤 버튼을 누르면 맵핑되는 메소드
    //dto에 회원정보를 저장하고, Service에 값을 전달함
 
    @RequestMapping("member_join.do")
    public String member_join(String _id, String passwd
            , String name) {
        MemberDTO dto=new MemberDTO();
        dto.set_id(_id);
        dto.setPasswd(passwd);
        dto.setName(name);
        memberService.join(dto); //mongodb에 insert됨
        return "redirect:/member/login.do"; //로그인 화면으로 이동
    }
    
    @RequestMapping("logout.do")
    public String logout(HttpSession session) {
 
        //세션 정보 초기화
        session.invalidate();
 
        //로그인 페이지로 이동
        return "redirect:/member/login.do";
    }


}
