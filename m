Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C3A26BA69
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 04:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgIPC4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 22:56:03 -0400
Received: from mail-db8eur05on2067.outbound.protection.outlook.com ([40.107.20.67]:51073
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726377AbgIPCz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:55:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOF5iRhb/x+V+XuW5eHCp8OM8pVBVm5ssnj2heaBNWqkcNPcStUefdI7p+JiO3HeJ9wZMXOk7AGx23U5oaibMz2YK2oTH16f25rtL/hR9W4ohEQmX66YfJmTNkC9/7A1a8Rj3zvx+XzQrO1WzzubgLqYL2w8J0rkPqklssckAzyeI6daaqEmjsK+HDtvVMHrmpU1v4BLCJBwfKtBTh/svuzqRNvifh17EzsRR6us9xDvVyR8T5wMmIUF39CNb2/KTcetS+aH7fmzpa4/MvDzlvKJ9KPCL9/vd0AA2OEKi3jSHbpma+XyXzYZwfyxWXn07pJejp+/AVqnIWc6mGGYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKZH0/mBvr3NUzlpnWt25MgUCsw8ZS+FS22rHg2+nd8=;
 b=B9rci/qvji7LdhJSN3o+fyZ3P+FrpZpKqj+7nFAReVDroezivDzc26w1aqHDqILZng+6EWIT35KDh/RcUSfoF3VzarJkMTzPZpTho5vr8NgTzxdiRaCv/7nQhnMAfv7q5yYL7B3eONv5qfYi8oRCWfeEb1KpNK90kc4PKNQSueZG32QOV/oK9kQqkyihsjNCOVZLaFuoLcAhr8REfQvWN2WRPYEM2EvSzGwbxUXnQ/cSvSCq1OwEeGWlI/dDEgGUOB/m44DCtPdA7YucYi5rEjapU8nweBaHQi3EpuaDd6Zzky1cRGeeYwZ134UhjhyRljnwOoOvo1oVTSMW8ho3Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKZH0/mBvr3NUzlpnWt25MgUCsw8ZS+FS22rHg2+nd8=;
 b=mROZ1hJZazZOZevZCOQvxvpXem9LFMOb7QtGsnwsGG5yoOGAF7NApDbeXGxcnstRMwBnuMyvn+gSbIjsCNfIE8jJhLgCKa1LiIiICiFwc/2pupsNtq4ruK+4DvUjOu7PT7PliXtwCAqQ2H+UrW6fop+mqyTImsFX35J4P9+Wwuc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Wed, 16 Sep
 2020 02:55:49 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::39ff:13b4:4f28:1413]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::39ff:13b4:4f28:1413%10]) with mapi id 15.20.3370.019; Wed, 16 Sep
 2020 02:55:49 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/4] ARM: imx: imx7ulp: support HSRUN mode
