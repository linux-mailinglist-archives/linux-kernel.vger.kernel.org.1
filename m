Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578872B19CB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgKMLPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:15:12 -0500
Received: from mail-eopbgr10088.outbound.protection.outlook.com ([40.107.1.88]:56293
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726619AbgKMLF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:05:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnEf0DDAGIndAst9vd5CMQAI1hIPGA9qU6a7iLPvVRc21+d9cOzsQIChwV0fsnL5MA2blIOEw5PXHWJL3o7m8vthfJuPZAFFoO9DodF5vAzgVe+WoSAg/1stybbT7aWuQM2KGkN7Tddrd4kIS+GMM5p0hwnzli9n+kgBVjANsLk0nx0sp4/Mii2NGH4BYK3kH1dRnphhvLMDxZoa0FQhWPP/16RA4Qbr0d+xmiTlJn6udnwFmLBNBg/rnmdpg84mAKFBLfIhDkb9DLWvh19u/wH6F+gr4nZmCkOnHBhnfTw+ShOWq4B/3p6x1r556zRxB5BFPw3qzBjf/lUKb4FSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Jb282RrjJoppsIFcnPv5605ItICZ2v3cjmDkA2j69o=;
 b=Mdl6i9f0BkWiMo5C1f1j75gQsKfiTga/dNX7TuvQvYZou+JAwSzGUQdaetR4Lz6vDxPnek/t3CE1dNQesIWlLbMVv+aIpDloKoK75MhHn6ZcpdomZpWKOv6SHjxjmm6cdnnAEFWKc3PrvodSyZkqXVelfaOabgPX00Crpiw6biQFS6S8+XGfFIEiXHZdT8jcbHLaaDSvm+Tt8q6qCpkDZtT51hQGxfL40j5MiUfBpV0OyMfyeokFcbsVxFNY0kTvW5St7xLXz/Lbyz8YdgZac7ew5QmOGkl6fMvoF9ECCzldBypGVIkQtjJN9+IxQASpcPW6p0vjI+8AUCjzOaFPeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Jb282RrjJoppsIFcnPv5605ItICZ2v3cjmDkA2j69o=;
 b=dS2xCrQl5sdgoFxKoZQNkomd+dO44kCZyyIv1r2MfkT6DTu8ZlXYz3L47wz1qDFZDkn3rmlo/J+wnY81ARdHAGS7QBfPJ214IsBteeR/NtB2U5nLjU5QZEeU7z182u5xVrVKqInaWlMCeKT12wrjFtbfttJFGQGxlHjohF8FKKQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB7071.eurprd04.prod.outlook.com (2603:10a6:800:128::8)
 by VE1PR04MB7279.eurprd04.prod.outlook.com (2603:10a6:800:1a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 11:04:33 +0000
Received: from VI1PR04MB7071.eurprd04.prod.outlook.com
 ([fe80::1de8:9a84:bb92:f944]) by VI1PR04MB7071.eurprd04.prod.outlook.com
 ([fe80::1de8:9a84:bb92:f944%7]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 11:04:33 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        krzk@kernel.org
Cc:     linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/4] soc: imx8m: change to use platform driver
Date:   Fri, 13 Nov 2020 19:04:09 +0800
Message-Id: <20201113110409.13546-4-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201113110409.13546-1-alice.guo@nxp.com>
References: <20201113110409.13546-1-alice.guo@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: AM0PR07CA0018.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::31) To VI1PR04MB7071.eurprd04.prod.outlook.com
 (2603:10a6:800:128::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by AM0PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:208:ac::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.15 via Frontend Transport; Fri, 13 Nov 2020 11:04:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4c192b14-b924-4a65-b2bf-08d887c3e6a6
X-MS-TrafficTypeDiagnostic: VE1PR04MB7279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB7279C305BB903392E73FD3AEE2E60@VE1PR04MB7279.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n79MTc/lER/AMxoHPEemeunMrk/0iHSAWITgFf1gAWIGNDShXYuFOx3C7mxRS+Fxn/aEwSA04Y4/7EtGBQ5qInkHWsXCb/6fBvzuMZ1/mcTOgD0sWX58ereq2tdKBIpgL9XVjyxaYyyS7kqg+HQbcCL+B6BuuuC1MxiQriTt2kSHqfGo348y2CGzKwJI2sTlEwmaZ6pLKo5XVL7R4iRnY0djNTnTu5mjuKfg4+EVaDxi5EsU/1nP3Eo80Ddr6syGga7tswpZQoJohl5BAMkuqNDYgKhIMwzBeAguDFhQCCO+Q6UH3eN3NYrwlk5u2QGW2r8GUgJpqQuwyKN5wiWcKv1PB26+/KwDQgX9tL+CgXq1Q/51sldQqlZxio2kloub
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(66476007)(956004)(478600001)(86362001)(66556008)(6486002)(186003)(16526019)(6512007)(1076003)(66946007)(36756003)(2616005)(83380400001)(2906002)(316002)(44832011)(26005)(8936002)(8676002)(5660300002)(4326008)(52116002)(6506007)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: P0vWY/XkuM+1lJfRIJSmT/ecF7a1mK3+jshKWHCnt7XyrMZur0LAkeFE0TfrGDSKIPezlPVBhipiBeIxId6qMNDfyRlN2/l6peW0+YRgVGg6mg2vAMzytCDEhfbxlpaN4tA9HP57ubKpMv1EGfDGNYC6nR1ThSB7aEfYHYPiyFgoiCsW2VtZ1HPDvmKMlRYy75ZFx/sWLiEOPrY3hixud8QWVIrntZjW27GtVLzGjLqIoQIFXfxWwSlJ32JJvO9srBaxM6BW0hBXe9rd55h9bLqi4WxsKBuGnZDEFo2xcJA0QCkzCeFCPoaFmrv/IqW5FKtI56ddiKkFWRYmzQs2N2xPODb9t/P1fSkg7Su3dq8o/FJz4oEti4fqVChc1nKH2+bGP5M0Gh3CqvpTm9+hhuX71RmuTXyhaphj4X75SvN1vxzu2og20+bX/N9fLE/CQbu2wJYzk4rTioECa/kqrLw+Fwy3Kiicy+vP12knUrKLz2fD7ciNnA/1yIIELzpSpTXYdISgKfbh4R1i3nsFlkApT2hCSBtmh5N14moJtFp2aF5BXorKMppHPdsa0/h6py4NbjgMGFC3Z628N3SujITp516Uy5e0nio0iOhUEzceS4sN5J9moeCEJ1z8IsBJDte4pdFrMJMu6h+XJX1DpLOdtjGtQej493WSrpHQz4fROnqZdlgb9YPEI/l7/kz8duFq7UwjtGW8aY6INA3vHeILRFftVqrGYXolLeeRR9rUKHkoVfr7CqhJUmUIFKjpvuzWN3PMtE+VjnWI4CzJILcb57q1hLf9+LKThjfqbUcV4RL5TaSpOm/imagHBiz26A4i1dteVzeHZC3GPQhHY3PzroziRRUfuY5Ee1PreJ2BLTN2loXVu7uEFlIrKQFgPSbKo4IxErUG1/SzbQWTcQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c192b14-b924-4a65-b2bf-08d887c3e6a6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 11:04:33.4625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQBI4YiaeM350Qcl0Ks8932+5ZVAwfejTE4H7wc4KYIyXCDX0487hxJuMXmA0V7cjQu3gsOwReXOcS5Rl1qfSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7279
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

Old .dts files can also work.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/soc/imx/soc-imx8m.c | 89 ++++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index cc57a384d74d..af2c0dbe8291 100644
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
+	u32 (*soc_revision)(struct device *dev, int flag);
 };

 static u64 soc_uid;
@@ -50,7 +52,7 @@ static u32 imx8mq_soc_revision_from_atf(void)
 static inline u32 imx8mq_soc_revision_from_atf(void) { return 0; };
 #endif

-static u32 __init imx8mq_soc_revision(void)
+static u32 __init imx8mq_soc_revision(struct device *dev, int flag)
 {
 	struct device_node *np;
 	void __iomem *ocotp_base;
@@ -75,9 +77,17 @@ static u32 __init imx8mq_soc_revision(void)
 			rev = REV_B1;
 	}

-	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
-	soc_uid <<= 32;
-	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
+	if (flag) {
+		int ret = 0;
+
+		ret = nvmem_cell_read_u64(dev, "soc_unique_id", &soc_uid);
+		if (ret)
+			return ret;
+	} else {
+		soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
+		soc_uid <<= 32;
+		soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
+	}

 	iounmap(ocotp_base);
 	of_node_put(np);
@@ -107,7 +117,7 @@ static void __init imx8mm_soc_uid(void)
 	of_node_put(np);
 }

