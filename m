Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6CB2E708D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 13:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgL2MMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 07:12:01 -0500
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]:59534
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726553AbgL2MMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 07:12:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoihsBKGXyeucg2/LEUxwGKL+73s/kfd7IOQE7hkSRW2URqDBnAi/mAsi6vtaYSCoIeJ7b10pNE8UdyRNJyUZsQf++F4nEtRv2lApuPGB0osBZh6kU5l+iOVuKQB4r+1ogidch1/2lfYvxEDHPhf1vQCy3RtdvUJzhyx42GRYaecexAcNwmpoWbH0IakYTSH3UoxgUI2MxBIMcO63VXShNdxJibsHqOMG4JVIeBNYomFYAAT/C9JQR7XGZZfnd+89oTKUkkH5XXSeEjNyRQT3ZCRXmJDXPDn3ImJajDLVo8NuK3J7zLrduVqvLJ3VODASE7jPLhJTrDtFTl2culyYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wipP/GQ/pHc3Gm8ZAZVZTX84SpeRoWfGqcjRXYZQmvI=;
 b=FEBaJIqsU2/fkmVsytzx5uiI24gk5t5vCb/PXdhNHe+F/g9A/OyNdfrHf6E8mG8fPWkv8eXN8Tge78Dzj76GgaHEzrNTVm2IlNPfCXQ8pXJRfJMeVWeS+2a6m6ltTlOFfhjO2aMReRaQL6bJVU1Kkq6yd7TUPY2L8ncDrRF7vf8UHWfMJBqtp7f2Mdoupb/8bh15sPG0sH4v1rWwi8V0bOmsvOKvNoORxgq413sToM+R4wrVsrahUs9TDLCGGToXoBW/52uZIh9l3P27pnuYFmMtwcvSSakW+vHT8s6JIZhKDD8o3Wuc5jXfiZupyKdHP0pEvWDBbQmxgGjlv4VvUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wipP/GQ/pHc3Gm8ZAZVZTX84SpeRoWfGqcjRXYZQmvI=;
 b=RAOrymzJEYZWy4p2uQQUiXpKBDQvXsm3ovGsaATpchBfRaCPanhqsrf41Ji8rvXPgO22g8vP1vN4Oe7ouzifTquivCHhuH3CziFQBdu3zukwwQXGQV+i+y79vY+HEEedw5n00WMFLmmhe8/UNgVfukNOpk7hiRd+a2q+z6vFfeU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4089.eurprd04.prod.outlook.com (2603:10a6:5:1b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Tue, 29 Dec
 2020 12:10:09 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5%10]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 12:10:09 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzk@kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/4] arm64: dts: imx8mq: add spba bus node
