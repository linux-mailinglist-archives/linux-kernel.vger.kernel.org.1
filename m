Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7672A77FC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 08:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgKEH0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 02:26:49 -0500
Received: from mail-eopbgr50043.outbound.protection.outlook.com ([40.107.5.43]:58244
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729779AbgKEH0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 02:26:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyEWMa47AI7fu21iQ+EPfCnNVnuKUwCQewuKAFONczykadykRmXOR0w3NGJ2OPRQ9d2ilheN79L4GE8F89HmRYG9RePqTuS3pKHNoLaPgG8+loa4RugoBdq8jdzNkY/yy64pAB/IWZy/eP5o2N7xrlAzfojHLCuY2pUfU6MI3RIfbiurd563E75PNTzzspjs2knAJK10eU0DktA26WAGWVmAekJjKH94yUFdLDDMJ/t1rdDRVYun4okzKeLMDryvzXaeWIEEBvJPPwTiz9bZkScl4dhYwyKeUMGS5ijoLg1+iykYaY3YukACEy6dchszvmTISFVlpU4VHIpObpOY1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IllMc9N7eAaQ+ljrA3HurI0uBJMA3gQmg+C53YtXF18=;
 b=WHnswN0Gk+4hWERrHWp6Yd3RbsTLyZcQPkiwTQ3k5pyL7B5IoBKJQlNLXk1pmgN75TTWx4L0xhZXRooVhU9idadm0ef1n91WH20KY3BM4hWaXsMRldABvJ3St11Rhq2WOmzSWkE1PpHw8UREudOvVMdy3Vjp/MyTedcQIU9t+cupLltwXwjdRjN9TcsuLAe6a309VpiO4/0DGrQOD4NhoK9G7W2c5i1eAesHPVRxeBFxwfleqOx/e0C2/IyXvGzJ8gdY6Hkjn2MBNq0JjLsas8t6ZByaZ9ev4fOUtksq16fJ8SYy4tiBGUJ/rImr5/XH0MFp2UKToJSPWYr7JBNUKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IllMc9N7eAaQ+ljrA3HurI0uBJMA3gQmg+C53YtXF18=;
 b=r6yT+keodU1iwXLl9WzlNWKdwt3cC+7Nu+ViiNJFgIxecrXSUoqkQ8vswv4YGlrWRv1CKIiSLboJa2TxUC5q7EBPg8T4QE5hWsoC7ZClj+WIi2LO0+mDdErEfkLwb5L0VqHHabNsQtXlMARGhNwXjl9w/zjO7KrME1CNsY0OKHE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DB8PR04MB6906.eurprd04.prod.outlook.com (2603:10a6:10:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Thu, 5 Nov
 2020 07:26:44 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618%8]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 07:26:44 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        krzk@kernel.org
Cc:     linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/4] soc: imx8m: change to use platform driver
Date:   Thu,  5 Nov 2020 15:26:29 +0800
Message-Id: <20201105072629.24175-4-alice.guo@nxp.com>
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
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR02CA0054.apcprd02.prod.outlook.com (2603:1096:4:54::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 5 Nov 2020 07:26:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 35e73a6d-1abf-4d49-cd12-08d8815c2565
X-MS-TrafficTypeDiagnostic: DB8PR04MB6906:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6906E9694BA54A97714C2BF3E2EE0@DB8PR04MB6906.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6tZR6+bwSMR5yUEM48p9DNvT2BUPFoI+B/P/JADSoU/uQ6Q71opoJrJrbAP6bh94sneQuDCn7k7tpaA6hLH5x7MdrE6o8VIRbtJ7kBGUAVxsZ+cfblGIj0G01I/E6q7ebbTWDunXWo4ByuJquMPiw+bt21DFAB8L0t3qimBh5LhQs1C7ezaG/oib97K+ntqhmMcZ1CCYLvITWhq1GsjtaGvlLi5NLRty2W3/h/mN/TTvyKEvG427Kjk8JRPQQmWOnzfa++AzZe22c3x34lwN2PXvhdcNox20LbgLxqHzV8HlU8eygqfIbjMT8VDub0g3n0UPHO1nNk/f+koZ8UBVQ1LMAzUXRKgZvOs/IgOURFiKSFBfplxq4RApCacn3gHy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(5660300002)(316002)(6512007)(44832011)(6666004)(478600001)(83380400001)(66946007)(8676002)(52116002)(6506007)(2906002)(86362001)(36756003)(4326008)(186003)(8936002)(66556008)(2616005)(26005)(6486002)(66476007)(956004)(16526019)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: nqDD8Ud0Po3hMUb70cjBFwYJnUeRMYHcm0Ry3+X56+zH0Hm48rUYT4BGrodwUQJo+HGmKyAxvxBi11eyx2G45FkB5v6SbuCEWrgo1mO0XP+mcX3zx0OLMzvPLOGokjDeiQXIxastpKTUXX1Fl46SmV81cH6cnp85UaSptW2aCTfvEM4RA71D/g6/vjwponIIN5GaalVbh99m0XYI4Ehp0NmO9nyKh/D0rjTWLzTBiQxuPsfZT3gKMFtP2uLVxhb9tp4JMluEPow18TB0qbgbVmwCDOLIt0H4XUZt+0kBaOU+/bFNRF0R5yhTNnkjR6gnem5qqaaOG3RWFfgGObvGN4rxkOcFl57qd7MAw1eYQ34oWxfJKdm86iDMhj4XueTE5dyO+ztvfPWR23lORK0Z97dJ3EUSj+kl9ypLLRDI0KhLw3UOec2V7v3p8jNlmBu5oe4ULPURTM246RlZ2yswYxJxqKdZM0FWfbgBARvcHZnbIzEoh4TPmxrVqf8O7gH+OzNtOXjFglprY2TG3rbP6XNHieWVXHjZ7Onmmq1smyfuvDs3NfXIzZpHn+NZVPJczzmhB5QE7Ngx8n+d1DaMo3lH+u0QbEjUs1h5OYC2J1C6WCP3xs0xY1LWCx/WYTsUsO3tbBB8/TiAPDDP+SD+GQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e73a6d-1abf-4d49-cd12-08d8815c2565
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 07:26:43.9936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lh3XDb29BDWEIgo0mbWk/97Ee2xVUzk+ijyBDr+uSugPzA8FHR3o37LGKmH8n9lQMnaTdWAWPq3GGXke1wxFiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6906
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/soc/imx/soc-imx8m.c | 75 +++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index cc57a384d74d..83f3297509be 100644
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
@@ -50,12 +52,15 @@ static u32 imx8mq_soc_revision_from_atf(void)
 static inline u32 imx8mq_soc_revision_from_atf(void) { return 0; };
 #endif

-static u32 __init imx8mq_soc_revision(void)
+static u32 __init imx8mm_soc_uid(struct device *dev);
+
+static u32 __init imx8mq_soc_revision(struct device *dev)
 {
 	struct device_node *np;
 	void __iomem *ocotp_base;
 	u32 magic;
 	u32 rev;
+	int ret = 0;

 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
 	if (!np)
@@ -75,9 +80,9 @@ static u32 __init imx8mq_soc_revision(void)
 			rev = REV_B1;
 	}

-	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
-	soc_uid <<= 32;
-	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
+	ret = imx8mm_soc_uid(dev);
+	if (ret)
+		return ret;

 	iounmap(ocotp_base);
 	of_node_put(np);
@@ -85,33 +90,20 @@ static u32 __init imx8mq_soc_revision(void)
 	return rev;
 }

