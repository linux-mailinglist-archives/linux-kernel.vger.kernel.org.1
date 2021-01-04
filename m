Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B092E9272
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 10:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbhADJRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 04:17:35 -0500
Received: from mail-eopbgr150049.outbound.protection.outlook.com ([40.107.15.49]:1335
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbhADJRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 04:17:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQoI/lWZ52kJ/vdpbzO2Ppf/hA3YkXn6FnqQV66S5O0u42oWVDWOyf5xk5XK94Lc5xXHCOytGgHAIC0MN6eTMjmsVYqR/YxJ52eoeQL5hxeBJgs4yzoX2MMmwf3UAR4nuqYr1+McbQWJTswmmy8RVVC1j05Y2SAhffanqfCUBag5QrTBn48kjOesQz2QZ8EzlgMa8q3PEmTDD3Rh+5Grr3muX+rRZEwqT9KtV7UvW7cv00QXqeGoqBULfkpHdiRunJh/SKRugou+82p0uMX4vyN6I9AgzqWcR4oGsbZepRyAjaXbBY1Cv6JNxsqW6YRcfFcZ0qa/nZUs2IUuXoOYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3f7aqQe90ej2t+fPyfc9NMr7vi7mmCsnTOLch5V/CE=;
 b=YaQ+AFNacNumpgfUL06f21nV3nQCRccxBrVAuOAJCwEQAGIhWvVooZlGWXZiHh17UDLkAVVV1OmMn7S8/SlDtQQo8Gm1dbzFIQuL2qTg3QAyP+xUfnYqmlFvG7hnzuwviLgl8YyIOIhq/3IRkv+Vp87Y2Pq4Od8NwROhjMa/gCh0xH3ijZYdS87KMcbVyaG6OLGZUkVKzgrLVfgwfFBJPUJwh2pl0f1ILosYEqJgrBazN/NZtJTfLhwmLtFVSgHypSZfnZT5W6CALnvi8pfjUdOnlCGeItAGnukz6UgXI1Si4tZborwTWw6F3s1tUDJkYgTVKwDi+qsdibuDnemkZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3f7aqQe90ej2t+fPyfc9NMr7vi7mmCsnTOLch5V/CE=;
 b=jfIhuuEYo5X71IEmMa/EqYBjn4ZlFjEmJIMqXZZKLP3Ml0tFaUDTIa9Pr2O4iICUa+3NA10PxiAx/NSKagFK7ThQQa7/DbZ+MCCU5aEiNq7uLwCjuCBs7yS7vZYvzRH5u+Ud0sThrPplUuEMRSiwxW3k16uB4NaM86uFxnyzug4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM7PR04MB6982.eurprd04.prod.outlook.com (2603:10a6:20b:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Mon, 4 Jan
 2021 09:16:35 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 09:16:35 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v10 3/4] arm64: dts: imx8m: add NVMEM provider and consumer to read soc unique ID
Date:   Mon,  4 Jan 2021 17:15:43 +0800
Message-Id: <20210104091544.13972-3-alice.guo@oss.nxp.com>
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
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by AM0PR10CA0055.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend Transport; Mon, 4 Jan 2021 09:16:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cdf0e8ab-061a-4e23-e758-08d8b0916f01
X-MS-TrafficTypeDiagnostic: AM7PR04MB6982:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB69825A3BCA51378573435869A3D20@AM7PR04MB6982.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IlrUm89FozV3mNA40OPq0a7hmb+4v3aDONGB4mtpyoaPqKEtdwIDoeetiTzCOYlxoFTOPYgIVHsGgEITpmsIRgZ/DbXf6UVBZdn4kIm8QPzctEaAfet+yOSJyikC8dWwQ51JWfBgR8ifz08BQEqS+jTmkKa8BURXb/BL/A6MQlkcR0W3tCUhC5nf+saQKMWzjsk/p5Ibm+2Np5TV2XTh0b5razSpdjc0egHG8L6jG5HFDuqIGhp3BeRmDzQstwNJsnh1VYLwRSoSDp5nXJL30M/FQEbB99JKLfZ4/8lU5D6aXY07IE6Cx65scThpiNl9rG+/FVrJ70I2afnjKQQXN2rOv7sumc+sDUQigCKYd+9bOPBUAQXfHxd5KkTIyJPDsqIn7LYinAsSwjQUpyt5wIBsRNmJxQBOPXOO8njM48fgT64I4zHCNAcVnGKjyUWi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(66476007)(66556008)(316002)(6512007)(6486002)(8936002)(8676002)(6666004)(1076003)(86362001)(2906002)(66946007)(4326008)(5660300002)(52116002)(16526019)(2616005)(6506007)(26005)(956004)(186003)(83380400001)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vTlEG2ODZXWdUTI40XUrPlfT1FUkdUFzLP0p1Kh153uKyu/BT1456ghk4c5u?=
 =?us-ascii?Q?yH2PpeSpmmPUyjncher6SuFnI5NWZdUMBK0Xeqy2ZH+pxRwqTlOOeeESn6Op?=
 =?us-ascii?Q?vle8vwElBlhZsQu75LljmaSB7R+9H5kr/hdqOapxcQ6xqat+GggcYHevVCpK?=
 =?us-ascii?Q?JL/ybRuHU8AVXQ03wPsHNEF1KvOOQdKJy0vrv0mlStRY/hQbhRdZLSmV+XPY?=
 =?us-ascii?Q?9gwiq6S7m0iCqqiHq4J+ABdNNwHl6nYr4E3cHzI5RBlVmMtwRCgSRmhEiATm?=
 =?us-ascii?Q?qC2yUf/YL4HjVr6jDuxtk9MML3bUwUxsme5xIvjKG4GB0Qb3JOzLvuEL1VIB?=
 =?us-ascii?Q?8GI7P0MURCQpOkYvMw9cUtvPYKbw40+D2jzglF7KCTOCtAayfGhxbMRnEIoV?=
 =?us-ascii?Q?fAPWpfMtght2Y7lNFdXbXApmURi+Gnx13K63cqcYmzXDid1hl0uY+M2FxYil?=
 =?us-ascii?Q?fLRUiWrKSH953FfY7gIW92uZgsEFbLQvfmzURLbejh8BKB79nqXXqg3doA47?=
 =?us-ascii?Q?wln6augpkKnkwzD1nMEcwJvIL1wAkBVoSHs9RsDCMTQ37hp9mtpBJ0TyKJA5?=
 =?us-ascii?Q?P6n2ao6NiN0Cqn5FDkSvCduCSC1+4J5UYzh6hwkyqKt0W1ANlhUqUzsNLCZh?=
 =?us-ascii?Q?c384PBoEi7DVfhMpQMO/qSa/GwL+RNV0pFFSVh+/IPo26G9mtYrnI9d6eltw?=
 =?us-ascii?Q?OsG6kwqJWvxviQrq8uWE4pSOgQtg+ENzB0+Idna4z6ZgtvsdI3Vu3fI0kLw0?=
 =?us-ascii?Q?VpbDQyLv8yfRB6CBqLfyMXtqb1KNBEWJgbTG1mrpSXvQhvm8IYVDE56ti6H4?=
 =?us-ascii?Q?OVfqPDHccxMSjDUhKMgoN1pbxbxZpYOYmYPcYbICnKJBr3M2EO+BRm9ZYJYu?=
 =?us-ascii?Q?IKtJbZFVOk0uKKMFOOHkm0j0zFTiVWjpUSiD33PAszQx1/kJx7lvhqP71KEK?=
 =?us-ascii?Q?lsqzxjLQmYEfd2kf/Pg26gmbnwZr+RAmI/ZlkRo39hk59rD4yTFoQN46YlrM?=
 =?us-ascii?Q?hs05?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2021 09:16:35.1567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf0e8ab-061a-4e23-e758-08d8b0916f01
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6x0JyMBdR9NDGatFK5IiIALAWA513qh4ExxLsmBWJbdoWoCVDNKrJajorJNpbwgORTZn0gL9moueEfYnKn27qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6982
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

Changes for v10:
 - none
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

