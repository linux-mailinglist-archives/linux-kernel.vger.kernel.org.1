Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632F42E9270
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 10:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbhADJRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 04:17:31 -0500
Received: from mail-eopbgr150070.outbound.protection.outlook.com ([40.107.15.70]:17957
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbhADJRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 04:17:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AK9MTYuTUB889PyntxyUpJa8UEURqFCy++M5Juh6sfpkJ9NUQ1h4gFsAeykoTvqTGIUu3QuYsbZi816vMD1EeWkV9ffMTCM+fiw2aY9RxFJaBYs8FEHwAN5WK2dhNTASpf3np9h/l6IG1ExCrBUjphMo8wK3eyncZYrzpCHGvlNKnJYnkfnZXe4mIC5UWnH8MmqAZDTJX0E9jnmwLYTlsfi1fbl1QVIVDhcasK/Ca7jRoY8PVka7tKZB7PddwFlCzA3JbR8nrZYcE9NB9+nprhkiqZTZrgdmFonMt6I8twLLm5AtAJPe+dGbc8CKGi09of0uT+wU93f4TlAe765hHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5o8mSJ8o8vcENoFFSYFrV6r/rBdZeRcso86IrP+5uC0=;
 b=ZUPrYxkMX6wC8LblnLwMbvqG9xQBKQ857huCe6yRv5WJRaxBt5BjorHSGQHMXXyk40lZkjnFIbL00vITaODgyMZEbsvjKFpF6pdjfP9efkQ2XRhYEIYoPiCE/dyiUt3gEJ0dpc8+8xjIfeiGR7roBuS8+APFTIKC7NxHA4E+tZ2heqAkXCXH8xShhmk9IavowYxFfEcNb+mAzOnSFjTNXqCJJ///I86Ay802l57CgT2/WYCWDUbfOsK/msa6zUYpq/DgJr/T0tgUKxQb7Sk0lMWGas9oLldv47N7qyG4Gqx9M1FEAzrP6883xb0N6yxFIfbC9U1MrWE+JD73XPkkBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5o8mSJ8o8vcENoFFSYFrV6r/rBdZeRcso86IrP+5uC0=;
 b=fXGEqwc7RycnAIpRP7oY26h/DbhBQj/1Y6zR10IWfnnWtb2z6P0uHfri4YUVnGjdh4UNwC6tM7KjB6/3r42xRN5g8qIwbtAvjS55jKPL9HU4k+E1RofBvFSgKAI8p3IhFNyF0ZZe57HWQ/igrxVdkcsHX3nBJYwbliQ5f5aRwZc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR04MB5141.eurprd04.prod.outlook.com (2603:10a6:20b:c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.21; Mon, 4 Jan
 2021 09:16:41 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 09:16:41 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v10 4/4] soc: imx8m: change to use platform driver
Date:   Mon,  4 Jan 2021 17:15:44 +0800
Message-Id: <20210104091544.13972-4-alice.guo@oss.nxp.com>
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
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by AM0PR10CA0055.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend Transport; Mon, 4 Jan 2021 09:16:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 029f594e-f50b-4186-3a5b-08d8b0917281
X-MS-TrafficTypeDiagnostic: AM6PR04MB5141:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB514178E7DBA8BBC20F900C30A3D20@AM6PR04MB5141.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vtSJb6G8B7TqYi0s5oquxb9dkyAjiKx4nPUqc4FrbryyCWltbD1oUEoOVb2rG1+5lvH7jCveP/rDcElIfUp32JjbLY2E1jrpCyaWA3trO9o6GaUrCDqAhsQZeaLBOb8ax4WfWNzdftGwnbPohfaxCznAmtyjoTbXSXLiUukbvelJDB+RnHqKHFbdzwXpknXZm4/37W2RmF3a/MqX8PvC2WdpiAVxydwKOHtOhlelvcDsioLyJTJHAZ00+Gc8G6wSS9hR2TDUyLp8B0luQUjHP7EaNjull01q+DmhjTP9dgXgW7yf2J6zSDxnAd/2sbv8KPUmEXFKO/sR42TnV25+BpQUhK2aoQruEHicrwz09yv3O9MMEsPeGAzJCjG4RAU0I+YcTuXYi0+r3Ua5zF+ojBEvNo/cvkMgeHavVkQun5gv9WcE+HC8S3IqWTeVwNPs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(52116002)(66946007)(66476007)(2616005)(6506007)(6666004)(26005)(956004)(16526019)(186003)(66556008)(5660300002)(6486002)(2906002)(6512007)(86362001)(83380400001)(8676002)(316002)(1076003)(478600001)(4326008)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Z5msBhModNfTuYA8oGBOIqfBWcH2ITlSwbMZUEvPp0sgrb26rEi9ashCKXsW?=
 =?us-ascii?Q?ZqiGoXs33K/vn4aGRGOkui3zLRLr7ACprv9gIx0S2gEx2MEJFSpn35ckc2it?=
 =?us-ascii?Q?gJQhBJEvXa+3p5B1tBniWST5X+VNz2DxrhlFn2QQ+zsu2zZuLjt3dejWwpa8?=
 =?us-ascii?Q?1zP3Xzr+7iusNC4gwb8F67sAEwIbSu3XJRn3nhq+pBxaAEygusk0tL9kTfH+?=
 =?us-ascii?Q?wq1GB88FG5W1DYQAet0Km2JGKU7QYDigCBQXFJ5ituFiUcBiF7nr8OvBGT+a?=
 =?us-ascii?Q?FKi7R+jXExBcwtjc1Et8Ur75NzRfj22iFkPE1STmAxaftpgJmfdY9fsQ782J?=
 =?us-ascii?Q?hJlXr9ctL2tcet2miYOKnqiktqZGkprzg6v+XFODAuSEV1n4jnti+6uKyOxX?=
 =?us-ascii?Q?17m9daTQayiZtiiQ50nq4ziJ5tqTtp2m+qjjKUf8qmQvOxdUK/FOszPnYsDT?=
 =?us-ascii?Q?A7vfcOuAr5cS1gUJX7EohRNnBZOxke0GmzIoggDWp5AEGFcXKPGdFgv/xcC7?=
 =?us-ascii?Q?w/PekNmEDa6YOb3koBg6hXA+iBfW7S62EiTpsrJCjsekROGAvMFP6ZDNUUSP?=
 =?us-ascii?Q?K3xj/hvqlGb/U50CBAvvLkC4GKuVZ07jqmqgEeeWs7P+swX3N5c8hGJ6vKV5?=
 =?us-ascii?Q?zzGqhqHGVz5d50LfYbTVo+2+3JM+bDxpMwmKdKZO2Wr4vA03Z8+gHsdZlbsx?=
 =?us-ascii?Q?VOc2vCXkmF/rw3i2KPzRabKTUToAuud9N2/bhMN/CnhPRwjzGItcF4Nsarsl?=
 =?us-ascii?Q?35CiVwiczESM19hMYF1GO3/B/8V4cSYEo+P+ZutKruoSRDowvRDQFZ0Q1j6o?=
 =?us-ascii?Q?I5/DMaXM4ihb/+zq3NrMhJfO5cCP1vFSBtGZOorKs/PQ6X1yEfOSKILlsFAc?=
 =?us-ascii?Q?LNL01PJ9Rw9vyL6vcosajdltuJ+In90HxjlQO2Q6q2/Tsns738p4cslQfp/A?=
 =?us-ascii?Q?XUfm91XbPBrDff0MqdQ6dRTzHLItDVdmgVCSnhznrHV7y603GYUUnnXZ2rJw?=
 =?us-ascii?Q?WVsk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2021 09:16:40.9394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 029f594e-f50b-4186-3a5b-08d8b0917281
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyO9pJ9i4CmV92HEpDUMvmXtw9pOeDhcghmQIM920gyfagDewj1MNeOyc4HJcm4uulZS6kPPFxrntd99QgqFLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5141
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

Changes for v10:
 - do not initialize ret to 0
 - return imx8_soc_info(NULL) directly
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

 drivers/soc/imx/soc-imx8m.c | 84 +++++++++++++++++++++++++++++++------
 1 file changed, 72 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index cc57a384d74d..071e14496e4b 100644
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
+		int ret;
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
+		int ret;
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
@@ -230,4 +270,24 @@ static int __init imx8_soc_init(void)
 	kfree(soc_dev_attr);
 	return ret;
 }
+
+/* Retain device_initcall is for backward compatibility with DTS. */
+static int __init imx8_soc_init(void)
+{
+	if (of_find_matching_node_and_match(NULL, imx8_soc_match, NULL))
+		return 0;
+
+	return imx8_soc_info(NULL);
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

