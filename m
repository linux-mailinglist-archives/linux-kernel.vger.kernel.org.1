Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6448A2A22EC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 03:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgKBCQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 21:16:16 -0500
Received: from mail-eopbgr50044.outbound.protection.outlook.com ([40.107.5.44]:3911
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727409AbgKBCQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 21:16:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFhsydvlftvtXtFmTI8K9dO3RyU/mnhWkOWZbiohR3Dk/7ncdR66ils5N4F9DEspXIVi3gJsnKx7XAza5+6UUm25rUhz+J+tW4lkt+4AecMpurrotT0E6iga+21y/DCNXoiC2sgk8ZgKx7Ojk54mJLcTr6k+725LRg5yH7pUkwGRxPJDnhDBWNuMLzqvCGG3Z9oelKVzWVo1ENsmmXpoB45q622aB0ZyhZruvRXaPjBKJeESUDHSzcDe5uCc6WxlxKlJB20xWdq1VFQYUxpKEamiWCtsJ47xeMXXm0u2aeTzxwh3KTcPvuCxniFYRxBsz+lKLT7GvAcMjVFKAxIiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pe0kw8CvZxaLfxZuSO80sx5nGrGjUpJ4Ic5VbKNkRpk=;
 b=eia38gMgsKNBRjuyygt4R3oaXp441oSbyfoz1zg+rxsq1Dj1ORU33VJIPAOf3ErCFwFJUY8Cclk1ve9LuvgwIS8UwABLuVMwYMHYriLS4ZrlMJrMRGzLms9yUQ4sYBJdKPiIzYZDcm3eVy0I7O5us7J81ezPy5lys13RksRIL2JTkfG7IiLlRXBUqoRlnasNE0hc1HQ27WioRMHC8VaXDPiID93qJLfq1LRt2Uyna0rfjkx2wSWiWCKNNCSJv8RB/hJKsYYmtcqvkAPXRJbG/xO889robXubS8oeSqbfZI4zUtNBSZwcrTAOluJa2khayEGH6SbuAINJBQyhU+azFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pe0kw8CvZxaLfxZuSO80sx5nGrGjUpJ4Ic5VbKNkRpk=;
 b=L7dmFRPR6xq1YlFXAiJZb57KXVNR6NClc1Ig3Rh5VINyBTzMkpe0tNnp5aIKsucaW5rEa6iD9/rI0oLL4oENoALcv4caH8ZC2HrVIDUPzX2X7Vya3AwVLWWdMMdDFbrinRc2RcYISU2cXmDk1hCUtOc+eGM67vKIoXzfoSzPzrM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBBPR04MB7996.eurprd04.prod.outlook.com (2603:10a6:10:1e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 02:16:10 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc%8]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 02:16:10 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mkl@pengutronix.de
Subject: [PATCH V2] arm64: dts: imx8mp-evk: add CAN support
Date:   Mon,  2 Nov 2020 10:16:34 +0800
Message-Id: <20201102021634.6480-1-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0087.apcprd06.prod.outlook.com
 (2603:1096:3:14::13) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR06CA0087.apcprd06.prod.outlook.com (2603:1096:3:14::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Mon, 2 Nov 2020 02:16:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9293c0f5-8243-4033-ad97-08d87ed543ab
X-MS-TrafficTypeDiagnostic: DBBPR04MB7996:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB799649B25935FF5163788F28E6100@DBBPR04MB7996.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:234;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHgcTfCREmIqjBAkT1JgdG78D2AgopgESky95QgbiTrewBFWybbkXF2l/Sxw5eZG+jveXX0tXmmsdYkGisYdPlc+sUfJZNtJQGItWZeUxxkAk5zeXS3xQd/mFKFA6Kqc5rA8sMIO+O2/vARMqtaSTjQo7Zp4uPL6/1EgdkHjl+bWp44WhSQMyfqND8Pb+fUuz2e1CbvZTxUCtc80tUjl/NxZnALadGhpPjmRgGLUM5++qidbIfUpdBG/Hs+ykzkhEub+JfKqps7G825z0GdzRW3unAhVskT8qlkgilCOg6K/Jk9xshPcROeEcvUJuZDd4ABKuiUlTJ0OUg02DDn28p2q2IjmQSVOPztlfhkXa6pkbppv+j3wsm49oOGzbqf/ChI4ey8/SpaauaPR0RGBxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(66476007)(478600001)(83380400001)(26005)(6486002)(6512007)(66946007)(52116002)(2616005)(66556008)(5660300002)(86362001)(1076003)(69590400008)(4326008)(8936002)(2906002)(956004)(6666004)(8676002)(16526019)(36756003)(186003)(6506007)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: IXcHV+CBTfeK/7GVPCnUQ/utr5WpBxItBvciut18QK//PmJi5dzITNjOx2BpSuYkNmjCXhke8h0km8CzB+AfpMLhgyAjzlqnHYICgbXguFD37dviVja1QRifO00qOzOVNcGRcT4PkB6iNREIlEAqaaJPS7WsGbaqDMLya+WcAZ4ck1VgRUY1iRuWarV1ce2h4X1sBBpZHwlefARyF718fRGM9VqoQRZgfUBtezq/DBeZj29BS3F8aGLWSfHkPeDurJDaC92gQfE6apQ/4etxOJgaldrOOCze8aA6eStCxnkWRT+eyv3hS7Q9rtA0DWtHK5zeWkP1IKhK4bjxu3iLYK6NQHJK7HevLURD3RziBpxz0f3RlNRMlr0P//UyIycThKfCuVe9URh76EWmgMirzEtDtdWRwdMi0dXHpaE0FzUdQKGJdWn9T1rZbifYFT0Zdfny8Ee0PbYILW6MEFllsVI/o5LDDxpp0TROdrz0SnoaPsCAearYA7gHRzdtznuBkEUG6gMlMr/DScbO9fnltHGbavzdFLOZ02doRoDu02rbcaOlf0XmZtD/69YK1O+HN8KpXtXZYtpv70yWsg5OYjPLbw1j6l5K9tHj9l23urueUbrvebF4xjsp4v4/59wq1DltYsORcT2yMk5fnRNEGg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9293c0f5-8243-4033-ad97-08d87ed543ab
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 02:16:10.4469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+dk29sKRejOjU8A/fXYv9FNLhXii8zPVMcU7pABUxvhjqh4Q6F+z0mbfainhXuGiU+VD2N/3ZMi4J/qYvXx3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7996
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CAN device node and pinctrl on i.MX8MP evk board.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
ChangeLogs:
V1->V2:
	* add missing space before '=',
	fsl,clk-source= /bits/ 8 <0> -> fsl,clk-source = /bits/ 8 <0>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 62 ++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi    | 30 ++++++++++
 2 files changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 908b92bb4dcd..b10dce8767a4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -33,6 +33,28 @@
 		      <0x1 0x00000000 0 0xc0000000>;
 	};
 
+	reg_can1_stby: regulator-can1-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "can1-stby";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan1_reg>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio5 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_can2_stby: regulator-can2-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "can2-stby";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan2_reg>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -45,6 +67,20 @@
 	};
 };
 
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_can1_stby>;
+	status = "okay";
+};
+
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_can2_stby>;
+	status = "disabled";/* can2 pin conflict with pdm */
+};
+
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
@@ -144,6 +180,32 @@
 		>;
 	};
 
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_RX__CAN1_RX          0x154
+			MX8MP_IOMUXC_SPDIF_TX__CAN1_TX          0x154
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_MCLK__CAN2_RX         0x154
+			MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX         0x154
+		>;
+	};
+
+	pinctrl_flexcan1_reg: flexcan1reggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05  0x154   /* CAN1_STBY */
+		>;
+	};
+
+	pinctrl_flexcan2_reg: flexcan2reggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27      0x154   /* CAN2_STBY */
+		>;
+	};
+
 	pinctrl_gpio_led: gpioledgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x19
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 479312293036..ecccfbb4f5ad 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -552,6 +552,36 @@
 				status = "disabled";
 			};
 
