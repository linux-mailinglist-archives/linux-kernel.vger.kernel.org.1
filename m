Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1589C29590E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508511AbgJVH0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:26:42 -0400
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:8942
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440718AbgJVH0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:26:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQARjHFKYUBJoOUGt8N2BgEiM9VyBLfciMSpL9JIrsH/BBOCgMDneU+w5DmCEqSZcgLqn0Y3Cj3a5J9qQFRebB5ciKiclq/sGaQtHqQQM1mhohqgdlaQOtr6dYwppTJlnk2sqdKgnJrpActv2dJfrW5Rrtw07+mBpfTSnc8BxU21+wVXX2g7/9teqnGMvLurQuP9Rr7jeV5bOA/DlBIOfk/4BJqFArIISiivGDindjtiVEWii/B5FKTxejon5KjAliWUjF2JS/AkQNVxPdboAlVIqJwJRSG0YYMWFRM1o3/gYCsL+FfIbMjTQiFusW4HMvuq36NEwjDsXq3PUEHtZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDADGvNFDY9YbL/CsO/Hbgsaa13hkyPu1S2ieHQ9TSc=;
 b=YOAGHONmibgfvPu+Stw7Z1VbkSpzy0KCUBFXB6alhiZsKPO0pA6E2DWXcrv7eH8xaM0vmAeqXkL0hgeKbAAKeFibXUnh8FOvMy+4h5vekPOAedaabaxRW/WfFj195S4jkAbreMmNC59u2UiekudzjCaInTFciUYp7VelpoRUJQ1BNDZvBiz2UrPVba/Q/vQXQfx980r5pMbhtMpzysY/Dvdl/xSAv/62TMNNK0e8MkxgGrb6LlkjqQj1Wwfx0kdPspMs8l6895NiG9IWdZWWCfx44pV2GRVaMti++LidZIhJBTW8RBWvtL0m0UV3d/sUiGY5XubCawEdfiHYgzkOzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDADGvNFDY9YbL/CsO/Hbgsaa13hkyPu1S2ieHQ9TSc=;
 b=LR6er9U34f984OoMOloHZVEmugdW7M4KpLjIpOrt+S8nlxfviFNrjfqqER6VsiifHyed5kWDkZ55KUSr8BsBKqexQ9euBf+Ag5bBPX+K3FpIrjc2VFTmG06QlwhyiB9YiP/oZSI0y0mCYLLj8l+CsG7S24n07zjA0d6qX75/btU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Thu, 22 Oct
 2020 07:26:36 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 07:26:36 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, marex@denx.de,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx8m: use generic name for tmu
