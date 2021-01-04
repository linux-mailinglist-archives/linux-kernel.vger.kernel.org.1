Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39EF22E9274
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 10:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbhADJRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 04:17:52 -0500
Received: from mail-vi1eur05on2059.outbound.protection.outlook.com ([40.107.21.59]:15457
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbhADJRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 04:17:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMA5CCkP8yYusE3kIuFX3MtaMihKC6EHaFgWP0ZoqyZMkhOU/LStFdUdoQzt4s6QMsbDWl9RbpOEyYui6Rr5U+xUKeVD0pjI0wT4Y3Sd7rwl4mepdGNdagMbOPp1d8LcmofnxYlkWvTOmc7VSwVID6gmXwdgT0fJiYTWgdi3J3gQz0ERyf91jvhq59bgunDdaxOPOXHFoYEBTG/q5KnNA+9oOv7/LeEXsvY81x39Awl86UbpQHTrCk3/KxU72RdiqCJRkmdli4ux95uPH4x5uvyQXPd1kl0ALgQViGPnjeJWQgY3ry1Q+Ijh/03GJNfmxxgtCawtlmdlSojCXx1D2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrDgV7wSG05eNlA/ep5fkWAVLAx5olGL3zy1+PfOq4E=;
 b=a/bQUxYrpG39b4CutMeoh3HpNLOmuQtPm3ruFliY2CoYTSbKVDcIR/X3/pz+CbZnRrpB9TFUrtA01/cv3arvCJ7wTJLnphpttWICV1hWOdby82d47vFQwPyWsNKVnqQO+fTKpqAYgvi1tBIRwVjaAdvyPqP+cyB3Q4AD6oklJ7v8owfMfQWwsgwef23NOG90F2tyUbEM6x8nWT8BQQqnvKAf2qa803iobfA1Sj8BPogBLqY2DZGJPVrSPwsRLcOQpPmaDbHfgWiEOztPbDD0p7++O8zASe7S+rJ8bICwEINIeMlX16uaQvfnLR1cEvtbrQWD4+WjoIsyb0naLPjZng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrDgV7wSG05eNlA/ep5fkWAVLAx5olGL3zy1+PfOq4E=;
 b=GtXiqRQU2rO7KUbRCE076ZNmbC0jHP6G8VWWA4KDu7/B4q0ziCGieCnfHQ/pCjOwpDWLYrwkL6Tuu4GxJQ1iZKK+1BvAY0KJoqsX3QbL5SoG7U5JWzocd7msgCir+5nmn6ZQAzF2zyFS25gaU+30EcqQNLruZY8xiUUUIGOI/do=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM7PR04MB6982.eurprd04.prod.outlook.com (2603:10a6:20b:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Mon, 4 Jan
 2021 09:16:28 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 09:16:28 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v10 2/4] arm64: dts: imx8m: add SoC ID compatible
Date:   Mon,  4 Jan 2021 17:15:42 +0800
Message-Id: <20210104091544.13972-2-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210104091544.13972-1-alice.guo@oss.nxp.com>
References: <20210104091544.13972-1-alice.guo@oss.nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: AM0PR10CA0055.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::35) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by AM0PR10CA0055.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend Transport; Mon, 4 Jan 2021 09:16:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6c311849-df9e-421d-d134-08d8b0916b44
X-MS-TrafficTypeDiagnostic: AM7PR04MB6982:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB6982473F2AAB4EF2DD23F90FA3D20@AM7PR04MB6982.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K0Mwn1EV3mJv3oeFOkltJ5othitN5mytVp6McILVpkzm8v0DLFnRcUP8ao5mbfMFVv4Q0+Bqoyrsw+a0CD2pWdC5wtdHJ7ozV/mtbRfgB6bwICVe6060IkFDz/jiyTqmeDaWgHlxD+a06Nu/lairpNjkM1KZUgzeDM7Rb16cfoA9lgcx3j9fghgeTcEuwVke9reroW7Q+eZi01z9RZlE2qbHM98D2qSuC7M0Mzn3DI0BVrymrPVHXixExIftX/eUfiPpsKUv27aZ5/gtk0jta6YHN8zEMp2IZDLKyqCIUeG5voMhvxX0kMNDgM1aEuS2gE9IxajXFGi40cisGvupqj8WNIVnZ6QcyfXxTYUdqBFJoraESQL5V/4MOhAZ6GTPABTP+P/NK/LbjlCH4t8HzVuogjL8gxRtLOE5GX8X/jVcOmvFW2Zy359makcmJTRr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(66476007)(66556008)(316002)(6512007)(6486002)(8936002)(8676002)(6666004)(1076003)(86362001)(2906002)(66946007)(4326008)(5660300002)(52116002)(16526019)(2616005)(6506007)(26005)(956004)(186003)(83380400001)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pjDf8MMT/tHTUuJbLwPCHC94xh+F1zi14TnhXxW/JZfrfgkPZYdk4s5mboWn?=
 =?us-ascii?Q?Sq2asi5ST7dGAsZLl4VESz5Yq1XDLhm/rX3gAAs+CiCjtf3edUJLB++tp6tf?=
 =?us-ascii?Q?Eyh9TjeVY+98oVzgY9AT3T+uuo1PxxHKflR1IM05gQ+hNUP754K7OtgsH1L6?=
 =?us-ascii?Q?o3E+4QO0wxERfGb5pTJSqt1FyltmoPyXL4wjX3DO3kexc0hEMu3Fpg0MoPwM?=
 =?us-ascii?Q?Xy4+MTZSILPICnrXgER6n7mYWt5LqIL4rwh5Ll3DYbpjmhsXoAMu1+v3vHbJ?=
 =?us-ascii?Q?XUHqIPFs/5B5ihbuFjtnbGWW8iePLPbFuICts1ULSQdW9WPN+ST51cea8UwW?=
 =?us-ascii?Q?iDVGmnWZh9gd882NtWb41SVkZlVm52BvF7LNmiJp/mPzhICssSxE2P6R2/lQ?=
 =?us-ascii?Q?pXXv5Dnns0DERspKQzqgIlt75jJ+TcF9sQFSO/oAQwUiiGyPQRsre7ubsx6+?=
 =?us-ascii?Q?tozXdX6/jun44cE3L9lRstJv9xtP7gR/nnoJTollVEcsgxnvEhIwVZ5i5xmD?=
 =?us-ascii?Q?qz8NkiL9I5do3AE/04hrgzAe0f40bxO1lp969mWnKElfLux2Kd3t4skPa/0p?=
 =?us-ascii?Q?zyoz5LvgSTK+l1Vsj/WnLYfXp9CkvgrPEqFCzhNiEm5Tkzv/rjPIvC7v/rvZ?=
 =?us-ascii?Q?CP0b3V8hVvIOth32pYjGRz1hq+NRtbdAh1z4leJOBUthaZ6BQX2kDUCtw80u?=
 =?us-ascii?Q?CUrqoAu7w1uPuDLO4lytImyeRF6bnM5iz+m9DQV9QTS5wwcr0fuVWRzsgne2?=
 =?us-ascii?Q?Y9VQazghFAjtEYHxsKBPABBj1Fm+b2SmNmu4jAXm6RN/UfMYj4ARqbs+vNxH?=
 =?us-ascii?Q?ovM5HW8sD6XKxsDZp97jQlFjtK5jErRyO+YyAHpCeD0BiO8INYOtlEZbpyAU?=
 =?us-ascii?Q?OHlCJ34ener/rdRnDXGT+VYA4fyzp+NTwKDY+9OcAcrEHE3z78+kWyKGxMXH?=
 =?us-ascii?Q?g44HDHXdPELsLXZMBjBfVTfACg7y5s+187nbySbyCAVr5rI5fldGkDhTduT1?=
 =?us-ascii?Q?DjXr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2021 09:16:28.8424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c311849-df9e-421d-d134-08d8b0916b44
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uewrq7XnVfUr22k4SpbNbq91Fgz5VugPhKk5/cRo7J3sz6Fov2BKZo7WS+FwnsXJ9Tag/29DZNlExFo2cr1Gjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6982
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Guo <alice.guo@nxp.com>

Add compatible string to .dtsi files for binding of imx8_soc_info and
device.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---

Changes for v10:
 - none
Changes for v9:
 - none
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

