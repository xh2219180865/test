<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
<base href="<%=basePath%>">
<link href="<%=basePath%>static/css/jquery.dataTables.css" rel="stylesheet" />
<link href="<%=basePath%>static/css/dataTableStyle.css" rel="stylesheet" />
<link href="<%=basePath%>static/css/bootstrap.css" rel="stylesheet" />
<!-- OA_select -->
<link rel="stylesheet" href="private/css/dropkick.css" type="text/css">
<link href="private/css/modalTable.css" rel="stylesheet"/>
<script type="text/javascript" src="<%=basePath%>static/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="<%=basePath%>static/js/jquery.bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>static/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="<%=basePath%>static/bootstrap-3.3.0/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>public/util/common.js"></script>
<script type="text/javascript" src="<%=basePath%>private/js/jquery.dropkick-min.js"></script>
<style type="text/css">
/*  .Tools{ */
/*  width: 400px; height: 100px; margin-left: -500px; border: 1px solid #red;line-height: 45px; line-height: 42px;background: url("images/icon/1.png") no-repeat 2px 2px; */
/*  cursor: pointer; */
/*  } */
</style>
</head>
  
  <body>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content" id="myModalCenter">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">高级查询</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" role="form" id="ff" method="post">
							<table class="baseInfoTable1 auto">
								<tr>
									<td>
										<span class="tt_span">身份证</span>
										<input type="text" placeholder="请输入" id="idCard"  />
									</td>
								</tr>
								<tr>
									<td>
										<span class="tt_span">手机</span>
										<input type="text" placeholder="请输入" id="mobilePhone"  />
									</td>
								</tr>
							</table>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-cancel" data-dismiss="modal">取消</button>
						<button type="button" id="submitButton" class="btn btn-confirm"
							onclick="queryRes()">查询</button>
					</div>
				</div>
			</div>
		</div>
  
   <div class="table-container" >
		<table id="example" class="display" cellspacing="0" width="95%">
    <thead>
        <tr>
            <th style="width: 60px;">序号</th>
            <th style="width: 80px;">姓名</th>
            <th style="width: 60px;">性别</th>
            <th style="width: 180px;">身份证</th>
            <th style="width: 130px;">手机</th>
            <th style="width: 200px;">邮箱</th>
            <th style="width: 130px;">固话</th>
            <th style="width: 90px;">部门</th>
            <th style="width: 90px;">职位</th>
            <th style="width: 160px;">入职时间</th>
            <th style="width: 160px;">所属公司</th>
            <th style="width: 120px;">操作</th>
        </tr>
    </thead>
