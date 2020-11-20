Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDB72BA71C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgKTKLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:11:34 -0500
Received: from mail-eopbgr60068.outbound.protection.outlook.com ([40.107.6.68]:4614
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725797AbgKTKLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:11:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMMYBS53lY6GKpCLh5K2tDN2GNybg1U0UqlwKRi321bZF+MaGUq1DOOAeswvGCUctV/QJiTtKsVB3LfvWj0982AWM10LSUIafJd0pHolPjXQWnlrDhvw64r7CHx3ZQu9AJN3oGuhJ4OydGly6XobNgfPkBT7dA01Juj1ttWbOa0csI2526Oc8OpLS0xp5pVkYXxAjN/4c1vxzxY/cimwXnYEljYFV/8HQ1CdsH10XH9Bsam0BMichfOvlJt3f7EK3ZR0uiYkcefj4XAOEPQG1p9cdqL2puVeoKnhEjjqOCVsy/jkYlt8bnAFQQnER2qAknb69LuSLcZB8i04wd4QYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOYv62s1mJhxxG7AYBWyBsaBnmSSipp7aSH7NVYTt4I=;
 b=BnSeifzVoyblPRY2FwWrUnyAOB25CE6AuwAkMZmiz2uO9/iIPrJvFDWLUiTk6DJu2OOQ+zf5L77iu2oPvP3sp5x6ViDan3jn7rfv68vyUVdkbamD0/QAQKRDza5PkMAJBOyV0EAvgw7jy66qWzF9U5fXxq0g8dGcg13hxaseEI3gPPMQyY7hWn/kENoQPMF3wF0ZzI/zTpFMBrvzhDhvIlO1GEJljkouNgq1ZguG8fJWA8egpBdEbkn5UkJNWZXvn6SdGT9Bqun+1tCrWbOZinOkiw6PfRIbFEDYZeaTFrkodmywenzt2T2F8zM8xN6MPG6FiwUF+C2resmN8BL/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOYv62s1mJhxxG7AYBWyBsaBnmSSipp7aSH7NVYTt4I=;
 b=n+J3onnE6ycuR/zvskx4j/BYm4ntHyLxH15TVnoGzyGk496CdTzK2uZBAUhcSfiZ0I5EMAswDKIijRsYs/02P96/aOtxfVWAtkhyo3/MFdjRgNBEcVYQWp6dqZE5qCDQnz3LpYD+sBBEfLzBVTT6swB4ZlM72RRBApoApAPer2c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AS8PR04MB7799.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Fri, 20 Nov
 2020 10:11:30 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::a968:d7c0:c9f8:b4db]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::a968:d7c0:c9f8:b4db%7]) with mapi id 15.20.3564.034; Fri, 20 Nov 2020
 10:11:30 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        krzk@kernel.org
