Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D952E0713
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 09:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgLVIMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 03:12:18 -0500
Received: from mail-vi1eur05on2077.outbound.protection.outlook.com ([40.107.21.77]:45729
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbgLVIMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 03:12:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbtDVFP/LfQnCCtwL+lxQWS5MxRa4YQ8itwHZDhgEFI57gme7f8BHaPenEsay0BKoWNhvXyxnTVXmnCHbGdCuHkwn0M2/vV3EIraxRhXyt8Bf61Ps4lgxKWvdulezvWstHCCPODlhsQqNLmNABDWfslwxVfiJZXC4vNyWdmNxHzcqVBVN96a6frywj394n9jGHrt8W6hKec1B93sHcRGYlV9GyTlDC/yDzUxk/9yXzhjPXLNHHJulUrdwKegBXI9KTvkGGuy//xJAJ9xokmxauW9bqQv8MUVapZ99o9W8nwfc7ChHv0PARQp4u3ZKjO+q/cuExFRHXsq4gtNwR1+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lhU8YsmLhenP/DynMPjv71zo3NksZ0Nm4R/dG1Dg0E=;
 b=irtyINekkxBhIdcYPHiFayUueDzmD2719xJ8ziorZHv0WRzDvs9wuR4gbOeZrwo32G299RhuGbkmVWMKcBdACH06DNGTwqHKRKvWFmsxCGXaEhGNn/seTNPQY/zdaxlVHyAX9xLyD0Q68BzynWyEHMX11aiIxSRB2V+lHlbIGlf5dBrge+dZiqs7ft9b3tNUYhVyhIjeYRq89SmL1ce3YTIwJKZLsmK8rp+PuY39j2CiA5UCF0ncGE6p/u46R9zm5S0voh98nhmZnXZGTlQX+EgQkGXZfq89f/iXJ+ek4AIaylSN+QESkWLnAKBPcw81lXHcKEMGOUSXK8Lbko4szw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lhU8YsmLhenP/DynMPjv71zo3NksZ0Nm4R/dG1Dg0E=;
 b=Wqvk+PaK+/NNRL/Aw9zeje+XmcXzrplotSqpFApwphtd9L5spiTlYM3AZTqQ5C09+/iW83/HFiwTY/9e+y5Vj3tpWIRn/febFmNwW4IaHEkdE0BMCTDX+pYMxjd4r3mnNaG/02k9s7tfpNojVE3+fL7H/ySeIJIZjJbMzFDT44Y=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR0402MB3752.eurprd04.prod.outlook.com (2603:10a6:209:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Tue, 22 Dec
 2020 08:11:27 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3676.033; Tue, 22 Dec 2020
 08:11:27 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v9 2/4] arm64: dts: imx8m: add SoC ID compatible
Date:   Tue, 22 Dec 2020 16:10:55 +0800
Message-Id: <20201222081057.26401-2-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201222081057.26401-1-alice.guo@oss.nxp.com>
References: <20201222081057.26401-1-alice.guo@oss.nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR0601CA0022.apcprd06.prod.outlook.com (2603:1096:3::32)
 To AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR0601CA0022.apcprd06.prod.outlook.com (2603:1096:3::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.29 via Frontend Transport; Tue, 22 Dec 2020 08:11:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff521b05-76dd-4c47-abb4-08d8a6512eb7
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3752:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB37521A75B84339E7D9DCA15CA3DF0@AM6PR0402MB3752.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uV0beWiexMTTXCLlldO+QqQhV866bp7d4MyDHbCL/CqXHcKDqv0i5S/+Jt93EkEKpbTsiAvCwAZV5M2BHM+YRDx0V+pBpN0vYYzdK1FYe0DgMAoMby5h1F1KmoPRSPvY8LlSSFOZtMFgNzMe+bpS/nn6i5d2MN0sf4wxt5jcOUtqNlPz7BjureVqeDnJ8+XCQL94pK2IQrBEoacbL2cUX1Wogs/idBcnPE7jJU4mlBiZBLO4G2qhXuXlyuRvueZeg86megqGINVy7A4gDz6BJOt0KD6MjdpkxavjbaqESyVmC8RdcJl/Xlj8JfBYtayMKnn4NWdqjQZx12P6Y1yEutiUDQm0vdW7P+x/tZZpF3GQCfVlOb5Gy0hpPQGsgNmHbC5P/FrOzcvz3RoXMCJ0oqXc6sYe90T2aHekHOsubvwzTC8PT+QomfSFrP952KJk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(66946007)(26005)(2906002)(316002)(8936002)(6486002)(86362001)(66476007)(52116002)(66556008)(8676002)(6506007)(4326008)(478600001)(956004)(2616005)(5660300002)(1076003)(6666004)(83380400001)(16526019)(6512007)(186003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VAxN9/8p1z17Rpzcnn3CYZl7cwgBtqBvic/cZs0wtbyS1j3vZ7YGRS3eU5sQ?=
 =?us-ascii?Q?X/DJNWB6/vZ6pOCj7m5kSxdrURDIGQDZuyLG1j3flebr46Wuwls9co1tKuG9?=
 =?us-ascii?Q?jSmMv/JDdqsif0yWFMOmcA+GKOUjutbMNv+jzNk7ylYuwd+Vw6O0+Z6BVsL7?=
 =?us-ascii?Q?XUtum3fIK3ItZ0GHmv21gly9TS6C1kJl46iTY3ogUT4zIEW9BdHNnDbmsCCf?=
 =?us-ascii?Q?dbDBsqgG5M3xpMK525vdrsfbmAuZlqIbgqDM+eZgUBxSzeLBfcbFcZeivPro?=
 =?us-ascii?Q?xMJMPkp2+fCXf7Ms10ns62SbOV3fmnH2IZnTZhROrH4MtkEFyWWCcB0kz+Ch?=
 =?us-ascii?Q?J23zVR2+kR33uv2CWZvS4+sad8OOn/l2+JlRZq8KjehGwNEGiteo/DetKrK3?=
 =?us-ascii?Q?+yelIXeFZh2n8boU4gY6viOLF+oGG1uNxCKmgnTvp9+lXU5WcBW/g3FeaCMq?=
 =?us-ascii?Q?0XcdukiXFEVO6JQ4/NfICirlHymGootjUTkuS0YHTSma55sNY90j542tTuMm?=
 =?us-ascii?Q?7d7ogVhXLGgIT57BWYC72PhhbrIdl+wYxuKwn+5L5E2MWUt/KnMnEY3BOXR7?=
 =?us-ascii?Q?vfctB5FO+Epb44aZ/+st4h8h8n5uX9LKUVjNysVshBiu+xNss42m+SUf9cEu?=
 =?us-ascii?Q?Q+derhABOCE8UWVx0i+JMNvRmMp84/g4JB6CNuApb0YbgNdgkDiXfVNixgmO?=
 =?us-ascii?Q?tzq0fdAiQNMwvhvAly75+JCPR0ipNL1Cz0NJdvQRfslNFmYTKp8gUroFskgY?=
 =?us-ascii?Q?7ovHAfWYlrBbVXvpo3oM0Z9of5t5JLluVVGzPkNdeB6n3pbdAduwGgpYIBsR?=
 =?us-ascii?Q?AtOgUj9fwJGjo1lbzDdlb+dQir1AqCqTx6j3KrrTT/Pe7LbW5jzdqEW21nT0?=
 =?us-ascii?Q?EeKTI+uJfQq8P+TME11P+DBZg9MCkqyTbV7HLX2+nSexVsH8vIEOx8+Slkw7?=
 =?us-ascii?Q?d4HY/p8yhXk6u8F0fR4GoV11TsEHJVKSrzo8XmOYYTwhX2fxfMlTfgfrQyXy?=
 =?us-ascii?Q?Hv1c?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2020 08:11:27.8736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: ff521b05-76dd-4c47-abb4-08d8a6512eb7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dszi+9mYntsah/UwED1OaEgHa1LxDjb/iscw2NwWoUQCVwL52ntPYLlQA+/h2cG5l2jaGbyQCPWpxK6F4+Ciqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3752
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Guo <alice.guo@nxp.com>

Add compatible string to .dtsi files for binding of imx8_soc_info and
device.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---

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

