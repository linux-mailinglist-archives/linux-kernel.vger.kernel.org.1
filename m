Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506542C82C7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbgK3LCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:02:49 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:48637 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727534AbgK3LCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:02:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606734147; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=OLXWNZc5h5uKDqDgsopyTd97mNlNgbDqil9da9/CCf8=; b=E8IJRwUEzDNBs9k4rTnGhoUtRfAQhjynaiIi+148M/nSDznizd0q/ueeCv9Ptxl2Sjqd3exU
 7VkI/P0hLqXJmhngbj2T24PCDtKIxtTi7nfxlbT9eBnORct1P1V6u5WdqPaJwiSMyJ/m91kP
 BlepNp5RX9UeYT/lt9QkzEg42oA=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5fc4d12a22377520ee814211 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 30 Nov 2020 11:02:02
 GMT
Sender: kathirav=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1D495C43466; Mon, 30 Nov 2020 11:02:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from kathirav-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kathirav)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6D996C43460;
        Mon, 30 Nov 2020 11:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6D996C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kathirav@codeaurora.org
From:   Kathiravan T <kathirav@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kathirav@codeaurora.org,
        Anusha Canchi Ramachandra Rao <anusharao@codeaurora.org>
Subject: [PATCH V3 1/1] arm64: dts: ipq6018: Add the QPIC peripheral nodes
Date:   Mon, 30 Nov 2020 16:31:45 +0530
Message-Id: <1606734105-12414-2-git-send-email-kathirav@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606734105-12414-1-git-send-email-kathirav@codeaurora.org>
References: <1606734105-12414-1-git-send-email-kathirav@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the QPIC BAM and QPIC NAND controller support and
enable the same in board DTS file.

Co-developed-by: Anusha Canchi Ramachandra Rao <anusharao@codeaurora.org>
Signed-off-by: Anusha Canchi Ramachandra Rao <anusharao@codeaurora.org>
Signed-off-by: Kathiravan T <kathirav@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts | 16 ++++++++
 arch/arm64/boot/dts/qcom/ipq6018.dtsi        | 41 ++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
index e8eaa958c199..99cefe88f6f2 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
+++ b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
@@ -62,3 +62,19 @@ spi_0_pins: spi-0-pins {
 		bias-pull-down;
 	};
 };
+
+&qpic_bam {
+	status = "okay";
+};
+
+&qpic_nand {
+	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+		nand-bus-width = <8>;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index cdc1e3d60c58..5372ec12cdad 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -231,6 +231,17 @@ serial_3_pins: serial3-pinmux {
 				drive-strength = <8>;
 				bias-pull-down;
 			};
+
+			qpic_pins: qpic-pins {
+				pins = "gpio1", "gpio3", "gpio4",
+					"gpio5", "gpio6", "gpio7",
+					"gpio8", "gpio10", "gpio11",
+					"gpio12", "gpio13", "gpio14",
+					"gpio15", "gpio17";
+				function = "qpic_pad";
+				drive-strength = <8>;
+				bias-disable;
+			};
 		};
 
 		gcc: gcc@1800000 {
@@ -332,6 +343,36 @@ i2c_1: i2c@78b7000 { /* BLSP1 QUP2 */
 			status = "disabled";
 		};
 
+		qpic_bam: dma-controller@7984000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x0 0x07984000 0x0 0x1a000>;
+			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_QPIC_CLK>,
+				 <&gcc GCC_QPIC_AHB_CLK>;
+			clock-names = "iface_clk", "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			status = "disabled";
+		};
+
+		qpic_nand: nand@79b0000 {
+			compatible = "qcom,ipq6018-nand";
+			reg = <0x0 0x079b0000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&gcc GCC_QPIC_CLK>,
+				 <&gcc GCC_QPIC_AHB_CLK>;
+			clock-names = "core", "aon";
+
+			dmas = <&qpic_bam 0>,
+				<&qpic_bam 1>,
+				<&qpic_bam 2>;
+			dma-names = "tx", "rx", "cmd";
+			pinctrl-0 = <&qpic_pins>;
+			pinctrl-names = "default";
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@b000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

