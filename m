Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9AC2E0719
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 09:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgLVIMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 03:12:54 -0500
Received: from mail-vi1eur05on2059.outbound.protection.outlook.com ([40.107.21.59]:19968
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbgLVIMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 03:12:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfPYhZuC0zowh9o3/Q1kT5gkDfyzpFw/HPDiYiQbUk4w3cO/VA43iO0cBchHL5X+UnxsX6U5incLfaeRZ7Uo/V1IqGJJBVlxrnUFiWCvDgUVBPfyLs1MZ91K3uiU5n+ev2JSJjG++lwWz6gqqtSHwui08Qr3Ut8j8jL6HoixDZ9xGyMhDH/wOPLCZqUcmcuZI8Ndf3GeC/Doss5kLXNU2fMnmPYF+dSX3A++5xhoxFwQQzw4gok31YhfbPdpUboISnjlNxEFgbFlavBDVtpnz450KSNSuYs1yBy7IWPwnVZM1Virjn0fS9/O2M7LFx+ktuPqsZakwYkNPahtchyJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eyQVS2+23EvmEHLjlpwjct6e9T9oSUQjwwW6EfoOKk=;
 b=hD+p1e+yqZ0hmmUb6X3D7AZu/qwrfY1ZPExzgkq9A9yCMl4BH7nUvbc4i43Sgm+cwOPdiYw2EQt4ZbwSLIuyohgfvF13bvFAbdeH6u50BbGA3qROQeMSY+xkYrjsKE4UOauu1roHW9DiEkxxQoL2sg8wn6vvGmc8JctDzB2JdWR/f1bBX34Z0ITPWFFUigHI3RogYnou9JlJY1AkX1Ujdrs8gJ9KAmjIM8meXzAow+cs4Tsr0uZfAOtGpVdr2n4ucluSSkp4qnnoP5M48d4DliN5zWHU44yVyT1oLoDk6hUWSxmE7BRIvEsu21aSG6FNz8YATx97WhHfxOgYdmvNMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eyQVS2+23EvmEHLjlpwjct6e9T9oSUQjwwW6EfoOKk=;
 b=e+mgFWtPXCEa48tyhBQAG97ZjluZOZ4MQyl4SubZzY8DhPjUTw5zypwjldr+2RtKdupADEbCw8X/9iZ3LVx2hmKcb9kqt/KoLYdW5QxCRB4e2IFybZf88r61TFgrvbZ54Rph59MPAlbO6iE2mFYb191AkTni7+GSwqgen/IM2e8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR0402MB3752.eurprd04.prod.outlook.com (2603:10a6:209:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Tue, 22 Dec
 2020 08:11:32 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3676.033; Tue, 22 Dec 2020
 08:11:32 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v9 3/4] arm64: dts: imx8m: add NVMEM provider and consumer to read soc unique ID
Date:   Tue, 22 Dec 2020 16:10:56 +0800
Message-Id: <20201222081057.26401-3-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201222081057.26401-1-alice.guo@oss.nxp.com>
References: <20201222081057.26401-1-alice.guo@oss.nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR0601CA0022.apcprd06.prod.outlook.com (2603:1096:3::32)
 To AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR0601CA0022.apcprd06.prod.outlook.com (2603:1096:3::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.29 via Frontend Transport; Tue, 22 Dec 2020 08:11:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23e6411d-cbec-4ec4-6ab0-08d8a6513150
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3752:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB37527D8B55641E6D9256BE93A3DF0@AM6PR0402MB3752.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +kVBap3x/FnKf/ZIKM93tt/k8W3OsczcJEnidnShIYzW20zItW74RhGQQ27A7WgzXHhJjG2ybFznCS/sgDxgX6SHkn/svcyijbnM3b5b5yolYad6DJJJCr71DfTz46OCQGsNVfFm4Qf1k16ixKyPGLcTizZGFsFkfLmYRv9VvKq+LChtG3VX8gpiAe5ge4jFiIGbYjxtHThuubAcZ1R1ISpFOh0CIbx5qT6f8Jet40XQkWTSN9hkQWX8r/hFsQ2tNVudR3MiLzDJqUX0vsy9iTlWOMHGb8mlhtJAUdJLXCd0wQ7MmsVQp51I5LUTspu8t1NDiQLBQRWHOoLUrnig1mNkWIDa8KHngKDDBsZBuvrgH8mD9dFk2auT0Tgkaj+F0vkxyzAurnyylJhhoTU0K179K8eP6EwnK12h50OzOBbs8CQ0jCI8d1Ttg3ZVnDeh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(66946007)(26005)(2906002)(316002)(8936002)(6486002)(86362001)(66476007)(52116002)(66556008)(8676002)(6506007)(4326008)(478600001)(956004)(2616005)(5660300002)(1076003)(6666004)(83380400001)(16526019)(6512007)(186003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vY3/JwnxZHrU4zayBXGkGGD6KMtFLhqBZc1hTUzAL3JgPh/N9GQOcQJ2QjMR?=
 =?us-ascii?Q?nrugx6JD5VrnIbdpmXzACUfaxRoQmessk+caS/jyd4SWJxaMdZTM/hi39j/Z?=
 =?us-ascii?Q?3cc3mmPoLjjxdqkYdO5phE6jkAc76ZIHSwXpZZM7zXiQsZlYIhV+XKrXdF1i?=
 =?us-ascii?Q?lBOr3+4TCxZs8DZe+DwhM98c/xgVE4FiBCN7ixlMxfkLIszZ4SDL4vTVCxaD?=
 =?us-ascii?Q?ejBvA1ngBlQa5Jp12eI2mv9dQx9v/UkkS4svvLcT6PxuHZb7Ma58BQj/bKML?=
 =?us-ascii?Q?Oc3/1sdOGSQwVZMC2Ve4clSUYKQApzn9a900AMchuS/GeJQJ0nlHJtmgnX/f?=
 =?us-ascii?Q?JitCcHXrrHWqCyivP8JCZs1i90bxd58cjb4JOBCVKjzWGCY/AKU3belQS+f3?=
 =?us-ascii?Q?22+WnV3egSXAEHM9esnInvI9sXkh8I0+zTk5l4XGg7ERmCf8lAksQ1ISkLIx?=
 =?us-ascii?Q?EEKvU7zBrzC1jJHip3xnIDxrE+SJ04r8kAdk6f7s27uhWuinDDEBZjso/J31?=
 =?us-ascii?Q?EhhPjnPz2QWk1AeyItgxWT+tSfMt4/zl1+5bMwupE9XI5YdQ1N6YK7s8b8kQ?=
 =?us-ascii?Q?EtkImJ6W8g4pAU3A+YgPc6vWqI+fC453dFTOwPoIUJegMRvbMAO3MFNyTL0u?=
 =?us-ascii?Q?ga1vD8pHfj7PUsd8/nIVTi9yrBEd/r+a5LtWCCHPhLabhXThy0Qx/KYJNYVw?=
 =?us-ascii?Q?Kf8zlMwxHglYCWgaaJaWWZ0c1snNHDBG6O0EZasxyS3eFhZ7HOPzQ/5nxDpl?=
 =?us-ascii?Q?/1x1+mVcfiIdlrBz10ZfZsWvqves9PAL9MGRHwCJNSzZ8Xh30sHzrJZRY/Hk?=
 =?us-ascii?Q?5xhS2VMz9GzTGqkb/S32ubf2idLxy0+/7gFp0CMpk6Fq4OPVHl067pw/pYpV?=
 =?us-ascii?Q?OQWZ6seQpjY771wtyTKTVkLGG1Ms5PDmSiF9iXKaC4Fes17/pAigg1b5r03F?=
 =?us-ascii?Q?BnmNhQ/6fvkfgPXQwX6swuYBtpSWQsvxdtu8fe9dQ8uDvbTc0I+aUmVjQhvn?=
 =?us-ascii?Q?Mahs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2020 08:11:32.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e6411d-cbec-4ec4-6ab0-08d8a6513150
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+vEA2czf/Zxyf90yMo0DNuLwOBjQ25hyLwrIUR/mM6/3Fv7DKrd0OZm1mBTakZV3YkZ+9WYHEva5MG3sE0mNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3752
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

Changes for v9:
 - re-add Reviewed-by because it was lost in v8
Changes for v8:
 - lost Reviewed-by carelessly
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

