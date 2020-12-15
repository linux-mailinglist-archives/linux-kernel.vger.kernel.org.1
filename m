Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019952DA955
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 09:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgLOIjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 03:39:51 -0500
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:12590
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727388AbgLOIjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:39:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOaE+WNck/MKv1z+7bNN9/6vhmBF02VByOk5rBb4DR4OCN0165LRKKbgxmJU6dX0+tbhz8XPmV7EHzdf1r4Am6Nw/99zjNDJrRoOw0766rUwPp2A8k+YHLNomF/bFgUYSBXLC7vSFXcROZuKCMCPumVYp5s/qSFJg+A4ZGOv8AokhNVNZPrZZmqc3ncvPDqCL2tjAqOqneSGB5gSQ0jg9P4gQLGJYBcCkA47P7D7n9aLW6u1SOj3AGaPlg1dIxeQsDT6pa6HfWR8NTjY1eE2MPrCkyLHDGjEKqfsvuce6IUd/u6GoC6OubnQzku3EbksOR3a+yrXAhKgdT0SlbwS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neTcX9m2uIo0xutsc3LeLYer4wUv60DvK0WOje+vipE=;
 b=V9ne4iiV7FjV1A1lP84lsl/DHZhBatNtixNavmqeoOreEtgBICPx8VSX4cIMpsPe4TTBROr0Bnanr45k5vvsIYHjgb9uik1X4SrYMgDvrhdWIg/y7fg/zhcHS7EHSFWkQBUSbEnoeGcgZEp4PPgBq01l6NFw1Xd2kbSJ+FiiuQGCttjiw3CWykS8G7QaXgKLb83nAR7R5SWGQNRx/SW2iIp48nom1dwpyRG6HGAdmkGMS9GQztrUsfi0bCrTugjtt2W2aS3OIAtklXc0GYvnyTMAG6ouQAoZggVbAGcVh5FQwck6xLmLmFhB+uMpnpuDco91TR1PBgVbuYB8+BbZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neTcX9m2uIo0xutsc3LeLYer4wUv60DvK0WOje+vipE=;
 b=lWwSBtLJXIN+hrtTyQiOng79faSH1A8+xubYexZKJnRLBeHfY9AXFgZ+RD1PskV5ZPbUSWHK4DOexDuAaNe3sAvu7q1vt4q6gp8iBX2eY4FQegQwVS7aGrQ1zb1NYVB5jCHhRnKqipY5Joz1VuzXRvNF8JBGABaPZ8dqb5rC3B8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM7PR04MB6807.eurprd04.prod.outlook.com (2603:10a6:20b:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Tue, 15 Dec
 2020 08:38:11 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 08:38:11 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v7 4/4] soc: imx8m: change to use platform driver
