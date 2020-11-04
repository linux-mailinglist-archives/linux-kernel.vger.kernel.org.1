Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E302A5CE8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 04:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgKDDHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 22:07:34 -0500
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:50756
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730182AbgKDDHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 22:07:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOtyudafIrwTJqSsLAWN6TPyvK/CaIU4YdDpAnj92oo0RArjmIbGdFdvrK/dl4t4+UkSFy7qq5DDw5ERPXtCipGCSplDXJk3zEPO90cb5vUpoDk6+UBjX7TOffqBeJid1srokBGLBnyzHr4vvIrvtkSy3WSbXsn/g7zEse7q/gyr1R7GJsqEjE6tsnrZd+5dgkv1R3EYiLGJEOQMhoW0CDw/U0lP8rxIWXbSSb6m5wga8gf1DqNg5mGAH1/MT09roV9TPHXf+ChUhaJveJCsNEv0NDw0nDc2h7azFUCA3Wye8DH26t8qjuLlqjeZFED65vLL684lzdYsaeb4Oerd2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7eN1X013fItIDbL97/9Oso5n83WAMtxSgkxRsyyR+g=;
 b=f7M1Wd2CgLDNtVlcAahj3MxU8gCCnaB8TkFzZSkkojwXJ2a6OqIlxaPrecQlnu3OAHrllzvaReKceEY4UHKaiHd6YRnltI7hBfCcfIewec2DjjeEcrkZGO4FGdKNfNWBPFog0GD16tzP0rg0z0B0FN6hGrWpl2xCh5ckkFdUX8C6lvWiOG+142twrZP8Q6J6Z37CVn2D6jdyoq7eUMESOH6hOw7V2jZruLgbbSGWOnnpG6Ttjjh7DRxjN6NFfhjrvdD/heTSgW54gOCB49zWHUzs/tBri8ZTR5ntJtI+zQPhpyGXMSzTKAL7ovxzySCaXnzsoQt0bY/BHmzk76yg3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7eN1X013fItIDbL97/9Oso5n83WAMtxSgkxRsyyR+g=;
 b=MWh/ncv9A6oO6iiRyGVJIz1qYoWHEkfUqS2/081yaLQD8GvMlGGLmt5X6FefPLRhlqxER2gknfyWW8LW+hRGY1eqXYGoBWXKErD4SpoNv6OxY58mYSTOS+JyTbksj95oqa4mXcXGlFwugQbStw23yyUkLCzTWvEVmIMyaieqWZ4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DBAPR04MB7365.eurprd04.prod.outlook.com (2603:10a6:10:1a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 03:07:29 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618%8]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 03:07:29 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peng.fan@nxp.com
