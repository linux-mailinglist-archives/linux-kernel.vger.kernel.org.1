Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696FE2E0717
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 09:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgLVIMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 03:12:41 -0500
Received: from mail-vi1eur05on2077.outbound.protection.outlook.com ([40.107.21.77]:45729
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725300AbgLVIMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 03:12:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkF9USLY4z5gGibQxuFKL0wF+6BXAxSf1yvxXG+atRMO1nQSloJN3VBQTJYE6n6X6Wio3Ingz09zRjkTZEvYVjlzZwIWHa14OG7CL80z1wbXTh2/DXs2TTTzsQO21kGqaXlO9oGeKuWUzMdQUlcm/qkZw3OghJneg83GR+PpHPuFzg7UILfpTCzaRlk1J0sdnLlJwwl5Bux5YovdEuiLiqfvQsQoOUv7D8Uil4OztNMiMGQSDiHL7ibRTt8MJN4i63dG/FIxW/ysLyrBs5HI6C4K1cHNMdIWi5rFzsU54qgFIQW6/sbmMAShMQNMjIDW7K5HLrJX+fpaPAWDR4XSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BvRMgVrWpEOD3LDHBSqeRuTIG9v4dhLzcQPaSesZB0=;
 b=juYepio+GH1Sa0gWcemKBb5O/TQaC4jdDfTJqmzqjnzO3ztFgpIWd9mqGhpfiVLMMvdV3J1kRROKxV45X1oWTQ4cqpCeo4uzs11P6VSKz9flv6rq7iq0wGP1AeStXEGp9GfdygC621FOvDS5jHs1g3QBx+iKMTRh48Ylz/UfGLo+zUv+34zmeQfqebunsi9FqCm2z6lsteX0noUI9cuJGYa4BKgj3RJ3/8Xs80H1LhgFYI5hYxO7lngbUKRVZVA2QbTTWX4Ne7iAicQelnoo2ujuEuRBiZvTPzHb11XAE1oBt2AoZ4e0sFPyx0PeQcd1CJP+OPZDIhEbTsK+6VuO1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BvRMgVrWpEOD3LDHBSqeRuTIG9v4dhLzcQPaSesZB0=;
 b=d4mrIJGtyFHeLaIkMEAJsvR3c+fe3KJsyLNoBR/qIIxGBt2QpeQ7dLzaVVsR5PBzLn66IUto+aEuCQ6FoCfemDkJo9DcBOxFar0NMMr4F2UG7EFBEiVfUflX8ol2BX5znJGZaXqruu49T0MJzz2gt0xoIWSD1HGcoRANzOZSERk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR0402MB3752.eurprd04.prod.outlook.com (2603:10a6:209:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Tue, 22 Dec
 2020 08:11:36 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3676.033; Tue, 22 Dec 2020
 08:11:36 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v9 4/4] soc: imx8m: change to use platform driver
Date:   Tue, 22 Dec 2020 16:10:57 +0800
Message-Id: <20201222081057.26401-4-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201222081057.26401-1-alice.guo@oss.nxp.com>
References: <20201222081057.26401-1-alice.guo@oss.nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR0601CA0022.apcprd06.prod.outlook.com (2603:1096:3::32)
 To AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR0601CA0022.apcprd06.prod.outlook.com (2603:1096:3::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.29 via Frontend Transport; Tue, 22 Dec 2020 08:11:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fcf08cb1-54b4-4579-ec2e-08d8a65133f2
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3752:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB37523CED99001DFFB08B8D55A3DF0@AM6PR0402MB3752.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fi4OlghNZEVPMKjY9KxXj7yXHXyE+urhbL2IfKoxnQPa/6zLPtPlGmu2X8xzZmWZlbujp1w2W21zm5ASWY1RFTe3ITo1OIRa1bYDASlBAwTyUfLwtPrlTyOWi8vBZRvngOPTcm5fiR1ReUkCIRf72bOLrTw+nsF3TYtrlglDSZpY46b3llG+IqgMpxOCRGYy4B3iaJP5wbQ7iqA56mn+Rqj/wJe6qIxubqs0fYk4zX/TRRqXAw2PzzJfpCDBXRp1K+5WlHWLS2UR+QjCSGV/5bI3SWmt7f/F8FVljJ6k4+rc6VbYQ0gM7Zh7M03PISCqp+sHjUbiyYFf8NEpBmNI2xzSLLPidXvt+OyN8ozFd9UpcyZ3uhonYltGxmdd5EuvzIg53Sq4VYJQAHao7Bb+2jwrs69EJRlBZCCT4S7xvEEWcoumrG3W7k5gkF0N7a2v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(66946007)(26005)(2906002)(316002)(8936002)(6486002)(86362001)(66476007)(52116002)(66556008)(8676002)(6506007)(4326008)(478600001)(956004)(2616005)(5660300002)(1076003)(6666004)(83380400001)(16526019)(6512007)(186003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?x9SeDJf6ok43KoobQUsRzXXzmO46ayRo+gNpvxFTq1+Ly8fnR4HmBgk0PeZp?=
 =?us-ascii?Q?5jpGsltkziFioNgotyla26gZd6wIRa/bHy/q+PN3tsL5LCFY2EXnpPaH58dS?=
 =?us-ascii?Q?J1Qc4sGZlijqqCun6KVC3/KgBVhvSay+A//meh8CFfFCIl0kYneQpgO6Q6+4?=
 =?us-ascii?Q?NaRAyU1Z1YOzCvajfW8RQrN718Q/OaAR31pA5CR077G8+JBCH1HxXQ1GBs4q?=
 =?us-ascii?Q?Dr0NZLn49EIFJhF3L+bm0sPHFlWYqtfpz+jlHCsiVkaG7rkFWKcQCO0ICcmM?=
 =?us-ascii?Q?GuStsbe3RT3GFgY4fnmIrDlJTuWQTNJn3gSAD0freVYBFjVE6et4qrOZzVZm?=
 =?us-ascii?Q?fLD6aqSAajHvGXD4iG04Aa/yOH16dqxnJBUTJwiD4RBsX9fZFd2CKj/TZuNA?=
 =?us-ascii?Q?o+kR3upgbfUHEbcMtQgYVJkUYvQSo43ayE5Z/CDFUoqUzheVpZRSxU1jDrEj?=
 =?us-ascii?Q?7G4Xx45gmmhBljZA7TbGdz2rc8hqHlP/AWDptPQdKrDOuzjc3B1Yp1lq6Yry?=
 =?us-ascii?Q?GgqWnfDAySOuNxi4tXic+F9w+X3qgwUt2qwDyzDeiJnVVm2tYK+X7h5x30An?=
 =?us-ascii?Q?DJ1YT8D2w56na11F8E6OIS4vDFkyLVUdXfWcV816nfI3PKV9fV3fzI+XogXt?=
 =?us-ascii?Q?f/K6jtYS7TzfIFbmR708Q+ZRJqNYYJRk/mTSX9dddBMSL2ysDQfgKy87oo0g?=
 =?us-ascii?Q?vAFLN4KFkK0UHZ0u3zy3HYhgynSXMix4eM70Sg6FSRl+6S9EaFwnYDbEAQt5?=
 =?us-ascii?Q?pp17jgRMkFFbXuoRiHQUyCyJ5+lfrKEw8V+F1iyAfazxXWQyd1Q2AexWK/0i?=
 =?us-ascii?Q?pJU2F7cYwjwJHRs56uy+05p9T07z7AIWr91sZS4y21WT7TEbReesDe9c4aGe?=
 =?us-ascii?Q?YgUEWy6zJRA7qu7k+jJtgepzRQd40OqkxX/QVX3+dNp5hNemKcEQGzEJ5v/1?=
 =?us-ascii?Q?LZJI7T2suwG4aZ/DNWskstuTAydgzWL7C/fpcl1l2IPO3beoqLWJPqSgyRs9?=
 =?us-ascii?Q?LwKB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2020 08:11:36.6525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf08cb1-54b4-4579-ec2e-08d8a65133f2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNH78DR07t17ufONRtAT2uZCimbEgQQlJH3R6kTR/omy7hBdoAbNvZgODuiXQKk4V2IhVTVlR5Y9b8g3u9jtzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3752
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Guo <alice.guo@nxp.com>

Directly reading ocotp register depends on that bootloader enables ocotp
clk, which is not always effective, so change to use nvmem API. Using
nvmem API requires to support driver defer probe and thus change
soc-imx8m.c to use platform driver.

The other reason is that directly reading ocotp register causes kexec
kernel hang because the 1st kernel running will disable unused clks
after kernel boots up, and then ocotp clk will be disabled even if
bootloader enables it. When kexec kernel, ocotp clk needs to be enabled
before reading ocotp registers, and nvmem API with platform driver
supported can accomplish this.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---

Changes for v9:
 - re-add Reviewed-by because it was lost in v8
Changes for v8:
 - lost Reviewed-by carelessly
Changes for v7:
 - solve the problem "drivers/soc/imx/soc-imx8m.c:174:34: warning:
   unused variable"
Changes for v6:
 - leave only the changelog under '---'
Changes for v5:
 - add cleanup part "of_node_put"
 - add note to explain that why device_initcall still exists
Changes for v4:
 - delete "__maybe_unused"
 - delete MODULE_DEVICE_TABLE(of, imx8m_soc_match);
 - rename match table
   "fsl,imx8m*"is actually a machine compabile and "fsl,imx8m*-soc" is a
   compabile of soc@0
 - delete "flag" and change to determine whether the pointer is NULL
 - ues of_find_matching_node_and_match()
 - delete of_match_ptr()
Changes for v3:
 - keep the original way which uses device_initcall to read soc unique
   ID
 - add the other way which uses module_platform_driver and nvmem API, so
   that it will not break the old version DTBs
Changes for v2:
 - remove the subject prefix "LF-2571-4"

 drivers/soc/imx/soc-imx8m.c | 87 ++++++++++++++++++++++++++++++++-----
 1 file changed, 75 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index cc57a384d74d..d5c86ae32903 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -5,6 +5,8 @@

 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
@@ -29,7 +31,7 @@

 struct imx8_soc_data {
 	char *name;
-	u32 (*soc_revision)(void);
+	u32 (*soc_revision)(struct device *dev);
 };

 static u64 soc_uid;
@@ -50,7 +52,7 @@ static u32 imx8mq_soc_revision_from_atf(void)
 static inline u32 imx8mq_soc_revision_from_atf(void) { return 0; };
 #endif

-static u32 __init imx8mq_soc_revision(void)
+static u32 __init imx8mq_soc_revision(struct device *dev)
 {
 	struct device_node *np;
 	void __iomem *ocotp_base;
@@ -75,9 +77,20 @@ static u32 __init imx8mq_soc_revision(void)
 			rev = REV_B1;
 	}

-	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
-	soc_uid <<= 32;
-	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
+	if (dev) {
+		int ret = 0;
+
+		ret = nvmem_cell_read_u64(dev, "soc_unique_id", &soc_uid);
+		if (ret) {
+			iounmap(ocotp_base);
+			of_node_put(np);
+			return ret;
+		}
+	} else {
+		soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
+		soc_uid <<= 32;
+		soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
+	}

 	iounmap(ocotp_base);
 	of_node_put(np);
@@ -107,7 +120,7 @@ static void __init imx8mm_soc_uid(void)
 	of_node_put(np);
 }

-static u32 __init imx8mm_soc_revision(void)
+static u32 __init imx8mm_soc_revision(struct device *dev)
 {
 	struct device_node *np;
 	void __iomem *anatop_base;
@@ -125,7 +138,15 @@ static u32 __init imx8mm_soc_revision(void)
 	iounmap(anatop_base);
 	of_node_put(np);

-	imx8mm_soc_uid();
+	if (dev) {
+		int ret = 0;
+
+		ret = nvmem_cell_read_u64(dev, "soc_unique_id", &soc_uid);
+		if (ret)
+			return ret;
+	} else {
+		imx8mm_soc_uid();
+	}

 	return rev;
 }
@@ -150,7 +171,7 @@ static const struct imx8_soc_data imx8mp_soc_data = {
 	.soc_revision = imx8mm_soc_revision,
 };

-static __maybe_unused const struct of_device_id imx8_soc_match[] = {
+static __maybe_unused const struct of_device_id imx8_machine_match[] = {
 	{ .compatible = "fsl,imx8mq", .data = &imx8mq_soc_data, },
 	{ .compatible = "fsl,imx8mm", .data = &imx8mm_soc_data, },
 	{ .compatible = "fsl,imx8mn", .data = &imx8mn_soc_data, },
@@ -158,12 +179,20 @@ static __maybe_unused const struct of_device_id imx8_soc_match[] = {
 	{ }
 };

+static __maybe_unused const struct of_device_id imx8_soc_match[] = {
+	{ .compatible = "fsl,imx8mq-soc", .data = &imx8mq_soc_data, },
+	{ .compatible = "fsl,imx8mm-soc", .data = &imx8mm_soc_data, },
+	{ .compatible = "fsl,imx8mn-soc", .data = &imx8mn_soc_data, },
+	{ .compatible = "fsl,imx8mp-soc", .data = &imx8mp_soc_data, },
+	{ }
+};
+
 #define imx8_revision(soc_rev) \
 	soc_rev ? \
 	kasprintf(GFP_KERNEL, "%d.%d", (soc_rev >> 4) & 0xf,  soc_rev & 0xf) : \
 	"unknown"

-static int __init imx8_soc_init(void)
+static int imx8_soc_info(struct platform_device *pdev)
 {
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
@@ -182,7 +211,10 @@ static int __init imx8_soc_init(void)
 	if (ret)
 		goto free_soc;

-	id = of_match_node(imx8_soc_match, of_root);
+	if (pdev)
+		id = of_match_node(imx8_soc_match, pdev->dev.of_node);
+	else
+		id = of_match_node(imx8_machine_match, of_root);
 	if (!id) {
 		ret = -ENODEV;
 		goto free_soc;
@@ -191,8 +223,16 @@ static int __init imx8_soc_init(void)
 	data = id->data;
 	if (data) {
 		soc_dev_attr->soc_id = data->name;
-		if (data->soc_revision)
-			soc_rev = data->soc_revision();
+		if (data->soc_revision) {
+			if (pdev) {
+				soc_rev = data->soc_revision(&pdev->dev);
+				ret = soc_rev;
+				if (ret < 0)
+					goto free_soc;
+			} else {
+				soc_rev = data->soc_revision(NULL);
+			}
+		}
 	}

 	soc_dev_attr->revision = imx8_revision(soc_rev);
@@ -230,4 +270,27 @@ static int __init imx8_soc_init(void)
 	kfree(soc_dev_attr);
 	return ret;
 }
+
+/* Retain device_initcall is for backward compatibility with DTS. */
+static int __init imx8_soc_init(void)
+{
+	int ret = 0;
+
+	if (of_find_matching_node_and_match(NULL, imx8_soc_match, NULL))
+		return 0;
+
+	ret = imx8_soc_info(NULL);
+	return ret;
+}
 device_initcall(imx8_soc_init);
+
+static struct platform_driver imx8_soc_info_driver = {
+	.probe = imx8_soc_info,
+	.driver = {
+		.name = "imx8_soc_info",
+		.of_match_table = imx8_soc_match,
+	},
+};
+
+module_platform_driver(imx8_soc_info_driver);
+MODULE_LICENSE("GPL v2");
--
2.17.1

