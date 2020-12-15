Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282C22DA951
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 09:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgLOIjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 03:39:18 -0500
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:12590
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727340AbgLOIjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:39:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1UAerOzd5Ir010y7AT20sOw+ta1dbNxQDSqF+Y3UQAtGfYmaudkRL0MGfphkQamviiCb2O3Oaf2z6WFiBTrHbqweSqlNGOLLWrjATfxVJ+PHnzhz2oEu2L5ZO1KIuP1V81TEB4+QkCGmdMFZHLWrDd37o2VMOzIf4b3fMgJWJhHmO1/PzsHiQNiFSLHFya2tK3HjXYdHlUDguZ/C7SLMAZPzHjwsFk6hgIVn+fgX0yn4R91Y6YkZfTeGHaM3z5zPUXyrmpcd6lXSCcc1egtBGNXEG0ieSIaP/kmc3klxwwu5pSjEloLRhaA/eRuPI/w4mSQvjkOaPOngXf1LLw2Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCKi3w2kSLf60DaMObFPJH0RcGwUYPgITeLbiN1+W4c=;
 b=NlX/dUaFtiKFdMai9NMGMgVsrtDmDPa2HFnyEmj8V61hNGmjXbh6CJYUfS72WCT7+rI7k1VlwkCcByWN420zYERLEP0XPWrV5O7P3e5mB3fCWFPT8LuyJ/mwRI10uvw8nyKxWj6Izwj0PdM9uvm2o3TDG0ekoqTDtBanKvZd/+1IPJNKNYZEgjxYlCsfLZVjcVUshq4M1DPqToJjAbYcsnNK/mcOThxmUYjDvQ5iat4wPSHhsaJX9GtWwUWoAI6WB92cB3k9gD6cvnnnuVwfZCH97UYbHmV3Ehpx8fAfFWQjGoaRBreWKUdQn6PZT8UxR/Ue1N/Mr8c/EGBBsyt3sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCKi3w2kSLf60DaMObFPJH0RcGwUYPgITeLbiN1+W4c=;
 b=HnJyPljXw7s4JGzy6gKwv1T9sWZ9bfJtk9G1/pzDw2L77WPq2GQPD3o/j4Wiw0jkgmQkB4VnGWcXiNjSPFMCKK2P0n85H+ESw7xbBVDIW4jPFs1a69bw+sZLpMbtjAllR+iqfeOV4J8/I2oDH1zOb6AnAQ9KOHEypd9LuC3U5/Y=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM7PR04MB6807.eurprd04.prod.outlook.com (2603:10a6:20b:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Tue, 15 Dec
 2020 08:38:04 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 08:38:04 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v7 3/4] arm64: dts: imx8m: add NVMEM provider and consumer to read soc unique ID
