package zcom.yetthin.web.controller;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.yetthin.web.domain.RecommendInfo;
import com.yetthin.web.domain.StockOfGroup;
import com.yetthin.web.domain.StockOfGroupreq;
import com.yetthin.web.service.GroupService;


@Controller
@RequestMapping(value="/group")
public class GroupController {
	
	@Resource
	private GroupService groupService;
	
	
	@ResponseBody
	@RequestMapping(value="/Detail",method=RequestMethod.POST,
	produces={"application/json;charset=utf-8"})
	public String getDetail(@RequestParam(value="groupNameOrId")String groupNameOrId
			,HttpServletRequest http){
		
		String json =null;
		json =groupService.getDetail(groupNameOrId,http.getRequestURL().toString());
		return "{"+json+"}" ;
	}
	@ResponseBody
	@RequestMapping(value="/Component",method=RequestMethod.POST,
	produces={"application/json;charset=utf-8"})
	public String getComponent(@RequestParam(value="groupNameOrId")String groupNameOrId){
		String json = null;
		json =groupService.getComponent(groupNameOrId);
		return "{"+json+"}" ;
	}
	@ResponseBody
	@RequestMapping(value="/Analyse",method=RequestMethod.POST,
			produces={"application/json;charset=utf-8"})
	public String getAnalyse(@RequestParam(value="groupNameOrId")String groupNameOrId){
			String json=null;
			json =groupService.getAnalyse(groupNameOrId);
			return json ;
	}
	@ResponseBody
	@RequestMapping(value="/Recommend",method=RequestMethod.POST,
			produces={"application/json;charset=utf-8"})
	public String getRecommend(@RequestParam(value="groupNameOrId")String groupNameOrId,
			HttpServletRequest req){
		String json =null;
		StringBuffer path =req.getRequestURL();
		json =groupService.getRecommend(groupNameOrId,path.toString().split("/group")[0]);
		return json ;
	}
	@ResponseBody
	@RequestMapping(value="/saveRecommend",method=RequestMethod.POST,
			produces={"application/json;charset=utf-8"})
	public String saveRecommend(@RequestParam(value="groupNameOrId")String groupNameOrId,
			@RequestParam(value="belongGroupId")String belongId,
			@RequestParam(value="upRecommendUserId")String upRecommendUserId,
			@RequestParam(value="repateContext")String context,
			@RequestParam(value="userId")String userid){
		String json =null;
		json =groupService.saveRecommend(groupNameOrId,belongId,upRecommendUserId,context,userid);
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value="/Summarize",method=RequestMethod.POST,
			produces={"application/json;charset=utf-8"})
	public String getSummarize(@RequestParam(value="pageNum")int pageNum,
			@RequestParam(value="pageSize") int pageSize){
		String json =null;
		json =groupService.getSummarize(pageNum,pageSize);
		return json ;
	}
	@ResponseBody
	@RequestMapping(value="/stockType",method=RequestMethod.POST,
	produces={"application/json;charset=utf-8"})
	public String getSotckType(){
		String json =null;
		json =groupService.getStockType();
		return json ;
	}
	@ResponseBody
	@RequestMapping(value="/stockTypeList",method=RequestMethod.POST,
	produces={"application/json;charset=utf-8"})
	public String getSotckTypeList(@RequestParam(value="stockType")int stockType){
		String json =null;
		json =groupService.getStockTypeList(stockType);
		return json ;
	}
	@ResponseBody
	@RequestMapping(value="/stockofgroup",method=RequestMethod.POST,
	produces={"application/json;charset=utf-8"})
	public String getStockofGroup(StockOfGroupreq req){
		String json =null;
		System.out.println(req);
		json =groupService.getStockofGroup(req);
		return json ;
	}
	
	@ResponseBody
	@RequestMapping(value="/stocksofgroupSave",method=RequestMethod.POST,
	produces={"application/json;charset=utf-8"})
	public String SotckofGroupSave(StockOfGroup stockOfGroup){
		String json =null;
		
		json =groupService.stockOfGroupSave(stockOfGroup);
		return json ;
	}
	/**
	 * 添加评论
	 * @param discussinfoId
	 * @param context
	 * @param upUserId
	 * @param groupId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/applyOrCreateRecommend",method=RequestMethod.POST,
	produces={"application/json;charset=utf-8"})
	public String applyOrCreateRecommend(
			@RequestParam(value="discussinfoUserId")String discussinfoUserId,
			@RequestParam(value="discussinfoContext")String context,
			@RequestParam(value="discussinfoHeigherId")String upUserId,
			@RequestParam(value="groupId")String groupId){
		String json =null;
		RecommendInfo info =new RecommendInfo
				(discussinfoUserId, context, upUserId, groupId,  "0");
		
		json =groupService.addRecommend(info);
		return json;
	}
	/**
	 * 删除评论
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/deleteRecommend",method=RequestMethod.POST,
	produces={"application/json;charset=utf-8"})
	public String deleteRecommend(@RequestParam(value="discussinfoId")String id){
		String json =groupService.deleteRecommend(id);
		return json;
	}
	
	
	 
}
