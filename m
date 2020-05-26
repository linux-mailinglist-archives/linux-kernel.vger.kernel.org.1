Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF011BBFC7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 15:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgD1NjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 09:39:00 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:11654 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727824AbgD1Niz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:38:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588081134; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=NUqZ6nBRUTDuFsuKEN4/TdAg0ONBkj78rZ9jiUu6P8I=; b=g/lIuDSBIKmSwZZyMjsUxh7Tf+hy94nbuFXgzWqxKmg6MYPk4Zb2vgM/rOSHp3V6Ap9uoq71
 SVL8t9h2RU2UrObywzrXFqwp/oVsCsnxZN9/Dd+CSorFhSYrweMJ4xP/65hNGM6z5Tz0coI+
 jF7o3azyGTI/d7c7Ug9DAcoNRoI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea831ee.7f7765bd8a78-smtp-out-n02;
 Tue, 28 Apr 2020 13:38:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D33EAC4478C; Tue, 28 Apr 2020 13:38:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CC6DDC4478C;
        Tue, 28 Apr 2020 13:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC6DDC4478C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v3 04/17] arm64: dts: sc7180: Add OPP table for all qup devices
Date:   Tue, 28 Apr 2020 19:02:52 +0530
Message-Id: <1588080785-6812-5-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588080785-6812-1-git-send-email-rnayak@codeaurora.org>
References: <1588080785-6812-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qup has a requirement to vote on the performance state of the CX domain
in sc7180 devices. Add OPP tables for these and also add power-domains
property for all qup instances.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 79 ++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 998f101..efba600 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -417,6 +417,25 @@
 			status = "disabled";
 		};
 
+		qup_opp_table: qup-opp-table {
+			compatible = "operating-points-v2";
+
+			opp-75000000 {
+				opp-hz = /bits/ 64 <75000000>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+			};
+
+			opp-100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+				required-opps = <&rpmhpd_opp_svs>;
+			};
+
+			opp-128000000 {
+				opp-hz = /bits/ 64 <128000000>;
+				required-opps = <&rpmhpd_opp_nom>;
+			};
+		};
+
 		qupv3_id_0: geniqup@8c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0 0x008c0000 0 0x6000>;
@@ -452,6 +471,8 @@
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -463,6 +484,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart0_default>;
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -476,6 +499,8 @@
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -489,6 +514,8 @@
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -500,6 +527,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart1_default>;
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -513,6 +542,8 @@
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -524,6 +555,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart2_default>;
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -537,6 +570,8 @@
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -550,6 +585,8 @@
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -561,6 +598,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart3_default>;
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -574,6 +613,8 @@
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -585,6 +626,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart4_default>;
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -598,6 +641,8 @@
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -611,6 +656,8 @@
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -622,6 +669,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart5_default>;
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 		};
@@ -661,6 +710,8 @@
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -672,6 +723,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart6_default>;
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -685,6 +738,8 @@
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -696,6 +751,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart7_default>;
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -709,6 +766,8 @@
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -722,6 +781,8 @@
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -733,6 +794,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart8_default>;
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -746,6 +809,8 @@
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -757,6 +822,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart9_default>;
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -770,6 +837,8 @@
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -783,6 +852,8 @@
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -794,6 +865,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart10_default>;
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -807,6 +880,8 @@
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -820,6 +895,8 @@
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -831,6 +908,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart11_default>;
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SC7180_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 		};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