+			flexcan1: can@308c0000 {
+				compatible = "fsl,imx8mp-flexcan", "fsl,imx6q-flexcan";
+				reg = <0x308c0000 0x10000>;
+				interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MP_CLK_IPG_ROOT>,
+					 <&clk IMX8MP_CLK_CAN1_ROOT>;
+				clock-names = "ipg", "per";
+				assigned-clocks = <&clk IMX8MP_CLK_CAN1>;
+				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_40M>;
+				assigned-clock-rates = <40000000>;
+				fsl,clk-source = /bits/ 8 <0>;
+				fsl,stop-mode = <&gpr 0x10 4>;
+				status = "disabled";
+			};
+
+			flexcan2: can@308d0000 {
+				compatible = "fsl,imx8mp-flexcan", "fsl,imx6q-flexcan";
+				reg = <0x308d0000 0x10000>;
+				interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MP_CLK_IPG_ROOT>,
+					 <&clk IMX8MP_CLK_CAN2_ROOT>;
+				clock-names = "ipg", "per";
+				assigned-clocks = <&clk IMX8MP_CLK_CAN2>;
+				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_40M>;
+				assigned-clock-rates = <40000000>;
+				fsl,clk-source = /bits/ 8 <0>;
+				fsl,stop-mode = <&gpr 0x10 5>;
+				status = "disabled";
+			};
+
 			crypto: crypto@30900000 {
 				compatible = "fsl,sec-v4.0";
 				#address-cells = <1>;
-- 
2.17.1