Date:   Tue, 15 Dec 2020 16:35:50 +0800
Message-Id: <20201215083551.6067-3-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201215083551.6067-1-alice.guo@oss.nxp.com>
References: <20201215083551.6067-1-alice.guo@oss.nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0250.apcprd06.prod.outlook.com
 (2603:1096:4:ac::34) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR06CA0250.apcprd06.prod.outlook.com (2603:1096:4:ac::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 08:38:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 979a4ad3-8c98-4ba9-389b-08d8a0d4bd66
X-MS-TrafficTypeDiagnostic: AM7PR04MB6807:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB6807DD71D27619D3B1034297A3C60@AM7PR04MB6807.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muSDhqtWbm7n8foT1Vs48kX7UtSBXsfIQkc8uXLITKigAdvALaT+t/IFeDr1+sY5w7gwzUSiRoKSrcrxI8y3oCnhZ96Q+AIqAsieXiJfvvfkuJM/r+8rsSkxtD4zENzH6UJkYu6PNDv/i2LPDvI/MRrSDZaX93zIu+LVlb/iKgrqqHWq4llwT5YJShYuL4vka4UvHqglnLkrrc6UNllZkGaNur4uI2XYDLcE3/xIN1yA+rRoeafWGKpFyLmQdskSzF9IPpUp9GCvbL03XV7A8nItiEncuMQWSNIqSQjOr7FamLzd5pXAKleeHlamuZqtQXc3PZMnI05IcqKbGJmB3YBo8ILo3vsBS7a3DrCfLhJWcPf4S2QKQV0yjjx4COC1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(83380400001)(6666004)(16526019)(186003)(66476007)(86362001)(26005)(8676002)(5660300002)(6486002)(8936002)(316002)(66556008)(66946007)(2906002)(4326008)(1076003)(6512007)(478600001)(2616005)(956004)(52116002)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/8zjayraom9RFXwrGLCm29XTWw0yVSkctY5SrgoCNAyYyaPeLkdxWvepXwhf?=
 =?us-ascii?Q?E3E6FroUYP61xE9c1KXh48b8OFDyqTsq1YvMAapSCfpBGjLZfUbfxyIX7I2J?=
 =?us-ascii?Q?WNpf2cnovxncsDNlmIKC6pyxsrC3XV4N5dcmPYtnG8tM+inVkcgXQL+qryUE?=
 =?us-ascii?Q?B6WxB1TEIGJ7+08TSFWzaNF2WC4XjIEKDLN0v3ZjyK6R1YT/zunJPU7XfGhv?=
 =?us-ascii?Q?c9ue+qTYbOsKDfwcH0jGzWI8TkHaRiMHhDggobCTES4H5Wf1+cyLUlFAOvhO?=
 =?us-ascii?Q?vvYjN2pi+jmo3iiVzCp2btoe7DeW6Js0mfo/AMVElU5fSTbX+gNWKKMz1Dy8?=
 =?us-ascii?Q?RoOPEnNY2ib7Kr705leMk/1Xov5SSsAhfAxhJWDlVU1rVrYKr+b3lCCqKk3d?=
 =?us-ascii?Q?wlWORRSH2/0beQHWb3GBJFL7nUD8Q/1YNovtc5wW1klMZZFF78R85vlBUUvU?=
 =?us-ascii?Q?wpgSfpGoDpOXdnha2KtLHR3F5SgMwCZrmJePRqz4naG2jJwH/GoXATn0LR7V?=
 =?us-ascii?Q?adZj9vhbDFA64BDF5jDa8gBeS1RIhgpiQEHrOv2fq4HDGTprlxEmATcDjWBE?=
 =?us-ascii?Q?LvRm7WMA13BETW+qa2YSyDkY7AoSA7z6quVa61h7swTnYPuftgcLsCsmfBwl?=
 =?us-ascii?Q?09bQWKFC+Lpbky9HIn2pjC7lf4HgCi51MIKjGf7u3LhimgGEb3WnswFRl8Wk?=
 =?us-ascii?Q?HFMfl7vwSZ3ceTDOQNu3Epb0TVoxKX189z0kGPhxo1gI6CU6b6Syjg+aaYdJ?=
 =?us-ascii?Q?ed9rZykoimjmuvwbUnKbLE/FZZQ24qS9NPFKq5qHnPf7a2DiU2KMUf3lzfCN?=
 =?us-ascii?Q?TC/EsohznCwR5mbC5ObshpjMUNhX0tzgDabNd9O8Ab7Owk5oIq8oWyw3rJKL?=
 =?us-ascii?Q?JrLmz2ub1cxR/RMx/5AcDCfm+Rfz4loJLtIBQe8IZ5/zae4/6yAt0rRLAteX?=
 =?us-ascii?Q?YIHTC0iInxG+civ5JUB7b9/FpP8ndqfR59nhQk35EQE0uYelbtHYo7rVtwQz?=
 =?us-ascii?Q?GFqn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 08:38:04.2759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 979a4ad3-8c98-4ba9-389b-08d8a0d4bd66
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJIIZTWygxFSZusKIVtGUppAYxe9so+lfEug/3/CDxU5UnNrMxcQ67PReolFz98Ija6gPTsw87jB1ePyOKQ7gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6807
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Guo <alice.guo@nxp.com>

In order to be able to use NVMEM APIs to read soc unique ID, add the
nvmem data cell and name for nvmem-cells to the "soc" node, and add a
nvmem node which provides soc unique ID to efuse@30350000.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---

Changes for v7:
 - add Reviewed-by
Changes for v6:
 - leave only the changelog under '---'
Changes for v5:
 - change underscore of device node to hyphen
Changes for v4:
 - delete "stuff" in subject and commit message
 - add detailed description
Changes for v3:
 - convert register addresses and sizes to hex
Changes for v2:
 - remove the subject prefix "LF-2571-3"

 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 6 ++++++
 4 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index d457ce815e68..9bee6f1889a4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -261,6 +261,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x3e000000>;
+		nvmem-cells = <&imx8mm_uid>;
+		nvmem-cell-names = "soc_unique_id";

 		aips1: bus@30000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
@@ -518,6 +520,10 @@
 				#address-cells = <1>;
 				#size-cells = <1>;

+				imx8mm_uid: unique-id@410 {
+					reg = <0x4 0x8>;
+				};
+
 				cpu_speed_grade: speed-grade@10 {
 					reg = <0x10 4>;
 				};
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index db50e6e01ac5..b344fdc16534 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -245,6 +245,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x3e000000>;
+		nvmem-cells = <&imx8mn_uid>;
+		nvmem-cell-names = "soc_unique_id";

 		aips1: bus@30000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
@@ -531,6 +533,10 @@
 				#address-cells = <1>;
 				#size-cells = <1>;

+				imx8mn_uid: unique-id@410 {
+					reg = <0x4 0x8>;
+				};
+
 				cpu_speed_grade: speed-grade@10 {
 					reg = <0x10 4>;
 				};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index ec6ac523ecfc..9401e92f1c84 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -222,6 +222,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x3e000000>;
+		nvmem-cells = <&imx8mp_uid>;
+		nvmem-cell-names = "soc_unique_id";

 		aips1: bus@30000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
@@ -328,6 +330,10 @@
 				#address-cells = <1>;
 				#size-cells = <1>;

+				imx8mp_uid: unique-id@420 {
+					reg = <0x8 0x8>;
+				};
+
 				cpu_speed_grade: speed-grade@10 {
 					reg = <0x10 4>;
 				};
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 9b6d9307e5d7..a2a885f1a07a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -291,6 +291,8 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x3e000000>;
 		dma-ranges = <0x40000000 0x0 0x40000000 0xc0000000>;
+		nvmem-cells = <&imx8mq_uid>;
+		nvmem-cell-names = "soc_unique_id";

 		bus@30000000 { /* AIPS1 */
 			compatible = "fsl,aips-bus", "simple-bus";
@@ -555,6 +557,10 @@
 				#address-cells = <1>;
 				#size-cells = <1>;

+				imx8mq_uid: soc-uid@410 {
+					reg = <0x4 0x8>;
+				};
+
 				cpu_speed_grade: speed-grade@10 {
 					reg = <0x10 4>;
 				};
--
2.17.1

