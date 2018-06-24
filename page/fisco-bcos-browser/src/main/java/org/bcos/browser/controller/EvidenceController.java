package org.bcos.browser.controller;

import com.alibaba.fastjson.JSON;
import com.yibi.ocs.sdk.entity.EvidenceData;
import com.yibi.ocs.sdk.service.EvidenceFace;
import org.bcos.browser.base.ConstantCode;
import org.bcos.browser.entity.base.BaseRspEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * create at 2018/6/24 11:14 AM
 *
 * @author <a href="mailto:yaolijun@hz-health.cn">Paul Yao</a>
 * @version %I%, %G%
 * @see
 */
@Controller
@RequestMapping(value = "evidence")
public class EvidenceController {

    private static Logger LOGGER =  LoggerFactory.getLogger(EvidenceController.class);

    @Autowired
    private EvidenceFace evidenceSdk;

    @RequestMapping(value = "/evidenceDetail.page",method = RequestMethod.GET)
    public String toBlockPage(){
        LOGGER.info("to page:evidenceDetail.....");
        return "evidenceDetail";
    }

    @ResponseBody
    @RequestMapping(value = "/getEvidenceInfo.json",method = RequestMethod.POST)
    public BaseRspEntity getEvidenceInfo(@RequestBody Map<String, String> body) throws Exception {
        EvidenceData data = evidenceSdk.getMessagebyHash(body.get("address"));
        BaseRspEntity response = new BaseRspEntity(ConstantCode.SUCCESS);
        response.setData(data);
        LOGGER.info("getTbNodeConnectionByPkId.end response:{}", JSON.toJSONString(response));
        return response;
    }

}
