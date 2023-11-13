﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Wxpay.aspx.cs" Inherits="Game.Web.Pay.WX.Wxpay" %>
<%@ Register TagPrefix="qp" TagName="Header" Src="~/Themes/Standard/Common_Header.ascx" %>
<%@ Register TagPrefix="qp" TagName="Footer" Src="~/Themes/Standard/Common_Footer.ascx" %>
<%@ Register TagPrefix="qp" TagName="PaySidebar" Src="~/Themes/Standard/Pay_Sidebar.ascx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="/css/base.css" rel="stylesheet" type="text/css" />
    <link href="/css/common.css" rel="stylesheet" type="text/css" />
    <link href="/css/pay/pay-bank.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/js/jquery.min.js"></script>
    <script src="/js/Check.js" type="text/javascript"></script>
    <script src="/js/utils.js" type="text/javascript"></script>    
</head>
<body>
    <!--头部开始-->
    <qp:Header ID="sHeader" runat="server" PageID="5"/>
    <!--头部结束-->

    <div class="ui-banner">
      <div class="ui-banner-bg-1"></div>
      <div class="ui-banner-bg-2"></div>
      <div class="ui-carousel-right">
        <div class="ui-carousel-left">
          <div class="ui-banner-img">
            <a href="javascript:;"><img src="/images/banner_2.png"></a>
          </div>
        </div>
      </div>
    </div>

    <div class="ui-content">
      <div class="ui-main">
        <div class="ui-page-title fn-clear">
          <a href="/index.aspx"><i class="ui-page-title-home"></i>首页</a>
          <i class="ui-page-title-current"></i>
          <a href="/Pay/index.aspx">充值中心</a>
          <i class="ui-page-title-current"></i>
          <span>账户充值</span>
          <div class="ui-page-title-right"><span>PAY&nbsp;CENTER</span><strong>账户充值</strong></div>
        </div>
        <div class="fn-clear">
          <!--左边开始-->
          <qp:PaySidebar ID="sPaySidebar" runat="server" PayID="13"/>
          <!--左边结束-->
          <div class="ui-main-details fn-right">
            <div class="ui-pay-step">
              <h2 class="ui-title-solid">充值流程</h2>
              <img src="/images/pay_step.png" />
            </div>
            <div class="ui-pay-way">
              <h2 class="ui-title-solid">您选择了&nbsp;<span>微信支付</span>&nbsp;方式</h2>
              <form name="fmStep1" runat="server" id="fmStep1">
                <script type="text/javascript">
                    $(document).ready(function () {
                        $("#txtPayAccounts").blur(function () { checkAccounts(); });
                        $("#txtPayReAccounts").blur(function () { checkReAccounts(); });
                        $("#txtPayAmount").blur(function () { checkAmount(); });

                        $("#btnPay").click(function () {
                            return checkInput();
                        });

                        $('#ddlCurrenry').change(function () {
                            $('#amount').html($(this).val());
                        });
                    });

                    function checkAccounts() {
                        if ($.trim($("#txtPayAccounts").val()) == "") {
                            $("#txtPayAccountsTips").html("请输入您的游戏帐号");
                            return false;
                        }
                        $("#txtPayAccountsTips").html("");
                        return true;
                    }

                    function checkReAccounts() {
                        if ($.trim($("#txtPayReAccounts").val()) == "") {
                            $("#txtPayReAccountsTips").html("请再次输入游戏帐号");
                            return false;
                        }
                        if ($("#txtPayReAccounts").val() != $("#txtPayAccounts").val()) {
                            $("#txtPayReAccountsTips").html("两次输入的帐号不一致");
                            return false;
                        }
                        $("#txtPayReAccountsTips").html("");
                        return true;
                    }

                    function checkAmount() {
                        var amount = $('#ddlCurrenry').val();
                        if (amount == "0") {
                            $("#ddlCurrenryTips").html("请选择充值额度");
                            return false;
                        }
                        $("#ddlCurrenryTips").html("");
                        return true;
                    }

                    function checkInput() {
                        if (!checkAccounts()) { $("#txtPayAccounts").focus(); return false; }
                        if (!checkReAccounts()) { $("#txtPayReAccounts").focus(); return false; }
                        if (!checkAmount()) { return false; }
                    }
                </script>
                <ul>
                  <li>
                    <label>游戏帐号：</label>
                    <asp:TextBox ID="txtPayAccounts" runat="server" CssClass="ui-text-1"></asp:TextBox>
                    <span id="txtPayAccountsTips" style=" color:Red"></span>
                  </li>
                  <li>
                    <label>确认帐号：</label>
                    <asp:TextBox ID="txtPayReAccounts" runat="server" CssClass="ui-text-1"></asp:TextBox>
                    <span id="txtPayReAccountsTips" style="color:Red;"></span>
                  </li>
                  <li>
                    <label>充值游戏豆：</label>
                    <asp:DropDownList ID="ddlCurrenry" runat="server" CssClass="text">
                    </asp:DropDownList>
                    <span id="ddlCurrenryTips" style="color:Red;"></span>
                  </li>
                  <li>
                    <label>支付金额：</label>
                    <span id="amount">0</span>&nbsp;元
                  </li>
                  <li>
                    <asp:Button ID="btnPay" runat="server" CssClass="ui-btn-1" Text="确定" onclick="btnPay_Click" />
                  </li>
                </ul>
              </form>

              <form id="fmStep2" runat="server" action="/Pay/WX/WxCode.aspx" method="post">
        	     <div class="ui-result">
                    <p>
                        <asp:Label ID="lblAlertIcon" runat="server"></asp:Label>
                        <asp:Label ID="lblAlertInfo" runat="server" Text="操作提示"></asp:Label>
                        <%= formData%>
                    </p>
                    <p id="pnlContinue" runat="server">
                        <input id="btnReset1" type="button" value="继续充值" onclick="goURL('/Pay/WX/Wxpay.aspx');" class="ui-btn-1" />
                    </p>
                </div>
             </form>
             <%= js %>
            </div>
            <div class="ui-pay-alert">
              <h2 class="ui-title-solid">温馨提示</h2>
              <p>1、请确保您填写的帐号正确无误。</p>
              <p>2、充值过程中，浏览器会跳转至银行页面，支付成功后，会自动返回网站，如果没有跳转或是弹出充值成功的页面，请
                您不要关闭充值窗口。</p>
              <p>3、遇到任何充值问题，请您联系客服中心。</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!--尾部开始-->
    <qp:Footer ID="sFooter" runat="server" />
    <!--尾部结束-->
</body>
</html>