</table>
    </div>
    <script type="text/javascript">
    var oTable;
    $(document).ready(function() {
    	$("#backTwo").offset({
       	 left:-10,
       	 top:-10
        });
    	oTable = initTable();
    	$("#example_wrapper").find("input").attr("placeholder","请输入姓名");
    	/*
    	$.ajax({
       		url:"dict/getDictForResume.htm",
       		type:"post",
       		dataType:"json",
       		data:{
       		},
       		success:function(data){
       			InitSelect("education",data.xl);
       			InitSelect("job",data.zw);
                $('.oa_select').dropkick();
       		}
       	});
    	**/
    } );
    function initTable(){
    	
    	var table = $('#example').dataTable( {
    		"processing": true,
        	//服务器获取数据
            "serverSide": true,
            //排序
            "ordering":false,
            //快速查询
        	"searching":true,
            //"ajax": { "url":'customerInfo/getAllCustomer.htm'},
            "sAjaxSource": "<%=basePath%>hrUser/getAllUser.htm",
            "fnServerParams": function ( aoData ) {
                aoData.push( 
              		  { "name": "args2", "value": $("#idCard").val() },
              		  { "name": "args3", "value": $("#mobilePhone").val() } 
              		  );
           },
            //分页样式
            "sPaginationType": "full_numbers",
            "sDom": "<'row-fluid'<'span6 myBtnBox'><'span6'f>r>t<'row-fluid'<'span6'i><'span6 'p>>",
            //默认列空值
            "columnDefs": [  
                           {                               
                             "defaultContent": "",  
                             "targets": "_all"  
                           }  
                         ],
            "columns": [
                        { "data": "id" ,
                        	"fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                                $(nTd).html(""+oData.id+"<div  class='Tools' id=a" + oData.id + ";style='display: none;width:20px; height: 46px; margin-left: -0px;'></div>");
                                    }},
                        { "data": "name",
                        	"fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                                $(nTd).html(""+oData.name+"<div   class='Tools' id=b" + oData.id + " style='display: none;width:20px; height: 46px; margin-left: -0px;'></div>");
                                    } },
                        { "data": "sexStr",
                        	"fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                                $(nTd).html(""+oData.sexStr+"&nbsp;<div  class='Tools' id=c" + oData.id + " style='display: none;width:20px; height: 46px; margin-left: -0px;'></div>");
                                    } },
                        { "data": "idCard" ,
                        	"fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                                $(nTd).html(""+oData.idCard+"&nbsp;<div  class='Tools' id=d" + oData.id + " style=' cursor: pointer;display: none;width: 120px; height: 46px; margin-left: 50px;line-height: 46px;background: url(images/hricon/1.png) no-repeat 8px 15px'><span onclick='probationEmployee(\"" + oData.id + "\",328)'>员工试用</span></div>");
                                    }},
                        { "data": "mobelFirst",
                        	"fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                                //$(nTd).html(""+oData.mobelFirst+"&nbsp;<div  class='Tools' id=e" + oData.id + " style=' cursor: pointer;display: none;width: 120px; height: 46px; margin-left: -10px;line-height: 46px;background: url(images/hricon/2.png) no-repeat 8px 15px'><span onclick='signContract(\"" + oData.id + "\")'>签订合同</span></div>");
                                $(nTd).html(""+oData.mobelFirst+"&nbsp;<div  class='Tools' id=e" + oData.id + " style=' cursor: pointer;display: none;width: 120px; height: 46px; margin-left: -10px;line-height: 46px; no-repeat 8px 15px'><span ></span></div>");
                                    } },
                        { "data": "mail",
                        	"fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                                $(nTd).html(""+oData.mail+"&nbsp;<div  class='Tools' id=f" + oData.id + " style=' cursor: pointer;display: none;width: 120px; height: 46px; margin-left: -25px;line-height: 46px;background: url(images/hricon/3.png) no-repeat 8px 15px'><span onclick='formalEmployee(\"" + oData.id + "\",329)'>员工转正</span></div>");
                                    } },
                        { "data": "fixedTelephone" ,
                        	"fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                                //$(nTd).html(""+oData.fixedTelephone+"&nbsp;<div  class='Tools' id=g" + oData.id + " style=' cursor: pointer;display: none;width: 120px; height: 46px; margin-left: -80px;line-height: 46px;background: url(images/hricon/4.png) no-repeat 8px 15px'><span onclick='retireEmployee(\"" + oData.id + "\",330)'>员工退休</span></div>");
                                $(nTd).html(""+oData.fixedTelephone+"&nbsp;<div  class='Tools' id=g" + oData.id + " style=' cursor: pointer;display: none;width: 120px; height: 46px; margin-left: -80px;line-height: 46px; no-repeat 8px 15px'><span ></span></div>");
                                    }},
                        { "data": "entryDeptIdStr",
                        	"fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                                $(nTd).html(""+oData.entryDeptIdStr+"&nbsp;<div  class='Tools' id=h" + oData.id + " style=' cursor: pointer;display: none;width: 120px; height: 46px; margin-left: -85px;line-height: 46px;background: url(images/hricon/5.png) no-repeat 8px 15px'><span >员工待岗</span></div>");
                                    } },
                        { "data": "entryJobIdStr",
                        	"fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                                $(nTd).html(""+oData.entryJobIdStr+"&nbsp;<div  class='Tools' id=i" + oData.id + " style=' cursor: pointer;display: none;width: 120px; height: 46px; margin-left: -42px;line-height: 46px; no-repeat 8px 15px'><span></span></div>");
                                    } },
                        { "data": "entryDate" ,
                        	"fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                        			var entryDate = oData.entryDate;
                        			if(entryDate ==undefined){
                        				entryDate = '';
                        			}
                                     $(nTd).html(entryDate+"&nbsp;<div  class='Tools' id=j" + oData.id + " style=' cursor: pointer;display: none;width: 120px; height: 46px; margin-left: -25px;line-height: 46px;background: url(images/hricon/7.png) no-repeat 8px 15px'><span onclick='turnoverEmployee(\"" + oData.id + "\",332)'>员工离职</span></div>");
                                    }
                        },
                        { "data": "companyIdStr",
                        	"fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                                $(nTd).html(""+oData.companyIdStr+"&nbsp;<div  class='Tools' id=i" + oData.id + " style=' cursor: pointer;display: none;width: 120px; height: 46px; margin-left: -42px;line-height: 46px; no-repeat 8px 15px'><span></span></div>");
                                    } },
                        { "data": "cusId" ,"fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                        		$(nTd).attr("name","operator");
	                            $(nTd).html("<a name='"+oData.companyId+"' href='javascript:void(0);' " +
	                                    "onclick='editFun(\"" +oData.id+ "\")'><span class='glyphicon glyphicon-pencil' title='编辑'></span></a>&nbsp;&nbsp;")
	                                    .append("<a href='javascript:void(0);' onclick='getDetailFun(\"" + oData.id + "\")'><span title='详情'  class='glyphicon glyphicon-search'></span></a>&nbsp;&nbsp;")
	                                    .append("<a href='javascript:void(0);' onclick='showInfo(\"" + oData.id + "\")'><span title='更多' id='more" + oData.id + "' class='glyphicon glyphicon-chevron-down'></span></a><div  class='Tools' id=k" + oData.id + " style=' cursor: pointer;display: none; width: 120px; height: 46px; margin-left: -60px;line-height: 46px; no-repeat 8px 15px'><span></span></div>");
	                        			//<a href='javascript:void(0);' onclick='deleteFun(\"" + oData.id + "\")'><span title='删除' class='glyphicon glyphicon-remove'></span></a>&nbsp;&nbsp;        
	                        	}},
                    ],
                    "oLanguage": {
                    	"sLengthMenu": "每页显示 _MENU_ 条记录",
                    	"sZeroRecords": "抱歉， 没有找到",
                    	"sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
                    	"sInfoEmpty": "没有数据",
                    	"sInfoFiltered": "(从 _MAX_ 条数据中检索)",
                    	"sSearch": "",
                    	"oPaginate": {
                    	"sFirst": "首页",
                    	"sPrevious": "前一页",
                    	"sNext": "后一页",
                    	"sLast": "尾页",
                    	},
                    	"sZeroRecords": "没有检索到数据",
                    	//"sProcessing": "<img src='./loading.gif' />"
                    	},"fnCreatedRow": function (nRow, aData, iDataIndex) {
                            //add selected class
                            $(nRow).click(function () {
                                if ($(this).hasClass('row_selected')) {
                                    $(this).removeClass('row_selected');
                                } else {
                                    oTable.$('tr.row_selected').removeClass('row_selected');
                                    $(this).addClass('row_selected');
                                }
                            });
                        },"fnInitComplete":function (oSettings, json) {
                        	var userList = json.data;
                        	$("#example").find("td[name=operator]").each(function(i){
                        		var userTemp = userList[i];
                        		var companyIdTemp = $(this).find("a").eq(0).attr("name");
                        		if(json.companyId != companyIdTemp){
                        			$(this).html("<a href='javascript:void(0);' onclick='getDetailFun(\"" + userTemp.id + "\")'><span title='详情'  class='glyphicon glyphicon-search'></span></a>&nbsp;&nbsp;");
                        		}
                        	});

                        	 $('<a href="javascript:void(0)" onclick="add()" id="addFun" class="btn btn-default" data-toggle="modal">新增</a>'
                             		+ '&nbsp;' +
                                     '<a href="javascript:void(0)" onclick="searchRes()" class="btn btn-query" id="editFun">高级查询</a> ' + '&nbsp;'
                                    /*  +  '<a href="javascript:void(0)" onclick="signContract()" class="btn btn-query" id="editFun">签订合同</a> ' + '&nbsp;'
                                     +  '<a href="javascript:void(0)" onclick="probationEmployee()" class="btn btn-query" id="editFun">员工试用</a> ' + '&nbsp;'
                                     +  '<a href="javascript:void(0)" onclick="formalEmployee()" class="btn btn-query" id="editFun">员工转正</a> ' + '&nbsp;'
                                     +  '<a href="javascript:void(0)" onclick="retireEmployee()" class="btn btn-query" id="editFun">员工退休</a> ' + '&nbsp;'
                                     +  '<a href="javascript:void(0)" onclick="dismissalEmployee()" class="btn btn-query" id="editFun">员工解聘</a> ' + '&nbsp;'
                                     +  '<a href="javascript:void(0)" onclick="turnoverEmployee()" class="btn btn-query" id="editFun">员工离职</a> ' + '&nbsp;'
                                     +  '<a href="javascript:void(0)" onclick="transferEmployee()" class="btn btn-query" id="editFun">员工调动</a> ' + '&nbsp;'
                                     +  '<a href="javascript:void(0)" onclick="rehiredEmployee()" class="btn btn-query" id="editFun">员工返聘</a> ' + '&nbsp;' */
                                     /* '<a href="#" class="btn btn-danger" id="deleteFun">删除</a>' + '&nbsp;' */
                                     ).appendTo($('.myBtnBox'));
                        	
                        	
                        	
                        	
                            $(json.data).each(function(i,r){
                            	$("#a"+ r.id).hide();
                            	$("#b"+ r.id).hide();
                            	$("#c"+ r.id).hide();
                            	$("#d"+ r.id).hide();
                            	$("#e"+ r.id).hide();
                            	$("#f"+ r.id).hide();
                            	$("#g"+ r.id).hide();
                            	$("#h"+ r.id).hide();
                            	$("#i"+ r.id).hide();
                            	$("#j"+ r.id).hide();
                            	$("#k"+ r.id).hide();
                            })
                        }
        } );
    	return table;
    }
	 var check=function(e){  
        
        e=e||window.event; //alert(e.which||e.keyCode);  
        if((e.which||e.keyCode)==116){  
            if(e.preventDefault){  
                e.preventDefault();  
                window.location.reload();   
            } else{  
                event.keyCode = 0;   
                e.returnValue=false;  
                window.location.reload();  
            }  
        }  
    };  
      
    if(document.addEventListener){   
        document.addEventListener("keydown",check,false);   
    } else{   
        document.attachEvent("onkeydown",check);   
    }  
    function add(){
    	location.href="<%=basePath%>jsp/PersonnelManage/PersonnelFiles/addEmployee.jsp";
    }
    function updateById(){
    	var selected = oTable.fnGetData(oTable.$('tr.row_selected').get(0));
    	if(selected.id==undefined){
    		alert("请选择一行");
    	}else{
    		location.href="<%=basePath%>recruitment/getResumeDetailsById.htm?id="+selected.id;
    	}
    }
    function editFun(id){
    	location.href="<%=basePath%>hrUser/getUserById.htm?id="+id;
    }
    //批量删除id格式id="1,2,3,4,5,6,7"
    function deleteFun(id){
      	 $.ajax({
   				url : "<%=basePath%>hrUser/deleteUser.htm",
   				type : "POST",
   				dataType:"json",
   				async : false,
   				data : {
   					id:id
   				},
   				success : function(r) {
   					alert(r.message);
   					oTable.fnDraw();
   				}
   			});
      window.location.reload();
      }
    //签订合同
    function signContract(id){
    	/* var selected = oTable.fnGetData(oTable.$('tr.row_selected').get(0));
    	if(selected.id==undefined){
    		alert("请选择一行");
    	}else{ */
    		location.href="<%=basePath%>hrUser/getUserRelationContractById.htm?id="+id;
    	/* }
    	 */
    }
    //员工试用
    function probationEmployee(id,status){
    /* 	var selected = oTable.fnGetData(oTable.$('tr.row_selected').get(0));
    	if(selected.id==undefined){
    		alert("请选择一行");
    	}else{ */
    		location.href="<%=basePath%>hrUser/getProbationInformationById.htm?id="+id+"&status="+status;
    	/* } */
    }
    //员工转正
   function formalEmployee(id,status){
		/* var selected = oTable.fnGetData(oTable.$('tr.row_selected').get(0));
    	if(selected.id==undefined){
    		alert("请选择一行");
    	}else{ */
    		location.href="<%=basePath%>hrUser/getFormalInformationId.htm?id="+id+"&status="+status;
    	/* } */
    	
    }
    //员工退休
    function retireEmployee(id,status){
    	/* var selected = oTable.fnGetData(oTable.$('tr.row_selected').get(0));
    	if(selected.id==undefined){
    		alert("请选择一行");
    	}else{ */
    		location.href="<%=basePath%>hrUser/getRetirementInformationId.htm?id="+id+"&status="+status;
    	/* } */
    }
    //员工解聘
    function dismissalEmployee(id,status){
    	/* var selected = oTable.fnGetData(oTable.$('tr.row_selected').get(0));
    	if(selected.id==undefined){
    		alert("请选择一行");
    	}else{ */
    		location.href="<%=basePath%>hrUser/getDismissalInformationId.htm?id="+id+"&status="+status;
    	/* } */
    	
    }
    //员工离职
    function turnoverEmployee(id,status){
    /* 	var selected = oTable.fnGetData(oTable.$('tr.row_selected').get(0));
    	if(selected.id==undefined){
    		alert("请选择一行");
    	}else{ */
    		location.href="<%=basePath%>hrUser/getTurnoverInformationId.htm?id="+id+"&status="+status;
    	/* } */
    }
    //员工调动
    function transferEmployee(id,status){
    	/* var selected = oTable.fnGetData(oTable.$('tr.row_selected').get(0));
    	if(selected.id==undefined){
    		alert("请选择一行");
    	}else{ */
    		location.href="<%=basePath%>hrUser/getTransferInformationId.htm?id="+id+"&status="+status;
    	/* } */
    	
    }
    //员工返聘
    function rehiredEmployee(id,status){
    /* 	var selected = oTable.fnGetData(oTable.$('tr.row_selected').get(0));
    	if(selected.id==undefined){
    		alert("请选择一行");
    	}else{ */
    		location.href="<%=basePath%>hrUser/getRehiredInformationId.htm?id="+id+"&status="+status;
    	/* } */
    }
    function getDetailFun(id){
    	location.href="<%=basePath%>hrUser/getDetailUserById.htm?id="+id;
    }
    function searchRes(){
    	$('#myModal').modal('show');
    }
    function queryRes(){
    	$('#myModal').modal('hide');
    	oTable.fnDraw();   
    }
    
    //加载按钮
    
    
      $('<a href="javascript:void(0)" onclick="add()" id="addFun" class="btn btn-default" data-toggle="modal">新增</a>'
                            		+ '&nbsp;' +
                                    '<a href="javascript:void(0)" onclick="searchRes()" class="btn btn-query" id="editFun">高级查询</a> ' + '&nbsp;'
                                   /*  +  '<a href="javascript:void(0)" onclick="signContract()" class="btn btn-query" id="editFun">签订合同</a> ' + '&nbsp;'
                                    +  '<a href="javascript:void(0)" onclick="probationEmployee()" class="btn btn-query" id="editFun">员工试用</a> ' + '&nbsp;'
                                    +  '<a href="javascript:void(0)" onclick="formalEmployee()" class="btn btn-query" id="editFun">员工转正</a> ' + '&nbsp;'
                                    +  '<a href="javascript:void(0)" onclick="retireEmployee()" class="btn btn-query" id="editFun">员工退休</a> ' + '&nbsp;'
                                    +  '<a href="javascript:void(0)" onclick="dismissalEmployee()" class="btn btn-query" id="editFun">员工解聘</a> ' + '&nbsp;'
                                    +  '<a href="javascript:void(0)" onclick="turnoverEmployee()" class="btn btn-query" id="editFun">员工离职</a> ' + '&nbsp;'
                                    +  '<a href="javascript:void(0)" onclick="transferEmployee()" class="btn btn-query" id="editFun">员工调动</a> ' + '&nbsp;'
                                    +  '<a href="javascript:void(0)" onclick="rehiredEmployee()" class="btn btn-query" id="editFun">员工返聘</a> ' + '&nbsp;' */
                                    /* '<a href="#" class="btn btn-danger" id="deleteFun">删除</a>' + '&nbsp;' */
                                    ).appendTo($('.myBtnBox'));

    
    
    
    
    function initButton(json){
    	$.post("<%=basePath%>dict/initButton.htm",{},function(r){
    		       var str= '<a href="javascript:void(0)" onclick="add()" id="addFun" class="btn btn-default" data-toggle="modal">新增</a>'
              		+ '&nbsp;' +
                      '<a href="javascript:void(0)" onclick="searchRes()" class="btn btn-query" id="editFun">高级查询</a> ' + '&nbsp;'
                      +  '<a href="javascript:void(0)" onclick="signContract()" class="btn btn-query" id="editFun">签订合同</a> ' + '&nbsp;';
                      
	                  $(r.button).each(function(index,e){
	                	  str+= "<a href='javascript:void(0)' onclick='gotoJsp("+e.value+")' class='btn btn-query' id='editFun'>"+e.text+"</a>&nbsp;"
	                  })
	                  $(str).appendTo($('.myBtnBox'));
                      
    	},"json");
    	console.info(json);

    }
    //根据不同id 调用不同方法
    
    function gotoJsp(id){
    	if(id==328){
    		probationEmployee(id);
    	}
    	if(id==329){
    		formalEmployee(id);
    	}
    	if(id==330){
    		retireEmployee(id);
    	}
    	if(id==331){
    		dismissalEmployee(id);
    	}
    	if(id==332){
    		turnoverEmployee(id);
    	}
    	if(id==333){
    		transferEmployee(id);
    	}
    	if(id==334){
    		rehiredEmployee(id);
    	}
    }
    
    function showInfo(id){
    	if($("#more"+ id).attr("class").indexOf("glyphicon-chevron-up")>0){
    		$("#more"+ id).addClass("glyphicon-chevron-down");
        	$("#more"+ id).removeClass("glyphicon-chevron-up");
        	$("#a"+ id).hide();
        	$("#b"+ id).hide();
        	$("#c"+ id).hide();
        	$("#d"+ id).hide();
        	$("#e"+ id).hide();
        	$("#f"+ id).hide();
        	$("#g"+ id).hide();
        	$("#h"+ id).hide();
        	$("#i"+ id).hide();
        	$("#j"+ id).hide();
        	$("#k"+ id).hide();
    	}else{
    	$("#example tr div").hide();
    	var data = oTable.fnGetData();
		$(data).each(function(i,r){
			if(r.id!=id){
		    	$("#more"+ r.id).removeClass("glyphicon-chevron-down");
		    	$("#more"+ r.id).removeClass("glyphicon-chevron-up");
		    	$("#more"+ r.id).addClass("glyphicon-chevron-down");
			}			
		})
    	$("#more"+ id).addClass("glyphicon-chevron-up");
    	$("#more"+ id).removeClass("glyphicon-chevron-down");
    	$("#a"+ id).show();
    	$("#b"+ id).show();
    	$("#c"+ id).show();
    	$("#d"+ id).show();
    	$("#e"+ id).show();
    	$("#f"+ id).show();
    	$("#g"+ id).show();
    	$("#h"+ id).show();
    	$("#i"+ id).show();
    	$("#j"+ id).show();
    	$("#k"+ id).show();
    	}
    }
    
    </script>
    
    
  </body>
</html>
