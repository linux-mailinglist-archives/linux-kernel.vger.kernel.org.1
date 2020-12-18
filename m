Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F77E2DDFFE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 09:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733039AbgLRIjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 03:39:18 -0500
Received: from mail-eopbgr150084.outbound.protection.outlook.com ([40.107.15.84]:60484
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732284AbgLRIjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 03:39:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPzv7cxylAxmHLF1wzeUJ61NQPWcdYEljKa72KjPfzpfTjJGH9RapzgsaF/az6PCYxsHU7h5aEcJJX/yk/B1Hf+uu6TiVXz49jLuht+SvQNYRZ+pjPa64+4bWjp+HGdWu6XyYDmTOA69MCvvBjkr2S0al0swO4LoQjJByNsD1TMeZM4W5jXBz5DXdB6Mo+17j1bVeMvEkpcDzNQhbnn3fZ2kHuPoBa1rlA+H6zXm3hbaKqObkTa7lMFRb4GqbgaSf4EXVoUgA+YjnWVcRMuc4gKn4TuVcJTao4pk9wfuQx87CwqCANTV0AAGkYKIfAT53hT5Br+Kz6FDoxvrUmL7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mt0ltC8M/WcFFRu30RVcMVjeva/xgQU5JL/9aJswkeM=;
 b=W2KTrsW+DQDewyivgZJKMyvpy79BD2t1Dw/xWlBzlNmqApkP/v/wk1/LpksSrSSAaRD0QjNMIlcYW2U/fJb1b976CU4QMIf9r9LMYhTtUP/08XKx8+ySqY7VjNebgtffcLI9+LV8GmsWeI4nlCC0Zv9NgT00Zi0stq6MaafY0hgk0AdgnyM6dJpchtGTl/0Agfl4xbB4KDnZAkCt5BZMkw9qeGUiCUCz+IjoEp3sfW1o1ego8HMpQmSceq1oP5PifR6Dvi7JUNs9yft7FxLO+CjEG+DJwvFfCfNMSaJY3S2G/10a/FTKygBiv3LiB1UjA3RTI/DU1FXIK5A2joSCJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mt0ltC8M/WcFFRu30RVcMVjeva/xgQU5JL/9aJswkeM=;
 b=W7HXPdIqN5Y3cm42230WLEw+0ZouwY5NPH5Pb+tq0Gmchqgtq53jrlUGnPB873fmYQnXgGGW9ZU0LFA8KOxCGuyOLQF8XwADRzaTrk/8qu1h+onNyCqFsvc107+Ey1L6u67BbARXLVhYS+XQeIPgeD+v3DaBt8tTlgZX1MA+CDE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM7PR04MB7096.eurprd04.prod.outlook.com (2603:10a6:20b:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Fri, 18 Dec
 2020 08:37:53 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3676.025; Fri, 18 Dec 2020
 08:37:53 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v8 2/4] arm64: dts: imx8m: add SoC ID compatible
Date:   Fri, 18 Dec 2020 16:37:24 +0800
Message-Id: <20201218083726.16427-2-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201218083726.16427-1-alice.guo@oss.nxp.com>
References: <20201218083726.16427-1-alice.guo@oss.nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: AM0P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::40) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by AM0P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Fri, 18 Dec 2020 08:37:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8b589e2-1985-40c2-1a40-08d8a3303629
X-MS-TrafficTypeDiagnostic: AM7PR04MB7096:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB7096CB53786F4C979507C216A3C30@AM7PR04MB7096.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hsU3unVPsKBm9tL9HJupLw1irRe1V7XBZOgFLsN6LBS4cdsH26v6JYKIN4AuKBLULTwc9mzn/hWUMAr/AATGtwRZl7ItJYEUEXn3HXCwoj+exh7A1J2q0f+vvjZaJL5PxE/nUua+NUimnO7p09lhzTf94Kphq4QjK8trFpNm0Y0uzp7cSBx40H3X+RXkZVN7kTw9wihrOL5Eg368/c0wqlgtEyzFQKMEGjgvFJQwhGCxHrkJgi7pAywcup0qE6O6Bdblc9tscx+d29Q8cO2xn/H0Vt2mVXapejAfnkR3k5djIdWWpRmk7+wwWqj/0ph7Twq2cG3yzUKh9efQAD/szbOp5UMtcS5jV0Xc3HfTE+iN0CIo1XET5ewUgV0uCA/qrS9YF1nWiETI0s98+P1YavZeBeXSGb6xcv3m0ILeuTowVWqG/HKlTHaeMZpKnhp9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(83380400001)(4326008)(86362001)(6506007)(6666004)(316002)(6486002)(6512007)(1076003)(186003)(26005)(5660300002)(16526019)(52116002)(956004)(478600001)(66946007)(2906002)(66556008)(2616005)(66476007)(8676002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Spatj6MpbBSBJXGi4tqf65Ikb9nKv/IkBqPAkK5GmOMNXEIEagx4UO/TsHKQ?=
 =?us-ascii?Q?POLF8Xm+x0S8IS7xL489Hq1vqkSXkszHVsoO4hQDb8MtUg1ran7x1tOYDBXT?=
 =?us-ascii?Q?Nas7nfvwmheCPoKQ5GTg2gMRktcZHxQJEksZa+Z8Zash+2JkTJdi2PipS99H?=
 =?us-ascii?Q?HaxvtQmygrP2b1hd/gGIDtLIuZjQau5rmzx+mAOLVOSeXBkklI/UJgKNhhs7?=
 =?us-ascii?Q?j/jjliYh8nS6ZJ/X5D1yTgoO1pHl+jqkYBVSqLWgNLCF2r4SSj9Sj8LveLUR?=
 =?us-ascii?Q?PKR2siKa8vE9mXuQeZZSEp8HrhDkMvgcpYwq2r9tJWM9AY6jwpI/VMGr2ygd?=
 =?us-ascii?Q?RgJzpHpjtCw5lUgfNBbd3hctUyfb+ts0fI8U18kqfvQaQQsTEUYQ9nC62QSy?=
 =?us-ascii?Q?k+pzO4ETtjjudX/X0dNGsIvRttI2A43UwZ9r3U6433dVbmWIV7GB8rOfhRWE?=
 =?us-ascii?Q?gq+p87clFZZxqDhtoDw/58KZJRgc46RHY66v36z2DRZm2VSe4jZRCJtZJzjT?=
 =?us-ascii?Q?nhUqrLpfGW4wrYa8aFiWUSqVL3sPZuPRpzquniBVtsemgzxvmGTgE4Lfqf0X?=
 =?us-ascii?Q?V61i0GQjt24crggRr0qvceVjseSTAdeYWCCphGOrRDzKUJUNwpsKCWUjJ9Lj?=
 =?us-ascii?Q?fU+vSBHshm5EoM4HIB1fYjrLw2bKY51eTFIBksvWmfV/gGFZvWfQ3PuLc6y3?=
 =?us-ascii?Q?qXkVNIzysfTruJ3sP8XMQtJdpu0b0xf1yc2smYEG6dkhQqktsaEt+OCa8YPf?=
 =?us-ascii?Q?0jGnN0rUimzkaNXKDtALucEjSloFfDzz/1fZ3woAw3nP6nJa19vkBHfPUDFH?=
 =?us-ascii?Q?c9QQ+wkBYhCal4Z5y7Iztks2dEuHlDXDWRWbPzTKuli9e/bgdXtOsdG7ppWc?=
 =?us-ascii?Q?w2iDYzfNrgI2LPleWulwRgrGSGCu39tjVMe6o6XFX1Eh4Q8KYVC9YHahQx0g?=
 =?us-ascii?Q?lENHyJjAn5/WN0ZRxhi4Ph5CNBdOwkLw7KYyxSKkbtb12UmhrF/nGIpz7pnX?=
 =?us-ascii?Q?VgZ/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 08:37:53.4946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b589e2-1985-40c2-1a40-08d8a3303629
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +57y45zziSVdToZcnD+ojEqv/CT8RnsVFA50sfUVECfc+CTF0p8jgdrhxyBNERRI2m4drkizRotXEE0YJ8DaGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Guo <alice.guo@nxp.com>

Add compatible string to .dtsi files for binding of imx8_soc_info and
device.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Changes for v8:
 - none
Changes for v7:
 - none
Changes for v6:
 - leave only the changelog under '---'
Changes for v5:
 - none
Changes for v4:
 - change subject and commit message
 - add Reviewed-by
Changes for v3:
 - none
Changes for v2:
 - remove the subject prefix "LF-2571-2"

 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index c824f2615fe8..d457ce815e68 100644
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
index ee1790230490..db50e6e01ac5 100644
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
index ecccfbb4f5ad..ec6ac523ecfc 100644
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

