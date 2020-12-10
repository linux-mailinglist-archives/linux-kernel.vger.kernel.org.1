Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2567B2D583B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 11:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbgLJK3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 05:29:46 -0500
Received: from mail-dm6nam12on2042.outbound.protection.outlook.com ([40.107.243.42]:40641
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729974AbgLJK3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 05:29:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuGOKvfIqg8wATxYUrdzjOpdXsSucj0gZpB+1rOJoPhT2JogcLpPpoM/s2783qE+eNGwmy5QEphYTZZKKdbjct/iZOh58MVuP/kQ9cGGx2UvO3lMN8icApoinhRYHJ/9vQ8PjmHCyx5K4xwMb5pX2IZdpPvSP+o6CTqtpwTd8oAOTv9Fns8vhutg4yy0xtQ+FPNNSc37EuWyFHMiSMJEQGmKb2Rv11gf6MkvdxE1y6IHcxPvMn480n2jDRLoHXFK/ThUeKqkOGJpiV2G5jE2NoUGKJZ4aJGXfMtET2s+Gi4QFhE+YZDqxoS/4cYnkJbddrzTbtx+XFaAb2KTLv9g1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+G73yeJi5CqkoOSQ0F00zuXL1qkQhjPSyv3ujMlpJ80=;
 b=IvdaNyq7+xrtN5iXAM8EU+N9M8MJcMIHdSRNUInBcInrARq/vkoXL7b6lJf/DfcBc7Fn/UGosUd+g6hWMTp9u9ABdeG4DyMfBewOW5ZAVBHITAY1frHtQPbtkf8V28Bh/XH4SghpEThypaQL7ywgxSo7E6qabOLVS/tVB9ONGHgMnoJqARvWT0EdFKEIBdl2Pcp7e3uMTKc9NTAsT+LP8i+5g0DEPwrGfv50TRgdtckGN197apbISkgaPkI5SA+heY25pnBiC6I429GoaqUzxbQr3gEKieUcsqqvvoUXJOdfuDHfb9zf77ApgM4+8UfnnfTHUMrPIysv7SCKGtCU+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+G73yeJi5CqkoOSQ0F00zuXL1qkQhjPSyv3ujMlpJ80=;
 b=dtDVeIEJu9M24E+gTi4vuSSKUQx9toyxrKMH5DP3Vb+FptQ5DsQ6AZ6iqfT6eVwLQotYpujx1nWTtA2T95Wvi2i+1CY+CQpStQ7JhUjRC8jwYcWvkLYOk4QTzfGyAdDj5iRX7Sn20TlicXg3bl/2obnYSne7PB87nEwiDQh/LP8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from BY5PR13MB4453.namprd13.prod.outlook.com (2603:10b6:a03:1d1::19)
 by BYAPR13MB2838.namprd13.prod.outlook.com (2603:10b6:a03:fe::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.11; Thu, 10 Dec
 2020 10:28:31 +0000
Received: from BY5PR13MB4453.namprd13.prod.outlook.com
 ([fe80::7c13:1ac6:9f2a:5eae]) by BY5PR13MB4453.namprd13.prod.outlook.com
 ([fe80::7c13:1ac6:9f2a:5eae%8]) with mapi id 15.20.3654.015; Thu, 10 Dec 2020
 10:28:31 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     bp@suse.de, anup@brainfault.org, Jonathan.Cameron@huawei.com,
        wsa@kernel.org, sam@ravnborg.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        sagar.kadam@sifive.com, sachin.ghadi@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v3 2/2] RISC-V: sifive_l2_cache: Update L2 cache driver to support SiFive FU740
Date:   Thu, 10 Dec 2020 15:58:03 +0530
Message-Id: <1607596083-81480-3-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607596083-81480-1-git-send-email-yash.shah@sifive.com>
References: <1607596083-81480-1-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain
X-Originating-IP: [159.117.144.156]
X-ClientProxiedBy: CH0PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:610:b1::20) To BY5PR13MB4453.namprd13.prod.outlook.com
 (2603:10b6:a03:1d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by CH0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:610:b1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.9 via Frontend Transport; Thu, 10 Dec 2020 10:28:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a98b503a-bbec-433b-ca12-08d89cf6574c
X-MS-TrafficTypeDiagnostic: BYAPR13MB2838:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR13MB28385929B2485C00EF38120282CB0@BYAPR13MB2838.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zm2vimluL97kcDT5a+8L+ToIAx6cYUiHqhMosmtcEwywx27m0NjHo4C1Hg3zQ/CqRf9Ta274fWKDTtHNRcnkqfjgB51o8556Sqj6XkEF/v5mA2FWnJHuhcS294HXCuss4pMMMrZXTPqu7Pr5dUqv1oQQiKcy8vpS80HETQDrLoVwS4Vq3Gfp8/K+9ak0xyiVN0xBMmyNSS4FG7PYNYinO9IagsQlZKVVb+HRdGYXe95SBajgHl9v4rloNaMXGeB7E/5Jb/LEPbh4zc/dAcDOzZoXlej3YJsHQwmyjt3yWpwewDwV+01TK+xTih+xTLtx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR13MB4453.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(376002)(366004)(136003)(346002)(15650500001)(7416002)(508600001)(26005)(8676002)(36756003)(4326008)(956004)(66476007)(2616005)(42882007)(66556008)(107886003)(44832011)(8936002)(16526019)(186003)(66946007)(83170400001)(83380400001)(6486002)(52116002)(2906002)(6666004)(5660300002)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tziQNxKmoBzJCe05mQ8XXuYwFXPA2aFsnWEfSeR9ydHXQjNQdfg/aevCttSa?=
 =?us-ascii?Q?Pxv9HT7tK0MuEeqlfJwZ05jeoRBkg3bofWl9sfLPXEpJeQ7mclfCXaYFHPwj?=
 =?us-ascii?Q?Wywrc6+wrGATliXVAh9F0Ew2zyTG4+Ael/lAuEkDmojOE/Wo5Q9EPjn3eg1P?=
 =?us-ascii?Q?sp3U5tdrjLRdhFB5p7r0KHmE6TL+hOeJIFi3v2g5VxKAw+5M9AqKgWoLdU9e?=
 =?us-ascii?Q?tgsk6ZYjTD0Wxsidax/bZ9XLgTkpYyxtu1YtLxbAuGClXkufU+Q/tafVCaSo?=
 =?us-ascii?Q?0jBOhxiyD6IjMFGinSTY3fPdHn7Tvj7Q3+M93a7dF6aSxaKVb/vSz/Rdw0bo?=
 =?us-ascii?Q?0frQ6z+W+/Cxqo8u+grwm860bD3WXqcFDyeU71uEzE+d1lpSxp+Lk8QAcdjN?=
 =?us-ascii?Q?bQ6kQliHfDGpEIrqZGCpbXq/UzaI5GAqsvU0jLbYWxdjKuImXbDyxL2eIJNE?=
 =?us-ascii?Q?dgo1Xqb5BkLZjcDbsOdmodG4oif00u1zfHF8S8f2+hCaW4150tioB/Ecoi86?=
 =?us-ascii?Q?AJ26BPuNvllfFFFE6u5qcZJUPz9RdphT+EelkT4MEgpOgAWYJccL0aH7CNkt?=
 =?us-ascii?Q?Q1TVvzcxcjdclaaVTCakI8rIOU54KGlpZlhKQVqIeAHPF9V1SLYwQ20vME8w?=
 =?us-ascii?Q?GcBBfmBsgBcQHnI4P9m6pdcAd6/B9k9SkzF+uKMNrWNtV4e5ECX+RI/P4kl5?=
 =?us-ascii?Q?bsKCGBhcpib0tIEAMorSfSVnJwpoBXrS9UGj0H5rjXmmf7uPxxKn9NPCSL/L?=
 =?us-ascii?Q?5EfMt0ZVlaY9M3g+7h9TKIZmmjKByQDx4lq/pOsKGdgfxUyIe4fDv14h3Ll5?=
 =?us-ascii?Q?54SjrUcmLgDJ2cKWy6Ew4naaPKjzDSdU32PZ4SKfjvBut8FmsWfqnr02cQeT?=
 =?us-ascii?Q?iIumIS5BQSOcI/+ww6zYVLhNv2+cnlz04MAEH+tMWWuFoy9U9LTugRAZQFrq?=
 =?us-ascii?Q?kalrIUHm3JJVlv1QPFUOpcu6BR38Wycx7PTlpWU8/TCJSoGbyf9LSaFMty+0?=
 =?us-ascii?Q?xPcs?=
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-AuthSource: BY5PR13MB4453.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 10:28:31.1989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-Network-Message-Id: a98b503a-bbec-433b-ca12-08d89cf6574c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRcIDmfGU/S2i3jRkFnLFRS/14lg4zJbIwXbBGM1xaqGufonXqTaKqoJyxzNS5GBrqfw2Kb8AB7A3MnhdpA7cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2838
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SiFive FU740 has 4 ECC interrupt sources as compared to 3 in FU540.
Update the L2 cache controller driver to support this additional
interrupt in case of FU740-C000 chip.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 drivers/soc/sifive/sifive_l2_cache.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
index 44d7e19..59640a1 100644
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
@@ -39,6 +43,7 @@ enum {
 	DIR_CORR = 0,
 	DATA_CORR,
 	DATA_UNCORR,
+	DIR_UNCORR,
 };
 
 #ifdef CONFIG_DEBUG_FS
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
@@ -181,7 +196,7 @@ static int __init sifive_l2_init(void)
 {
 	struct device_node *np;
 	struct resource res;
-	int i, rc;
+	int i, rc, intr_num;
 
 	np = of_find_matching_node(NULL, sifive_l2_ids);
 	if (!np)
@@ -194,7 +209,13 @@ static int __init sifive_l2_init(void)
 	if (!l2_base)
 		return -ENOMEM;
 
-	for (i = 0; i < SIFIVE_L2_MAX_ECCINTR; i++) {
+	intr_num = of_property_count_u32_elems(np, "interrupts");
+	if (!intr_num) {
+		pr_err("L2CACHE: no interrupts property\n");
+		return -ENODEV;
+	}
+
+	for (i = 0; i < intr_num; i++) {
 		g_irq[i] = irq_of_parse_and_map(np, i);
 		rc = request_irq(g_irq[i], l2_int_handler, 0, "l2_ecc", NULL);
 		if (rc) {
-- 
2.7.4