-static void __init imx8mm_soc_uid(void)
+static u32 __init imx8mm_soc_uid(struct device *dev)
 {
-	void __iomem *ocotp_base;
-	struct device_node *np;
-	u32 offset = of_machine_is_compatible("fsl,imx8mp") ?
-		     IMX8MP_OCOTP_UID_OFFSET : 0;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-ocotp");
-	if (!np)
-		return;
-
-	ocotp_base = of_iomap(np, 0);
-	WARN_ON(!ocotp_base);
-
-	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH + offset);
-	soc_uid <<= 32;
-	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
+	int ret = 0;

-	iounmap(ocotp_base);
-	of_node_put(np);
+	ret = nvmem_cell_read_u64(dev, "soc_unique_id", &soc_uid);
+	return ret;
 }

-static u32 __init imx8mm_soc_revision(void)
+static u32 __init imx8mm_soc_revision(struct device *dev)
 {
 	struct device_node *np;
 	void __iomem *anatop_base;
 	u32 rev;
+	int ret;

 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-anatop");
 	if (!np)
@@ -125,7 +117,9 @@ static u32 __init imx8mm_soc_revision(void)
 	iounmap(anatop_base);
 	of_node_put(np);

-	imx8mm_soc_uid();
+	ret = imx8mm_soc_uid(dev);
+	if (ret)
+		return ret;

 	return rev;
 }
