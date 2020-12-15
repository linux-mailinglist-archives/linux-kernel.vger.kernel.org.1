Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CD92DA953
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 09:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgLOIjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 03:39:37 -0500
Received: from mail-eopbgr140079.outbound.protection.outlook.com ([40.107.14.79]:33857
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727340AbgLOIjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:39:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2GO1GyXD/YyJSp4h9GRUhCW9h4gDogpLsfoy2IgY7NzISGM1+lHbpYT4ZZnEDHiMXUMbtVJhfQHxwGOs6P7GTG8nOIq3NQCIid84Yor8t76Qet7I1UIkVNRbbsQwCTo8zGB+ing5s23rbwJqdj26ERso2G8lIS1LCFK2+/Z1YudvTy5WIS0JM9VdKKgumWfb6sWewBbpwR5FDdQr2rmggcm4O6RVtDv22m1MKtBKpf5lTM3a4i2/nd1pZOEC30EcsmmwrCHufonXI+or0cYzu9lE5tMEeQGzadEd/x5w41BWnYuOb/MopdiWOHCC4eKXdeqEhE37VWAJcFYjWB1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CQu4se6wkoYC4VFeVDbzVYryNBepVd+nHvJd407cwg=;
 b=FpPXlNkr1BklHHOgzGSsVuNK70KoZ1HWVA0H9f9q9cXsV484LKGq0AL9VYNI62kJ+M64i36KFYk6JHXn/OgI1Bmief+nN+RVgqGa31DGkf+DTgiTaAOAfevReD4fwHzWYpZvvzJsb7mNwDmIJIsvizmGgSiVC9ibyav9/EcYX3gmi+nQe7JELguZJhcTgincY8YDYa7QxD2r6EXwR76hv6rbxTFDj5q2iY6IaemhYpsABCkHu3q5OEYffvW713biOrSqRQK0W7Ff5qLi+BMpCpw1pj4vPShDWpNyT5E4YBbBolVjTTCxCkZ+fid3g7/RB1wTQerWAODVg+wF/Il2uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CQu4se6wkoYC4VFeVDbzVYryNBepVd+nHvJd407cwg=;
 b=GvLJG8l0WZDSsitA4v5hK5gRUu/i/nGnJz1SGoHJAXZb0IPjKxagdSgWdt9e5CUAe/N1rMgD03X/B1CLrvoxpa/3CH9E4LMY8NelkAh6h0De7kHHJQHaK7a2kkj3eC8KrzKQ5IZIQlnnRYZHLsX1/7SS04vLdNXvHEqAk26LcZk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM7PR04MB6807.eurprd04.prod.outlook.com (2603:10a6:20b:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Tue, 15 Dec
 2020 08:37:59 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 08:37:59 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v7 2/4] arm64: dts: imx8m: add SoC ID compatible
Date:   Tue, 15 Dec 2020 16:35:49 +0800
Message-Id: <20201215083551.6067-2-alice.guo@oss.nxp.com>
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
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR06CA0250.apcprd06.prod.outlook.com (2603:1096:4:ac::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 08:37:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97047b10-146e-4dfc-892a-08d8a0d4baa3
X-MS-TrafficTypeDiagnostic: AM7PR04MB6807:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB6807AC9236410E6E75600285A3C60@AM7PR04MB6807.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZZh9zXMw+dbZpERzI4npXrRZSHbf7btdTZs67uh6Rgf35fv/Fa83r6hk7RFb6rcf7WAiJjWhuoLpg+diMGIvlwcP7GGbz5Mi5mD1qCJ/rm1vaQbX1Lk8Z7aMdSR+z2kI1pHFsrgc9MLAhd28nRdHGwzd8w3IusfxHuhG/1RJTcxliYrHYVcKHuUcHwrf65Izsg5Th0JeKVPjiSY4PIi13a8xwXOUHTaYIBKzADmXruuHrp8bXxI15wg6Grj+n6j5SoPacBzfOJaU+bJIvMCJNeBm7HTAgjZ5bw+muGzZdy7QRCQf1V+BVJxl1f4lvMgexI1meh8e5H+d+D/k7cPIumOxUxIitcUTYEHEKFZV0CRvHHyeYHO4kjTCuK2Fv+y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(83380400001)(6666004)(16526019)(186003)(66476007)(86362001)(26005)(8676002)(5660300002)(6486002)(8936002)(316002)(66556008)(66946007)(2906002)(4326008)(1076003)(6512007)(478600001)(2616005)(956004)(52116002)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NP9UZtnTNgC/UIFwDofHbQUT/Ev1dVBs/hVI4DVGou006e0yxEDXUkrIYkDM?=
 =?us-ascii?Q?l3BFx0CDmvrtDllb+GCqPOtxETcJpHxKepVGxD0w9BtuXVic6xCIva/u4heo?=
 =?us-ascii?Q?JbeAiaIOn61Fe7cXKu/6YVQjKPzcix+kmE7aU6VeOj3H8a6BBgF22MV0zqKn?=
 =?us-ascii?Q?BJuwzem5Wvva1+w2LuWjVDTvnT2wEf8tXjerx6ti1eL2t0R0gd29ftluY9c3?=
 =?us-ascii?Q?+CHIUxLY/19MVhvFpoLJWUslcL2ZYncIn3vjePX2VgBtHml2M1CnLPhImUs0?=
 =?us-ascii?Q?Vugpz00omIdQXinx2fVGEHVIC0pdHrA6HjPrXMmk9eckg3+ns4Kk0C8AtJoF?=
 =?us-ascii?Q?Zrs0kJeq79YIjYl+1fpfD1VC7RN1iuuuZWbIkJ9H3LQPuKUhW5m4YF+b3uPu?=
 =?us-ascii?Q?sDvrJCHv7M0pfD2Dse7zyoxklCwWMsePen/FQZQKmaZdaVS8rv92nFNP8nfp?=
 =?us-ascii?Q?m9ECELp+q28kI1nLT/g5IAXQGOXsiZDmmaiFWPz2fCwN+GcP3/59zNG5HOaE?=
 =?us-ascii?Q?OedxHuE+EFnvk5UFjCz+YUn5v/gXX+swJUGb9XzXDqQZUr84rCudrDjcqmoH?=
 =?us-ascii?Q?/WIWk04baBxC6U+qMbvmJYALYOfWD3XXbLD/Ov6dMAEFNj2/kMgehqeIam8f?=
 =?us-ascii?Q?NsrkQqQ6rPocrDDWEFBVOPfujXI/NJmMAB2Ktp9jvYPWGDo19fj2HgJ6stA1?=
 =?us-ascii?Q?osNuqaKtx5f8LxtWSFFUr4Gk3Fjw2w8jHdkcyJSazJnP/7vXVEEDCrE7e8YN?=
 =?us-ascii?Q?YZJ3R4VtETnaTTZnjEm4b0h4NeWiYoV/YdzfFacZgjVc8gclk2UXo/8ewDeZ?=
 =?us-ascii?Q?HAGN3L7EOGGjGFgQZvtdbkpBNseueasa4jxcJhE3fEGTFb6FcRICuX0ZNb8a?=
 =?us-ascii?Q?UUsQFUOKJe0Ub1c+L1FykXC/o3GG0PV3UopoAIYQ7K9ZeENWLwgZ1pD7FyLB?=
 =?us-ascii?Q?TkXarW5/T7pI/eYjbvA1DF6oPZG7+mxZslIcaBt4oOaMm2cPL3oAVFhsQCY/?=
 =?us-ascii?Q?qcms?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 08:37:59.7116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 97047b10-146e-4dfc-892a-08d8a0d4baa3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PpH6ZElZWW71PLtMvMvYmK+sXua+1EIYn0FEL8h9ngmzucMJvmmjc16rYBQbneMlvbEx/MDPZ4rLuCeTGUj7Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6807
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Guo <alice.guo@nxp.com>

Add compatible string to .dtsi files for binding of imx8_soc_info and
device.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---

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

