package com.cafe24.nonchrono.dao;

import com.cafe24.nonchrono.dto.*;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.*;

@Repository
public class RecruitDAO {


    @Autowired
    private SqlSession sqlSession;

    public RecruitDAO() {
        System.out.println("-----RecruitDAO() 객체 생성됨");
    } // end

    public List<RecruitDTO> list(String order) {
        return sqlSession.selectList("recruit.list", order);
    } // list() end

    public List<MoreDTO> listAjax(String order) {
        return sqlSession.selectList("recruit.listAjax", order);
    } // list() end

    public String game(int rcrbrd_num) {
        return sqlSession.selectOne("recruit.game", rcrbrd_num);
    } // gm_name() end

    public List<GameDTO> gm_list() {
        return sqlSession.selectList("recruit.gm_list");
    } // gm_name() end

    public String gm_list2(String title) {
        return sqlSession.selectOne("recruit.gm_list2", title);
    } // gm_name() end

    public HashMap<String, Object> detail(int rcrbrd_num) {
        return sqlSession.selectOne("recruit.detail", rcrbrd_num);
    } // detail() end

    public String nickname(String mem_id) {
        return sqlSession.selectOne("recruit.nickname", mem_id);
    } // nickname() end

    public int insert(RecruitDTO recruitDTO, int hiddenCount) {
        if (hiddenCount != 0) {
            recruitDTO.setRcrbrd_status("대기");
        } else {
            recruitDTO.setRcrbrd_status("진행중");
        }
        return sqlSession.insert("recruit.insert", recruitDTO);
    } // insert() end

    public List<GameDTO> myriList(String mem_id) {
        return sqlSession.selectList("mypage.recruitList", mem_id);
    }

    public List<RecruitDTO> myrcrList(String mem_id) {
        return sqlSession.selectList("mypage.rcrList", mem_id);
    }

    public List<Integer> rcrCoount(String mem_id) {
        return sqlSession.selectList("mypage.rcrCount", mem_id);
    }

    public int attend(RecruitInfoDTO recruitInfoDTO) {
        return sqlSession.insert("recruit.attend", recruitInfoDTO);
    } // attend() end

    public int roleInsert(RoleDTO roleDTO) {
        return sqlSession.insert("recruit.roleInsert", roleDTO);
    } // roleInsert() end

    public int numSearch() {
        return sqlSession.selectOne("recruit.numSearch");
    } // numSearch() end

    public List<RoleDTO> roleList(int rcrbrd_num) {
        return sqlSession.selectList("recruit.roleList", rcrbrd_num);
    } // roleList() end

    public List<GameDTO> idxRankingRecruit() {
        return sqlSession.selectList("recruit.idxRankingRecruit");
    }

    public List<RecruitDTO> idxrcrbrd() {
        return sqlSession.selectList("recruit.idxrcrbrdlist");
    }

    public Integer idxrcrbrdCount(int rcrbrd_num) {
        return sqlSession.selectOne("recruit.idxrcrbrdCount", rcrbrd_num);
    }


    public int roleConfirm(RoleSeatDTO roleSeatDTO) {
        return sqlSession.insert("recruit.roleConfirm", roleSeatDTO);
    } // roleConfirm() end

    public List<RoleSeatDTO> roleName(int rcrbrd_num) {
        return sqlSession.selectList("recruit.roleName", rcrbrd_num);
    } // roleName() end

    public Integer roleSeatCheck(RoleSeatDTO roleSeatDTO) {
        String result = sqlSession.selectOne("recruit.roleSeatCheck", roleSeatDTO);

        if (result == null) {
            return 0;
        } else {
            return Integer.parseInt(result);
        }
    } // roleSeatCheck() end

    public List<Map<String, Object>> seatDetail(int rcrbrd_num) {
        return sqlSession.selectList("recruit.seatDetail", rcrbrd_num);
    }

    public List<Map<String, Object>> rcrKing() {
        return sqlSession.selectList("recruit.rcrKing");
    } // rcrKing() end

