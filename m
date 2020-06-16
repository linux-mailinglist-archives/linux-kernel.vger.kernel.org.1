Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17451FA503
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 02:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgFPAWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 20:22:38 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:35802 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725960AbgFPAWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 20:22:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592266956; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=Mx3uyslVkwrYk9S4RNuEP4zAhRekk8MfjkBR3eyltiE=; b=O7ZcDqNUKZ7OunISyx0dfV91rVVWczmhnDGtAjlo9iM5A8WWIvSqkjyqTCVAeBVxgLmtEiAe
 fAeR4ymPziPiJQ+wj//9AG9oxu5Pznx00nB1sicRmiFIXljRz45paOc+8ZcxwrOZU9ldd7F/
 63XbQQ2TEPAN07boyv4Ve688q0E=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-west-2.postgun.com with SMTP id
 5ee810cbe144dd5115e9e34d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Jun 2020 00:22:35
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 61AE9C433CB; Tue, 16 Jun 2020 00:22:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from linuxdisplay-lab-04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tanmay)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4BBD9C433CA;
        Tue, 16 Jun 2020 00:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4BBD9C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tanmay@codeaurora.org
From:   Tanmay Shah <tanmay@codeaurora.org>
To:     swboyd@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        sam@ravnborg.org, seanpaul@chromium.org, robdclark@gmail.com,
        aravindh@codeaurora.org, abhinavk@codeaurora.org
Subject: [PATCH v1] arm64: dts: qcom: sc7180: Add Display Port dt node
Date:   Mon, 15 Jun 2020 17:22:15 -0700
Message-Id: <20200616002215.32207-1-tanmay@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable DP driver for sc7180.

This change depends-on following series:
https://patchwork.freedesktop.org/series/78247/
and https://patchwork.freedesktop.org/patch/351990/

Signed-off-by: Tanmay Shah <tanmay@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 58 ++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 998f101ad623..989960d2200b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1557,10 +1557,19 @@ ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
 
+					port@1 {
+						reg = <1>;
+						dpu_intf1_out: endpoint {
+							remote-endpoint =
+								 <&dsi0_in>;
+						};
+					};
+
 					port@0 {
 						reg = <0>;
-						dpu_intf1_out: endpoint {
-							remote-endpoint = <&dsi0_in>;
+						dpu_intf0_out: endpoint {
+							remote-endpoint =
+								 <&dp_in>;
 						};
 					};
 				};
@@ -1634,6 +1643,47 @@ dsi_phy: dsi-phy@ae94400 {
 			};
 		};
 
+		msm_dp: displayport-controller@ae90000{
+			status = "ok";
+			cell-index = <0>;
+			compatible = "qcom,dp-display";
+
+			reg = <0 0xae90000 0 0x1400>;
+			reg-names = "dp_controller";
+
+			interrupt-parent = <&mdss>;
+			interrupts = <12 0>;
+
+			clocks = <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
+				 <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
+				 <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
+				 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>,
+				 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
+			clock-names = "core_aux", "ctrl_link",
+				      "ctrl_link_iface", "stream_pixel",
+				      "pixel_rcg";
+			#clock-cells = <1>;
+
+			data-lanes = <0 1>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@0 {
+					reg = <0>;
+					dp_in: endpoint {
+						remote-endpoint =
+							 <&dpu_intf0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					dp_out: endpoint { };
+				};
+			};
+		};
+
 		dispcc: clock-controller@af00000 {
 			compatible = "qcom,sc7180-dispcc";
 			reg = <0 0x0af00000 0 0x200000>;
@@ -1641,8 +1691,8 @@ dispcc: clock-controller@af00000 {
 				 <&gcc GCC_DISP_GPLL0_CLK_SRC>,
 				 <&dsi_phy 0>,
 				 <&dsi_phy 1>,
-				 <0>,
-				 <0>;
+				 <&msm_dp 0>,
+				 <&msm_dp 1>;
 			clock-names = "bi_tcxo",
 				      "gcc_disp_gpll0_clk_src",
 				      "dsi0_phy_pll_out_byteclk",
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

