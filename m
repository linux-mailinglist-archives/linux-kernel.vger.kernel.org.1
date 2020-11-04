Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BA82A5CEF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 04:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbgKDDKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 22:10:34 -0500
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:61181
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730645AbgKDDKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 22:10:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eg32inm4gST4XKG/jEH/RNbQmjIwdcv8np3Vmd07yfBTACAW7gBjxghXbNa21GX9YsSFbi9S0rUnN/6NqWFEoxqSIGaxHa+8i6joIy4O2pZcUyrFxvx+45FivhoJBvaOu0wIKunNkdqiWx7yH1//WQmrkd69BAWtVF7exUgmlDU+sFBArxShRvTWsSxULSyiOcHD++1umiZIuZMW/4soZdSf+SkgbRNlAYr94Qvpxz/zg9PyraMYV2AagA5g9+tKjBgPSfVeULSVnWGcBjvh/j5PlSDgSrkrZynmj8MDe6IrawINvLAlWqFHwzCSpxgMU2eZNFKFIoKdDjF1oOkocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7eN1X013fItIDbL97/9Oso5n83WAMtxSgkxRsyyR+g=;
 b=bG2avauQqE+tZEN3K+mVk5xcyxKraAn2+G4WKoF/aNPUk6mtK3+EWyjOiCno9MURyh02qAa7gnmlwiz1wRIiQaDVqpRrGGjDs3NkvgLSte9Q5BFxGxHRTXXu48kfZNn+sE0cBZij7gzifwZc37uriKJHXuZmhTAJPhUGsvLJCzC06UG8JFOnqMRTCCJ4TM8Y9d024hIzpIVAAXtV+at1qW29TWcOjEM+G3DwQ4PB5ZNSjzi66OT0G6qZn6u3WIrBpr8+C1sqr2ljVlaqAxYPgzE3GUm1+VeXKX+TFz3z/1HtKiMC8sssEwsh/hnT/wmR0mffxx+CmBJ6ccprudmczg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7eN1X013fItIDbL97/9Oso5n83WAMtxSgkxRsyyR+g=;
 b=Xn690yzvZwn2ccvIM4+Ri8fXPaOdktQh8vI1H0cmK2k5HL3bqku22gWKlvg3jzXz1YFnQj5i99SY864dLBkDK+Txk67AqpCckCt0VVyh+DUJj87USEm1aCo5k95sCEwulqeIsoItq9Fa12Its9ZpQO3Oy6CLqul352XjG9JpwtI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DBBPR04MB7961.eurprd04.prod.outlook.com (2603:10a6:10:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 03:10:29 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618%8]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 03:10:29 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peng.fan@nxp.com
Subject: [PATCH v1 3/4] arm64: dts: imx8m: add nvmem-cell related stuff
Date:   Wed,  4 Nov 2020 11:09:58 +0800
Message-Id: <20201104030959.13264-4-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104030959.13264-1-alice.guo@nxp.com>
References: <20201104030959.13264-1-alice.guo@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR02CA0113.apcprd02.prod.outlook.com
 (2603:1096:4:92::29) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR02CA0113.apcprd02.prod.outlook.com (2603:1096:4:92::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 03:10:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ad6ac005-ee34-424e-37a1-08d8806f2f02
X-MS-TrafficTypeDiagnostic: DBBPR04MB7961:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB796113F65766D1AD80E41870E2EF0@DBBPR04MB7961.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KtkhN7Anuvk3EV3XEg+v6JsioEy53m5yxeJ/yc9N8P+yAm9zuwQkW3yg0BW0HCki9GDoGVClyVuI1SNuAnpDsp0AsmQb8x/8RtWU6ACeEkzk6asKsk9lbfvpGjSvBTlNsfh7tFK53ndSBYte/PpUDqma9z70a47Rbk6D63LoGXp8zG/iBQkMD7Je4nyCGjzC85aTbebtJ5yUvTDnpKG7Bhirsg+Jx2zGq8UY+yiSCH1ZOWHM7gkxLaeGrSx5/9+F/rMkO9UsuAjBOJWSBDq3xatsDrv5SOpA5wbRca7/WBY6uMjjLOBGbZv2eBcmUCcJiJ5p2R96rHd44S9HnFTusCEkvwQt3w/oQ3kDcIUAipsxzzNq4OOALVLNUQbCAvPr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(52116002)(2616005)(1076003)(4326008)(956004)(66946007)(66556008)(36756003)(316002)(6512007)(66476007)(8936002)(6486002)(478600001)(186003)(8676002)(86362001)(44832011)(2906002)(6666004)(16526019)(5660300002)(26005)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gawpYtAjOW+3D0UUlSk6RDoW7T2HsqdKxLZhinGhIiignE/6b8WqXnPA6LjyumfCQUnnmdrQ4/nuFk1biUvkwGzlXX74/2QoLmq1DQ4sxvm/Vq5DL6lK41wlz59iJxif9MXRYigJooD9poelbWqoREAyFdAyrZ+Tcxb86KX4DKMou7xSi+VX89oCryOQUAH1xSipnHFx+4IUYaG8vPC16J/obmA/rloI+Q/rBMpGcA42BeHIf1BU/i13OQwl5jmfEL01LDr717gKr5ZBu68n+WkPG9BrD2Ynk+z4wztS0MznLdIbmpw00pHtbD6VLLPNcej6cfZUSC9upkp7PgLHjjXZ680RumuPAIAJ1qHnJG27NQIUNGh+saAIqjmkUouacb1euF295WEJdWSoqAcOtXiiQRYUi4+yXGZx0c20hyBptITUFeM1b8eDiMY7eA/rJf4Mi6RSOf+lpXK803ce8X4BE6SYegRrV1TyHaOte8Qzov9tFzMhN3SdGd9SwqKsPMASTepHrw8+Vl7gr1HJRHc+q1sv4ygHD2JxdtaW0Use31hOZ5YU9hTgoKW2d3fNGvL83z24Q62xMM+s8la43wBuJXvFtWejuHWdU8XAVPk4PmJ66K0wY4Mndm9gW1zKsWLHB45NRoy24BkfsHeVAA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6ac005-ee34-424e-37a1-08d8806f2f02
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 03:10:29.3545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUnQlWjIrYobng6eKiL4BxISBN4yhZ1nhKqq8hztIMyEdPvesPLVg9jxHg5f3XRSqhQf8/CR5A2lOGOAQqUktQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7961
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

