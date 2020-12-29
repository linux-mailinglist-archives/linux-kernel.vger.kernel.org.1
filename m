Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4285C2E7085
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 13:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgL2MLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 07:11:21 -0500
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:56642
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726318AbgL2MLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 07:11:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezr4W2PdDQUs19AtioPoZYxpu2ohBzdDn6E/l8mTAgxsdPnUfxO9qyTPPcNG4EpCMoUCxlGYW86x1XfW9VO2FGTQMeDNcBYnZhRJCnRFupGBy7g5FtjAEQcBR4/apfS9DyFZieyhfsoWAu1ud+GlUGrfR5r6x05ubNxt4lLOF4+FotY9s1uCpytGe1SWbpCm+v2Q5GfXei5jLyPHdzOoMR0o2ik75ntPf5xXeK+OcxbyKXazpxGXhMfydl5gCMNYb3w+tZ7Ljg2sxP0+4LJB22rWQniXoVaS2XoChGaOYHvLrtA7MqbTXQwhRH3iPPXh/nYbuLTuRHauY7VezlbsiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRlswaGZz+EMySLImxIT8nPYFpVQq6HS8PdYGMR9Z48=;
 b=YG5QsmqyXq91F4JoOJBhWQcrSHYisJvDwdt9unvxYx3t/Z1yI2GYPW7n6Q9JopK7mjPVDa39l5nVWUt0TIQ+43JBoC6LGOiyE0abjAZFph+hM2HaSLwB6cOCknouDeaeNqpWWx2xxCPEcVhQGkqhQF6vD5DpZPEKWxxbVkW28j5OMoCjkArrUToUsXDs2rxUT/tOwOmaTwSk7g26nAqCPyipHnxOsDIfRvwUxyyTKev2+TcOGSbxykCO9BUpjWiB8huS2mKkwHDOGgGY6UUfdQ4MdWH9EfTT2wt4eTfv76arKwCL3MImLDBqOUhFARUVhKSpR4nwHPJST5KcM+zBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRlswaGZz+EMySLImxIT8nPYFpVQq6HS8PdYGMR9Z48=;
 b=W0SnhRfPJkH3f+ksdT3BCXviUbTWEmmo+fcTaDpVcS8kOHPi5Id9aZ3CW5L1bhd2rPnc5sY4gnL3vhBBVfBW3POJZjxXMMgjHuY+Ur3J7FGv13kSFkPfnGLRtwS4bpwR50TnmDELoMOI9/IN6izNA5d7FB87iN/WLn+aqpKq6/0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4089.eurprd04.prod.outlook.com (2603:10a6:5:1b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Tue, 29 Dec
 2020 12:10:02 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5%10]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 12:10:02 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzk@kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/4] arm64: dts: imx8mn: add spba bus node