@@ -151,19 +145,20 @@ static const struct imx8_soc_data imx8mp_soc_data = {
 };

 static __maybe_unused const struct of_device_id imx8_soc_match[] = {
-	{ .compatible = "fsl,imx8mq", .data = &imx8mq_soc_data, },
-	{ .compatible = "fsl,imx8mm", .data = &imx8mm_soc_data, },
-	{ .compatible = "fsl,imx8mn", .data = &imx8mn_soc_data, },
-	{ .compatible = "fsl,imx8mp", .data = &imx8mp_soc_data, },
+	{ .compatible = "fsl,imx8mq-soc", .data = &imx8mq_soc_data, },
+	{ .compatible = "fsl,imx8mm-soc", .data = &imx8mm_soc_data, },
+	{ .compatible = "fsl,imx8mn-soc", .data = &imx8mn_soc_data, },
+	{ .compatible = "fsl,imx8mp-soc", .data = &imx8mp_soc_data, },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, imx8_soc_match);

 #define imx8_revision(soc_rev) \
 	soc_rev ? \
 	kasprintf(GFP_KERNEL, "%d.%d", (soc_rev >> 4) & 0xf,  soc_rev & 0xf) : \
 	"unknown"

-static int __init imx8_soc_init(void)
+static int imx8_soc_init_probe(struct platform_device *pdev)
 {
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
@@ -182,7 +177,7 @@ static int __init imx8_soc_init(void)
 	if (ret)
 		goto free_soc;

-	id = of_match_node(imx8_soc_match, of_root);
+	id = of_match_node(imx8_soc_match, pdev->dev.of_node);
 	if (!id) {
 		ret = -ENODEV;
 		goto free_soc;
@@ -192,7 +187,11 @@ static int __init imx8_soc_init(void)
 	if (data) {
 		soc_dev_attr->soc_id = data->name;
 		if (data->soc_revision)
-			soc_rev = data->soc_revision();
+			soc_rev = data->soc_revision(&pdev->dev);
+
+		ret = soc_rev;
+		if (ret < 0)
+			goto free_soc;
 	}

 	soc_dev_attr->revision = imx8_revision(soc_rev);
@@ -230,4 +229,14 @@ static int __init imx8_soc_init(void)
 	kfree(soc_dev_attr);
 	return ret;
 }
-device_initcall(imx8_soc_init);
+
+static struct platform_driver imx8_soc_init_driver = {
+	.probe = imx8_soc_init_probe,
+	.driver = {
+		.name = "imx8_soc_init",
+		.of_match_table = of_match_ptr(imx8_soc_match),
+	},
+};
+
+module_platform_driver(imx8_soc_init_driver);
+MODULE_LICENSE("GPL v2");
--
2.17.1