Date:   Thu, 22 Oct 2020 15:21:18 +0800
Message-Id: <1603351278-8198-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR02CA0062.apcprd02.prod.outlook.com
 (2603:1096:4:54::26) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0062.apcprd02.prod.outlook.com (2603:1096:4:54::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 07:26:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b2eb0d56-a073-4650-29e4-08d8765bcf32
X-MS-TrafficTypeDiagnostic: DB8PR04MB7177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB71777E4D9C65895BF41F9EBE881D0@DB8PR04MB7177.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:374;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +VafNKcKX+w4FBUGQu+EXvZhfFikkWeS2rEC+VX7mX5Q7AULgqcPXszrdfMulot5w787mC559e8FdMnPZ3s6EaNqmKoIjNX3iVyss68gt9kNyl9BcqeODKNG0dGi2jSSQVtvb9hlMIRorg2MEzF4x0UDChRhQv3SeMi+JcXar5wy4JfN7zSFGanqePV90QVn4xU0D7I/CL4YJjTZvPCufoXeteiheHIhpRHC39hjjTd1bDQtqUAFCnaPGXGVyIdsGtV+NOfi0MKwV8nJN6mJspoDpWKg5jy3xlNeRZKPNkUjhJpzIpsfgMgetpfcSwAaQLQ2ZbmgsNuebenMI10XWVh7NjgaZ3EsC+m5qBpv5DmrOLgWAfLgBgjvRpziVXXSmbznU6ibOD+MBno/wSfSExXz54WPwcmQ8LQHSUDBtA8eQ6e34NDRi0QQP8EnN2Lo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(478600001)(4326008)(36756003)(83380400001)(8936002)(8676002)(69590400008)(86362001)(186003)(26005)(52116002)(9686003)(6506007)(316002)(5660300002)(16526019)(6666004)(6512007)(66946007)(2616005)(6486002)(956004)(66476007)(66556008)(2906002)(41533002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: lTSOqsEGu5VyU/irRyLOzlMjyBVG9ne1Oiel2AcAgWdlT+HxC3rWG1xXkb8QWD+0hsF6n547gt7427W6RDH14WoAUDKrku672fnqE0g3zXRr1QWBRv3uMnjc780cbf5KARZZCEwnIMANPTDKmOsy2wbP9oKZaumR9MLhMqhaWsKzAGua3gMAs41Yd0Moj+9RzbHwaMW881vlMqhjDFik5fFJgFJP4BZdblJksiwMrCRUcneWbXqTMedD7WTrzUEoMypAW+OhwaaUkN1hEiNIcNJLDbFqeFl99EgC00iTD6ltDIvXBD8on/ohIZLEcPVT0sYB1bdF2KMYq878QPLVjCy24kVOF8oAhKfjixtvXRNnFXayVysrsVmC1/1/EyHS6VujeARVq4897pe4ROhfjtWD5gaWmbN6oSD2RQ1r88okI371FLbCEOh9VClEfa6jJL/reJVHWLJ2TbutN9j+23kFVHdhSzQ6+p4N2gFiwN7XDF0IWzAiGF4uZaud3h7UsvY+b9bKCtZgexVwFDRezau+iuN45AsgRRfrC4JNG+bH4lzFJhPt9qyN10BaUcgFtNE2DmCNTH2pvIwNCycPsEeiIX7RxcmcxTAqzr2RJcqyEpq8Y7TDO0LjpNWTZ+af0W5X9L6CySTsO64DYW096A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2eb0d56-a073-4650-29e4-08d8765bcf32
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 07:26:36.6166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdzycdRCt9cu1SoNRLQmMgVAw+ZdCurhHNBUnVvyrVc0KD6M1hWCWw9JmexHtEB3F6PJ18pIkkfmLGDuVnSHWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per devicetree specification, generic names are recommended
to be used, such as temperature-sensor.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index b83f400def8b..327f1d44ced9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -404,7 +404,7 @@ gpio5: gpio@30240000 {
 				gpio-ranges = <&iomuxc 0 119 30>;
 			};
 
-			tmu: tmu@30260000 {
+			tmu: temperature-sensor@30260000 {
 				compatible = "fsl,imx8mm-tmu";
 				reg = <0x30260000 0x10000>;
 				clocks = <&clk IMX8MM_CLK_TMU_ROOT>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 746faf1cf2fb..994fcb021b8f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -311,7 +311,7 @@ gpio5: gpio@30240000 {
 				gpio-ranges = <&iomuxc 0 119 30>;
 			};
 
-			tmu: tmu@30260000 {
+			tmu: temperature-sensor@30260000 {
 				compatible = "fsl,imx8mn-tmu", "fsl,imx8mm-tmu";
 				reg = <0x30260000 0x10000>;
 				clocks = <&clk IMX8MN_CLK_TMU_ROOT>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 6038f66aefc1..2a16016b1cf4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -288,7 +288,7 @@ gpio5: gpio@30240000 {
 				gpio-ranges = <&iomuxc 0 114 30>;
 			};
 
-			tmu: tmu@30260000 {
+			tmu: temperature-sensor@30260000 {
 				compatible = "fsl,imx8mp-tmu";
 				reg = <0x30260000 0x10000>;
 				clocks = <&clk IMX8MP_CLK_TSENSOR_ROOT>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 5e0e7d0f1bc4..ab57839a3de1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -420,7 +420,7 @@ gpio5: gpio@30240000 {
 				gpio-ranges = <&iomuxc 0 119 30>;
 			};
 
-			tmu: tmu@30260000 {
+			tmu: temperature-sensor@30260000 {
 				compatible = "fsl,imx8mq-tmu";
 				reg = <0x30260000 0x10000>;
 				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.28.0

