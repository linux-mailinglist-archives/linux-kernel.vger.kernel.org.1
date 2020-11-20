Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255082BA71E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgKTKLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:11:39 -0500
Received: from mail-vi1eur05on2059.outbound.protection.outlook.com ([40.107.21.59]:61856
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725797AbgKTKLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:11:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsHIyIYGwgkTrUmtMYezYr9z5hb9Qasr7bJ8Oo0V6/7sc/3ptZeL4z3YSi1e536aKP326185H/XuJF8m48ZkyN7FBQ8WorIyAu66gu/riWATjqn9p2Px8NQc08AVLq66N4eJYJmwXTcMKD+/yrYNTE15oHQzf9PxDb2t3YGY+CMtM8FTk8kVT8ZbZgx2e5KN3SnZ2gs4ndVvD2JWxkU6yCRYu8N74JYLaRhzHnAvbzxA7+LAFMS6ysRnFFKZUEwJclPFifyQG0BPjwa0M529nI7fTmmBgJpWKukQwIq2KiE21QA0tjHPolJO8vf75T/s96B7TGr3APKBKDik3E8kJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NpueG1GYEh/LweyOKA2IyVxHDkhUyTD+9OsEfdGdQg=;
 b=WW393AZZi6iitSQ+B8oY5ROHGjRZfYKgEvdxfv93scaO4F/KfPbHFzhKTUTrs6awGCYm6MPN7S98I3iMXtXk44WWu8py0+vBTo59qR5eHyfAVmYJP8LaU7WNTWkgq3CRBHSD3Fmcyhd80wwBC3Hom8C035ex6EaJpOwwpz/o2GCdkeT2IEbk8IFaEkHnNEk64QGug/YaTSo1iUcaZaOyoxvNV3NnNL2Mz7ArvXl7svui9CoTmjA+9r8a9/LJBQ0dFIvxPI8mhFu2WywLEzS5ymQGQjg4iONP+nQXSvxYTYXmFZbRwqipKoHy7SRpcw2xXw+kvjhyeROjYVDuj4iVtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NpueG1GYEh/LweyOKA2IyVxHDkhUyTD+9OsEfdGdQg=;
 b=TTEnlS8k0QYzA/+UYK4QeHMeFp1MRHe/xFdWp3L9WLTCBVR98NBOyRWPY1QwWZo6nTT5CV9ILsfwclkKmoYKVLRkoJGRQvOno9kTIt9L8A8bx99eDLcfW3+Efwz93ayGvGrqRrZDKhu8BIlHENz+QvJBAt9J3l2b28MmM2XgkIE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AS8PR04MB7799.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Fri, 20 Nov
 2020 10:11:35 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::a968:d7c0:c9f8:b4db]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::a968:d7c0:c9f8:b4db%7]) with mapi id 15.20.3564.034; Fri, 20 Nov 2020
 10:11:35 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        krzk@kernel.org