Date:   Tue, 29 Dec 2020 20:00:43 +0800
Message-Id: <1609243245-9671-3-git-send-email-peng.fan@nxp.com>
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
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0161.apcprd03.prod.outlook.com (2603:1096:4:c9::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3721.12 via Frontend Transport; Tue, 29 Dec 2020 12:09:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 50cceeb6-cb01-4a08-aea8-08d8abf2abad
X-MS-TrafficTypeDiagnostic: DB7PR04MB4089:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB40890F5D481783B06AF77DE688D80@DB7PR04MB4089.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6O6yxaoODUEr4AxYJdXAuYJm0EeWyyKj6Ge/FJE8Cp86fr+LCcDpBmbOrmHe9xiCmI5gt1UN0b4SQbWRN35Q6NdKKAqrtkv3V1N8im/S3ZPPmABEEdO+jsPj31fuA2PM6KIhNyyPMBBxPyI8V2ycL1hDWuwakzQJoXJ9A8lW9RzivUgbmY7vml7r1QVTQd45sPO97hcS/Nr6DuyZu7k+C1lZpH5kRnWNzSrd72IpzjR7qXLhEUZm93HmVfKoSk78m+DVLYxr9P5mT+kPpc5odXNVwn3OifEl3cC1L8JGawooQvHb0C99NEpr5i+hnSsomvwUDz3ygVgbKZsRc2YsIhZ/tt1YTnmpoM8kb8dbiJbEa8XHIEl9xXZ8KsQ+0P+uH0ySvaKxxzA19oLEU//qz438Ov8HNCQiwoNdRkfAlC+8/NJgpwYRjVB4HbpI+XDhYvY5YD3uyalXMT+PXnllU9ssh3G1Qu0b8yb7HQyUVw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(66556008)(956004)(6666004)(6486002)(83380400001)(86362001)(30864003)(66476007)(36756003)(16526019)(4326008)(2906002)(26005)(52116002)(498600001)(9686003)(8676002)(66946007)(5660300002)(6512007)(6506007)(2616005)(186003)(69590400010)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ppay0RTEzaU3pmxE9edps4ukUQojAwbOix6TiwGAznd/GdVt6IDUjy0Pj46T?=
 =?us-ascii?Q?xZ5OnVJTHdHbc+1EBHLTOpkInkqMr8hBsB1xnFSCPR3WzKpNgt5AO+fufkyR?=
 =?us-ascii?Q?/M7TSlKoLlQFcWFF7a8OYQlzMp8Xtdyd9vsYPMzCMrHuXv2cj55Ql/5Tve8x?=
 =?us-ascii?Q?TA0KzJ/GoFCd6sGb3sWUn4UHNLo+GyCrYIAFnHr5koFrFUxHfzJJPxTZ+D6F?=
 =?us-ascii?Q?YQ4zsOyzyk2e4ZAJ8PBrXMb8Rm6Tc+XstzeDIj7pgz/d1lbyjYFenM8WTe/U?=
 =?us-ascii?Q?doxy8N9A6/iRDJGDZxSyHuE7aSY1rZX/34Kg56PRE5r69uoJKDVYUsSa3Gmh?=
 =?us-ascii?Q?oU0487dV+fe65sf66ifRZ2FIbvtgCFys4Xj9wtamMp1kVGTfpYy8BjVis3RA?=
 =?us-ascii?Q?5E/OYJFDltEdzYWd1U8cHutweLrqu6l0LmtWPoQZDgKjIfzUTILew4NvDvqM?=
 =?us-ascii?Q?opsxpQ9CDvYI6Ula86Lw1YB8DSZf1SSFfgpdjduJ5C1BMe4VF0v39PwvvJ36?=
 =?us-ascii?Q?oxBTOUnkQzlArhDqsbbIhpMd1VvKoycc2yVjrWF5i5kE21a8gI+9RZv8aYph?=
 =?us-ascii?Q?W0min+dsZv0KEdFwaZlaFQu0fbPn6zV4yGF6Gyf1gFE6ZKGrslUc9H15oAsU?=
 =?us-ascii?Q?0fw0fq9Y7Tsy2ep/kZioKuPaBrDPenTO1uyQ6O1szRmwVPfrIyAIc6ZPMGtR?=
 =?us-ascii?Q?ZX/a6VjHpNGTtm9x8i3QTNJVVaFUmeaPcGq6VEtTzHSBRKw6k+ASQvGlDgKY?=
 =?us-ascii?Q?Rtx0TsPaK3MoS2l3JymOijaE5pP5RJYQXkrZk8ObpfI+DUwavSez2sCLKtpT?=
 =?us-ascii?Q?OKwbRwOOukaDPqXZ6Gk/uQhDBvQSi0hBwlp2xqBl9ox+0aiufmrtweSDVIqv?=
 =?us-ascii?Q?mpjF+Mv+Ah1rZKThhcwQNtSzAc24m0yxeeFXI/RH0pFWU2+tzGsIqx2x8Gp9?=
 =?us-ascii?Q?RYK+eD8P2g9EHXnFE4Di2QhHGD5O3P2RTobQL9+q4S/BhYmxARL6lAOkxYRn?=
 =?us-ascii?Q?q0nS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2020 12:10:02.3097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cceeb6-cb01-4a08-aea8-08d8abf2abad
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJR/WuDzjiJtxSz9X0uJ1zPAY5HAyNVS2W3xNt26bx6nkqIgYwLQ2g9PoHP0XoBeHJWSSKURchsz6OE8T1IGXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According to RM, there is a spba bus inside aips3 and aips1, add it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 362 +++++++++++-----------
 1 file changed, 189 insertions(+), 173 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index c824f2615fe8..91f85b8cee9a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -269,117 +269,125 @@ aips1: bus@30000000 {
 			#size-cells = <1>;
 			ranges = <0x30000000 0x30000000 0x400000>;
 
-			sai1: sai@30010000 {
-				#sound-dai-cells = <0>;
-				compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
-				reg = <0x30010000 0x10000>;
-				interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_SAI1_IPG>,
-					 <&clk IMX8MM_CLK_SAI1_ROOT>,
-					 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
-				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dmas = <&sdma2 0 2 0>, <&sdma2 1 2 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+			bus@30000000 {
+				compatible = "fsl,spba-bus", "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x30000000 0x100000>;
+				ranges;
+
+				sai1: sai@30010000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+					reg = <0x30010000 0x10000>;
+					interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_SAI1_IPG>,
+						 <&clk IMX8MM_CLK_SAI1_ROOT>,
+						 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 0 2 0>, <&sdma2 1 2 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			sai2: sai@30020000 {
-				#sound-dai-cells = <0>;
-				compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
-				reg = <0x30020000 0x10000>;
-				interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_SAI2_IPG>,
-					<&clk IMX8MM_CLK_SAI2_ROOT>,
-					<&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
-				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dmas = <&sdma2 2 2 0>, <&sdma2 3 2 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				sai2: sai@30020000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+					reg = <0x30020000 0x10000>;
+					interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_SAI2_IPG>,
+						<&clk IMX8MM_CLK_SAI2_ROOT>,
+						<&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 2 2 0>, <&sdma2 3 2 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			sai3: sai@30030000 {
-				#sound-dai-cells = <0>;
-				compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
-				reg = <0x30030000 0x10000>;
-				interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_SAI3_IPG>,
-					 <&clk IMX8MM_CLK_SAI3_ROOT>,
-					 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
-				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dmas = <&sdma2 4 2 0>, <&sdma2 5 2 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				sai3: sai@30030000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+					reg = <0x30030000 0x10000>;
+					interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_SAI3_IPG>,
+						 <&clk IMX8MM_CLK_SAI3_ROOT>,
+						 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 4 2 0>, <&sdma2 5 2 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			sai5: sai@30050000 {
-				#sound-dai-cells = <0>;
-				compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
-				reg = <0x30050000 0x10000>;
-				interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_SAI5_IPG>,
-					 <&clk IMX8MM_CLK_SAI5_ROOT>,
-					 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
-				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dmas = <&sdma2 8 2 0>, <&sdma2 9 2 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				sai5: sai@30050000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+					reg = <0x30050000 0x10000>;
+					interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_SAI5_IPG>,
+						 <&clk IMX8MM_CLK_SAI5_ROOT>,
+						 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 8 2 0>, <&sdma2 9 2 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			sai6: sai@30060000 {
-				#sound-dai-cells = <0>;
-				compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
-				reg = <0x30060000 0x10000>;
-				interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_SAI6_IPG>,
-					 <&clk IMX8MM_CLK_SAI6_ROOT>,
-					 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
-				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dmas = <&sdma2 10 2 0>, <&sdma2 11 2 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				sai6: sai@30060000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+					reg = <0x30060000 0x10000>;
+					interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_SAI6_IPG>,
+						 <&clk IMX8MM_CLK_SAI6_ROOT>,
+						 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 10 2 0>, <&sdma2 11 2 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			micfil: audio-controller@30080000 {
-				compatible = "fsl,imx8mm-micfil";
-				reg = <0x30080000 0x10000>;
-				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_PDM_IPG>,
-					 <&clk IMX8MM_CLK_PDM_ROOT>,
-					 <&clk IMX8MM_AUDIO_PLL1_OUT>,
-					 <&clk IMX8MM_AUDIO_PLL2_OUT>,
-					 <&clk IMX8MM_CLK_EXT3>;
-				clock-names = "ipg_clk", "ipg_clk_app",
-					      "pll8k", "pll11k", "clkext3";
-				dmas = <&sdma2 24 25 0x80000000>;
-				dma-names = "rx";
-				status = "disabled";
-			};
+				micfil: audio-controller@30080000 {
+					compatible = "fsl,imx8mm-micfil";
+					reg = <0x30080000 0x10000>;
+					interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_PDM_IPG>,
+						 <&clk IMX8MM_CLK_PDM_ROOT>,
+						 <&clk IMX8MM_AUDIO_PLL1_OUT>,
+						 <&clk IMX8MM_AUDIO_PLL2_OUT>,
+						 <&clk IMX8MM_CLK_EXT3>;
+					clock-names = "ipg_clk", "ipg_clk_app",
+						      "pll8k", "pll11k", "clkext3";
+					dmas = <&sdma2 24 25 0x80000000>;
+					dma-names = "rx";
+					status = "disabled";
+				};
 
-			spdif1: spdif@30090000 {
-				compatible = "fsl,imx35-spdif";
-				reg = <0x30090000 0x10000>;
-				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_AUDIO_AHB>, /* core */
-					 <&clk IMX8MM_CLK_24M>, /* rxtx0 */
-					 <&clk IMX8MM_CLK_SPDIF1>, /* rxtx1 */
-					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx2 */
-					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx3 */
-					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx4 */
-					 <&clk IMX8MM_CLK_AUDIO_AHB>, /* rxtx5 */
-					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx6 */
-					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx7 */
-					 <&clk IMX8MM_CLK_DUMMY>; /* spba */
-				clock-names = "core", "rxtx0",
-					      "rxtx1", "rxtx2",
-					      "rxtx3", "rxtx4",
-					      "rxtx5", "rxtx6",
-					      "rxtx7", "spba";
-				dmas = <&sdma2 28 18 0>, <&sdma2 29 18 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
+				spdif1: spdif@30090000 {
+					compatible = "fsl,imx35-spdif";
+					reg = <0x30090000 0x10000>;
+					interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_AUDIO_AHB>, /* core */
+						 <&clk IMX8MM_CLK_24M>, /* rxtx0 */
+						 <&clk IMX8MM_CLK_SPDIF1>, /* rxtx1 */
+						 <&clk IMX8MM_CLK_DUMMY>, /* rxtx2 */
+						 <&clk IMX8MM_CLK_DUMMY>, /* rxtx3 */
+						 <&clk IMX8MM_CLK_DUMMY>, /* rxtx4 */
+						 <&clk IMX8MM_CLK_AUDIO_AHB>, /* rxtx5 */
+						 <&clk IMX8MM_CLK_DUMMY>, /* rxtx6 */
+						 <&clk IMX8MM_CLK_DUMMY>, /* rxtx7 */
+						 <&clk IMX8MM_CLK_DUMMY>; /* spba */
+					clock-names = "core", "rxtx0",
+						      "rxtx1", "rxtx2",
+						      "rxtx3", "rxtx4",
+						      "rxtx5", "rxtx6",
+						      "rxtx7", "spba";
+					dmas = <&sdma2 28 18 0>, <&sdma2 29 18 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 			};
 
 			gpio1: gpio@30200000 {
@@ -660,80 +668,88 @@ aips3: bus@30800000 {
 			ranges = <0x30800000 0x30800000 0x400000>,
 				 <0x8000000 0x8000000 0x10000000>;
 
-			ecspi1: spi@30820000 {
-				compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
+			bus@30800000 {
+				compatible = "fsl,spba-bus", "simple-bus";
 				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x30820000 0x10000>;
-				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_ECSPI1_ROOT>,
-					 <&clk IMX8MM_CLK_ECSPI1_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 0 7 1>, <&sdma1 1 7 2>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				#size-cells = <1>;
+				reg = <0x30800000 0x100000>;
+				ranges;
+
+				ecspi1: spi@30820000 {
+					compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x30820000 0x10000>;
+					interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_ECSPI1_ROOT>,
+						 <&clk IMX8MM_CLK_ECSPI1_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 0 7 1>, <&sdma1 1 7 2>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			ecspi2: spi@30830000 {
-				compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x30830000 0x10000>;
-				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_ECSPI2_ROOT>,
-					 <&clk IMX8MM_CLK_ECSPI2_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 2 7 1>, <&sdma1 3 7 2>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				ecspi2: spi@30830000 {
+					compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x30830000 0x10000>;
+					interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_ECSPI2_ROOT>,
+						 <&clk IMX8MM_CLK_ECSPI2_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 2 7 1>, <&sdma1 3 7 2>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			ecspi3: spi@30840000 {
-				compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x30840000 0x10000>;
-				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_ECSPI3_ROOT>,
-					 <&clk IMX8MM_CLK_ECSPI3_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 4 7 1>, <&sdma1 5 7 2>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				ecspi3: spi@30840000 {
+					compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x30840000 0x10000>;
+					interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_ECSPI3_ROOT>,
+						 <&clk IMX8MM_CLK_ECSPI3_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 4 7 1>, <&sdma1 5 7 2>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			uart1: serial@30860000 {
-				compatible = "fsl,imx8mm-uart", "fsl,imx6q-uart";
-				reg = <0x30860000 0x10000>;
-				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_UART1_ROOT>,
-					 <&clk IMX8MM_CLK_UART1_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 22 4 0>, <&sdma1 23 4 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				uart1: serial@30860000 {
+					compatible = "fsl,imx8mm-uart", "fsl,imx6q-uart";
+					reg = <0x30860000 0x10000>;
+					interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_UART1_ROOT>,
+						 <&clk IMX8MM_CLK_UART1_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 22 4 0>, <&sdma1 23 4 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			uart3: serial@30880000 {
-				compatible = "fsl,imx8mm-uart", "fsl,imx6q-uart";
-				reg = <0x30880000 0x10000>;
-				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_UART3_ROOT>,
-					 <&clk IMX8MM_CLK_UART3_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				uart3: serial@30880000 {
+					compatible = "fsl,imx8mm-uart", "fsl,imx6q-uart";
+					reg = <0x30880000 0x10000>;
+					interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_UART3_ROOT>,
+						 <&clk IMX8MM_CLK_UART3_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			uart2: serial@30890000 {
-				compatible = "fsl,imx8mm-uart", "fsl,imx6q-uart";
-				reg = <0x30890000 0x10000>;
-				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_UART2_ROOT>,
-					 <&clk IMX8MM_CLK_UART2_ROOT>;
-				clock-names = "ipg", "per";
-				status = "disabled";
+				uart2: serial@30890000 {
+					compatible = "fsl,imx8mm-uart", "fsl,imx6q-uart";
+					reg = <0x30890000 0x10000>;
+					interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_UART2_ROOT>,
+						 <&clk IMX8MM_CLK_UART2_ROOT>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
 			};
 
 			crypto: crypto@30900000 {
-- 
2.28.0