    public List<MoreDTO> getMoreContents(int startCount, int endCount, String order, String keyword) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("startCount", startCount);
        map.put("endCount", endCount);
        map.put("order", order);
        if (keyword.equals("null")) {
            return sqlSession.selectList("recruit.more", map);
        } else {
            map.put("keyword", keyword);
            return sqlSession.selectList("recruit.more2", map);
        }
    }

    public int delete(int rcrbrd_num) {
        int cnt = 0;
        cnt += sqlSession.delete("recruit.deleteRecruit", rcrbrd_num);
        cnt += sqlSession.delete("recruit.deleteRole", rcrbrd_num);
        cnt += sqlSession.delete("recruit.deleteRoleSeat", rcrbrd_num);
        cnt += sqlSession.delete("recruit.delete", rcrbrd_num);
        return cnt;
    } // delete() end

    public int status(int rcrbrd_num) {
        return sqlSession.update("recruit.status", rcrbrd_num);
    } // status() end

    public int views(int rcrbrd_num) {
        return sqlSession.update("recruit.views", rcrbrd_num);
    } // views() end

    public List<Map<String, Object>> rcrbrdlist(String mem_id) {
        return sqlSession.selectList("mypage.rcrbrdlist", mem_id);
    }

    public int rcrbrdlistCount(int rcrbrd_num) {
        return sqlSession.selectOne("mypage.rcrbrdlistCount", rcrbrd_num);
    }

    public int attendCheck(int rcrbrd_num, String mem_id) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("rcrbrd_num", rcrbrd_num);
        map.put("mem_id", mem_id);

        Integer integer = sqlSession.selectOne("recruit.attendCheck", map);
        if (integer == null) {
            return 0;
        } else {
            return (int) integer;
        }
    }

    public String heart(RatingDTO ratingDTO) {
        int cnt = sqlSession.selectOne("recruit.heartCheck", ratingDTO);
        String mem_id = ratingDTO.getReceive_id();
        if (cnt == 0) {
            sqlSession.insert("recruit.heart", ratingDTO);
            sqlSession.update("recruit.good", mem_id);
            return "님께 하트를 보냈습니다";
        } else {
            sqlSession.delete("recruit.heartDelete", ratingDTO);
            return "님께 보낸 하트를 취소했습니다";
        }
    }

    public String declare(RatingDTO ratingDTO) {
        sqlSession.insert("recruit.heart", ratingDTO);
        String mem_id = ratingDTO.getReceive_id();
        sqlSession.update("recruit.buyer_bad", mem_id);
        return "님을 신고했습니다";
    }

    public int comment(CommentDTO commentDTO) {
        return sqlSession.insert("recruit.comment", commentDTO);
    }

    public List<RecruitDTO> list2(String order, String keyword) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("order", order);
        map.put("keyword", keyword);
        sqlSession.insert("recruit.searchInsert", keyword);
        return sqlSession.selectList("recruit.list2", map);
    }

    public List<MoreDTO> listAjax2(String order, String keyword) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("order", order);
        map.put("keyword", keyword);
        return sqlSession.selectList("recruit.listAjax2", map);
    }

    public List<String> searchRank() {
        return sqlSession.selectList("recruit.searchRank");
    }

    public int useMileage(String mem_id, int mileage) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("mem_id", mem_id);
        map.put("mileage", mileage);
        return sqlSession.update("recruit.useMileage", map);
    }

    public int mileageCheck(String mem_id) {
        return sqlSession.selectOne("recruit.mileageCheck", mem_id);
    }

    public List<Map<String, Object>> commentList(int rcrbrd_num) {
        return sqlSession.selectList("recruit.commentList", rcrbrd_num);
    }

    public int commentDelete(int com_num) {
        return sqlSession.delete("recruit.commentDelete", com_num);
    }

    public int commentUpdate(CommentDTO commentDTO) {
        return sqlSession.update("recruit.commentUpdate", commentDTO);
    }

    public int open(int rcrbrd_num) {
        return sqlSession.update("recruit.open", rcrbrd_num);
    }
} // class end
