Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60682C1B24
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 03:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgKXCAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 21:00:35 -0500
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:15847
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727245AbgKXCAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 21:00:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgM8i+tltWh1t9x0uaftt2H2wNRi+LEhq+C/DNDjfLzEbpkjz8yABd06uLOflE2JYBpabBSGnFYJzUH3Rqyb087sgGIdLBNMQuU1IvfWhlZRYZuKoUwXH3pTiCkQh8CNQ0t5e4eXQbUkh36tNvwuTVzxoYhThs2vsLEVov1BKIn/4srF1bsoKUvMrwfjv/qOClttgJPfjW2M4U9Bz3fFC2y5Xar0dmvcrvPAE9oX3fccdsj06nvcFb39hloqKi1sFCIvOICARICu0XNv5w2+cR+adTIhy/u1b7lOGtlm0uBXqlCM9BI0cQMivlGiFJugJ6MzcenP/VtKNfC53WHKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AxtkdrpXUMLQd7xPH7F8Y8AeaEot2qD1hnm8JRbVec=;
 b=FsmjdyV3INWLvF8xmLOKaNcN2CFm12i5gexoIPhcO+TuNMs59bYDUgn4S3xPm6hL0k+7DvPXBBEMlguiBg/wM9+5UxY13iGBVvDOoi29QaSIyuWFYsKyLIzuCxfBPZJR5YPzo5bxjrWJCuDloGcGWopYP8R7+8WWkAONUqIEJn4t5wWqo26UqZrXRbaLiTQJCL0dGNK4jqT4AwQ/67LKEuk9Bj4+8IDBugZA41tLepp2qNgqrwVmwWDyVaNhoHarOs07oplf4fMPOGHnB+hyGHB/1FbXkf6zPZ0a5RlVQ2DAfhFJQAcyi0z9A5uRtxSyC8ZVaoPYoLJkvFzHx5pVTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AxtkdrpXUMLQd7xPH7F8Y8AeaEot2qD1hnm8JRbVec=;
 b=OpvH8niNtkupR22lhM5G4aRo5HLqxc0YZDV9KEm6TEYlgrcD7wH9URv0pwbkou78dVTHl5D9RR1c5Dd8DIFiGYEfkG1pnKLonJDxEz2uCZ8rGZoLgf4BTjIT5t2RDpU1+M619RPjjI90HJSGfhWTYbpP7AlmbdOBJ0S1APHZ9NE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM7PR04MB7096.eurprd04.prod.outlook.com (2603:10a6:20b:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Tue, 24 Nov
 2020 02:00:25 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 02:00:25 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        krzk@kernel.org
Cc:     linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 4/4] soc: imx8m: change to use platform driver
Date:   Tue, 24 Nov 2020 09:59:49 +0800
Message-Id: <20201124015949.29262-4-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201124015949.29262-1-alice.guo@nxp.com>
References: <20201124015949.29262-1-alice.guo@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0188.apcprd04.prod.outlook.com
 (2603:1096:4:14::26) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR04CA0188.apcprd04.prod.outlook.com (2603:1096:4:14::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Tue, 24 Nov 2020 02:00:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 376f0762-f2dc-4d4b-1da0-08d8901cb5c7
X-MS-TrafficTypeDiagnostic: AM7PR04MB7096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB7096BB80A0308B5C4FE90399E2FB0@AM7PR04MB7096.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dAdM/qWviyQjLqSaTFivWJMQUVOR61w3KRx4Jhagr1SM8RvsCDIVOmsw5SAMB3jY8uwtIhERs9WTubVxowLd0m5/WfxkhC7+r/ouNHnFR/ClxykQXO67epQdtK/GhUbcK/In2k5mwURpOFbJ5tE6Dd+QWtlk4pZxFIl8kLdXR+b/4Tt4npb1ozlWBZdhQcs93LAaEYQSwytz7iU6GawnbSsRUbLLVY7JwipAooOY0+1bE6BVqzpJMSpSjJipUsd19+/xoMsUeyRJOhTxSFXF8Yn6XvH+4LowUezqPhwGx14Zc8htdrOvUpkgClLyhDx7wq9RgdqSxYxsqAXTWpASf8pIO8lyNETJaa4Rm6OSfywKFyZvAXjwJDwQD964Fptn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(956004)(478600001)(36756003)(2616005)(6512007)(8936002)(44832011)(4326008)(316002)(6486002)(26005)(8676002)(52116002)(2906002)(6506007)(16526019)(186003)(66476007)(66556008)(6666004)(66946007)(83380400001)(1076003)(86362001)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: nYPvHTfGU/RcF9pCGzNFwpmsRxzn7VtlgdvDiWPOarqCeaVBGXa7F4FqxCJTneCb/3mO7VwPXzYCVKb070Hl2u7/HIamCHis/lbcziq+pdUjusWWcH1tSx125BN9ZY/noWJZMqid1lH+M9OdCS2rpiENuvYEXEHTv/4mBn0HwATZzFSBXyDiAbHMuHfO/lyuhQWXGsVPN2D5LqLldDxmcPx1Wb/V6DSxNxd4bRyegAGPJhCpbyMwhPiYwQ6MPpUlvxC9Uv2jbjNkKi8XOZuAefQvnR/n/N1T3POaYjeOM3SYQrIp7CddxICKLOT4HtJUvvgKc6jC6dAkUMu7p4fAbXVlO1TZ765bUWUFI5TdoV2WPXyJUtXetPLynz6rt4I5kGAz6EsBYGyHrsaY2mBvEXO+MuP8rL4fLG41HoGkrWu7rWr/3gWpF88dJvQiXziXxP+dkCdERrMdHeRbPKhGM4oUWA2WVfPWnvXB4y6VPNEFLX55hfrsnywXwWQQI1pWJgMMQDLdPJvS01X1Sn60NiVcm6xzm3RsM67otVRT1aWWawR7u6yEspNuc5tQyNjJAidgBBw9DVmfXVEdb4m3oNKSaMCkL5AVSVffq8v9/i3+6Uzc8dGrBHSNxvBpz6ZpKZ3lCqYnPhoXiYcL2WySvctTRrAk/HGrRaV50fwXZkb2SX9fN4jVmr4OHMSGp7i2+Hhp1vnG1EJWn5NB8l6EEa6k3zSH8kVUzSW7n+OOGycFtMFAvRtX5g+Hr5dqDQ0kCampwnurt/D2qiaF8qvm4gXONCt6ByToew4lrXf6H7uvjYKgqL76QSF4iZfDori90J1WxONnEuY+h3uwSOKN/eqxyyPFngFh5FrJ98jt0ypDXWSCTehNSwiiquh7j40cbj0L2XQjH1wMZJG/SvMy3w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376f0762-f2dc-4d4b-1da0-08d8901cb5c7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 02:00:25.8293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkEXgJJ4fznp6b2NmwJWnr9RstNlU/lS7Jl2FrYiPq2fjguI/n0W7FNHgmXRa1m+TFMHOTBNqkLPOeIZcOdMqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7096
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

v2: remove the subject prefix "LF-2571-4"
v3: Keep the original way which uses device_initcall to read soc unique
    ID, and add the other way which uses module_platform_driver and
    nvmem API, so that it will not break the old version DTBs.
v4: delete "__maybe_unused"
    delete MODULE_DEVICE_TABLE(of, imx8m_soc_match);
    rename match table, "fsl,imx8mm/n/q/p" is actually a machine
compabile and "fsl,imx8mm/n/q/p-soc" is a compabile of soc@0
    delete "flag" and change to determine whether the pointer is NULL
    ues of_find_matching_node_and_match()
    delete of_match_ptr()
v5: add cleanup part "of_node_put"
    add note to explain that why device_initcall still exists
v6: none

 drivers/soc/imx/soc-imx8m.c | 87 ++++++++++++++++++++++++++++++++-----
 1 file changed, 75 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index cc57a384d74d..250530177920 100644
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
+static const struct of_device_id imx8_machine_match[] = {
 	{ .compatible = "fsl,imx8mq", .data = &imx8mq_soc_data, },
 	{ .compatible = "fsl,imx8mm", .data = &imx8mm_soc_data, },
 	{ .compatible = "fsl,imx8mn", .data = &imx8mn_soc_data, },
@@ -158,12 +179,20 @@ static __maybe_unused const struct of_device_id imx8_soc_match[] = {
 	{ }
 };

+static const struct of_device_id imx8_soc_match[] = {
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

