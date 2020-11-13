Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3172B19A3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgKMLII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:08:08 -0500
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:17220
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726621AbgKMLFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:05:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vx34GG7uTnveZGXdVbFRoSOR0LIInW8AuBvyE/cULYHXj2ykvfDTQCeKxyoq7/BB1/lDzdNtfOdeJ7/CnHGChSJawCUy0uatWT5Og0j9kOPTyUq5rc+r+Zi1KKyQH2EzobmshpQaB9VYsJ6IZaPA5wOcY0ku0zr2ZL61c5OkE27JmYcStp5J2hyMzSYCdYmsIeE9go27Ly3/rC9g4KMrpasfL0TKNopeT3kPTJqVrxSuau5vGG+210tVVN+0MpBq+7gi2EBbV1z2wSIVX3w2/AeIsVLDud7trZQTaXclBIfzSFjpmOroYyitdzgF08/BTLpZUu1p+qIgMJ488XVAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/UnqVSWhX7CfXa9AN46bNW2rTl6rHiSSzsHtYvshDw=;
 b=YcEj/qSYeR3+Vf5JSEbpckzHPOQfdNRvxdA9wrNj+Kkq+QYBhOQxX7jizwujyzHPNAx3J8Z5/lcAE1SGce5SvRi18+KF+58WU/BAeSEhT9KPW/tvBMkwXpFEbiSPuWCviMAo/y7JTQS1bMTIEQHKlSJIBJ3HRVBKfCV1Z1arZovCpwnIF1kizqGUucKbIw3mu7XMwDc4/1DDqrsA6fAYBNdYYg9PLLZ6pnSpnchZb/z4gqVj43nIOjbtqFdnN35jIrobTg0Evh0ivTjprXX9nKX5Lgj+/ttQD61K3pe/mq2Byv1YEQiOAFAODu+Y+IFE68P5iYffOvA+idTpZ908GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/UnqVSWhX7CfXa9AN46bNW2rTl6rHiSSzsHtYvshDw=;
 b=UFU7kekupobhtoNm0t6qM2ryQ9lZG7twpkRLt9sL8u7pl3eOxMQGrRQ8y0WeEOHyr6wVW+KR+wU6XqefJgKfRCai41RZEQShYrDiFkdFgOT1C/t3DBeQ6RU1BxSt2/jJVM4HeU+LeHrslOhu7M6PbmhxKHGszTlGeuZGjN6nvLM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB7071.eurprd04.prod.outlook.com (2603:10a6:800:128::8)
 by VE1PR04MB7279.eurprd04.prod.outlook.com (2603:10a6:800:1a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 11:04:25 +0000
Received: from VI1PR04MB7071.eurprd04.prod.outlook.com
 ([fe80::1de8:9a84:bb92:f944]) by VI1PR04MB7071.eurprd04.prod.outlook.com
 ([fe80::1de8:9a84:bb92:f944%7]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 11:04:25 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        krzk@kernel.org
Cc:     linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/4] arm64: dts: imx8m: add nvmem-cell related stuff
Date:   Fri, 13 Nov 2020 19:04:08 +0800
Message-Id: <20201113110409.13546-3-alice.guo@nxp.com>
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
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by AM0PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:208:ac::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.15 via Frontend Transport; Fri, 13 Nov 2020 11:04:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84df484a-06f8-4e89-77d1-08d887c3e203
X-MS-TrafficTypeDiagnostic: VE1PR04MB7279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB7279E40AE753D870D03864AAE2E60@VE1PR04MB7279.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k0Ge8ejdlusaE3nrYQWCgQUCrXmR6ACxQ/z+7uqPALlCK/vGD26zrAHeQAZ63IhUl94aTzxR5k6Q5AIizT/xzCNTz5ckEQBoQ/aFP9vgNdEGnSl6EC5JXu2tc9CSEpbyYs8EuIN4Dco9/pcHNj9WPHWgIxQgAs7QxptqSKwc0GC5XT+LcqKtlv4r/tLkvfgIO8MH1OR6dxrVdj8AwW8k4xMLvy45j3KFaKrFOai5ekMwlGD+4IsbphkutXffTmupWMSlsGLYts38eVmEQ8+dHOGbRA0INQRItZd3xy7FJVGull2gPvWCT5LE8BcYNxtibzGxoG+ViJzyVGnRuTkRN46VPqGQmwADblbr75aGT2AVKOwWnwpRmzyAz1ufQ3n0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(66476007)(956004)(478600001)(86362001)(66556008)(6486002)(186003)(16526019)(6512007)(1076003)(66946007)(36756003)(2616005)(2906002)(316002)(44832011)(26005)(8936002)(8676002)(5660300002)(4326008)(52116002)(6506007)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rxqJAHCHq2rX4aBsulSExsHEUq9hJ/TrYbmij9+bSt6rqQjimNhLvZ16C3S5HPpoQCd8I2i4N1GczvF9u3bAzK1D04/7v8YSLr8ncnl6dRw5ui2Xkz7jmhcIHNRHpyOOYko+SNDrvHfkbAcqxOYJsueMY6nGQ5DM3ZYzRHHaMW6gjsUcegpLD6FALDLypsTeGemiuugjLljbQahcuGf3QwnB2WWCbzycUEfvTxNTnOtbk57E6I7qcwh0v0SM956oZD0ETjMpbxxXJ96oRgSWbNfeD0+7kkg6UlcbTBDpuIPxRSEGtXFDKynmoygRufs98IbB1TObZWMRrsiObb0BGkEkOxn2/1n4gjPxt/JDw3vigZTMvLE/yvhoBpDGBJUqjHka2svQZYqRSNgDBb70ikoYDi2kDkcb1fBhxOdbF6458O4df6HtXcXnv22aEI0KZpfJA1vI6yv8lr/abgTgrGXfAGao/rbdNecWM84r7Kz0Q1l0zJMKK+GaMMJUkKSahRHLGlTkIowyX4S7jn9J3wENDCvxv+KXdbIurvuVJPWxt9DHsSJurY5+blfrfxP/svBKQXEeGfsfXHaMTY0sIUUAhjGYhWGZFoPwFndUOL+X0/BIzI4+XHd53zDXEaQ1pYDh75teVbT/k5HH+lZ+Ug4pBHnlb7euR5O0RbJresJX78sXPtsZlAVoXfnP5we2eaLmhbJyDfOhvNyYo0WRzHmixZuOKNqRL/qMpQm3kBxwBPHWu45IG4z4Y4kSxYcc4mNnQQCbS75TP2SXLl+7gdohIHOgSxBMOmFf8f09zuYsOcrTtb1XU2ORQuk3iexXaSYOJGFjtyWpTUala1jqF8gM/qNzHbxnp0DGrz4RuaBBp0yLs919rOQbR5u1DBujC9TqcAjf5S4pDb+/9HCafw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84df484a-06f8-4e89-77d1-08d887c3e203
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 11:04:25.6799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bSozh/kypRcokrapLP1UYV94g3Yyr0vAt4LpnHPT2XSK4eh0FgZTeD9pphD6CYWoflcZ0ymcNNBmR+poJfX5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7279
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
index cd9a77d763eb..d4aec3eae147 100644
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

+				imx8mm_uid: unique_id@410 {
+					reg = <0x4 0x8>;
+				};
+
 				cpu_speed_grade: speed-grade@10 {
 					reg = <0x10 4>;
 				};
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 6d3a809a00fd..ff12194b60a1 100644
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
+					reg = <0x4 0x8>;
+				};
+
 				cpu_speed_grade: speed-grade@10 {
 					reg = <0x10 4>;
 				};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9cd218f5f004..3db59f61e871 100644
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
+					reg = <0x8 0x8>;
+				};
+
 				cpu_speed_grade: speed-grade@10 {
 					reg = <0x10 4>;
 				};
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 9b6d9307e5d7..6db5cba9c07d 100644
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
+					reg = <0x4 0x8>;
+				};
+
 				cpu_speed_grade: speed-grade@10 {
 					reg = <0x10 4>;
 				};
--
2.17.1

