Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 795461A1814
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 00:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgDGWYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 18:24:46 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:61044 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbgDGWYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 18:24:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586298282; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Imil9AjSTOr7fzSdf9HIL72Sr8OKj1T2LJjdyGPinNs=; b=s4RJRTPaQGB7EmuhMXkjJoshPwTwxjdTW9dlZ3feq/585mMBTYATc/fiOdeTtQq9soi+aKpX
 IAB3uIrgG8Yg6r1BJP/DJcrGvsjnrUfhMAIFudafEgX6bHY8WHyjy7ccJCqGK5VMe17u5N1y
 a4/AUMZFiZXTFNjKmKMJ3pTOa60=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8cfdaa.7f7d47d9e8f0-smtp-out-n01;
 Tue, 07 Apr 2020 22:24:42 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 39083C433D2; Tue,  7 Apr 2020 22:24:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 412DCC43637;
        Tue,  7 Apr 2020 22:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 412DCC43637
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        vinod.koul@linaro.org, Jack Pham <jackp@codeaurora.org>,
        Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH v3 2/2] arm64: dts: qcom: sm8150: Add USB and PHY device nodes
Date:   Tue,  7 Apr 2020 15:24:27 -0700
Message-Id: <1586298267-4722-3-git-send-email-wcheng@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1586298267-4722-1-git-send-email-wcheng@codeaurora.org>
References: <1586298267-4722-1-git-send-email-wcheng@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jack Pham <jackp@codeaurora.org>

Add device nodes for the USB3 controller, QMP SS PHY and
SNPS HS PHY.

Signed-off-by: Jack Pham <jackp@codeaurora.org>
Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Vinod Koul <vinod.koul@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150-mtp.dts | 21 ++++++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi    | 92 +++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
index 8ab1661..6c6325c 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
@@ -408,3 +408,24 @@
 	vdda-pll-supply = <&vreg_l3c_1p2>;
 	vdda-pll-max-microamp = <19000>;
 };
+
+&usb_1_hsphy {
+	status = "okay";
+	vdda-pll-supply = <&vdd_usb_hs_core>;
+	vdda33-supply = <&vdda_usb_hs_3p1>;
+	vdda18-supply = <&vdda_usb_hs_1p8>;
+};
+
+&usb_1_qmpphy {
+	status = "okay";
+	vdda-phy-supply = <&vreg_l3c_1p2>;
+	vdda-pll-supply = <&vdda_usb_ss_dp_core_1>;
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "peripheral";
+};
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 141c21d..fd6c83a 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -621,6 +621,98 @@
 			};
 		};
 
+		usb_1_hsphy: phy@88e2000 {
+			compatible = "qcom,usb-snps-hs-7nm-phy",
+							"qcom,sm8150-usb-hs-phy";
+			reg = <0 0x088e2000 0 0x400>;
+			status = "disabled";
+			#phy-cells = <0>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+		};
+
+		usb_1_qmpphy: phy@88e9000 {
+			compatible = "qcom,sm8150-qmp-usb3-phy";
+			reg = <0 0x088e9000 0 0x18c>,
+			      <0 0x088e8000 0 0x10>;
+			reg-names = "reg-base", "dp_com";
+			status = "disabled";
+			#clock-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
+			clock-names = "aux", "ref_clk_src", "ref", "com_aux";
+
+			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
+				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
+			reset-names = "phy", "common";
+
+			usb_1_ssphy: lanes@88e9200 {
+				reg = <0 0x088e9200 0 0x200>,
+				      <0 0x088e9400 0 0x200>,
+				      <0 0x088e9c00 0 0x218>,
+				      <0 0x088e9600 0 0x200>,
+				      <0 0x088e9800 0 0x200>,
+				      <0 0x088e9a00 0 0x100>;
+				#phy-cells = <0>;
+				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "usb3_phy_pipe_clk_src";
+			};
+		};
+
+		usb_1: usb@a6f8800 {
+			compatible = "qcom,sdm845-dwc3", "qcom,dwc3";
+			reg = <0 0x0a6f8800 0 0x400>;
+			status = "disabled";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			dma-ranges;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB3_SEC_CLKREF_CLK>;
+			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
+				      "sleep", "xo";
+
+			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <150000000>;
+
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq", "ss_phy_irq",
+					  "dm_hs_phy_irq", "dp_hs_phy_irq";
+
+			power-domains = <&gcc USB30_PRIM_GDSC>;
+
+			resets = <&gcc GCC_USB30_PRIM_BCR>;
+
+			usb_1_dwc3: dwc3@a600000 {
+				compatible = "snps,dwc3";
+				reg = <0 0x0a600000 0 0xcd00>;
+				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
+				phy-names = "usb2-phy", "usb3-phy";
+			};
+		};
+
 		aoss_qmp: power-controller@c300000 {
 			compatible = "qcom,sm8150-aoss-qmp";
 			reg = <0x0 0x0c300000 0x0 0x100000>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
