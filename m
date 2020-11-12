Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9C92B01CE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgKLJMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:12:23 -0500
Received: from mail-mw2nam12on2058.outbound.protection.outlook.com ([40.107.244.58]:30929
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbgKLJMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:12:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOmqvkcF8x8tmMnK9w0mqZyoUi+/1pJm8ACjjQbmOQ8Sj4dmISpVO29YxTKMSGXLvZmrUEX7fX4kSZcO/8m+E6nt76p/bRywAdryaUIiyuXENhKsNvU5cV1cb3uwUA4Cr1TNp5Dxdcla/xWB6R9bsE8ztwTx0WgTagR0gbmxwQTDfc4wgUKgIGl+iW+Or3FxlFDuwxXaaXlUOrrh4QHV9S5yrqaff3tkst4YF1vnEmgTbp9ne2FyR4cDHworAmsnhIk4Nq1uMsDOGmyOyY2SpCxYCk/9N3po21IqqbCYjjrvySdPOe7Qpj6VtnE7I7Pmp9v6D6m2NAouUOMI/y3a7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b046VNj3IhwS0BCHOptnTZEAzIOXOM9b2618hByBYNA=;
 b=Z/5WmXy3lhga6aGS/nGPp6A8DC8K5DaAhGctOrP+8iWiwzLdbny/YfUIU5HT7SjHQ0jaUTAkohQBNDFW/JGphE0AMrvMgQjUVESltdm0yLLiv6FHbIZAxqgq5MgvOyYnTVJsbNxGuu2/XIqqxAW7rEtZFqNB4Tizik1Hoz4vFeGtqMluLA1EIj7FdodSS7Ba9q0ssVLUEcL0+9UmNftGz7OoiJ7wooFczU267YJSUTHVj2CtWQ0xNjJcqdyQDWXbl91z+R6xXvD4p4xgdpS1lDHOfX8foXwFypppktQn8aKeDWQGL+a5LvvFZLLNo04G5KzivxO4UmuUfL4qx0cfcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b046VNj3IhwS0BCHOptnTZEAzIOXOM9b2618hByBYNA=;
 b=BFu+eutiJNYnfRkV7qijgKfcM9Quydsjl7dIZG7Xb+QYSYrETn+OihOQPVXzwkkXM88VQhRAFO36WQF0yYEOAAiOjqNR7C66BivLAp/BQD9ElUTilh9f5Kma1uY0EwiyGt+8RalIIFkP1jTVpZwBU7ELEBSgFBYexQtLeD0noNo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from BY5PR13MB4453.namprd13.prod.outlook.com (2603:10b6:a03:1d1::19)
 by BY5PR13MB3617.namprd13.prod.outlook.com (2603:10b6:a03:21b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.21; Thu, 12 Nov
 2020 09:12:14 +0000
Received: from BY5PR13MB4453.namprd13.prod.outlook.com
 ([fe80::2c46:9095:ba12:6513]) by BY5PR13MB4453.namprd13.prod.outlook.com
 ([fe80::2c46:9095:ba12:6513%8]) with mapi id 15.20.3564.021; Thu, 12 Nov 2020
 09:12:14 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com
Cc:     aou@eecs.berkeley.edu, Jonathan.Cameron@huawei.com, wsa@kernel.org,
        sam@ravnborg.org, sagar.kadam@sifive.com, anup@brainfault.org,
        bp@suse.de, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 2/2] RISC-V: sifive_l2_cache: Update L2 cache driver to support SiFive FU740
Date:   Thu, 12 Nov 2020 14:41:14 +0530
Message-Id: <1605172274-44916-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605172274-44916-1-git-send-email-yash.shah@sifive.com>
References: <1605172274-44916-1-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain
X-Originating-IP: [159.117.144.156]
X-ClientProxiedBy: BMXPR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::17) To BY5PR13MB4453.namprd13.prod.outlook.com
 (2603:10b6:a03:1d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by BMXPR01CA0007.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 12 Nov 2020 09:11:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 543f3f1c-2822-4bb4-c010-08d886eafcdb
X-MS-TrafficTypeDiagnostic: BY5PR13MB3617:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR13MB3617FA5ADEC38B8CC61F06DF82E70@BY5PR13MB3617.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d3paQAoMy0cS0835+P1iFiJPui5XPCFCbKcu/AQEVVGK8pDf2zKlGUxtvad1QUfujGIZNDnydedKs0K+kiiQenvKmjdZSJyrjn9k7dgtRh36kLABL77N+Y5EHWhp+uprOGjHuSMzAtfwmglswF1qbZvl7QG3pNPX9MgrPdvEk1TJxkczqCPcr2b5KmxXt/bRCaLc9uhsIFlxnHucBL1y1E2DL+S2qR/owp59FVMZEFKMgX81XNpbPC4iH+dSg/lsb9fWIo/wCl//+TvMY3p+CMqfIKBTQmdQ6ibVbnxmet9WE0w0y0joHYyieicYp/7d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR13MB4453.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(366004)(376002)(346002)(39850400004)(396003)(136003)(7416002)(8676002)(44832011)(52116002)(83380400001)(6486002)(478600001)(6512007)(8936002)(5660300002)(6666004)(36756003)(26005)(316002)(66476007)(6506007)(186003)(16526019)(15650500001)(2616005)(42882007)(956004)(83170400001)(4326008)(2906002)(66946007)(66556008)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: d1sEr2+dhgJxAPXt/qFDYi/mA1MOqwhQFva4LAH/u4yEaOwH7E0wNix2fJw3j+Qq1jmqEB+EY412IBLlTy9u2ci9YkOS9z32Ezi/B7wh2zd3E+DvpRV3lgdZFO46YS1itXbxnZPPRiz3ke7vnQDLI5/MrQyg1bqrn+eJ7BRgO20jGARYXR6xyentT6qLYaqewWrb8HrioUHgCEKK+/Go8bgyWPjgmOMJ/bddtsCKDs/DFpGkrML6oT/akVnMluV37BMdjoeHnSMqgyxldFcQJ4hlIDcQv3N8ZvnaZqkzk0bqlznf0m/JKRrU+Us4F1qcc1HnIpLpx5yyoS/ATl7Q0SCVDVLAzpZAxCjn2rVcRUjwlc8C2c8Hpu/6/RSI0uu1CYwL4vWWLG6C8AYcVwa1Zy6YsEGj1e9Q2W5xmEnhLTJCgkBzoN/wc4j0Khq+vEL0tIhieKnX4S0vBcoV2ztqW/orIpacuXmmu/CFdO3bB/Mf6nZWbcdjsVteqlb9uxA9tQTNgjqVxo3Ppi23GdAXhcF4mJBvq1QMbn19xHVcfHlt5dlZlKQpwoeqIHF8LQgtbDJEhu/xw8HPNnRP7Esei+fWk2yfM0XL5nYpyziMEfNQKI7vzFPRUtfxxy+X9XYsFaGG702r1Tlj1W184YUDfUL3PinomL3uwaqPQzE43AW+Ds/oRxP7hpCdlErbszAG/LKCRb0Y5uQLNAS0bU7nXQ0uOYOIfSqXWFQwXSVqgvXPJ8DO3w3e32aU7RQkGA1HtqTaH0Y6EAabx6RcmIKKQHeXgGQJ77sPDRyjMaphMNlxWzOzmAQgvrdBMiCLWLIiYX3ktjt2oiqJO8j4IBOR6RhgNn1X+XM6a7Vyi2sW8Q/x6uLJmriOusw2cBwfsYUL0xI7M5xV3NSyBAoQw0PDEA==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543f3f1c-2822-4bb4-c010-08d886eafcdb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR13MB4453.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2020 09:11:49.8143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBEYG7+L8yx5mFsxQ26sEZWL18psOvXPp2e1MHvVDLLxmD5+eGB+rwqsjaihWTkwp/0o/qTyn8lyq8BO/dnP3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3617
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SiFive FU740 has 4 ECC interrupt sources as compared to 3 in FU540.
Update the L2 cache controller driver to support this additional
interrupt in case of FU740-C000 chip.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 drivers/soc/sifive/sifive_l2_cache.c | 49 +++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
index 44d7e19..4e5e841 100644
--- a/drivers/soc/sifive/sifive_l2_cache.c
+++ b/drivers/soc/sifive/sifive_l2_cache.c
@@ -17,6 +17,10 @@
 #define SIFIVE_L2_DIRECCFIX_HIGH 0x104
 #define SIFIVE_L2_DIRECCFIX_COUNT 0x108
 
+#define SIFIVE_L2_DIRECCFAIL_LOW 0x120
+#define SIFIVE_L2_DIRECCFAIL_HIGH 0x124
+#define SIFIVE_L2_DIRECCFAIL_COUNT 0x128
+
 #define SIFIVE_L2_DATECCFIX_LOW 0x140
 #define SIFIVE_L2_DATECCFIX_HIGH 0x144
 #define SIFIVE_L2_DATECCFIX_COUNT 0x148
@@ -29,7 +33,7 @@
 #define SIFIVE_L2_WAYENABLE 0x08
 #define SIFIVE_L2_ECCINJECTERR 0x40
 
-#define SIFIVE_L2_MAX_ECCINTR 3
+#define SIFIVE_L2_MAX_ECCINTR 4
 
 static void __iomem *l2_base;
 static int g_irq[SIFIVE_L2_MAX_ECCINTR];
@@ -37,6 +41,7 @@ static struct riscv_cacheinfo_ops l2_cache_ops;
 
 enum {
 	DIR_CORR = 0,
+	DIR_UNCORR,
 	DATA_CORR,
 	DATA_UNCORR,
 };
@@ -93,6 +98,7 @@ static void l2_config_read(void)
 
 static const struct of_device_id sifive_l2_ids[] = {
 	{ .compatible = "sifive,fu540-c000-ccache" },
+	{ .compatible = "sifive,fu740-c000-ccache" },
 	{ /* end of table */ },
 };
 
@@ -155,6 +161,15 @@ static irqreturn_t l2_int_handler(int irq, void *device)
 		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_CE,
 					   "DirECCFix");
 	}