-static u32 __init imx8mm_soc_revision(void)
+static u32 __init imx8mm_soc_revision(struct device *dev, int flag)
 {
 	struct device_node *np;
 	void __iomem *anatop_base;
@@ -125,7 +135,15 @@ static u32 __init imx8mm_soc_revision(void)
 	iounmap(anatop_base);
 	of_node_put(np);

-	imx8mm_soc_uid();
+	if (flag) {
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
@@ -158,12 +176,21 @@ static __maybe_unused const struct of_device_id imx8_soc_match[] = {
 	{ }
 };

+static __maybe_unused const struct of_device_id imx8m_soc_match[] = {
+	{ .compatible = "fsl,imx8mq-soc", .data = &imx8mq_soc_data, },
+	{ .compatible = "fsl,imx8mm-soc", .data = &imx8mm_soc_data, },
+	{ .compatible = "fsl,imx8mn-soc", .data = &imx8mn_soc_data, },
+	{ .compatible = "fsl,imx8mp-soc", .data = &imx8mp_soc_data, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, imx8m_soc_match);
+
 #define imx8_revision(soc_rev) \
 	soc_rev ? \
 	kasprintf(GFP_KERNEL, "%d.%d", (soc_rev >> 4) & 0xf,  soc_rev & 0xf) : \
 	"unknown"

-static int __init imx8_soc_init(void)
+static int imx8_soc_init_flag(struct platform_device *pdev, int flag)
 {
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
@@ -182,7 +209,10 @@ static int __init imx8_soc_init(void)
 	if (ret)
 		goto free_soc;

-	id = of_match_node(imx8_soc_match, of_root);
+	if (flag)
+		id = of_match_node(imx8m_soc_match, pdev->dev.of_node);
+	else
+		id = of_match_node(imx8_soc_match, of_root);
 	if (!id) {
 		ret = -ENODEV;
 		goto free_soc;
@@ -192,7 +222,13 @@ static int __init imx8_soc_init(void)
 	if (data) {
 		soc_dev_attr->soc_id = data->name;
 		if (data->soc_revision)
-			soc_rev = data->soc_revision();
+			soc_rev = data->soc_revision(&pdev->dev, flag);
+
+		if (flag) {
+			ret = soc_rev;
+			if (ret < 0)
+				goto free_soc;
+		}
 	}

 	soc_dev_attr->revision = imx8_revision(soc_rev);
@@ -230,4 +266,37 @@ static int __init imx8_soc_init(void)
 	kfree(soc_dev_attr);
 	return ret;
 }
+
+static int __init imx8_soc_init(void)
+{
+	int ret = 0, flag = 0;
+
+	if (of_find_compatible_node(NULL, NULL, "fsl,imx8mm-soc") ||
+	    of_find_compatible_node(NULL, NULL, "fsl,imx8mn-soc") ||
+	    of_find_compatible_node(NULL, NULL, "fsl,imx8mp-soc") ||
+	    of_find_compatible_node(NULL, NULL, "fsl,imx8mq-soc"))
+		return 0;
+
+	ret = imx8_soc_init_flag(NULL, flag);
+	return ret;
+}
 device_initcall(imx8_soc_init);
+
+static int imx8_soc_init_probe(struct platform_device *pdev)
+{
+	int ret = 0, flag = 1;
+
+	ret = imx8_soc_init_flag(pdev, flag);
+	return ret;
+}
+
+static struct platform_driver imx8_soc_init_driver = {
+	.probe = imx8_soc_init_probe,
+	.driver = {
+		.name = "imx8_soc_init",
+		.of_match_table = of_match_ptr(imx8m_soc_match),
+	},
+};
+
+module_platform_driver(imx8_soc_init_driver);
+MODULE_LICENSE("GPL v2");
--
2.17.1

