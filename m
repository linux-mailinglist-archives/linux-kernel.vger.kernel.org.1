Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E5A2E7086
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 13:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgL2ML0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 07:11:26 -0500
Received: from mail-eopbgr10077.outbound.protection.outlook.com ([40.107.1.77]:19458
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbgL2MLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 07:11:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiCSj5jFaZTC8opcuypJfXdHthp8ybC8UjhSSr7ZLkuQsbLvSCGjfz8eW3fZe0nFiai9W/bsvpGDkO48NJwNM2WhgmwK1gdB61HCXQMTwuf5vuQZmlXj3gj+BIBtK26HdXtCg/1Wvfbb+Y8E67OoREXF0uaLB3YVE8LAub5I0Hwmpwh0tPDU3WZ38zenxT+YlArKxX+wEpLhLvCY4tftFO4ulQ9N/n9epbi7Sx+PWFpn9YJZhS2/TNjvNAwBpxfWNCcMcFH9sDpZQcDsUCvoiVZZ6yrTbtlywKh7YVLppuJ0lJXQYwRigdmAIX7EUtppEHcPVE+VUD5oERHkYKDsVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyrFjO997mP1e+WID6ocGgB9QyDwBvRRGXChJ/vcE7k=;
 b=Dlbm6PXFNuh9ltTXVDNzBWowfe+MUv8dqyrw/1ocY5CdiKK3N19LivB1rJe4sX/ONzX0li59l8wGOlVL2M5o5wYtgdokysOiGPqLtJKgFzmF61s1n147BWgw17spxFabncax3sp7+iqypr64lYsNFnk5Jq2sUwYktJ5hZMhJyEcwk9nQFytiFAW60MnSgsMzx5bATTsHd/DvwNW2SGfR55bXD3pX3glTlcrcnK2/KZs3IVaS/RuCG+Cwc2PQ2XJrC9L/dKTr+yUmKha619FtN9Bc+YwYZx999K7g+RGy5PrA/vWFxWe+v96miXjmWrxPXu5qAil19uvoHvshS8PszA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyrFjO997mP1e+WID6ocGgB9QyDwBvRRGXChJ/vcE7k=;
 b=d6//lwsahS/+0ZX2PhiVfNRQSBRAbRbaibq0CT6cyUdzWzEyyscTUgfamxu3SOXHMPeM4e4ACnxU9zV+OCqkPMRy1Ajzfr1Q9GzjNaWsB04wJLr1558OtCNu9ik2C1V58BaExMqI4+A1BfFpxS1bAka07TC5+SYJUpcikYEyOfI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7948.eurprd04.prod.outlook.com (2603:10a6:10:1e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.31; Tue, 29 Dec
 2020 12:09:58 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5%10]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 12:09:58 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzk@kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/4] arm64: dts: imx8mn: add spba bus node of aips3