Date:   Tue, 29 Dec 2020 20:00:45 +0800
Message-Id: <1609243245-9671-5-git-send-email-peng.fan@nxp.com>
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
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0161.apcprd03.prod.outlook.com (2603:1096:4:c9::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3721.12 via Frontend Transport; Tue, 29 Dec 2020 12:10:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e196199-0585-4e68-66dd-08d8abf2b030
X-MS-TrafficTypeDiagnostic: DB7PR04MB4089:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB408991D7985A9B621F85695088D80@DB7PR04MB4089.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pj4vJSM45cpek15TYwYJI+t3KgfdGrWXFzzSiY9YKoRDFgMqpGZs1kQtFbLl7G2nmSpOnGXGcyQDEmvhzI67WP7/a3BOgP8b9/A22adpRuSHj7uVQOyQlOB2lzqfqMHzguA1v4sLYOR2nGjNKoEfqlcsdaWFOPus4cArkFFzE/a0zsECoFkQZrmv5gfY6TM/Kfv+Wk6ZtjwFqDyJSzfSt/HFAcTYoE++xDeRd7QAWGCHm9aSqikzi5tcuQpyTaM3TZJFPO8myqe9sBcN5Y1B2c5OpusKWLFY448Gd0oIaAHxJHLQRFHJx7lqUm0rfB/fvGPnNEK8bILYC/swcKpUN/Q0Y/acX5fbTZ6E5vo3GK7pDdhHvFFNERTlGI/sLXKxA1CHvlQwU9rMi/PDf0WKF7t4XKQGjGjK+YkHy/AM5QkhN8su9D7D+T3ybhZ57qSjVb/l3102rI41q+PplB0OJlXsFdkmLRf3WsbFyA1oTjg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(66556008)(956004)(6666004)(6486002)(83380400001)(86362001)(30864003)(66476007)(36756003)(16526019)(4326008)(2906002)(26005)(52116002)(498600001)(9686003)(8676002)(66946007)(5660300002)(6512007)(6506007)(2616005)(186003)(69590400010)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jF7v5iMTaSiEs27YokVg7DSaqBIi/xYqdFbSPj0lJ5nd2IhVugWaOh0mVspL?=
 =?us-ascii?Q?0daO7aea+w+9lejUc19Ugy1k7vlhWj1jvcFktOuTAmGAHw4i3XXf13Q1AMME?=
 =?us-ascii?Q?5i1deEgs4wmMWbvJWrgJXREtrzoii/j/G06whl+2m5+IuqabmAaGSIY5dxCN?=
 =?us-ascii?Q?+rrQTomRbWAYm7Jfs2ZsrBJRLw+lU0926z9YcwCJjQ8lX9iqnvPi7Knsy7JA?=
 =?us-ascii?Q?VKKFQN+ijy/w4cfNfF2zjcVle1t8AhsVX9FZ78y3jABX1bdA36y5JCSvSjN1?=
 =?us-ascii?Q?wBV449S1xw9KuIUtVzknh1g7Fqt68fuNxZOzrRvMh2B+9CuPlYatcuHFmRRC?=
 =?us-ascii?Q?+EVS4ASkKvScbBp9eOSGpmutqJONiy71dj+ysjzjfV9OSlpTseRw/XQh8w/o?=
 =?us-ascii?Q?Kyfdc3MWR0Q+fdbjiLp1zCEQuqFRRDsaNcMHVXuAGZszzPkOKBTPdf5VYPWc?=
 =?us-ascii?Q?CgOTyYGF8q6ToLgdU/g8C1scyPkZnbI4SNf9HB0ga8y2tVtFE5ZtzlTPQm18?=
 =?us-ascii?Q?RtfplTbip27B9ZoHyu/4HqLiP0DVgL/vYEPatWuy17i7jxG9WOcmpIewB0CC?=
 =?us-ascii?Q?0mOwmonYHfVqd9REEpTWVrZT3eSqSshQjapokk2qUV2ghZBv7gu7ARRKmKWo?=
 =?us-ascii?Q?nhq3yNQDdFJJ2y6mn6cQFqvpxITl7vcNG87+BqYrWSl4x3rDUogx9P0o/aCq?=
 =?us-ascii?Q?XPxtPZ4f0eyyu1SgsdqGfAe3J+/pZ8qr7SdVdos+Va3podHGjn5p/x1lKRKM?=
 =?us-ascii?Q?8TSixtoq7HSCFeuQkbTqh52fhGRgQbrf66U1Inbi8sNVEb9gYHmedl08x/F1?=
 =?us-ascii?Q?1QvPjHe85yseIyRvXw/ZsEX7A2xuC76yNUH3pr4hyN8wrScpXDU2ns/FUtTC?=
 =?us-ascii?Q?ziFPxUDH4cLp6w+fG46PeoXjwQPl9TJm5gJTm2NyfPnezh5It0l+BZhW1Jqs?=
 =?us-ascii?Q?upcA8/7O7/fSunaApLQsemvtvY5faM112O3RLr7wG6kj4/EgwMgSGf376t8+?=
 =?us-ascii?Q?dRm0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2020 12:10:09.8692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e196199-0585-4e68-66dd-08d8abf2b030
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQvciHDRZIiyv9hKiGP1Pi/tVrD0mlIQw3sg3f+fRmR8qntvmwcCuvXaO5P+Gt0RbA4KcuBsC9Lv2WN1Mvvtpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According to RM, there is a spba bus inside aips3 and aips1, add it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 386 +++++++++++-----------
 1 file changed, 201 insertions(+), 185 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index a841a023e8e0..d043d8474314 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -299,60 +299,68 @@ bus@30000000 { /* AIPS1 */
 			#size-cells = <1>;
 			ranges = <0x30000000 0x30000000 0x400000>;
 
-			sai1: sai@30010000 {
-				#sound-dai-cells = <0>;
-				compatible = "fsl,imx8mq-sai";
-				reg = <0x30010000 0x10000>;
-				interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MQ_CLK_SAI1_IPG>,
-				         <&clk IMX8MQ_CLK_SAI1_ROOT>,
-				         <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
-				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dmas = <&sdma2 8 24 0>, <&sdma1 9 24 0>;
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
+					compatible = "fsl,imx8mq-sai";
+					reg = <0x30010000 0x10000>;
+					interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MQ_CLK_SAI1_IPG>,
+					         <&clk IMX8MQ_CLK_SAI1_ROOT>,
+					         <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 8 24 0>, <&sdma1 9 24 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			sai6: sai@30030000 {
-				#sound-dai-cells = <0>;
-				compatible = "fsl,imx8mq-sai";
-				reg = <0x30030000 0x10000>;
-				interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MQ_CLK_SAI6_IPG>,
-				         <&clk IMX8MQ_CLK_SAI6_ROOT>,
-				         <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
-				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dmas = <&sdma2 4 24 0>, <&sdma2 5 24 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				sai6: sai@30030000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx8mq-sai";
+					reg = <0x30030000 0x10000>;
+					interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MQ_CLK_SAI6_IPG>,
+					         <&clk IMX8MQ_CLK_SAI6_ROOT>,
+					         <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 4 24 0>, <&sdma2 5 24 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			sai5: sai@30040000 {
-				#sound-dai-cells = <0>;
-				compatible = "fsl,imx8mq-sai";
-				reg = <0x30040000 0x10000>;
-				interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MQ_CLK_SAI5_IPG>,
-				         <&clk IMX8MQ_CLK_SAI5_ROOT>,
-				         <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
-				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dmas = <&sdma2 2 24 0>, <&sdma2 3 24 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				sai5: sai@30040000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx8mq-sai";
+					reg = <0x30040000 0x10000>;
+					interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MQ_CLK_SAI5_IPG>,
+					         <&clk IMX8MQ_CLK_SAI5_ROOT>,
+					         <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 2 24 0>, <&sdma2 3 24 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			sai4: sai@30050000 {
-				#sound-dai-cells = <0>;
-				compatible = "fsl,imx8mq-sai";
-				reg = <0x30050000 0x10000>;
-				interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MQ_CLK_SAI4_IPG>,
-				         <&clk IMX8MQ_CLK_SAI4_ROOT>,
-				         <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
-				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dmas = <&sdma2 0 24 0>, <&sdma2 1 24 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
+				sai4: sai@30050000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx8mq-sai";
+					reg = <0x30050000 0x10000>;
+					interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MQ_CLK_SAI4_IPG>,
+					         <&clk IMX8MQ_CLK_SAI4_ROOT>,
+					         <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 0 24 0>, <&sdma2 1 24 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 			};
 
 			gpio1: gpio@30200000 {
@@ -793,149 +801,157 @@ bus@30800000 { /* AIPS3 */
 			ranges = <0x30800000 0x30800000 0x400000>,
 				 <0x08000000 0x08000000 0x10000000>;
 
-			spdif1: spdif@30810000 {
-				compatible = "fsl,imx35-spdif";
-				reg = <0x30810000 0x10000>;
-				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MQ_CLK_IPG_ROOT>, /* core */
-					<&clk IMX8MQ_CLK_25M>, /* rxtx0 */
-					<&clk IMX8MQ_CLK_SPDIF1>, /* rxtx1 */
-					<&clk IMX8MQ_CLK_DUMMY>, /* rxtx2 */
-					<&clk IMX8MQ_CLK_DUMMY>, /* rxtx3 */
-					<&clk IMX8MQ_CLK_DUMMY>, /* rxtx4 */
-					<&clk IMX8MQ_CLK_IPG_ROOT>, /* rxtx5 */
-					<&clk IMX8MQ_CLK_DUMMY>, /* rxtx6 */
-					<&clk IMX8MQ_CLK_DUMMY>, /* rxtx7 */
-					<&clk IMX8MQ_CLK_DUMMY>; /* spba */
-				clock-names = "core", "rxtx0",
-					      "rxtx1", "rxtx2",
-					      "rxtx3", "rxtx4",
-					      "rxtx5", "rxtx6",
-					      "rxtx7", "spba";
-				dmas = <&sdma1 8 18 0>, <&sdma1 9 18 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
-
-			ecspi1: spi@30820000 {
+			bus@30800000 {
+				compatible = "fsl,spba-bus", "simple-bus";
 				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx8mq-ecspi", "fsl,imx51-ecspi";
-				reg = <0x30820000 0x10000>;
-				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MQ_CLK_ECSPI1_ROOT>,
-					 <&clk IMX8MQ_CLK_ECSPI1_ROOT>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
+				#size-cells = <1>;
+				reg = <0x30800000 0x100000>;
+				ranges;
+
+				spdif1: spdif@30810000 {
+					compatible = "fsl,imx35-spdif";
+					reg = <0x30810000 0x10000>;
+					interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MQ_CLK_IPG_ROOT>, /* core */
+						<&clk IMX8MQ_CLK_25M>, /* rxtx0 */
+						<&clk IMX8MQ_CLK_SPDIF1>, /* rxtx1 */
+						<&clk IMX8MQ_CLK_DUMMY>, /* rxtx2 */
+						<&clk IMX8MQ_CLK_DUMMY>, /* rxtx3 */
+						<&clk IMX8MQ_CLK_DUMMY>, /* rxtx4 */
+						<&clk IMX8MQ_CLK_IPG_ROOT>, /* rxtx5 */
+						<&clk IMX8MQ_CLK_DUMMY>, /* rxtx6 */
+						<&clk IMX8MQ_CLK_DUMMY>, /* rxtx7 */
+						<&clk IMX8MQ_CLK_DUMMY>; /* spba */
+					clock-names = "core", "rxtx0",
+						      "rxtx1", "rxtx2",
+						      "rxtx3", "rxtx4",
+						      "rxtx5", "rxtx6",
+						      "rxtx7", "spba";
+					dmas = <&sdma1 8 18 0>, <&sdma1 9 18 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			ecspi2: spi@30830000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx8mq-ecspi", "fsl,imx51-ecspi";
-				reg = <0x30830000 0x10000>;
-				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MQ_CLK_ECSPI2_ROOT>,
-					 <&clk IMX8MQ_CLK_ECSPI2_ROOT>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
+				ecspi1: spi@30820000 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx8mq-ecspi", "fsl,imx51-ecspi";
+					reg = <0x30820000 0x10000>;
+					interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MQ_CLK_ECSPI1_ROOT>,
+						 <&clk IMX8MQ_CLK_ECSPI1_ROOT>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
 
-			ecspi3: spi@30840000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx8mq-ecspi", "fsl,imx51-ecspi";
-				reg = <0x30840000 0x10000>;
-				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MQ_CLK_ECSPI3_ROOT>,
-					 <&clk IMX8MQ_CLK_ECSPI3_ROOT>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
+				ecspi2: spi@30830000 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx8mq-ecspi", "fsl,imx51-ecspi";
+					reg = <0x30830000 0x10000>;
+					interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MQ_CLK_ECSPI2_ROOT>,
+						 <&clk IMX8MQ_CLK_ECSPI2_ROOT>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
 
-			uart1: serial@30860000 {
-				compatible = "fsl,imx8mq-uart",
-				             "fsl,imx6q-uart";
-				reg = <0x30860000 0x10000>;
-				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MQ_CLK_UART1_ROOT>,
-				         <&clk IMX8MQ_CLK_UART1_ROOT>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
+				ecspi3: spi@30840000 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx8mq-ecspi", "fsl,imx51-ecspi";
+					reg = <0x30840000 0x10000>;
+					interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MQ_CLK_ECSPI3_ROOT>,
+						 <&clk IMX8MQ_CLK_ECSPI3_ROOT>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
 
-			uart3: serial@30880000 {
-				compatible = "fsl,imx8mq-uart",
-				             "fsl,imx6q-uart";
-				reg = <0x30880000 0x10000>;
-				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MQ_CLK_UART3_ROOT>,
-				         <&clk IMX8MQ_CLK_UART3_ROOT>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
+				uart1: serial@30860000 {
+					compatible = "fsl,imx8mq-uart",
+					             "fsl,imx6q-uart";
+					reg = <0x30860000 0x10000>;
+					interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MQ_CLK_UART1_ROOT>,
+					         <&clk IMX8MQ_CLK_UART1_ROOT>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
 
-			uart2: serial@30890000 {
-				compatible = "fsl,imx8mq-uart",
-				             "fsl,imx6q-uart";
-				reg = <0x30890000 0x10000>;
-				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MQ_CLK_UART2_ROOT>,
-				         <&clk IMX8MQ_CLK_UART2_ROOT>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
+				uart3: serial@30880000 {
+					compatible = "fsl,imx8mq-uart",
+					             "fsl,imx6q-uart";
+					reg = <0x30880000 0x10000>;
+					interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MQ_CLK_UART3_ROOT>,
+					         <&clk IMX8MQ_CLK_UART3_ROOT>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
 
-			spdif2: spdif@308a0000 {
-				compatible = "fsl,imx35-spdif";
-				reg = <0x308a0000 0x10000>;
-				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MQ_CLK_IPG_ROOT>, /* core */
-					<&clk IMX8MQ_CLK_25M>, /* rxtx0 */
-					<&clk IMX8MQ_CLK_SPDIF2>, /* rxtx1 */
-					<&clk IMX8MQ_CLK_DUMMY>, /* rxtx2 */
-					<&clk IMX8MQ_CLK_DUMMY>, /* rxtx3 */
-					<&clk IMX8MQ_CLK_DUMMY>, /* rxtx4 */
-					<&clk IMX8MQ_CLK_IPG_ROOT>, /* rxtx5 */
-					<&clk IMX8MQ_CLK_DUMMY>, /* rxtx6 */
-					<&clk IMX8MQ_CLK_DUMMY>, /* rxtx7 */
-					<&clk IMX8MQ_CLK_DUMMY>; /* spba */
-				clock-names = "core", "rxtx0",
-					      "rxtx1", "rxtx2",
-					      "rxtx3", "rxtx4",
-					      "rxtx5", "rxtx6",
-					      "rxtx7", "spba";
-				dmas = <&sdma1 16 18 0>, <&sdma1 17 18 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				uart2: serial@30890000 {
+					compatible = "fsl,imx8mq-uart",
+					             "fsl,imx6q-uart";
+					reg = <0x30890000 0x10000>;
+					interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MQ_CLK_UART2_ROOT>,
+					         <&clk IMX8MQ_CLK_UART2_ROOT>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
 
-			sai2: sai@308b0000 {
-				#sound-dai-cells = <0>;
-				compatible = "fsl,imx8mq-sai";
-				reg = <0x308b0000 0x10000>;
-				interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MQ_CLK_SAI2_IPG>,
-					 <&clk IMX8MQ_CLK_SAI2_ROOT>,
-					 <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
-				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dmas = <&sdma1 10 24 0>, <&sdma1 11 24 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				spdif2: spdif@308a0000 {
+					compatible = "fsl,imx35-spdif";
+					reg = <0x308a0000 0x10000>;
+					interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MQ_CLK_IPG_ROOT>, /* core */
+						<&clk IMX8MQ_CLK_25M>, /* rxtx0 */
+						<&clk IMX8MQ_CLK_SPDIF2>, /* rxtx1 */
+						<&clk IMX8MQ_CLK_DUMMY>, /* rxtx2 */
+						<&clk IMX8MQ_CLK_DUMMY>, /* rxtx3 */
+						<&clk IMX8MQ_CLK_DUMMY>, /* rxtx4 */
+						<&clk IMX8MQ_CLK_IPG_ROOT>, /* rxtx5 */
+						<&clk IMX8MQ_CLK_DUMMY>, /* rxtx6 */
+						<&clk IMX8MQ_CLK_DUMMY>, /* rxtx7 */
+						<&clk IMX8MQ_CLK_DUMMY>; /* spba */
+					clock-names = "core", "rxtx0",
+						      "rxtx1", "rxtx2",
+						      "rxtx3", "rxtx4",
+						      "rxtx5", "rxtx6",
+						      "rxtx7", "spba";
+					dmas = <&sdma1 16 18 0>, <&sdma1 17 18 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			sai3: sai@308c0000 {
-				#sound-dai-cells = <0>;
-				compatible = "fsl,imx8mq-sai";
-				reg = <0x308c0000 0x10000>;
-				interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MQ_CLK_SAI3_IPG>,
-				         <&clk IMX8MQ_CLK_SAI3_ROOT>,
-				         <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
-				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dmas = <&sdma1 12 24 0>, <&sdma1 13 24 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
+				sai2: sai@308b0000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx8mq-sai";
+					reg = <0x308b0000 0x10000>;
+					interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MQ_CLK_SAI2_IPG>,
+						 <&clk IMX8MQ_CLK_SAI2_ROOT>,
+						 <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma1 10 24 0>, <&sdma1 11 24 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
+
+				sai3: sai@308c0000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx8mq-sai";
+					reg = <0x308c0000 0x10000>;
+					interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MQ_CLK_SAI3_IPG>,
+					         <&clk IMX8MQ_CLK_SAI3_ROOT>,
+					         <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma1 12 24 0>, <&sdma1 13 24 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 			};
 
 			crypto: crypto@30900000 {
-- 
2.28.0