Cc:     linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 4/4] soc: imx8m: change to use platform driver
Date:   Fri, 20 Nov 2020 18:11:12 +0800
Message-Id: <20201120101112.31819-4-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201120101112.31819-1-alice.guo@nxp.com>
References: <20201120101112.31819-1-alice.guo@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: AM0PR10CA0096.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::49) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by AM0PR10CA0096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21 via Frontend Transport; Fri, 20 Nov 2020 10:11:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a3186edb-4966-4529-cd1e-08d88d3ca8fb
X-MS-TrafficTypeDiagnostic: AS8PR04MB7799:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB7799637A4A6B5CA658B08DE1E2FF0@AS8PR04MB7799.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rw01iP7SvF7Yo/4NfLEAGD8Zc5WRUlgIKpZ42RnuP1FbKLkWS7OtwZBHsQEtXlQCFQ6JhHAz+X/dnWYsMx9diaI+EpEj+SwNEy8PcURxslcARvQTU90GZsv6CAzl5K5KcsgAtFuZAlbbxIwN/o14qU9az7SeZJxrm8KgOhizhBhmC9idP20mvnj1RfKx7AX5LWp9+Yb5qhkbFyGqoh/bTP6r1km9+UvPv3WAF7wXI7Jh3TwC3DVLHH8kAIAl4vjnOWT9BlWMase7amETXd5uVeIyn71PMIDlKd9ifvhWDGF2n+zkAh2/8mXzwtb10y127F9lTxjpLv3fNuy38rbDGlL0/QOWWwKT0furudUJTlVLFmf9arfLIPnVDj9fJ9p3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(2906002)(6666004)(66946007)(1076003)(5660300002)(6512007)(66556008)(52116002)(16526019)(26005)(6486002)(86362001)(186003)(66476007)(6506007)(316002)(36756003)(956004)(4326008)(478600001)(44832011)(2616005)(8676002)(8936002)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: IB9UgLmp4FVJD8KJSjSWyjnehxkBHolMTWW3yAe2Vj/HTZ4EoHgTik1IFRDVp7mVDl0kNwGsOPWwGCNqvPwsLcnV/v4biPfaom5mlOxnYiKm/ShALYFuZ+mmpqM405OHl5Q8hyIXKFpnorcdCp8fYVb71vINcHJFZeGzt6dN99xKBX4uQkOwf9Lr/14xLtX+uHUYKT3ICP49mqkZx3yd6sIIfe2c3dlL7BiG0IN9dPQin+NzIEYu/OhB+ju5X17ExGP5R6v9UIQGPyY+1cUsFNuE9IDgyOHf0V/2doAnoWptwWcQH6NL3IfyuFV7UUDet2zE5pHn7xncgwmRnX3hyYjnMk5lc8Q0bsNMsj1Hq02u5euiIdwkRrsLvLpUk7pjs+U277Wh7vD99ArbEhl8K8x7zsLhAmm5Nv1NRXJ6xAnO/3di8h76lH5zHGe45O35fBP/K+utJlymzNsxsIr505a/UFRLMhd/2JY3sgt9YeleDQxPHUeYh0bD0axTC7BVe6oJVXsoJqpEaWtWe2hUL/XaFEqUCXVB66EU+jnQJUkSn3blt//S+cJCkTIYFO8Fn1ECEp7gbIGJ+9K/EV3RkU4+Ts8WvmuP7utel84xwOENFOGvEKsZ4kXLKyN92Q5vGKO8Lfves7UZ6FHVHV2HTVu6ZHqPFP7It4WYokM/1+8SVMPt8CGLOzfuoH+9wW9n1upoDxdEPRJsRhDr+YeWkJqPqhZhQJ0H4uP8Ut1t3CDX+bdI42lcmTf/09X08mbsv0iOsEPQvLf+lEUT91Ukq1G5AoXMEFazA7q8xL5mZG14Z6/urU3sysbpMRLKn9sJckrMRWHNzA8OUPXyiz2XTibF7BoSD7r9DkWU3Lghto+F263Jv11qB1HzRtS2EuNJfaSYEqb6LOKGVB2PRxRTkg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3186edb-4966-4529-cd1e-08d88d3ca8fb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 10:11:34.9561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6Qg75d1WczAk+BrEm4qk7di4/eQeJYFOWoKhjKEOFNAhdiqi1Q3RtUfKsToJpAopTMRRBzf4RE/tgM7R8gb6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7799
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

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/soc/imx/soc-imx8m.c | 85 +++++++++++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index cc57a384d74d..1b0a34e545ae 100644
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
@@ -75,9 +77,19 @@ static u32 __init imx8mq_soc_revision(void)
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
+			return ret;
+		}
+	} else {
+		soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
+		soc_uid <<= 32;
+		soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
+	}

 	iounmap(ocotp_base);
 	of_node_put(np);
@@ -107,7 +119,7 @@ static void __init imx8mm_soc_uid(void)
 	of_node_put(np);
 }

-static u32 __init imx8mm_soc_revision(void)
+static u32 __init imx8mm_soc_revision(struct device *dev)
 {
 	struct device_node *np;
 	void __iomem *anatop_base;
@@ -125,7 +137,15 @@ static u32 __init imx8mm_soc_revision(void)
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
@@ -150,7 +170,7 @@ static const struct imx8_soc_data imx8mp_soc_data = {
 	.soc_revision = imx8mm_soc_revision,
 };

-static __maybe_unused const struct of_device_id imx8_soc_match[] = {
+static const struct of_device_id imx8_machine_match[] = {
 	{ .compatible = "fsl,imx8mq", .data = &imx8mq_soc_data, },
 	{ .compatible = "fsl,imx8mm", .data = &imx8mm_soc_data, },
 	{ .compatible = "fsl,imx8mn", .data = &imx8mn_soc_data, },
@@ -158,12 +178,20 @@ static __maybe_unused const struct of_device_id imx8_soc_match[] = {
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
@@ -182,7 +210,10 @@ static int __init imx8_soc_init(void)
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
@@ -191,8 +222,16 @@ static int __init imx8_soc_init(void)
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
@@ -230,4 +269,26 @@ static int __init imx8_soc_init(void)
 	kfree(soc_dev_attr);
 	return ret;
 }
+
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