+	if (irq == g_irq[DIR_UNCORR]) {
+		add_h = readl(l2_base + SIFIVE_L2_DIRECCFAIL_HIGH);
+		add_l = readl(l2_base + SIFIVE_L2_DIRECCFAIL_LOW);
+		/* Reading this register clears the DirFail interrupt sig */
+		readl(l2_base + SIFIVE_L2_DIRECCFAIL_COUNT);
+		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_UE,
+					   "DirECCFail");
+		panic("L2CACHE: DirFail @ 0x%08X.%08X\n", add_h, add_l);
+	}
 	if (irq == g_irq[DATA_CORR]) {
 		add_h = readl(l2_base + SIFIVE_L2_DATECCFIX_HIGH);
 		add_l = readl(l2_base + SIFIVE_L2_DATECCFIX_LOW);
@@ -179,9 +194,9 @@ static irqreturn_t l2_int_handler(int irq, void *device)
 
 static int __init sifive_l2_init(void)
 {
+	int i, k, rc, intr_num, offset = 0;
 	struct device_node *np;
 	struct resource res;
-	int i, rc;
 
 	np = of_find_matching_node(NULL, sifive_l2_ids);
 	if (!np)
@@ -194,11 +209,33 @@ static int __init sifive_l2_init(void)
 	if (!l2_base)
 		return -ENOMEM;
 
-	for (i = 0; i < SIFIVE_L2_MAX_ECCINTR; i++) {
-		g_irq[i] = irq_of_parse_and_map(np, i);
-		rc = request_irq(g_irq[i], l2_int_handler, 0, "l2_ecc", NULL);
+	intr_num = of_property_count_u32_elems(np, "interrupts");
+	if (!intr_num) {
+		pr_err("L2CACHE: no interrupts property\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * Only FU540 have 3 interrupts. Rest all other variants have
+	 * 4 interrupts (+dirfail). Therefore offset is required to skip
+	 * 'dirfail' interrupt entry in case of FU540
+	 */
+	if (of_device_is_compatible(np, "sifive,fu540-c000-ccache"))
+		offset = 1;
+
+	g_irq[0] = irq_of_parse_and_map(np, 0);
+	rc = request_irq(g_irq[0], l2_int_handler, 0, "l2_ecc", NULL);
+	if (rc) {
+		pr_err("L2CACHE: Could not request IRQ %d\n", g_irq[0]);
+		return rc;
+	}
+
+	for (i = 1; i < intr_num; i++) {
+		k = i + offset;
+		g_irq[k] = irq_of_parse_and_map(np, i);
+		rc = request_irq(g_irq[k], l2_int_handler, 0, "l2_ecc", NULL);
 		if (rc) {
-			pr_err("L2CACHE: Could not request IRQ %d\n", g_irq[i]);
+			pr_err("L2CACHE: Could not request IRQ %d\n", g_irq[k]);
 			return rc;
 		}
 	}
-- 
2.7.4

