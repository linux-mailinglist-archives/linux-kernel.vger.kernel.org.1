Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F642A77FA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 08:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgKEH0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 02:26:45 -0500
Received: from mail-eopbgr50043.outbound.protection.outlook.com ([40.107.5.43]:58244
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729495AbgKEH0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 02:26:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qi6x31SfgkUI7n0LLYIqCIyxjaK4kKcnL1TnlvuLKcimA2cUneey+aaxnjbjynirYwxCv/xaZWlqZWQyBUH/7F34cqD6A2Re4lvxPprZXV/UNIhhkoNitJphYYs/DvPz1sp1D3eOd8/jVnMVERld93QK8EgHgJwYnVIYbN2COZSu0iIFJYDNakytqvCmojIehuHfxRmXJquMSCS0uprrht5ADZE3VBaSe42cjKFxfLFX93g51gqSNdBcvo5zurFlWmRyoDcyDmDL8C8ZCto0nkTQHM8prsbbYQHpdSJkTIhF5zW8nNt2gSn3la6pmg+Gh3okxvYQZ0PQNoYw5hqe5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/UnqVSWhX7CfXa9AN46bNW2rTl6rHiSSzsHtYvshDw=;
 b=TgYXxXUkFYk3azkKwVYmXoK124QzNdF4XEf+dwY40Y4N0pRVwlBn4+XrxM/noszx+SdPbEHNbyenaw2u2l8aOkd7mb3YMTdSubfrunqP4Bmxmiu3ZNGODCR/DNwz9Jst9UldhO9UCrApA4QJBMEJ1wd1oPykTrK+DF/CoDpncb7VeoOevtqEa/og7VKHieVnoihOJkXVni+dl41pMvVXLDUAsyqDvkuEGyqg4HBJLfiOhxpdC9emlDslU61WI96SFjLRCNaifqzS+YjAg4wJAgWbsv//OF0Ls5bWRRJnZ1Po3wAoZVpfr149Fx9qwU3IouonF7qWR52L4M80GYb6QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/UnqVSWhX7CfXa9AN46bNW2rTl6rHiSSzsHtYvshDw=;
 b=GQ3B0EM1na8+MnZ+YNEAC7u2VlrUvMuRIfaueYLxZaAd629IMO30didxOiVTMJ0RI2HMIaGsNHUDppWZyTtoW89b1Nzc+6A7x1b5P0c2WCcF6h/6nihOrUM5GbCbz72ADde8tv89bYHHUkY3uQsxKsYOEogIxr8jKjjMqj2wyN0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DB8PR04MB6906.eurprd04.prod.outlook.com (2603:10a6:10:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Thu, 5 Nov
 2020 07:26:39 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618%8]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 07:26:39 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        krzk@kernel.org
Cc:     linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/4] arm64: dts: imx8m: add nvmem-cell related stuff
Date:   Thu,  5 Nov 2020 15:26:28 +0800
Message-Id: <20201105072629.24175-3-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201105072629.24175-1-alice.guo@nxp.com>
References: <20201105072629.24175-1-alice.guo@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR02CA0054.apcprd02.prod.outlook.com (2603:1096:4:54::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 5 Nov 2020 07:26:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cbadec3e-4ae7-42e4-782d-08d8815c2277
X-MS-TrafficTypeDiagnostic: DB8PR04MB6906:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6906B2C1804C3BECCBAB17CDE2EE0@DB8PR04MB6906.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g2x+n2ayNDN8wFzi9rxB992INiEhwhLecm7mN+2wi43cqyoleC7i/oe+xrSKd5IBCNBM8pk0w2ysSiD9BX4e0rjvQxSv2Ahjk/Ear5olAzmPATXzlzjuz8sY1jNYQkXBzKbrZfihB5RydbNndU2ry0GwBmkwXzby2AO3bToUpOn5h6/1nsFN97PQcEV38/rKFqHicaM6Xe7IHTeEIoMqlbljwDn8Kg+AAYuKuJnA4rGOUNpTRfzGpcy+yUWr23Jrt83dKAWxOUJVLXVbXIEnJKHtJPMrebkN8lDipJnNm1ZVS9kwwTB1OyCjJlxlCXpfh6iSMf2txu+NHFfozlX5fXmZe4auQohqniUe7q7gZRjpeKSK2a1yq/UAgLR6womD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(5660300002)(316002)(6512007)(44832011)(6666004)(478600001)(66946007)(8676002)(52116002)(6506007)(2906002)(86362001)(36756003)(4326008)(186003)(8936002)(66556008)(2616005)(26005)(6486002)(66476007)(956004)(16526019)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: uF1GSov3cvcEbG9JWIvPpHcHm++SmzidciAm7RdVllYNtvr/E91gOT7NwPcvu3bNjrxgvGzhNlNgMoOA5DyCeTf2jNQPP0XuRk6TrVF5FN40Ayn2RT5s8+YC0Mqy/Fn0/gw97/1LRUI2TaYvTAC9TCii9ePomQs2U+IUokkVVefQ5hfjD0XjzXa4gEOmhEt1dTk7FULoICs0O+m1hv4XbNRhek5+uEN7f9gl4e8ybSCkFPA+NTzDpx509Iuqiopl5fJ8h+FXw7AEuuLzoK+DJsbFxBVvtu4YOtb7QaspnW79J3ZrRhH8dWz+yvSYbL8+YxJq6SmtaN9xfqfDmwZ52aEJygVqLLZ5uPek0h1Q3EQ+taEFiHGPPfSE0xAI/ghRJTdvbvL7Tb/teseR8QNKINiHx7tzdCKasmzjpPxMm//97pzJlX+rOo98KSgWe+c36vB6b5bMZtJDEPSQv0MJs4ARGgd12CLwrJTNmv5lj7PG258C+DSLKLA4oD2RPeCDcP7urlyttQHC3d+462BKR2x6p8Hi1pcwuu62XTtlSwcDAF524zatvT/0DOid3rE3jrzTp0to38n2CCIgNL4b6I5FKQ+6TUtgV+SrYrxKKVtKbP/53tFvF63GgzRzraGH6kSh4Lo9veRhicX5CcBEQQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbadec3e-4ae7-42e4-782d-08d8815c2277
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 07:26:39.0962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9IhdYjpEVTQBcAHwyhUbX1DTktiJh4/OzEjX2n47Kkj5zWN/xbD9zExYWX0fOkeYwYUbG2tLn8Bgbn8yl7ECw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6906
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