Date:   Wed, 16 Sep 2020 10:48:36 +0800
Message-Id: <1600224517-31465-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600224517-31465-1-git-send-email-peng.fan@nxp.com>
References: <1600224517-31465-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0165.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::21) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 10.192.242.69 (119.31.174.67) by SG2PR01CA0165.apcprd01.prod.exchangelabs.com (2603:1096:4:28::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3391.11 via Frontend Transport; Wed, 16 Sep 2020 02:55:44 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 776c5198-6a65-434e-828b-08d859ec045a
X-MS-TrafficTypeDiagnostic: DB8PR04MB7177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB71772247816041C98A8EE0DC88210@DB8PR04MB7177.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: siO4AYxvQyjRXzuY1MGRem4XrkzamYXcPVFXaMAjDb4tjUoOAJnN5RAFcOtJavG9GixIK0Ly+a9k1iL4L1G/OTjIxq1QWaSaAp+CNuXXuRlXROVS79wmIGLBa6K9VbHXQC5MOFRYRQ1ovjPDA7iCkJvJE4DdeTJTn+NDN9kXw1H3i4IVA+9fTexxUpYVQ6WpOtOfgND7AheMk0AL5w6r3yC8JLYNEg/tRm/o4hCSoW6oyPqnLh2GHL+6B4nKPcPK07DxMkvXKYtW706HgbElMhT88H7zG+PydyENr46LHH7NxBr04N7F8eipBqsBzFuhy6wgCZeEEP1q7Mkyfoj6A9+uIZTzgDvC3JcS/QhKGEuJLFIwcStgyAfdzhEJBDYO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(4326008)(8676002)(66946007)(36756003)(16576012)(316002)(86362001)(8936002)(9686003)(16526019)(186003)(5660300002)(6666004)(26005)(66476007)(66556008)(478600001)(52116002)(6486002)(2906002)(956004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 9bxrCF0AKejYeGU1JiHkniVshh4ObMvKm0bKI7OZ7FINuIpK0+pY84e++C/XDwPCIi2OOUqn3jNxixvvE7ZL2TuLUupwx/HN2BrgudI1wh0WDHNyPpeuvenQrh44fKxGWylns2oT07RjgUHsXcgNVRjwRYOw/sTFdvUkwltijW1S3h4Y3DsfjDsYvjIFtBO2QsbJ+VkV9qAidh8MqSFFAdu8fcAuuNgdHBpoBVO+QkjnHDCPgHmu2WRqOp5ZIvyIv111A8EzkndlS3i9wCoFPKbxsjS5aDQnJY4BUgrCNxKOd4cHxBTQ558m2VBHzkjlrVw0cIBALqhZbkBDDSf4nNAlToTHT58CfPm4efzvqkRNvZwgTL7uCKd47fQsuQnPJCpx8u0jxSRff1ymEehAVnzUGdIYitrvddU2tGO+kiWiAvQYSCrEnMweCEfX9nzKBU5EAeOfCzS6kOMQlDZHucac5Ti0ImwpU64NTlPL62OmfnXyj7pU3BRR0Fj1mYcVO1jRdIdQpIZ1cYAZoSLknWYdipWOBH2BP+xY6TVlViVi1tIUjQLOJ1p547lUfe7OwhHK6Wfm/cqeLN/9YgBcgJK+oGrWf/ywM90tgOSajGajgimRSMzN04S2OlHWWVnwoCfqfpvE1OB6RhSlAmpG3g==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 776c5198-6a65-434e-828b-08d859ec045a
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 02:55:49.6158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uuLySBIkdqG2sQwQhNDarJoEBnmNGd9pmzR2RVqe8AsjDkxcKFxMsei2AdVY8T1fJFXpf68Ui+dj7XxsuGLvig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Configure PMPROT to let ARM core could run into HSRUN mode.
In LDO-enabled mode, HSRUN mode is not allowed, so add a check before
configure PMPROT.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/pm-imx7ulp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-imx/pm-imx7ulp.c b/arch/arm/mach-imx/pm-imx7ulp.c
index 2e756d8191fa..393faf1e8382 100644
--- a/arch/arm/mach-imx/pm-imx7ulp.c
+++ b/arch/arm/mach-imx/pm-imx7ulp.c
@@ -11,6 +11,10 @@
 
 #include "common.h"
 
+#define PMC0_CTRL		0x28
+#define BM_CTRL_LDOEN		BIT(31)
+
+#define SMC_PMPROT		0x8
 #define SMC_PMCTRL		0x10
 #define BP_PMCTRL_PSTOPO        16
 #define PSTOPO_PSTOP3		0x3
@@ -25,7 +29,10 @@
 #define BM_PMCTRL_RUNM		(3 << BP_PMCTRL_RUNM)
 #define BM_PMCTRL_STOPM		(7 << BP_PMCTRL_STOPM)
 
+#define BM_PMPROT_AHSRUN	BIT(7)
+
 static void __iomem *smc1_base;
+static void __iomem *pmc0_base;
 
 int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode)
 {
@@ -65,5 +72,13 @@ void __init imx7ulp_pm_init(void)
 	of_node_put(np);
 	WARN_ON(!smc1_base);
 
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx7ulp-pmc0");
+	pmc0_base = of_iomap(np, 0);
+	WARN_ON(!pmc0_base);
+	of_node_put(np);
+
+	if (!(readl_relaxed(pmc0_base + PMC0_CTRL) & BM_CTRL_LDOEN))
+		writel_relaxed(BM_PMPROT_AHSRUN, smc1_base + SMC_PMPROT);
+
 	imx7ulp_set_lpm(ULP_PM_RUN);
 }
-- 
2.28.0

