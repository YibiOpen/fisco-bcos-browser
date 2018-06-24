<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Evidence Info</title>
    <%--公共的css和js文件--%>
    <%@ include file="../pages/comm/JSandCSS.jsp"%>
<body>
<div class="wrapper">
    <%@ include file="../pages/comm/header.jsp"%>

    <div class="breadcrumbs">
        <div class="container">
            <h1 class="pull-left">存证详情 &nbsp;<span class="lead-modify" id="pkHash" style="color: #999999">${pkHash}</span><br />
                <a id="Top"></a>
            </h1>
            <ul class="pull-right breadcrumb">
                <li><a href="../">首页</a></li>
                <li><a href="../transaction/transaction.page">存证</a></li>
                <li class="active">存证信息</li>
            </ul>
        </div>
    </div>



    <div class="profile container blockImfo">

        <span id="ContentPlaceHolder1_lblResult"><div style='margin-top:20px; margin-bottom:8px'></div></span><br />

        <div class="row">
            <form class="form-horizontal" role="form">
                <div class="form-group">
                    <label class="col-sm-1 control-label">证据地址</label>
                    <div class="col-sm-11">
                        <input style="width: 500px" type="text" id="address"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">
                        <button type="button" class="btn btn-info btn-sm" onclick="getDetail()">查看</button>
                    </label>
                </div>
            </form>
        </div>

        <div class="tab-v1">
            <ul class="nav nav-tabs" id='nav_tabs'>
                <li class="active"><a href="#overview" data-toggle="tab">存证查看</a></li>
                <%--<li id="ContentPlaceHolder1_li_disqus"><a href="#comments" data-toggle="tab">Comments</a></li>--%>
            </ul>

            <div class="tab-content" style="padding: 1px 0;">
                <div class="tab-pane fade in active" id="overview">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title">存证信息</h3>
                        </div>
                        <div id="ContentPlaceHolder1_maintable" class="container row" style="margin-top:30px" hidden="hidden">
                            <div class="col-sm-12">
                                存证信息：
                                <pre id="resultTransactionDetail"></pre>
                            </div>
                        </div>
                        <div>
                        </div>
                        <br />
                    </div>
                </div>

                <div class="tab-pane fade in" id="comments">
                    <div class="panel panel-info">
                        <div class="panel-body">
                            <div>
                                Make sure to use the "downvote" button for any spammy posts, and the "upvote" for interesting conversations.<br />
                                <div id="disqus_thread"></div>
                                <noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript" rel="nofollow">comments powered by Disqus.</a></noscript>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <br />
    </div>
</div>
</body>
<script type="text/javascript">
    //提示工具
    $("[rel='tooltip']").tooltip({ html: true });

    function getDetail() {
        //查询参数
        var paramData = {
            address: $("#address").val(),//交易hash
        }

        //获取交易详细信息
        $.ajax({
            url:'../evidence/getEvidenceInfo.json',//URI
            contentType:"application/json;charset=UTF-8",//设置头信息
            type:'post',
            cache:false,
            dataType:'json',
            data:JSON.stringify(paramData),
            success:function(DATA) {
                if(DATA.status==0){
                    //显示json
                    var jsonStr = JSON.stringify(DATA.data, null, 2);
                    $('#resultTransactionDetail').html(jsonStr);
                    $('#ContentPlaceHolder1_maintable').show();
                }else {
                    $('#ContentPlaceHolder1_maintable').hidden();
                    console.log("query fail:"+DATA);
                    alert("query fail:"+DATA.msg);
                }

            },
            error : function(DATA) {
                console.log("query fail:"+DATA);
            }
        });
    }

</script>
</html>
