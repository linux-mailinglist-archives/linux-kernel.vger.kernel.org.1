Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246492A5CEE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 04:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbgKDDK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 22:10:29 -0500
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]:64741
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730645AbgKDDK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 22:10:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBGstUKLPUntveAS1kHoeI1Ig1Sn1zwKJ6kJXpzs/XgLATGseIFIftw4cIedDjsUL5Q2EZvZnO24N+PcglCCyb0BXVMRpMvh7cTMbt8+nlK3pkqbGEthkjc3ddAGor1su6v6VGUHVDgD19eMyOu6D6eQd9XS5c/OVmoxoPT6lbf7lBYVQXwUK62tMwXCVojXn8vNw6oQ8Ey7KgSGaHCHxo2Du2ciILwtwZHl9D3BQoE7MDJY06Y1sB4TC024INslzHZeTGG7aTbnuh8OyUHlikaKGiOhhsZytKspbleK/ROoTOoE0l/cpg8V8oMiMXx1a238cKQ+ZXXyFCd7EXIvtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0W/zgzbITw41BieKDty3BYftC/0bDPczpFFIfqUV2N8=;
 b=FiZO/hEeCyEouwAyu8/bIMxNEVa4Q8/nrEyZGKekar57GKd3pMX0OwpJXSMnLE9xAnnbjQ099TDwpQNEAWpM3QhJVWpe6aT8DrOwgQVsZIWkIDpNYDiLKNGryzdJZXe6v/2930DVvK8OD/K3DESTX5oscfwUScFYJAOn5AV+pt65pIubt6CB7PXo1CoZ7OiotMSTuA35plEZ6ffT5+uIU4aV7ydZpCu5GnIfnv9su/jNn7dCxWeFM/6suUWyEY61nqhMZA0BXvkFH9hfq7/AKqVPqFEK9pg7l2r8yfcAc9Rbw5srAVFocAViBWFXVaX+UxCbvGAn7uBr3W2xrKWq4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0W/zgzbITw41BieKDty3BYftC/0bDPczpFFIfqUV2N8=;
 b=VVrNASlfiz453rSPotNyoSDnQorb2Xk8r5Xz6xoed/gsbOvzx+L6bTQqkmng7v9/h1w/bWnNXAeu6rPbKhtldqP6VzZmlLdiqrFPg0w5VxlGUF5DmMl1fjYZCvJrDZYtTq8QYxwTSQ7+U5YkfEMtsVvHRcmdGO3LCKkq1tzR7PQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DBBPR04MB7961.eurprd04.prod.outlook.com (2603:10a6:10:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 03:10:25 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618%8]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 03:10:25 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peng.fan@nxp.com
Subject: [PATCH v1 2/4] arm64: dts: imx8m: add compatible string to .dtsi file
Date:   Wed,  4 Nov 2020 11:09:57 +0800
Message-Id: <20201104030959.13264-3-alice.guo@nxp.com>
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
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR02CA0113.apcprd02.prod.outlook.com (2603:1096:4:92::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 03:10:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 70161104-816f-45b0-5175-08d8806f2c89
X-MS-TrafficTypeDiagnostic: DBBPR04MB7961:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB796107859949D3D75C25EF50E2EF0@DBBPR04MB7961.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1b1NwfJSgq/ng8/RWLFyrZkyW8Y23LCMo8/BH2rw/H3RkZMe23A0YRJAgtraIZJNrkzPjfXMILbdqRr/p+q+MLlcsUaSmqpp5QDGnGluhOBOU/NdvtWno7KyAHSE6NGk5pO4XdISa9klK7OUcXvxhSJcWgyYuRPzvABHIp40NkNT57z9jj56ug4sBOgItRI4vmzVyVkkiSpLPFuuEShE6q6i0juW/0xd1hHcQsryBFdHqb+3tzcbYTM/VFRg0638XiJnj1I4NXHKgvi+ESIf7AgQiHFbWFImA+TvqCcGxYFa4nCcAEAmU1yypPxD6dzpiIiUUrEFXsOfA+Bplu4GLEjcvt3RtJY0boo3JwShjFoEwaqjGtdMTMmYbLKOA2i+ejcPhft1+XerEvg/oD9ojQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(52116002)(2616005)(1076003)(4326008)(956004)(66946007)(66556008)(36756003)(316002)(6512007)(66476007)(8936002)(6486002)(478600001)(186003)(8676002)(86362001)(44832011)(2906002)(6666004)(16526019)(5660300002)(26005)(83380400001)(6506007)(142923001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Smnjtd0wHJID82c9lkRFoHLb2HomaJs1oiNMzJnxene3bvPCAMz0a1tvzjV/RotupFvsAxukadTEYGsaeC+Uv9XxmoIjm2JSSRJI+LjjY/Bbze5FPx8eDxIGklKlV6skPyLXYMGW6OtaON2ZCvK0bKlyYzlU7ZTHNqmIJ8UrtnRsI+J0oF0+koQ0saqBJesKBg/440uhMtU8suk2SySFRQ6fanAtJGeHPmo5RcuuVT2Y92fV2S/+wKNvVGihAMo9BDHsOOIJkUdTiTfGkGb2nJq50APxCDRGQBsstYJbewIKLsDF+K6A9qjanSimD3A6rg0SeJM8Jzeu48vcPiSEPjSIwqQ62yzQJ47VZxHvp1QFF7hqYXTjyrD7vn9C85JP7bY4X9IJ5Iapvs/noH17HhPIPqxZ15PsZmnst51AK0/ee8KpkVlKPHnjnpml4FKzMYfWMv6Swrg8QocAAAPR7bRZeMU1vtcX/sa4ZuxGSK1v0g7075ZzAmkF5zcAatpSkkG1DxWHMpRfx+0Ukx4nkwfDb3WMatYdfj+tAgUwePX3KIIseuZWo7C3ZsuJmFTbraq/ZynztyS3+PZTzZQyKZbqj1zTLUqAk2EgUl0np2GMJdOm4LeIn26YkSXf7n4rAVoMawHv7zlSlIXcCjRr7g==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70161104-816f-45b0-5175-08d8806f2c89
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 03:10:25.1609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYqZzhNdbbv7DeR+2c8oIVQAmt5p+pMft+GapaLeb3C+4kfW1fa5a4PJjwplmYmTtp6XVzX6w3nuGNNiT9NE1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7961
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
index ee486597afc0..ec71a5e8a062 100644
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
index 5e0e7d0f1bc4..a3c76bb880db 100644
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

