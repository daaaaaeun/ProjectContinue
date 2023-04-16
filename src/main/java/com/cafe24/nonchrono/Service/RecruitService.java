package com.cafe24.nonchrono.Service;

import com.cafe24.nonchrono.dao.RecruitDAO;
import com.cafe24.nonchrono.dto.RecruitInfoDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class RecruitService {

    @Autowired
    private RecruitDAO recruitDAO;

    public List<Map<String, String>> seatDetail(int rcrbrd_num, int rcrbrd_max) {
        List<Map<String, String>> list = new ArrayList<>();
        RecruitInfoDTO recruitInfoDTO = new RecruitInfoDTO();

        recruitInfoDTO.setRcrbrd_num(rcrbrd_num);
        for (int i = 1; i <= rcrbrd_max; i++) {
            recruitInfoDTO.setRi_seat(i);
            Map<String, String> innerMap = recruitDAO.seatDetail(recruitInfoDTO);
            if (innerMap == null) {
                innerMap = new LinkedHashMap<>();
                innerMap.put("mem_id", "");
                innerMap.put("mem_nick", "");
                innerMap.put("mem_pic", "");
            }
            list.add(innerMap);
        }

        return list;
    }
}
