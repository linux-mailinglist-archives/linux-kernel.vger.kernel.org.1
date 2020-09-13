Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9390D267E02
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 07:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbgIMFVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 01:21:42 -0400
Received: from mail-vi1eur05on2072.outbound.protection.outlook.com ([40.107.21.72]:29825
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725883AbgIMFVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 01:21:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMU/Q2m9YAdtuUZDq8II7tAfvnosXE33x639UvHGWdziBBjWbsoZT2DRyFjMkPZlYjYwDwgNbJ98N38GUWmhYcBhDURVSRVQvK/CA7NPOWvxp9vTxbTigSo0uSJ01hdBwIAsFm5AfkyJ002A409pYM35o3i3mcIq4fHf17VKDVBmIUPgCUwGt6nnz5Enrk5r0TtgswWbLXuTya2pHjWWWsf4bVIViTW0B00wZIxNlIbcHDmlMPh19LFQM1vqrgaZz61iBZYWow0kjuglAcgHW1cJiUG6W/rHlBNkOQI5t3alS9ZnuqPhwVhlZHzPUdi0MROTMJtYu6fidOoNLTjlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPNEgKzdjydXXJBUb+T7dcwnQ1W/mTFGDZlR48x1/zA=;
 b=a06ahJHYrCHfSFKDSHgcrtME8y/ckNRQWXdOgJLiP4CXASLShwDhP/VXMh+nrYsWFZFw2aS26BWMe/Q1TZxr2sssE0Okax+wZIaqB8NrY56wexxqvcbtP5XMpQBGthOfyKaX0Ix59KoPgvJ2KRIUSI0j982KZg8OsJJiFUFa95QXqoTSso5scH5V1AsR9GnDtQd60F9xpf8B3wibB98RtBeZKz72u1M7csx59wOUI7A6PHGHdNpEuXe5HbBdWPLvcuTvqRMpDFFXoqJAXcVRuBiDdj/gs43902KZanz7zyR3iq/lmoR+KM/LnYMCdWlx4gKhiBwXbJlwF4bJ5+xq8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPNEgKzdjydXXJBUb+T7dcwnQ1W/mTFGDZlR48x1/zA=;
 b=Li+/N4qXEW5mGiepg185cEtjEoFYA7oZ17tfuRpHnIVUNPq5ITEoyf9Vi7lxOZzPcaJMTZmzM4a74WF4o8rohBT/9jZdlEJFNtr0duOPMiQG0lLfM+JfAAONLsNhX2pl7wiF/ULQTTPlKGmetSGYVO2Wj1ifGtlxVhomxl/I/Jk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com (2603:10a6:803:123::13)
 by VI1PR04MB4224.eurprd04.prod.outlook.com (2603:10a6:803:49::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Sun, 13 Sep
 2020 05:21:32 +0000
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::1dce:f6ac:a750:5ed0]) by VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::1dce:f6ac:a750:5ed0%6]) with mapi id 15.20.3370.017; Sun, 13 Sep 2020
 05:21:32 +0000