Cc:     linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/4] arm64: dts: imx8m: add NVMEM provider and consumer to read soc unique ID
Date:   Fri, 20 Nov 2020 18:11:11 +0800
Message-Id: <20201120101112.31819-3-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201120101112.31819-1-alice.guo@nxp.com>
References: <20201120101112.31819-1-alice.guo@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: AM0PR10CA0096.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::49) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by AM0PR10CA0096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21 via Frontend Transport; Fri, 20 Nov 2020 10:11:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 011e38f9-56cb-46b5-f5fd-08d88d3ca64a
X-MS-TrafficTypeDiagnostic: AS8PR04MB7799:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB7799B5FB1AA7408093A5884CE2FF0@AS8PR04MB7799.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EI3fgCBgX83y7G1XaL1/33N7GWoNCtiKCUU5cKKEMvyzHiEbk5bUjnEyftjMt/eku7Xr2E+6111MiHfirThfPgi1F5y6tyeKS7Q7kdfjf1IGSXjyXhRg4rtuq6z3SrRKatdxtHKwTSeFQEMF7Iyugu8WEnua7Vcwz5rJJuf6WwRmDP/rX7Vpd5waLdzhKU32X32oa9xgS4Ao1XfMTmxoh0UuEF1O8vSYnXhGmQMnHp//R8MyrFVeXhVIdM5YxYBbtLAlctAuvqo/YnUu6DXEd8x8ninEN0rXMb7R+pLFn1FrKQtqGOgMDV4ej0PdzUrCOtXUWvIsZ+fyZYKGauqVe++DF7lGCY9N7UJuDbAb+Ca5TJ/uZxhfxumveqLqROKE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(2906002)(6666004)(66946007)(1076003)(5660300002)(6512007)(66556008)(52116002)(16526019)(26005)(6486002)(86362001)(186003)(66476007)(6506007)(316002)(36756003)(956004)(4326008)(478600001)(44832011)(2616005)(8676002)(8936002)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: lTr2pZGNl+ROzkJqkZNiOmre5KTvbfVnVKJOmRw15Se+XAO6LG3DXhJ7vuRlJ/VtuDbL9IU1r7/pbGYNChDSPThL49Npjhj5+SQcjUU0F3SddeQywI7XoD7WevTbnDQcd7Q5u34OCc4BXa3zfEnEFdG/A7cFHM/U1pm1xk9TR8WygP6MXVHvPNlrc266k4QJU4JvRf/mWm4Nx9FUKcLDSpXKBUGZJNWpZlQOohsJ2dAr4G3ogo5kWBPf0ICj5ncd3+W1dS0iHB8yThGblEctTeUIK7+VVzK+wAjnWpo6BJ0NzyRMbFXjv6EWlKdrBNjsTlPtW33rLAi24eDvpfDILRQ5GWU0uFqTvSchDBtEY+WTLamqQQDfv90Bq/CfqmFFPhqM8TVYy9yA1OnrU5IE7RlEae8WXpMSG9bM71OgosNAEIz+DYTFEeVVaeeNcTRIfZBbs+xGPYMSfT2YB2UQHnZzSugsWnjuvixbX8sFenpQBM+BpSlX9EERGymXx16LIM/lM+Gdn6fz9CEhlniGegQL/K5QRuN74rZWPCb4lUtYDimLohs1etIpka2ZDoLMv5gSUO76ocrAte8Ue58Yk5DWXmQD4j8EPYjcLqUsMIAi1Utynjx36B5X7qBjDoPSBbz9YAizOLgHHMD37mL4tA3zdkSRGHcFJWbzTavAVwSVpGBRVg5SWd7NEkIV/hEc8sY9Oj50wKARWIbdz4akl9LXIIdiq4CCat8KUZ3ri0AOIEcGmCLMvhJRduijoYEn5aaNI0nechJ1NBpuX/KqwWuz2thfhF5GXbgPcClFgxdthFwDB+vyW/Ro+pK2we04DbdlmHaH3kZI1hCFc6SqT9pcEEtJ5G7yV+UZUUK2MI/IorKAnuOPYGcaed/4rFxzASqlHYpe8QzdMxxrvCZPnA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011e38f9-56cb-46b5-f5fd-08d88d3ca64a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 10:11:30.5137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwwMrleDDrpd22frq9ybgvL4xtGK1xvGL5PZUZdfzDWSpNNsWdzW8ZULAi6KCMh0HXUbTTBdV1ij0LOiP6X1tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7799
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to use NVMEM APIs to read soc unique ID, add the
nvmem data cell and name for nvmem-cells to the "soc" node, and add a
nvmem node which provides soc unique ID to efuse@30350000.

v2: remove the subject prefix "LF-2571-3"
v3: convert register addresses and sizes to hex
v4: delete "stuff" in subject and commit message, add detailed
    description

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 6 ++++++
 4 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index d457ce815e68..0e0edd5db07b 100644
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
index ec6ac523ecfc..8fbcded6a091 100644
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

