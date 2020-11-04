Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48AA2A5CE9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 04:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgKDDHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 22:07:39 -0500
Received: from mail-eopbgr60048.outbound.protection.outlook.com ([40.107.6.48]:56390
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730017AbgKDDHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 22:07:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dup1kQ+FBuMuhhCDkIteskffHKeAV9HnA9k1cjGVjHbovjsLfJsUkQeM+luOiL3IfdNhuRpRNyh8IIm3UKMsAK9ii7WrnJYALnky/YmvowitD/vPbBR0/jTDqKwuG35KnHJzT72YVt8sZ6oJwXwsmepvbfiuYLWwwBJYQ+bqUNyUzCqU129TBOhWvOGBcUeh52sBJWHRg3e1tKW/sDV40Aq23HbxE4JRbBL804F6wSIzA2+6+ArdK9JWKfBEeyQmlDYZ9hHZSwBNnF0ExbvLIITvwmAN+oCTxIREnVlYkGIt5HzLrDFh1c0jJcl7+ZgQMvY1K5mm6psNW8509ke/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IllMc9N7eAaQ+ljrA3HurI0uBJMA3gQmg+C53YtXF18=;
 b=O0GVz6uyDN4fdTVRaCq5NPJtJdqcs+1wKaejnY0PhDyFkOKLVc1Ibk5Dy5u/+MWlOknq1nqzLZmN4KIfzzI2ZLyFW3gLCt/JEEA30/25l46wtJm56cU0vwaCRUlWesuodlFR8XauAr9r7vm/Bmz23biqX8Q45g0Os/tRCDs3mEZHw6J5H2x77OQBRNVkgZV5E+HWcWQB+FMOf2eBjsfQOTaS9ZmJ/yIi6yP21wVeReEjI4sr9MOhHRSTL1XSHtTNZbObui7Y9BfVSchUiBnhcrfKJZM6B1kBYoYFKMpIqFEKd4QQr4z/46C616MIKs/Jau2G+LwF7IVfRqmZj1MwHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IllMc9N7eAaQ+ljrA3HurI0uBJMA3gQmg+C53YtXF18=;
 b=LDlGp9GxbHJZRIJFX/XcqruARhidW5TrsnV48m4o7o0+BIuojDM2/7tqt+EBQCzrcsmbNsZeAVKl18f9TQ/4eAYUN/87HcYJPQXISexHgRkcIvWPAZaKBchuTmIDgJ+qpOh8JPfCACiv8iWYO8bCv2sHniPTAxEj1xKFTdSZc1M=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DBAPR04MB7365.eurprd04.prod.outlook.com (2603:10a6:10:1a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 03:07:34 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618%8]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 03:07:34 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peng.fan@nxp.com
Subject: [PATCH v1 4/4] LF-2571-4 soc: imx8m: change to use platform driver
Date:   Wed,  4 Nov 2020 11:06:45 +0800
Message-Id: <20201104030645.12931-5-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104030645.12931-1-alice.guo@nxp.com>
References: <20201104030645.12931-1-alice.guo@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0225.apcprd06.prod.outlook.com
 (2603:1096:4:68::33) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR06CA0225.apcprd06.prod.outlook.com (2603:1096:4:68::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 03:07:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a990c923-647a-4ac8-412d-08d8806ec6d8
X-MS-TrafficTypeDiagnostic: DBAPR04MB7365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB73650B2A37B0A2579E1EB132E2EF0@DBAPR04MB7365.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NKOQdgd6e3lG+VIC9DY+Be953GlG91PZ31Xzein1DGvhGtb7yV0un7zgGEh6TuLORMsAwQ/GnmgFhHDcX91o5Zoznme3+6EB50b3SfAfQhxR9PowkIJeu/wstGgnB57qDmTFF7K6UtCGkX+AU/H6oDb/d6f4m//je3U/65I2oG0bx3q/bExof+Ir9HwtmbwcqbTKlM8TTy7MULQ6dha3+iw78VGxjlP1E95dsfLFV/kBej7DLttCJSmKyMDTnTH9C/KH5SqWL0IWQ9sXiGxAPNbp+k1sDfG0g3pmGAsmQRb7nXeFbGIAQGFbucP1DjHGfqUmiqA7HkZJA23wEZj//LtgsvzoydJC4S22yqZ53o6ZmPZ+ns+fteNsHIYOTqVq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(1076003)(26005)(6506007)(2906002)(2616005)(956004)(36756003)(186003)(6666004)(6486002)(16526019)(478600001)(83380400001)(8676002)(4326008)(5660300002)(52116002)(316002)(66946007)(86362001)(44832011)(8936002)(66476007)(66556008)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Il7VDo+0G0YGlYa2YezkdjkaX319gyGA/b0Cy1Nqmb5uDkIJZs4kjtORpMIfLkaLEZ06cPOJuz8JNuMVZ5h7sVqqw/6Im8ztRU22NgaIZ0znhC7v4o/nWHYtwmmwKCAgh8Fj2c4BkQmW3nv0915dAG11r5ByORRohh5EKFvzaw3QY/jyqcncteEUktYcpdO1PJLraTweOZgF3TjhgoNUUL3P7MDM7oG0qZLUHX4KK9cJJSGqGKiXTDUK5gnMzBnV26r2J67YU6Nwr3Y3DWEmvOaOE0vhuMe9JtTFpHFJsbtPZzSNMQ9C7dLSrBiSpsidm78djTftk5QJhBJpnICEbvc6InLOSc+/YOrtmWdBWhyb9kequJLw8CxWwFdTeUYRq5YAQ7MFgn31jsSBRMuIUhmjUbnPgxLCa30Hp6xd7gHQC9a3yDEGRbbU/CHYQ9SfUoYie9jv26ZmoH1JcapqTPJwRlZz/mFpBfd6agefzjFQFXNW8pnl0tWbeFqHe+T3TrCShi4Y9KJuBmlr+OGeWxHnm5hBhYMDRxZ122QbRlh4KBzMfBjFlk9F1vJyWcp4oxH+cQ++JcwQqAaQyhQUl11g9TJTCIw9Nc6RfLTdjA08hTwvhyywzqxU0CDt5SKo3US3X/0vzDZi+3/FJZq79w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a990c923-647a-4ac8-412d-08d8806ec6d8
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 03:07:34.5616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjlW4KcQ75BRyedLVgtW7MAzGGgKFSqoZspCzA4n+LixevQbmSKXmKiXLSsSbfuIF3+wNGz1FzCS8aJOTVW9xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7365
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

