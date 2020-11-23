Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EADB2C0290
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 10:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgKWJvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 04:51:55 -0500
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:31975
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728108AbgKWJvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 04:51:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVItV27PkwHs/sLbZd/NwFK2dSl6RHgEs1UygyNk04PVqNELzJGZH/a79FICTf20F0IcyxgWcpAm/FE8tH0ELs+8R9r/DTCjFDEuzPolXEHMAg7B+AxYiYFy3OQ3fIxlmonk3+UHuyra9KT1ScagOtT7E8nuzMmaI+iiNrFZ+HqHK6rsyWgJKIbMI5UV9F6+9r2YfkeldQitKMKj2Ni+0sw40km3N4l7NvIpLiWOllTMip+eh8Dx3JoxHDhHO7kj+ESCkj8xrKnspF1OxPSAKGY6+NKK0wBBVsUGIrksIMWXr8g/D12BVqi40rQ9r9wzMYmFfiZA9/EmZfSxsSA5+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XK+IrX/eiDQ1LXc8G2NeJ0FtXYv7Q3JjLDy7R+vgBBo=;
 b=ijritzSUFdnE/BpCdzV2vOuRRsdWPGty/C9U6cuv6+84JoqpMpePsjMZQk44JvMX0YJYuNNQMBn7j2OyhLIZcqJNUWXRujZCNv77hLygILkV3nve9/IKR1LmPP8/x+vobT9JqK3tYD7rr7SBvqPtbTYoPsh4QuGjwl82vj9JLmnCjE4SugaHb7j1lBzE/UmTpN3Zz+xScadv0FzqmsQZY8AtTuma+MYQvonxDqqPROJOXwLe6p/Fc0uVFjM0tavLsc0OEm7KTKqi+/edGToQAk9sZRPi+CybLt2ErX3CrIQW17QglrAvUFMt3V3rhOBf0wCAG9T2JFXS2W2s27hbmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XK+IrX/eiDQ1LXc8G2NeJ0FtXYv7Q3JjLDy7R+vgBBo=;
 b=MnkvKkP0Vb/t2obzmPm2Sztlz3GgahFP9ODdyQ5rwUL7gEpGwsqwUUjHB3rEQV5W+LLq35jkghUYH33QbPBbdyb6UTYrZlGxLYekl8KBSHuvp9oy6OF839kpmNPBYppqt1n9vkxUbHbmIn4UAws/hX13DV1Qh1rUrUwZSrQ27oQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM7PR04MB7048.eurprd04.prod.outlook.com (2603:10a6:20b:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Mon, 23 Nov
 2020 09:51:50 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3589.030; Mon, 23 Nov 2020
 09:51:50 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        krzk@kernel.org
Cc:     linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 4/4] soc: imx8m: change to use platform driver
Date:   Mon, 23 Nov 2020 17:51:08 +0800
Message-Id: <20201123095108.19724-4-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201123095108.19724-1-alice.guo@nxp.com>
References: <20201123095108.19724-1-alice.guo@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: AM0PR10CA0088.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::41) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by AM0PR10CA0088.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 09:51:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6f7b4d3e-30a7-4721-8514-08d88f956643
X-MS-TrafficTypeDiagnostic: AM7PR04MB7048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB7048DB8483A81001E95B56C2E2FC0@AM7PR04MB7048.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fSf2xLuwbfUplC7iDUH+pe6ehqfVPTH3bJYWXdPNdPALfIVpHVkheGgwOe5mWVR01AOZIMKLoFRtaCgFiiLYPHXCWPD66dMN7C9G1NG6C00IDPhxfZDwHB22WMkfCfMQEZP2unU1xiRwSiQWPz540NFpC8af0Vh5bezWtx+xBYLQsyq9XVQebn7pJhpPf5iU+Nx5571Rv+glfqMRm1NuD0PIQRuA9YZJbvghFNwZMciSnx4myeWC7qt36Rv0cv5AZCndseVySr8xPvnsp9oc6BxQV/BznH9RhQo3mtgAcG6PLd6ZEkEQnFLD9fRFlX8yC8mqwSdcf1578oaBHjivphspd+1kl8IeLkCaj+2HfWgIZpXff5ZtsKpXK2stMGUQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(2616005)(478600001)(6666004)(4326008)(52116002)(8936002)(8676002)(6486002)(316002)(2906002)(6506007)(6512007)(36756003)(186003)(16526019)(26005)(44832011)(66946007)(66556008)(956004)(83380400001)(66476007)(1076003)(86362001)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 67wF4lhVBnJLbksfsPV6u0Mqo3sYSfbD94v/ACvqvYCcCSuB7LqI5/jxewNFH+B8DwurhNTatsf5VmTOo4H1HIartVX0bxMZ718Fzah304iwqcTkKr1NEmdDH85as6suxdGOHzBA/UWX8xqgktvbkiP1zjgbSKSJVrNUO9RXtYNyc70VjEm4hPXo+HNaBS4Aha6HzpusOT2IiIQFlVC8NfIMOEy0mPj6e83vfqsxn3iOkgM8QgKDP3YmBDxDeG/BxzpOWp0S5huwFCfTEEzxL+PZm32XwQr3nWmiwX8dK897VWXCS4PpzVISE/yTfo8D4IUwD2Bof9QMyl/7DPrOo2UjPKUrK2eqop7fnzWS8EYlVhbdbYTMSfqPzHbt7rkUeXcujuJK2iFirmakfzXOCxVnQrlNoYPBbilpKSeuL9J1FJ1c0dTKPeklf2Zk/XW4jJDyN7kbrUs4W+5pcc/5jzTJTHmAb0pBSsWXl6nW2cVVcU5fJE4jb/tLErs41z8YpeKHdcyLVdzEHbZlQeE8NonoKCuNNl2QYYUR0+ytOx22MHODsO0969EBXUYCggDo9aWiXjfB2SqeBRx+1cuXb/z5hOJVG1NWgO9lVjpA6QlTd6BhJ55gEjErLP54DgHWHBayXSF+cSzEg3tbH6ntfE0XB5oWYskv9/OZ4LmYsdzMk3ERmrFvCtnRWstzycvrXqFgXkjeiKVHgzT1UXhSTcYdek27u9vjwKiawdIxFlNQRe+Vr5c21EjxoF9nl7V5SbFBIInByoLMiTEM3Ph4jHVyrjRiZW1bywZKS+kqpyeMrmK8neu7paJL5SOb1gXCvLEuSkR0KLslwIf8JPBkhkKOLzpZeGyNeTFOHx/CLcAWIR7l6Cy+4Ff6nsvqAquS9acY9X9YngYxwclA2EFBsw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7b4d3e-30a7-4721-8514-08d88f956643
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 09:51:50.7241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /L0gZLj8rKsQ2K7/nFANRowOv/a85EXUFKo9he5Os/QSVyTzNcScU/VeowSbR28XZmqYLlZLjHuQrcmaK51YZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7048
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

