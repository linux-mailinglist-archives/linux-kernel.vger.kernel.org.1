Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0152B19D2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgKMLP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:15:57 -0500
Received: from mail-eopbgr10076.outbound.protection.outlook.com ([40.107.1.76]:61867
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726599AbgKMLFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:05:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPxvdrZa9d2bYIAqMG1F5Nmgcq4IOxQfZJV/kh2Yg6POAvKbtOCtMmikRi7CoVnCaBhFRxSun7G5thr/s4SECG0D0RMMtzHx8Gu7777yew8zdbu1Z+FiSUtZcYPkhu0PrnGdeQWTQD9NLkTXicCVcN7m1/aV+8EYx3plEV6DRHlFFnlwSe3PynFzFJUkp9E3JlxOzm3kFjFJP/0RwulvGANIJwXe1wwFVpTJyrKnrN6M+tcMYt/GpmWlGNjq+xUmNwYuLYVH6VCBGD/HiHuYfLZJvWm8ASDtEP7all5bFd1n0lrrhdgQQfNEoYeWdHEmWTYGbLF1E6ltCBlPLeRarQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLAlX+R5gF9Fbyihby34OqDI6NYjY1TrJk7fTEbtbwo=;
 b=i31WDWrgVsg2IXsJfMZR+LUmFJIK7TDraEVLNvSR83LOWTFYqQMEoCPMzsJkHal4AC6AQOh0w2GU45a+rzApGlOdB/HDDCOAZ3xnvV2ywKG+Bu9WL1LtDcXJp+khPAEjkxIT1lIPPOboRFs5t3PQ1yD9t02kZ7jjN15UtG/A5DYomKqaOLo5butriIVKRYpz+asHCDMZj+KmSZGn/NqoVrF123lJekj1D+G4zKTOYvi63z2uFuRpSR4LEMO94ywiMUZGHsCWIAwpt4LjRPzcwD056rdOdB9YTEvXHg2tn0eN9wIuCRVUuPgwslE/EgAQTSdUkbepjZB6vKFHzYiAKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLAlX+R5gF9Fbyihby34OqDI6NYjY1TrJk7fTEbtbwo=;
 b=SItQNBeFEmKHqAfCt9VjzaD0AUvbMTOFy7cKhWQmpiSjkBGNKVJ2J9Tl50q01MopK5ActleyccoX0BqheQgfeM2BSdhN0D0j4C/MY8dfX4E1fgxKObrWV56baTd4TlOAeioZqNFFWqyLBIEFkvMnc1dUpSIi1WJYh5EBIjVNnk4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB7071.eurprd04.prod.outlook.com (2603:10a6:800:128::8)
 by VE1PR04MB7279.eurprd04.prod.outlook.com (2603:10a6:800:1a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 11:04:19 +0000
Received: from VI1PR04MB7071.eurprd04.prod.outlook.com
 ([fe80::1de8:9a84:bb92:f944]) by VI1PR04MB7071.eurprd04.prod.outlook.com
 ([fe80::1de8:9a84:bb92:f944%7]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 11:04:19 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        krzk@kernel.org
Cc:     linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/4] arm64: dts: imx8m: add compatible string to .dtsi file
Date:   Fri, 13 Nov 2020 19:04:07 +0800
Message-Id: <20201113110409.13546-2-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201113110409.13546-1-alice.guo@nxp.com>
References: <20201113110409.13546-1-alice.guo@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: AM0PR07CA0018.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::31) To VI1PR04MB7071.eurprd04.prod.outlook.com
 (2603:10a6:800:128::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by AM0PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:208:ac::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.15 via Frontend Transport; Fri, 13 Nov 2020 11:04:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 14a6c6c3-95e5-4a7a-ba14-08d887c3de74
X-MS-TrafficTypeDiagnostic: VE1PR04MB7279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB727980160D46324D957BB8D2E2E60@VE1PR04MB7279.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRTh7yOSwIwVpwq2FGADjCRdsqDp8FqveKuTV4XfipNUYOFHNCdlpqBqwimqYsQJxTr4CinSMMHzL8gEPyH6ZjH45paDAT9SX+IpqQj+QeUXchNDeLYP5gpIZNqsW3okYh42x4LBuIPn2TKCkj2nV+YPQNFaYu2wwYsVH8rTE3q4oRFz4zbZI3w5uK+MwX6Bc7TaFACquhcqmkQ939jZun77QEK1mjwSsdprZEL6XNPqmSbe7Wx0yl6pwGVgXVxgW90eZiZzCoujmb36AsdvrkhylRYooqHpppuD47svgtRsBUkJ3ndyd9uUKEGEfzAsO4hsyKRnLTsE2Cz1PJnYy3llseZWAgdDAGpMo6xQudY7p1HJUp7VHW8x3zl1OJRBu9IRDV61JUkgjIUshQKxtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(66476007)(956004)(478600001)(86362001)(66556008)(6486002)(186003)(16526019)(6512007)(1076003)(66946007)(36756003)(2616005)(83380400001)(2906002)(316002)(44832011)(26005)(8936002)(8676002)(5660300002)(4326008)(52116002)(6506007)(6666004)(142923001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +hi+/yWBBXRM65UAFGq948RaPFArUS209zOxaBF/cR/Dehf90ekzowrA4v/KEul9NXnPMdllTuFdUqKpFCo5G56aVeBUmXqvEa4+x7q9y7Wpb1PRp1llmW2AfzTb20WsTfRrtXcs5qxk7+f0I96gdMuAIYqDi8Oh3IW2mfRJCxZU4HldU5ZPpinvNK0deIBbSC4zHmfNv95mYU3oxOUWQBVt3X4UcFCPEDwVj8qYxv1ZEDUnsH10T56KR+REGzt/qs6J73K0YsXqDyXkHMpqsEk7qMGZVM7G+gyt6Dvr4jkHd/7ggSh27cVQpRLeNbvBSlmOMvZjJuzZRTz8JTb2pI6jJkN32+0U4l65iGjRI+d1oPWOgQsOreXneS3jRShN+EARg5uFKdwUfYh/YBSMO5g1/BOguuTjNHLnP5V61m1u7NdxcAtp9EwmxZ0DRWTfnTVItojRZZnpczO+dz+gdG9otVUCGP6P+s4glJs0HEdYxf1rtsukP1YBjvuVb7xSa34c+o9xxVWgQdyd4u+4YUahorIyiv6TSqZQwY0z1qpKoe1RGdp56LI6pQJUHFmsK3q1z/G9xgwcqa7IYBoA+WkfWuJ7naFDdTTrqsMKZY6JdaWeuZT8cY2omtPc6ri5sJ52v8Ug36xBbI52lqIyElTMsu5uViiV9nPq0YSLMrONI3p++gt05Ij16jkbq+FzSJN8skBrVKmtNyPI/MMgdXjlyG/rK0cxBxxHuKKAoO6TwwdatQIp6hJ5HUojNhh9sXYfJLYM4dvlsFG56WCUe59xRvbjX5E61MUPWWOOIuSfOatiph+58NWjLGFIESbPuJQL8FhyDxmkBSlemo6+D8QNXI0uLUpNvCmIW2x1UVcQ8GIPMkPCTjejwi1FmR8KZX037ZzrgprtynReDI+ilA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a6c6c3-95e5-4a7a-ba14-08d887c3de74
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 11:04:19.7282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFXB0XrVU4ZPPIsTmfgldedVUeN1/cf26yTXydk9iY/2U+MfoM+3QQ9/s/IjU+GoyDAAxkjMgHIS2NliskOYww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7279
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string to .dtsi file for binding of imx8_soc_init_driver
and device.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 033fee525982..cd9a77d763eb 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -257,7 +257,7 @@
 	};

 	soc@0 {
-		compatible = "simple-bus";
+		compatible = "fsl,imx8mm-soc", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x3e000000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index a06d2a6268e6..6d3a809a00fd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -241,7 +241,7 @@
 	};

 	soc@0 {
-		compatible = "simple-bus";
+		compatible = "fsl,imx8mn-soc", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x3e000000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 479312293036..9cd218f5f004 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -218,7 +218,7 @@
 	};

 	soc@0 {
-		compatible = "simple-bus";
+		compatible = "fsl,imx8mp-soc", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x3e000000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index a841a023e8e0..9b6d9307e5d7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -286,7 +286,7 @@
 	};

 	soc@0 {
-		compatible = "simple-bus";
+		compatible = "fsl,imx8mq-soc", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x3e000000>;
--
2.17.1