Date:   Tue, 15 Dec 2020 16:35:51 +0800
Message-Id: <20201215083551.6067-4-alice.guo@oss.nxp.com>
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
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR06CA0250.apcprd06.prod.outlook.com (2603:1096:4:ac::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 08:38:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 06f6d4e1-24fd-4a97-8588-08d8a0d4c185
X-MS-TrafficTypeDiagnostic: AM7PR04MB6807:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB68079AFD3FBC9F868329AB3BA3C60@AM7PR04MB6807.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mfDluSvj57sOz2JeMMcG+cb6eE0vwJ3MwWRH8conElJEYkuy/pYi2jygFMMnfZSGCmOXx+IfxVI/wdAzNbpQu0tmVmOk2tqGxi9Q4jKQY19YfNXd2T/9OTJ0IhlbsUFSPIwrWjrBQJ09N7sh6/IfXq0MGPI3QPx9vo8ResBwIPBEuj/TVHuCXE4EgwIi6vz/pPHsCeSWNSwtqYX+x4eYISLbVsT/y5WMFl3IMp8xUZ1UvYRtkYJ3pbEHdD8YYF5cdBj9zwJeFjcTqqqGfFfcVH9OvlKJCN2MESqNy0/0f+UXXc5MwR41zCnVR9+2VzIXZVNAQ1DFlTEiYOIQNofyMIP3gvmfO1IUDg/5UTsdhh/CJRbaNPnK+WpIpMeK2wUZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(83380400001)(6666004)(16526019)(186003)(66476007)(86362001)(26005)(8676002)(5660300002)(6486002)(8936002)(316002)(66556008)(66946007)(2906002)(4326008)(1076003)(6512007)(478600001)(2616005)(956004)(52116002)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XuOlHbU1cFWn+zJ/zFVzR9giRz30Im5TGUs3+Ctm4z7TEaEGUjn/jE0yjYHg?=
 =?us-ascii?Q?J1x2iECslhAk3SB1oj5/BSodLmtilDnr8rT4OS9BlO2vc0U7pFuphNT2+YL1?=
 =?us-ascii?Q?nM0AgnBT2zcs01XzuHV/CDUcXH07deSwdWvgaWWJsn7uuB6nR3KcrSLqrc1s?=
 =?us-ascii?Q?qGeb+a+ucx04WjSuKnMuGJl47ftHOs1GEinT4vD3a9K+Iscr7Mzd9HveGXsT?=
 =?us-ascii?Q?jJEdblwjTC2i++HpTOssElSKRr4Vb6fjI7Kgyp09hwQDfcwlyp5IcyCQ2y4e?=
 =?us-ascii?Q?6gecx464v4wqHS0uYUAEpMV/aZLyuX0lSgbPWurkBvwyZ5LkY0uwnv8wpjZw?=
 =?us-ascii?Q?9pDAjTDBCugdyDl8GaNFkmgJz0jp+epYWgVSIMXHjepq+zMb1Zj7UnQ2jupm?=
 =?us-ascii?Q?0MgJDwBcAzQpGUpTzHq0Or590ctH4RQ9YH5rSoSUoAmOga/T1CblJdtIpRQT?=
 =?us-ascii?Q?H+ht40U3Jji9M2ABKbgW/hTHagLYr1QYjyFwLuCxXr3+FIlyNkGsiDNu2BGC?=
 =?us-ascii?Q?Su7xaUVROdBH8Qmp6kCSrhJA1rGBbLY4c+Aa0to01We7oN6b7T8z9FAY+ZO4?=
 =?us-ascii?Q?XtbsDaWToSFfOLpb+fbUsKm7WzxWXXRjFhT0dLBqbLw34jNWpgFA8Gqs9+an?=
 =?us-ascii?Q?/t/+TbJgiwWlH+Ci9XDFUu8zGxixaP8zLsnrha6lq1umU4PoguuRANW9uJDT?=
 =?us-ascii?Q?OxBvhPiOZ+A8kJUQf8toW5u4EkEhFcn+U1mqR0JOQ4ERHSxCYstK+NFjBIWx?=
 =?us-ascii?Q?87BjSArvj1ClU6P5tcPCZMZxvU7ixLs+69omx4iWnGV1oZll6Hio2y3a26NF?=
 =?us-ascii?Q?N+c5NPLL+f0TLyGTeWYGHe+D44Er6pFquI5275ocXIki5VO7m5D8wAU/ibb8?=
 =?us-ascii?Q?u6DinPgHVLQSTj9uwm5fBz3lZ2+AC12rEiKlerpknWN5YvQmfwPBFodcL1FM?=
 =?us-ascii?Q?fWWMKtuW2pnwjRQeOqzrXByg+Vp8aMPGrcdvIjwW268wycqK1KCcV9fNoiXz?=
 =?us-ascii?Q?/wTN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 08:38:11.2289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f6d4e1-24fd-4a97-8588-08d8a0d4c185
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7vnGlGkGjoMqtOKZhOVt19xWWh5NhO+eqXVHc1qppcxBIojwKMQ1+oaxSk8zOVug1ekRhyWtGCrannsP7fU8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6807
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

Changes for v7:
 - add "__maybe_unused" to solve the problem
   "drivers/soc/imx/soc-imx8m.c:174:34: warning: unused variable"
 - add Reviewed-by
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

