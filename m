Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52E52DE009
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 09:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732739AbgLRInA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 03:43:00 -0500
Received: from mail-eopbgr150049.outbound.protection.outlook.com ([40.107.15.49]:32167
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733024AbgLRInA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 03:43:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxWogQ3Mm/TV9E8oVozIzXlhWhnOlZxGO/0kODikup43NELZ4c+skzFv9TzJ6HmtEbOG6DOSo09U2mp/sG+y6QpWBuXjWeWW0lMZSkCjbxwI1Qoz345AtWHrLdRfmtQvFNg5Si3ilFaEJJYvBC/xsgRrmRhHI8FEZhDmk76StLS3jneFI0+9DuNvwCBiboJY0Y7i00NZfsxjAio9+PpWzepaoeSOb1+Q8istEkacpn8w2wBFtlFmPAM1z53T/95U5jqq3jfFRjlwN9CIZiiklZAD+qp85RaDSsTuKoSTm9b55zQ6A2Yirml/5cbmlHZY+Loqrr487cB+gcB9qq6zFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NCAHft4zK3bU4TPl29zjFXelekEYPl8w9CEfRVTPbg=;
 b=Ugkq1q5d2GrXTMfguUovHxFoN2j0I/TpJhznJgAp+eC+CsNM6n9/EVUk6jcdUJ1gkxztjxtgoTt1p/dZvo/VG5Cu84yKGmLnOzzlK5UwB3PbtzggK8C6c9TVfJYxUGFiOFUojpRdl4gjFCOcRUcSHbBH3pwG4KK2mimzQz8RlTtvSdpGfG9CSQv3yPW243vi5vMbbz1BgcfFCu8Sp+vdhZdM7Hh1f1rv4CVJtcBvP41c79u4lL7LcGqUymbWuYOKGFx1IyK0Zoh0I/zuNGYMgXhgOzX1sUIQ3CffqN7VZDaEWrAZq2HYY+ZlcUOpHnnVNDFTI8MW5FQypYVwZ3HfKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NCAHft4zK3bU4TPl29zjFXelekEYPl8w9CEfRVTPbg=;
 b=gFVq/lxHh94e80WvJexvzfq30ExzX7shOtmp3Q28OnqolgzVsTVPOExvCOZgxBqQtZA75MNY/DtxU7gmFF+fdf3D0eGuUTFPxSjWLUHtwhhKKM4woeWk6DUoAn+iq1q/88mHooYxjQC02QSls9XQgNBz/mqmyrYjifdhFiS1rNY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM7PR04MB7096.eurprd04.prod.outlook.com (2603:10a6:20b:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Fri, 18 Dec
 2020 08:38:04 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3676.025; Fri, 18 Dec 2020
 08:38:04 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v8 4/4] soc: imx8m: change to use platform driver
Date:   Fri, 18 Dec 2020 16:37:26 +0800
Message-Id: <20201218083726.16427-4-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201218083726.16427-1-alice.guo@oss.nxp.com>
References: <20201218083726.16427-1-alice.guo@oss.nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: AM0P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::40) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by AM0P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Fri, 18 Dec 2020 08:38:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 116e0a41-bf56-4d0e-ca49-08d8a3303ca0
X-MS-TrafficTypeDiagnostic: AM7PR04MB7096:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB7096A6EB5E33828E2D5E0DA5A3C30@AM7PR04MB7096.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1SgT6VwdWrG5Hxx7IidbOtsw+IC7M2xa9+uZTRbXk8mV6GXhEBczavVEHV3xKgnBCr5qFNcVvdxaUbtx3npvxs810IOmO5n/txMJ6T4XZQC7LqK2dlPQ2Cnatyhi7+PxrvFzaGqcHV9mxDpafKGH7XsjLrl3jEm3JvGhP+c/blCpONrGJFYCJZsYoqjwuumE/NpU/D8oC3lJte3HU0yNyAHzwpfXCDll2e/ofUsWh9Y2XpsT6krdaIkuECMI1C4K/Gp22c0DjL3tzgMMI3ESz4TvxALLLL+XpDOVkEjlweeVY9QDes7EcE/V7XOS7qb1G0Kxj+KMQgseZ8YfGWcnvOUfpJ6GtZFFf4Mf5tp97FsoVDrJ15F/21IQ4une9bVYGNQVG35iM310996hIGuoCDfBJg2CUpDrOY0/Jiz9rDlwY0n5PTUmxAKwMmEoILR+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(83380400001)(4326008)(86362001)(6506007)(6666004)(316002)(6486002)(6512007)(1076003)(186003)(26005)(5660300002)(16526019)(52116002)(956004)(478600001)(66946007)(2906002)(66556008)(2616005)(66476007)(8676002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VOQeYQV5Vu0qdrzQuVTNn8Ss79RfEQwW9cDSy5bufWgnHLWk2aq9aJfZDfuJ?=
 =?us-ascii?Q?IgYjspnvX/keHAnSOe9rRWx5TDeJfh7Ay6bKJtjmNI8TyUuyaenS14gTQ/jP?=
 =?us-ascii?Q?oEC1oXUhuiHY8lV23MClV/dAX74alk1n36Nf92W/j+zYlzxwpRR4RjeH5xX4?=
 =?us-ascii?Q?dy8hLGtKu2jIMxzaDM5m4HF3hdWSVdPgXSd9h/eZf1+KRhScjzEVv74vKLgx?=
 =?us-ascii?Q?mIcTuMi8YHrW+O3PRcLn3kVbT2kq9QpUkSjzISdwbEvDBP5KSwGLOBlULhcm?=
 =?us-ascii?Q?ctJ/q/F172hbht1yYuvE6N8Wg6jgDpEtHNMHKpUttQVG5F+zJurQECBqVfTJ?=
 =?us-ascii?Q?8CQ3k4tIMB87wdR2gkBKDcnRvg1EnBc0s5yMYYSFl7kG5l1bpEZUWtVMR0ze?=
 =?us-ascii?Q?bYS0AU+zNSWdG/BBhG1op45sjcvCXd5OEKYMyw2Ov9yfjnecrEo1jhj5IVog?=
 =?us-ascii?Q?rw8uT2GjyS7nKv+YCuh+uTwdAQ16aya76ybUgj9HNCvBf0NavPrTsfp9Zx8O?=
 =?us-ascii?Q?IKgM+k6behLf33OrBmVIb5V7/N/Y0hpnuTIb94ymr3eSXpmr+2hfKZ5dXV7c?=
 =?us-ascii?Q?Oh7u6Kox4s+oCBn8R4idz9wh6Lo03f6j+6rxEHthlv+mWJhL4TxBb5LiIgYU?=
 =?us-ascii?Q?1siyntfn2Qt7fn8ujyyAfoNU7PciZIBprdChfB8+kN6q7ycw6j+CEELTKj5X?=
 =?us-ascii?Q?7wBq7mrxcdjAnz0us00xV09OrwjX3Br3zzg+mWmykgacvOvZyf5e2zJFCKC7?=
 =?us-ascii?Q?pSkfd18bkD09gVaKiHF55IR0SeCI9Bj5bOyDFzzsHgPdc6juu2aE6Lx/vhKq?=
 =?us-ascii?Q?3HuKbPojZSej4zR4SfqjLYtPYOWbrh3k9EdFwTRVYlEPOwLVXAqNZqjNVuGO?=
 =?us-ascii?Q?1GjNK5K97hFzWa1croL2vI2Q/oLVsgmPDWtoZVsQbf48h0PYcPZR5jCvLhld?=
 =?us-ascii?Q?9KXyY5S4HzMJDOBbPmphZQ67tUTbL/ZqrdzBNxDkWgD6Fr6nQxpYgrVVtdl+?=
 =?us-ascii?Q?7tn3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 08:38:04.3393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 116e0a41-bf56-4d0e-ca49-08d8a3303ca0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3u1ovumS9efhm8Fp+8cx0Ter9qmLA8XP7dXjoL3A/d06elv68YWptVRdhqO2o/IGPuUW0OH+PfY7unGOOpZbcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7096
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

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Changes for v8:
 - none
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

