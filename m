Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360CE2DDFFC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 09:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733022AbgLRIjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 03:39:02 -0500
Received: from mail-eopbgr150049.outbound.protection.outlook.com ([40.107.15.49]:32167
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732284AbgLRIjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 03:39:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/NU9G2ZZ0E3QbtjyE2KXnnyIVQvtufVEAxq7JMQTRQQI7g/l5yirnXlPvL77jiuHm1hOjQ6UciQzfcaVQHcfzbo+A5ywgjuBqvaM4ICchJzHUuaoC0GAHvCHb0T0Q3VbH9VtrXLhbBoD5TngvthGMfFGirhSZOdvvZfJYu5zC5vOgVECibGe7QG6twkbK7HLaLbGV592kgy6jAdGgCUDURGv/8Z0Df6zsoPEEnhbb8pnLOUBts9TVjOXHhI8mboZfLqUgBZw4cUU4v/jxn8J8OJ1+1eHdgCjT4oqQs1WSJTjRPG/csGnpOpWb80gDs4NALX3sGsu2LSB8pAMYVpog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8SYH+NbNYy61rFBwzHoAsIFaktYavvqqxII6NS2/j8=;
 b=Bmqdh89SM98E5xfybOTUbKBr6VvqAw8mmw4cWf4uxpQonOMmqnDregzHiN+VrldwxBu7Yac35c1nb0HIyZlAletrj7vSKlQxAq00VhfK4LdqOSWraA4KjHesRjgrigsMhI+XwRFAKJhb5eWqwxkwyjEGvfLjJyvGLx0RDqwphEfvGkK2P1i4O3HgTH575Q2QpwwReYy06dluGwFZiBTwpEoNUHyNKjquZjFulw7MDcuYrZzG7tXzSFR9Outf/M92d56VC4O1Om1S2Amo8odIV1ByKReFZcGuRYJa0X4jZyxE6gwEIX+B1tBIkTGf9XYLsNwwMvsKkE6EOOt6/zrcZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8SYH+NbNYy61rFBwzHoAsIFaktYavvqqxII6NS2/j8=;
 b=RUUaX97qMybJNkqlSyHx53Q9S0mTSdRj5bDpeBzNwSiMcFRkw60GWOiMdJ2gK0c4AuD31egx3P+e14xoX2gD9XqKsuCn2yC5wbAjJqXuQMsmzhI0Dty0A3vNVfKa0pjVkQ3eruS0U4TQLOtGC4Yj+qk3luTlKQ+u8mwNdpYYKx8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM7PR04MB7096.eurprd04.prod.outlook.com (2603:10a6:20b:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Fri, 18 Dec
 2020 08:37:59 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3676.025; Fri, 18 Dec 2020
 08:37:59 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v8 3/4] arm64: dts: imx8m: add NVMEM provider and consumer to read soc unique ID
Date:   Fri, 18 Dec 2020 16:37:25 +0800
Message-Id: <20201218083726.16427-3-alice.guo@oss.nxp.com>
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
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by AM0P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Fri, 18 Dec 2020 08:37:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f1eb7cb9-b10e-47ef-499e-08d8a330397b
X-MS-TrafficTypeDiagnostic: AM7PR04MB7096:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB70969EAC43908152AD8B0006A3C30@AM7PR04MB7096.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EwChF78tYrYKhhzdPMKOvPSQSSWjKqS7KFa6f5xWvPF5u1YfJXik9n/nEtkxlNpooRyMMimelGBv2dDjUVTabvAmtOP+irDwAcoScp4PfDbW0LJW0w+5Tsv65MuwjCgJtXqzNg9f5Br4Ta1RYaLZ6jji6p3+wgj1B8NCOSSp6h8il0GHPAGX5g6uuUAWqqbxX0rS/rBX+2EOu3GN8caOmRrYLOGqVrHsKwwnRyUlT7X9tAPnlXGJmXjm5Lb7EHA0LEWjB8lrcSx5rtZtmwMPWMO8n+zcjyROOTQTek97iY0tzZ4SRSZrMbuh3jfUys85GC82q19rjM9i/sKDYhPhketPGI9+KecpF3dVOPXgq1Xt2RYwJ47jxUIM6Gct73dLQk0W2rRqnVNWKbVBfnZE5rzPsvbe65yt6QHun4cLbfgjybI601bmK5EqKTRXXpWw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(83380400001)(4326008)(86362001)(6506007)(6666004)(316002)(6486002)(6512007)(1076003)(186003)(26005)(5660300002)(16526019)(52116002)(956004)(478600001)(66946007)(2906002)(66556008)(2616005)(66476007)(8676002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nNEfsrLwbMIenmWwAnTYMEaeeqreSSsb4T3CSM/mDyI+2JZG3rZQBluqn0jc?=
 =?us-ascii?Q?7rWaoFl+pUph1Kvf3b+ZIaH+3LxhGYipDkFxNxXIfV7W/5+3AMGBj/ig+TTn?=
 =?us-ascii?Q?3+FSa97XqbYkoIVm3suvOwZd08CVVY/TMQPkWDxeVGyHdVd3TDLK/LaI69Lz?=
 =?us-ascii?Q?xQKr9tyLb/ylqhKefUuZD+xYBCQFhfAgO2HXS/txShD+r0/UC6+qDv9Y2fdx?=
 =?us-ascii?Q?e86YBg5UszRoKlqffCFGCE3QkXLbl1PKB6nkaAPmH5qa6Q/tAc9Qi6VOE7TC?=
 =?us-ascii?Q?2C/osPczz1DEJ7ik1HhLnxkEYx7Ii+jaMubrMOsX2kRTUSAfmWER+JkS7Mf2?=
 =?us-ascii?Q?J5BRgfN2FMXxI3qS6dS8Db3yAp8y85Mx/SGf42Ee54uaICygCg0OA5FHP5fd?=
 =?us-ascii?Q?/9j3J32i8L1Sh5ErmfwosXzGgmXNpH57hnQf7dJNoayxosfEA2OX72WKNJTI?=
 =?us-ascii?Q?Dt+F8b/dfGZ/A9U5JSoMw6D3TfKKV8Y5hw43WRjpODPuWC1Fs5U5ofI/Ab5M?=
 =?us-ascii?Q?haeGiw5cxFNxrkchQapR8JP4cuNoP28qM1HZTJEJHRlJc5D+oqi/YidyfFVW?=
 =?us-ascii?Q?t/7aEd4YX8OBZGaj+BEu8XzyTZfOckiOoqq2HWiqWPI6HcTSSb4C3TDXLEsJ?=
 =?us-ascii?Q?/dW8XE+wYg0yaGOI6iF9yaSm4iv3MSHhMi4wqjNNjKTA/5LshgE1smRF7/zp?=
 =?us-ascii?Q?/OhCmCa9iQtZgjw9SC23mxSxldgMbGFACsB0N57o73fQLc7YQmz6Kq7jtrvM?=
 =?us-ascii?Q?dT2dIasfHvxMYTT5ZBZFtfwAHDK3RSeGeVI0Ie/qkRJ+Wnkv6QM0Um8V/WMw?=
 =?us-ascii?Q?s40yOb1nGmAYkR1N2mPXZyzJHpvruQhZXEVIQ2is8UHbZy33LgILKs0t3hFj?=
 =?us-ascii?Q?UNUzagNGxfkEsbvpxsbF0IBFV++A/waG8QWMA7D1bZhcJFZkIQmqh4JuhVm+?=
 =?us-ascii?Q?XtMe8O/5QeMQAIA3L+SNSyfhTPmpi2S+9qkgGLs9I6l2QbswARqDyue7TCF7?=
 =?us-ascii?Q?L53G?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 08:37:59.0664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: f1eb7cb9-b10e-47ef-499e-08d8a330397b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jtj34GAQ04iP66dH9prsWbCfKzyR1NDlO4On65inVTvlMIitBvGuVIfVz51AfYhagsAFi1lXBQed2ai+XZra9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Guo <alice.guo@nxp.com>

In order to be able to use NVMEM APIs to read soc unique ID, add the
nvmem data cell and name for nvmem-cells to the "soc" node, and add a
nvmem node which provides soc unique ID to efuse@30350000.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Changes for v8:
 - none
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