Date:   Tue, 29 Dec 2020 20:00:42 +0800
Message-Id: <1609243245-9671-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609243245-9671-1-git-send-email-peng.fan@nxp.com>
References: <1609243245-9671-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR03CA0161.apcprd03.prod.outlook.com
 (2603:1096:4:c9::16) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0161.apcprd03.prod.outlook.com (2603:1096:4:c9::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3721.12 via Frontend Transport; Tue, 29 Dec 2020 12:09:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86e664e3-12e8-4128-660b-08d8abf2a96c
X-MS-TrafficTypeDiagnostic: DBBPR04MB7948:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7948E732CEB3A642D82DD81088D80@DBBPR04MB7948.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZJvM3hV4TmdFCOBqIaOAu8jA0ncZSV6ZRFUK49HRcN7CXhAde9n9lcsgSRM6oev28rekSsv7zvl380UEEeoSpxxQ3xI2a6PPhFcZhaj7FTBjG7e4y9OdhvUn/PmME8MgoEMFOjVxOcpAxy46MPZzvvaXSX5sTnJBhs4fqg3iu+nkzZ1nFyB6jWVvuwLCPZxhuDNy+ljmAR3bq3H1muQSHrnq0d2DMlXUHS1yas39QJfm3hMHmJkng1MmWylamr7hXtTT0WK/zZOu9kjXuxUG3deLQM0OWAmQ3J5DbJYrtpGpTa5rW8rvzLpBJiEboGkrkobqh1vOYGrlStG63kS3KhSAPWC6AtICIAAJUpi9XdNH/fQ4s4gS8iMVY+PE8Mk1Jb8/Uwv0yOadfqKXxRs0texyslkocX0i6q7jvJ3MKG5dnTL6QuBI4H0xbHW6h1RhsauM65FevxqApCYtc32NitrrWCdtOR0f7+CXjiyJy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(6666004)(498600001)(6506007)(52116002)(956004)(2616005)(2906002)(69590400010)(6486002)(36756003)(66556008)(8936002)(4326008)(9686003)(6512007)(186003)(16526019)(5660300002)(66476007)(83380400001)(66946007)(26005)(8676002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8pQ0JdUmUPRXPqgyOqy3dHwNCRlU75tlw8xRH6EEFRr5qL+HEDq1yyn3eYdZ?=
 =?us-ascii?Q?c8K1XZJo4OvJKVlCZznZjhoSEm7x+I5N/fL/ZMKa8/SZkupBSjd1MxjAuywe?=
 =?us-ascii?Q?Us//XMAoE4P2C7yCs0GMdidjNwRhzHzyT1vsG00tAczMxdNEOtCXa9E4hT8D?=
 =?us-ascii?Q?Cd4AP0kYOnHEvOO4dB1vkV9NhzqenRZ96OGfDfqcChcOUSFZmlLZLFF3Xn33?=
 =?us-ascii?Q?90bMYvT8ZncxT8CK8FrREbv8HZ8tRtvO2EJZ/2WsiUFL9adMSvhPyDd0sJQM?=
 =?us-ascii?Q?cUF8ElcFaJ6GNFe2erPJKf5UbCZ91/skn2Mo/HJpNVTNqE6MsNLlaobjTreb?=
 =?us-ascii?Q?txiL3FWzX93XtRUk8wlPUb2PrrpDfAJDq4CRLyWOkgKmxFRxL0nTF7+ZsZHH?=
 =?us-ascii?Q?456ARkD+uRl1icQ3ZlKGwVgbCbWi6hdtqTG9Uahx3AgtaWSVcQsUJdN/CrrL?=
 =?us-ascii?Q?1gMWmMiiUqr2Uww7fdCnm8IwxiqbaSw3AkQ3ZP2XQ0noTH3AwoSBtXepBm5b?=
 =?us-ascii?Q?F5quqk3UeKZaO+T6MTRT0xbwgu4/Crm27gybbKJFmvLNF3q2VvN7FKIhxz14?=
 =?us-ascii?Q?pwmVIST5Jd3H4TnKrsHUMVDZynMLd5iD7n+k0HvyWJif8S6bjwrQQfy1YQ9C?=
 =?us-ascii?Q?OFZgl6UqZYHjNrUUunNP3U0j85CHJd7EpZX5GGzfduFUAB6DwO7fxySa1WvP?=
 =?us-ascii?Q?nFueAsWJ69xSPp+XW7jztfhf6vBmWclq7Cemuca5xjHq4K8CKPfZDwfLM6jo?=
 =?us-ascii?Q?hCtlynL0q8d5Y3eC4oj/e5ojGhCkc6kT+JiaSs+LJ7z6tAKtqSch86IyZ3SR?=
 =?us-ascii?Q?e8QIblV4epLZwjJ34mBnttl8xKdazI0nccUMbrepeOYrJLBeOP5P07TZ9Htc?=
 =?us-ascii?Q?tqHPv0QGK5P24tRq6m9r9VB74qK2Arr/v0BCyNx3s45minSgUSUiuah/S2IY?=
 =?us-ascii?Q?AN05Dmy0h5JCkS/3euIVAQR6OAUOWAz8c0ZgPMArhe/QXaN1RxbPUH5aClAA?=
 =?us-ascii?Q?TCXa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2020 12:09:58.4764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e664e3-12e8-4128-660b-08d8abf2a96c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yldSSDs3P42dvynV5NR8YL+QT/3sZYPuA7E1EIivkfvDhGmE1AZEoxk9pPs3BxNm340UaUJgTsWPR8kQxugTBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7948
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is a spba bus inside aips3 space, add it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 148 ++++++++++++----------
 1 file changed, 78 insertions(+), 70 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index ee1790230490..73602832ccaa 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -253,7 +253,7 @@ aips1: bus@30000000 {
 			#size-cells = <1>;
 			ranges;
 
-			spba: bus@30000000 {
+			spba1: bus@30000000 {
 				compatible = "fsl,spba-bus", "simple-bus";
 				#address-cells = <1>;
 				#size-cells = <1>;
@@ -667,81 +667,89 @@ aips3: bus@30800000 {
 			#size-cells = <1>;
 			ranges;
 
-			ecspi1: spi@30820000 {
-				compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
+			spba2: bus@30800000 {
+				compatible = "fsl,spba-bus", "simple-bus";
 				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x30820000 0x10000>;
-				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MN_CLK_ECSPI1_ROOT>,
-					 <&clk IMX8MN_CLK_ECSPI1_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 0 7 1>, <&sdma1 1 7 2>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				#size-cells = <1>;
+				reg = <0x30800000 0x100000>;
+				ranges;
 
-			ecspi2: spi@30830000 {
-				compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x30830000 0x10000>;
-				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MN_CLK_ECSPI2_ROOT>,
-					 <&clk IMX8MN_CLK_ECSPI2_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 2 7 1>, <&sdma1 3 7 2>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				ecspi1: spi@30820000 {
+					compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x30820000 0x10000>;
+					interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_ECSPI1_ROOT>,
+						 <&clk IMX8MN_CLK_ECSPI1_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 0 7 1>, <&sdma1 1 7 2>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			ecspi3: spi@30840000 {
-				compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x30840000 0x10000>;
-				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MN_CLK_ECSPI3_ROOT>,
-					 <&clk IMX8MN_CLK_ECSPI3_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 4 7 1>, <&sdma1 5 7 2>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				ecspi2: spi@30830000 {
+					compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x30830000 0x10000>;
+					interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_ECSPI2_ROOT>,
+						 <&clk IMX8MN_CLK_ECSPI2_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 2 7 1>, <&sdma1 3 7 2>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			uart1: serial@30860000 {
-				compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
-				reg = <0x30860000 0x10000>;
-				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MN_CLK_UART1_ROOT>,
-					 <&clk IMX8MN_CLK_UART1_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 22 4 0>, <&sdma1 23 4 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				ecspi3: spi@30840000 {
+					compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x30840000 0x10000>;
+					interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_ECSPI3_ROOT>,
+						 <&clk IMX8MN_CLK_ECSPI3_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 4 7 1>, <&sdma1 5 7 2>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			uart3: serial@30880000 {
-				compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
-				reg = <0x30880000 0x10000>;
-				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MN_CLK_UART3_ROOT>,
-					 <&clk IMX8MN_CLK_UART3_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				uart1: serial@30860000 {
+					compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
+					reg = <0x30860000 0x10000>;
+					interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_UART1_ROOT>,
+						 <&clk IMX8MN_CLK_UART1_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 22 4 0>, <&sdma1 23 4 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			uart2: serial@30890000 {
-				compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
-				reg = <0x30890000 0x10000>;
-				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MN_CLK_UART2_ROOT>,
-					 <&clk IMX8MN_CLK_UART2_ROOT>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
+				uart3: serial@30880000 {
+					compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
+					reg = <0x30880000 0x10000>;
+					interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_UART3_ROOT>,
+						 <&clk IMX8MN_CLK_UART3_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
+
+				uart2: serial@30890000 {
+					compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
+					reg = <0x30890000 0x10000>;
+					interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_UART2_ROOT>,
+						 <&clk IMX8MN_CLK_UART2_ROOT>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
+			}
 
 			crypto: crypto@30900000 {
 				compatible = "fsl,sec-v4.0";
-- 
2.28.0