Subject: [PATCH v1 3/4] LF-2571-3 arm64: dts: imx8m: add nvmem-cell related stuff
Date:   Wed,  4 Nov 2020 11:06:44 +0800
Message-Id: <20201104030645.12931-4-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104030645.12931-1-alice.guo@nxp.com>
References: <20201104030645.12931-1-alice.guo@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0225.apcprd06.prod.outlook.com
 (2603:1096:4:68::33) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR06CA0225.apcprd06.prod.outlook.com (2603:1096:4:68::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 03:07:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b1c8c940-ea20-4c50-c837-08d8806ec3fa
X-MS-TrafficTypeDiagnostic: DBAPR04MB7365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB7365AA4B7F1B879F4FBAE91BE2EF0@DBAPR04MB7365.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6bOKEO71lV5xwkxMTtzLa0/DfuEPPykwRKb8pcveRVXaRx0WTpnejNK4dfRB2rexzbXL7lroBS3Ee0ceuF5t3cGim1Alh+XR7w5eGyisKDtwPUZ4Hbrw6EotrgPd/MLX9WtGyGIrIk2UW5XoMScwAWlIcr9kFPJ5GsMa4hIWsKdNJvzHRvFgeKas1e5fDAqgsykhh2MxpIkbV9IgNIREKoBLtU3ut/eYQNqT/ZAVabVy2Rb5V/6hI/bOAQIJGra+NhFn8GR3kAPAIhT7n7pj4jI7cmJZ7MyzKt3vNqcmLfQmBn/nMp+kon5yONwcwre8Ti1LVEOuYxj+35TwZjEc9BNhEhkX412ZffB2BgjEX9SsK0M9tPW7yjn3V4jHg+ph
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(1076003)(26005)(6506007)(2906002)(2616005)(956004)(36756003)(186003)(6666004)(6486002)(16526019)(478600001)(8676002)(4326008)(5660300002)(52116002)(316002)(66946007)(86362001)(44832011)(8936002)(66476007)(66556008)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: LQI8hTnzroOHNHc1sVHKghTsrFJPLuCcLMN4AMcGYY9Ulvd6guSGL4nx1Ir8C5ZJz5jARBWh/QKGC7EoePrB8YCCbfMGzosD89g5fkT4NFaOiXEvp1OJ+nuz28DyYDiHMvTp35r8cIjU4Np0wAn1bZygbu3/GWCLI1hrfqoM2DgS3j5qVF+lGVDIpJ9AbCEqUyy/eQntJH99DOnqY+WHuMNC+eBxJotgTfIIw1NaKK0WfPFzfRv4qgmHQ2YEWu76W9vFGJ+XAdrgzs4d2iyesMb1ragSCL3OvyuG2sANsUrhHYoXjI7oIlrY4ty2RzuWlODN3gVmCIHOEyZ8J8mk5RJvrq4cbFUZVd4+73ywfvh6H+CP+/YOKZEbJK/TyzpyK0lhWKkkrFvy2D/Z+4ifzIfO1D3RtaoZKLnKfk4qC3KtXsLvAuvFEZ3hPROKU7NgEIaeWKtSgWBF6mcNurpl3LUD5H00ookSBAzgPQN5cMhTFVWO7Yfpk+UqO8s7jXjK1E0s2TdR8y2fKVl6bORpO/JF3ndzHAt/BySQP23xN5N84RsRBonQ2m7MU2qz4sj2MrxoHTH3i8vsoPlo7WQivJkP3B+l15TmOly6M6B7iuqBwDFQ65MkhhzBpY4aQ9YLgZOaGpqHn2ok2dXkMyk0oQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c8c940-ea20-4c50-c837-08d8806ec3fa
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 03:07:29.7537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hEX5781T8poaUW7WjcUmUy7Xf0dSX86w6UDcLy4G3oarIOL4HWnpg1F5uY4WvxZZyPg3C0J+bV3RUDaUzM5ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7365
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nvmem-cell related stuff for the soc unique ID.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 6 ++++++
 4 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index ec71a5e8a062..b45dfe133ec7 100644
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
@@ -475,6 +477,10 @@
 				#address-cells = <1>;
 				#size-cells = <1>;

+				imx8mm_uid: unique_id@410 {
+					reg = <4 8>;
+				};
+
 				cpu_speed_grade: speed-grade@10 {
 					reg = <0x10 4>;
 				};
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 6d3a809a00fd..7418c886fdab 100644
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
@@ -388,6 +390,10 @@
 				#address-cells = <1>;
 				#size-cells = <1>;

+				imx8mn_uid: unique_id@410 {
+					reg = <4 8>;
+				};
+
 				cpu_speed_grade: speed-grade@10 {
 					reg = <0x10 4>;
 				};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9cd218f5f004..e0f1d5a0dc21 100644
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

+				imx8mp_uid: unique_id@420 {
+					reg = <8 8>;
+				};
+
 				cpu_speed_grade: speed-grade@10 {
 					reg = <0x10 4>;
 				};
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index a3c76bb880db..8fad6730db3d 100644
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

+				imx8mq_uid: soc_uid@410 {
+					reg = <4 8>;
+				};
+
 				cpu_speed_grade: speed-grade@10 {
 					reg = <0x10 4>;
 				};
--
2.17.1

