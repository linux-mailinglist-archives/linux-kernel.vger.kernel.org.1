Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017CF2A5D09
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 04:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbgKDDNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 22:13:12 -0500
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:61181
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730653AbgKDDNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 22:13:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgK8H5evC6vyZthpXuVMdd0NH0xOOsRJDP1dSV53psAnuDH6bcT4sNAf72hvBvZoE/wW9K0bAI4eZdF1ikRZSYZj8F7QqhCCbrycCjGIMv4WSazgCXmBB2X793fOW+RKYJjtv3i7CghZ4ECxF0byubXZfQn3TIC7mAKab4CllwV2yXuZ3KLhRxpVBjMa6oKiGjMooIWl+dQp91DEyQmEy9MQ9ouBy/rH+KO/cQ12TCuNXbC1k0Xxmw3QdaPOkM+f4Fit0015bol1+Y0w4ET5xmFkDkxf+aBGUTGCJEtIogI8xxZax65fONgI6Ca9zWjK68YwZLwiMPZvvsSC5JKMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IllMc9N7eAaQ+ljrA3HurI0uBJMA3gQmg+C53YtXF18=;
 b=BJYJFm4aUtMIalN9b6j9gwz/rHI+bGw9dfXus9cNTWwsQPgJK/SZ40e6za8LjSVjGycnjAdiQz56wyxMP8YVEKOQhfmx1qWevKUoJgXM3ylNju+PgHfmr2qcnAuB+pOG/KugEb05Je43vNrgGHZ1mI7cehisRbRdqT8yMMsFy6MrTBE9OYuowF1szAERS0TNGGlvgMHHj2Rn9xgjXf5ITxJFXnSO/0bfgRJW9neSBqf7x/nP5QEz/NmxYmwNpupyslSLw9uAGiMd+jG6iiEtWLtV0RDc6PPuCLjJg8qqj/cbFLrHxv2nnWrvirJSHSQ60dxmxof22L2T6F98Im8/CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IllMc9N7eAaQ+ljrA3HurI0uBJMA3gQmg+C53YtXF18=;
 b=iLkwAm87+RptMrtCUWQc1YYDYxP9Hw/FisftQcNxPW2z0zYgO+fHSpKzjLVT5F9iFO3oAlSjxKXNXvXZEHqJuE8sS1dO8ru7ELqUQbv2w/6R8utMhgmAarF+hXauRtDY7n/quh5HbHlECNZypk/DI1GorXoLdwoyCHfk1xAXWNg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DBBPR04MB7961.eurprd04.prod.outlook.com (2603:10a6:10:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 03:10:33 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618%8]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 03:10:33 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peng.fan@nxp.com
Subject: [PATCH v1 4/4] soc: imx8m: change to use platform driver
Date:   Wed,  4 Nov 2020 11:09:59 +0800
Message-Id: <20201104030959.13264-5-alice.guo@nxp.com>
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
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR02CA0113.apcprd02.prod.outlook.com (2603:1096:4:92::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 03:10:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c96924b3-a848-4980-f82a-08d8806f3143
X-MS-TrafficTypeDiagnostic: DBBPR04MB7961:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7961DF6559F24FDBEAFA3415E2EF0@DBBPR04MB7961.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qck6gJBkY6wwTB+leA/si1Ru0ZJmcbA9gp7XiLxscGUd+ig2SvKTQuYtnj7pLxu+Xg9qdFJ3OQ0Laxkvg6XTQ0rx6zkmQMYOzfSC/bQyPlxTKWlLtyXDH3iKhDD3UlFReaTgcLykvNqnVH0XTs8uzlJeAy67sKsX9XVJiCpIrK+iIJj7gD5dp6LlmdR8Sna562dego49qgQC8Frx8urtxDi+7hB9ggApC0YXJouvjLmU303K6uS21x2giG8qdHzbb/WoRA+YgrxtDwUaeSWmYOzTa3QgJtqJKEhqXoXqExobJI16QAeUtVCpOamibEYrfgRtaj4zfeVLxcpPqL6YQ/j+xvPMP3+r8W5SgBkPT1dy1MZeLqtjiuwPyPo7T+CV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(52116002)(2616005)(1076003)(4326008)(956004)(66946007)(66556008)(36756003)(316002)(6512007)(66476007)(8936002)(6486002)(478600001)(186003)(8676002)(86362001)(44832011)(2906002)(6666004)(16526019)(5660300002)(26005)(83380400001)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ho9qrF5E+QHFnNjO+p+Ud0mCnHigIcFXyDME/a/6rEWju1S8PpVAhHPErND/bxvAmnFtegbT13zVHp02w8ls8QmEOjXxnZUwQoNHaoSPzU36m3d18f9w2o7g8445W2nXp9yB9dr0inIIi4s6cpQMSfG+6FNBCIbcl/2QgXrTrBG8Jt+afgb+0Yq7M3MM3X41f4STW/PKK8dy5lTPkazPuIuy4SUtDvyUP1TwvpCfBSgbocPtN8GGMOr/U383+2//yuVetou8+c3HbtIGm91hq3nSckUsnV84zJVeKtEE/OjL9jTS0GMvH4MQ7kT4xrEqJy9vC+CF2pVv74kOnAEbx181xAK6lAwP5lULPPsbazzjGXqYJyHckx+wY5k0fbwSHOcpJNqkFfcOPc3IwFe5Zmicb4XezjbnsONfpQiBZvq0eGVsovDE357QIG0txejWoksA247f6pFCvK1Hot7EFAJ17Mvm9VUwO1Vpjvk17kU8uT17ISx208Rn2Z8oPFS0TXdIr4BnH1csns0PiaOADgfygm3NEVWKTA7T2x/6kjNIVGwGbIXhCeyXHc3j0goYrgfGQOZou7q9hyP0kjIyOXNXgRorhxblXbsKAuugXVUse0dll4Kfh+aTUyvgKT2gKfG6b4KQkRkCelwqrpOKZA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96924b3-a848-4980-f82a-08d8806f3143
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 03:10:33.1289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHavEaBPr9/S+b0rfBLINJJJ7p0xBTvMzPRdPWfl/RnSfvoN7YFXWvVzJMOs3zR9J7vYBaCBNsi7FNAVBS7JeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7961
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