From:   Wasim Khan <wasim.khan@oss.nxp.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, V.sethi@nxp.com
Cc:     Wasim Khan <wasim.khan@nxp.com>
Subject: [PATCH v2] arm64: dts: layerscape: Add label to pcie nodes
Date:   Sun, 13 Sep 2020 10:51:16 +0530
Message-Id: <1599974476-10617-1-git-send-email-wasim.khan@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0244.apcprd06.prod.outlook.com
 (2603:1096:4:ac::28) To VE1PR04MB6702.eurprd04.prod.outlook.com
 (2603:10a6:803:123::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03032.swis.in-blr01.nxp.com (14.142.151.118) by SG2PR06CA0244.apcprd06.prod.outlook.com (2603:1096:4:ac::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3370.16 via Frontend Transport; Sun, 13 Sep 2020 05:21:29 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [14.142.151.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 30072c21-45c5-48aa-373c-08d857a4e007
X-MS-TrafficTypeDiagnostic: VI1PR04MB4224:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB422496005AAFC0771C0F2477D1220@VI1PR04MB4224.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aJFod3F7MdmxG3nmtWTpizPdF5qrbQqY1aB1Kk/ItahM5/KhoVVi8bGaprojdRArGVNTb1qzGKBSOSctMOc4sNgsXLC2NIKkxsCuj4MD51WkzegfIjTzMo/l+G2AQNOUu8gjbmhoYwFHq0SUmD7kBLk+swllnpRv+uFwc9SmM33vEjwk2JgPJ1zWfhhKDCbwXGfsZlWvl9gyyFGXkZVDE0vyh7QAjOzpmjSEhMB5IMlySz8ufUgRCzjr2Qw+Q8iHpVOXqJGUWNYQGdPFv6luVKI1BMgrtmiCe/Lx3eYrN/naf18LhEEVAQu4sNplxpO59hi+3NGzWnm6aP9w+weu/YybVyK5+deyiwPoEu4+PU//HSuymGR21nYvYAq/nMOc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6702.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(6512007)(52116002)(316002)(55236004)(6486002)(8676002)(6666004)(4326008)(5660300002)(86362001)(1006002)(83380400001)(66946007)(66476007)(66556008)(8936002)(186003)(956004)(2616005)(16526019)(26005)(478600001)(2906002)(6506007)(44832011)(110426005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: cDNKEcCMA8aXn/w3bvixbJk0Gmw/7Q6Z+EwCyrE7SOkkWt76rDL9F4OpWBKOVFpmqLdlA4tA3MYuCnbPrg2Fz5pc9kUYeZQ7oRxPePwvcdNOVmj0N/xfbj0uvFS8OWWnejqT6WSvxXE2DZka/4ByEbZsKQT9uKZcJAhyDbv3wwsHeAvLzv1/9kawmyCraMIO67au/4MT9TAwKptORknMShtVIQOvhrV315zPafREOTWJxRIRxvUGOweAE0cDpidLb0cgssr+87z0+P1xOS8LdbeGw02InQGXYXzlsPiJBdb6+SqniweXdpQD4Kshh44ANBpyKCTgtAX4yepOiMLFZ/XkYXNV48KqTkoP6YvmRG40GUpxT5/1LvhLmslyDUaKHCeWdHzM6hja/9mqka0PBIryiX6O3qAmEacTAv1GZuM+uJTSVbINXmV+0u3MBoVIJF35UCmQON+oOJWfx9Aah5SCmBZyj5YtyIG09TmTCbGTQVvZGN3zMPsUto/OTEejQCAWbbkAKTK/HpRU3UFRbseLVEaRXZPpcAJiZdLiyicBywVG2EmyXkU2U8mR/Bq47tEWn4hhTqjCZAabYU8OavAllFawlZX7RgTWEMBMzY17V1zIF9M9nLaMAPyD5s34k/cqNEudpix8IblPfDEndQ==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30072c21-45c5-48aa-373c-08d857a4e007
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6702.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2020 05:21:32.0236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDp5sVII0Qwiiv+hEjFoLpn5MzLHhCeQnFiRRkCtd30PAUvkc38OqH8dWTu6c9yR5NVmN4j3ZnAnh1t2R1PtjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wasim Khan <wasim.khan@nxp.com>

Add label to pcie nodes so that they are easy to
refer.

Signed-off-by: Wasim Khan <wasim.khan@nxp.com>
---
Changes in v2:
- clubbed separate patches in single patch

 arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi       |  5 +++--
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi       |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi       | 10 +++++-----
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi       | 16 ++++++++--------
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi       |  8 ++++----
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi       | 12 ++++++------
 7 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts
index 9927b09..242f4b0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts
@@ -87,7 +87,7 @@
 	status = "okay";
 };
 
-&pcie {
+&pcie1 {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index ff19ec4..6a2c091 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Device Tree Include file for Freescale Layerscape-1012A family SoC.
+ * Device Tree Include file for NXP Layerscape-1012A family SoC.
  *
  * Copyright 2016 Freescale Semiconductor, Inc.
+ * Copyright 2019-2020 NXP
  *
  */
 
@@ -489,7 +490,7 @@
 			interrupts = <0 126 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		pcie: pcie@3400000 {
+		pcie1: pcie@3400000 {
 			compatible = "fsl,ls1012a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 0efeb8f..55b6e72 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Include file for NXP Layerscape-1028A family SoC.
  *
- * Copyright 2018 NXP
+ * Copyright 2018-2020 NXP
  *
  * Harninder Rai <harninder.rai@nxp.com>
  *
@@ -553,7 +553,7 @@
 			status = "disabled";
 		};
 
-		pcie@3400000 {
+		pcie1: pcie@3400000 {
 			compatible = "fsl,ls1028a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x80 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -580,7 +580,7 @@
 			status = "disabled";
 		};
 
-		pcie@3500000 {
+		pcie2: pcie@3500000 {
 			compatible = "fsl,ls1028a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x88 0x00000000 0x0 0x00002000>; /* configuration space */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 5c2e370..0464b8a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Device Tree Include file for Freescale Layerscape-1043A family SoC.
+ * Device Tree Include file for NXP Layerscape-1043A family SoC.
  *
  * Copyright 2014-2015 Freescale Semiconductor, Inc.
- * Copyright 2018 NXP
+ * Copyright 2018, 2020 NXP
  *
  * Mingkai Hu <Mingkai.hu@freescale.com>
  */
@@ -814,7 +814,7 @@
 			interrupts = <0 160 0x4>;
 		};
 
-		pcie@3400000 {
+		pcie1: pcie@3400000 {
 			compatible = "fsl,ls1043a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -840,7 +840,7 @@
 			status = "disabled";
 		};
 
-		pcie@3500000 {
+		pcie2: pcie@3500000 {
 			compatible = "fsl,ls1043a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -866,7 +866,7 @@
 			status = "disabled";
 		};
 
-		pcie@3600000 {
+		pcie3: pcie@3600000 {
 			compatible = "fsl,ls1043a-pcie";
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 			       0x50 0x00000000 0x0 0x00002000>; /* configuration space */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 0246d97..1fa39ba 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Device Tree Include file for Freescale Layerscape-1046A family SoC.
+ * Device Tree Include file for NXP Layerscape-1046A family SoC.
  *
  * Copyright 2016 Freescale Semiconductor, Inc.
- * Copyright 2018 NXP
+ * Copyright 2018, 2020 NXP
  *
  * Mingkai Hu <mingkai.hu@nxp.com>
  */
@@ -718,7 +718,7 @@
 				     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		pcie@3400000 {
+		pcie1: pcie@3400000 {
 			compatible = "fsl,ls1046a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -744,7 +744,7 @@
 			status = "disabled";
 		};
 
-		pcie_ep@3400000 {
+		pcie_ep1: pcie_ep@3400000 {
 			compatible = "fsl,ls1046a-pcie-ep","fsl,ls-pcie-ep";
 			reg = <0x00 0x03400000 0x0 0x00100000
 				0x40 0x00000000 0x8 0x00000000>;
@@ -754,7 +754,7 @@
 			status = "disabled";
 		};
 
-		pcie@3500000 {
+		pcie2: pcie@3500000 {
 			compatible = "fsl,ls1046a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -780,7 +780,7 @@
 			status = "disabled";
 		};
 
-		pcie_ep@3500000 {
+		pcie_ep2: pcie_ep@3500000 {
 			compatible = "fsl,ls1046a-pcie-ep","fsl,ls-pcie-ep";
 			reg = <0x00 0x03500000 0x0 0x00100000
 				0x48 0x00000000 0x8 0x00000000>;
@@ -790,7 +790,7 @@
 			status = "disabled";
 		};
 
-		pcie@3600000 {
+		pcie3: pcie@3600000 {
 			compatible = "fsl,ls1046a-pcie";
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 			       0x50 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -816,7 +816,7 @@
 			status = "disabled";
 		};
 
-		pcie_ep@3600000 {
+		pcie_ep3: pcie_ep@3600000 {
 			compatible = "fsl,ls1046a-pcie-ep", "fsl,ls-pcie-ep";
 			reg = <0x00 0x03600000 0x0 0x00100000
 				0x50 0x00000000 0x8 0x00000000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 169f474..08c0125 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Include file for NXP Layerscape-1088A family SoC.
  *
- * Copyright 2017 NXP
+ * Copyright 2017-2020 NXP
  *
  * Harninder Rai <harninder.rai@nxp.com>
  *
@@ -473,7 +473,7 @@
 			};
 		};
 
-		pcie@3400000 {
+		pcie1: pcie@3400000 {
 			compatible = "fsl,ls1088a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x20 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -499,7 +499,7 @@
 			status = "disabled";
 		};
 
-		pcie@3500000 {
+		pcie2: pcie@3500000 {
 			compatible = "fsl,ls1088a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x28 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -525,7 +525,7 @@
 			status = "disabled";
 		};
 
-		pcie@3600000 {
+		pcie3: pcie@3600000 {
 			compatible = "fsl,ls1088a-pcie";
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 			       0x30 0x00000000 0x0 0x00002000>; /* configuration space */
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index d247e42..83072da6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1011,7 +1011,7 @@
 			status = "disabled";
 		};
 
-		pcie@3400000 {
+		pcie1: pcie@3400000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x80 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -1039,7 +1039,7 @@
 			status = "disabled";
 		};
 
-		pcie@3500000 {
+		pcie2: pcie@3500000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x88 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -1067,7 +1067,7 @@
 			status = "disabled";
 		};
 
-		pcie@3600000 {
+		pcie3: pcie@3600000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 			       0x90 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -1095,7 +1095,7 @@
 			status = "disabled";
 		};
 
-		pcie@3700000 {
+		pcie4: pcie@3700000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03700000 0x0 0x00100000   /* controller registers */
 			       0x98 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -1123,7 +1123,7 @@
 			status = "disabled";
 		};
 
-		pcie@3800000 {
+		pcie5: pcie@3800000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03800000 0x0 0x00100000   /* controller registers */
 			       0xa0 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -1151,7 +1151,7 @@
 			status = "disabled";
 		};
 
-		pcie@3900000 {
+		pcie6: pcie@3900000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03900000 0x0 0x00100000   /* controller registers */
 			       0xa8 0x00000000 0x0 0x00002000>; /* configuration space */
-- 
2.7.4

