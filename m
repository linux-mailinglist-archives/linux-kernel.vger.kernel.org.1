Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38766304E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390386AbhA0AYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:24:15 -0500
Received: from mail-co1nam11on2084.outbound.protection.outlook.com ([40.107.220.84]:22603
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388799AbhAZRNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:13:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRS6249iFBAB8mEFUPobHGSoW5h4rYnd26eUmWFDZ98afODYJ4NXqpX123BzCcFJVCngmBqnhAdUu2ZgMBUQ2OTsgkVXB7FGbZ9WCu0DWEdtBCTMr/jl4vAzBfAByqL0569H6gX4p3MMGZ4LZEkmn2QCxV5Bna2qAIKeVTB1l5iP9kyWkRbbJMp9sf/tQybSatKOcA3PFSlA3tAdAQTAWblGWgtC5zSKuIAVVT3Sa+eKr9ICeBzn9IVBADul2oXDPrju5quZGvE7VXLpu0SKNmwZUTe01JiUBRTiARl8lTiEIYCYHHH6OWDft7oiTbqSeIJW4J+migtxRq56smdrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgXqiuO8d+ep75K/9ZSXJI4lTR6powKiHD2N5SJiTF0=;
 b=oZUXslLW25kXpHBMFrw26zQY7jG+HuUBbLdzJIV3g27CDubqChpoll9JYLcBSG3F+1xeVbEiId9B7CVgk3nh7T23Sw2xy0Lw0CHGn0s53UNLd93q6glNktkRx4xQQuoviE2ziQPeP6V4rnyT3shWRMvJZZZAjYklAtCr8pIwYpGoPhow1mCAFEeU3Q3YA4RH7poQvjFrXfoxlr5FFilQ1R9hYWb7eh6z2XLBOm/aqHWfxMNi+qazvzf5wHrNEPikqDVyolBfcE4JJ13p01cuJAFQOhKC9rc3+Z6wOmaVjIgCto7LZ3Y+gVGPSa2z2wkB+xvPFwfWHufmfY0cJDtinQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgXqiuO8d+ep75K/9ZSXJI4lTR6powKiHD2N5SJiTF0=;
 b=FHvkwdn+J3FuGbJeX+aHkzn1t4CFo93WDAkVoQ7sOolFD8T+1knNuOzg2P9N2XgnbiErYzoVwqvDupPRDqL+CqKBzj1kB0qkea37Oy+DAfXmQzyD+EIKeJfIl5jXgknxT2oJ7rR0ijiprs7GTq7MQZ4ikvh4KnWmS5SeG6IimFk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR11MB1900.namprd11.prod.outlook.com (2603:10b6:3:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Tue, 26 Jan
 2021 17:12:30 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%4]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 17:12:30 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     lizefan@huawei.com, mingo@kernel.org, tglx@linutronix.de,
        josh@joshtriplett.org, yury.norov@gmail.com, peterz@infradead.org,
        paulmck@kernel.org, fweisbec@gmail.com, linux@rasmusvillemoes.dk,
        andriy.shevchenko@linux.intel.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3/8] lib: bitmap: fold nbits into region struct
Date:   Tue, 26 Jan 2021 12:11:36 -0500
Message-Id: <20210126171141.122639-4-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126171141.122639-1-paul.gortmaker@windriver.com>
References: <20210126171141.122639-1-paul.gortmaker@windriver.com>
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::15) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-pgortmak-lx2.corp.ad.wrs.com (128.224.252.2) by YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 26 Jan 2021 17:12:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84d66217-de98-4a41-5a60-08d8c21d9008
X-MS-TrafficTypeDiagnostic: DM5PR11MB1900:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR11MB19009A26FE4C26229DEFD13383BC9@DM5PR11MB1900.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uT2A3e0s73EjhOUe2ZI01KQAsARLdanS/sklviVQxq5RK70qdT+f8o7LtD6oPAAK6dOnn1DCOpms9MFJ6ZnF40lNUyNfikt/YRcO69XNZ49oJ+MQa1f4BS6t8WCQMA/uuJok+iHsTK9VUpNyJ+c5LXgkZw5lm0c93AWUOoO9gM3T1T5+qzgF4sVX/svNZmR4o6Oa1uLCkT5KFVFl92GCjrykHCaN+qCAaMhKLwnSotxbOsW2VXPb2BfgnKiC/a8ziXUVM8DBThdmm1g2oVci5D3FDEaxI7DPET2pODn1kc01zZxwquPpbSL9QYeyhIix4meBSB/C0bjNON5biRWPxhq0XjlY86kamCK5Spbm/IuxaVru5yx4rcO/euOaPWGVgLgp5SO0ydD95taBa2r7Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39850400004)(366004)(136003)(346002)(6506007)(6486002)(83380400001)(2906002)(66476007)(8936002)(16526019)(5660300002)(4326008)(36756003)(52116002)(956004)(6916009)(44832011)(2616005)(7416002)(66946007)(26005)(316002)(8676002)(186003)(86362001)(6666004)(6512007)(107886003)(66556008)(1076003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fEJuRmzyMkfh4ODhulRU8IyM4He0rYU1hETUnSfUBaI1vVWL1EqzRz3mm37I?=
 =?us-ascii?Q?sEcldj37ht+BYNFXKuLUFphpeZnD8MsTmzryPcuC/T6bG9upFsa/ccNRUQQ6?=
 =?us-ascii?Q?IDKpe5fI6i1k9QzOQba4M+LfgwxSpa/CczdPGEV0spu2vJZbIuhNbBTC3nQE?=
 =?us-ascii?Q?OsYgmWVmOTgZDQ8/nQv1ywWz4iSzT4BsLHRFAhRlhIhk6acbYkLczX+7nEfl?=
 =?us-ascii?Q?fl5RvqBk/m2yw2elILsmIMhEABJzLK1bjb2LlS7fi1GsVsd8WSlU3QcNo5mF?=
 =?us-ascii?Q?pFVR9q9T2CWOyQomB8M9698VWCgi4Cy1z7xoCdFcDl5AjwPMdDOlTSXiIYLX?=
 =?us-ascii?Q?A0w3VltBzfjxBr/Ob4aiv14MDGNARzN3N3UDxbbJ8YsBhCyEp8WWB8PMkpmt?=
 =?us-ascii?Q?gEhEVa6SO8NIL7wigsYlnDrdfAomjSx+/jjuUWARIkTsrvpUoRcz/wuaIRhs?=
 =?us-ascii?Q?1uWoq/QPEr5RnMjI6/+YAzEw4rUzj9j5xmoavq5OKieM3pUj1zLQ02Y9LHFW?=
 =?us-ascii?Q?795RWFhc0Lxjt2Wb376j7aX/UBT5XrTBsGX3wKpGbhadebfIDAHGk1aoA+v2?=
 =?us-ascii?Q?AMw4oWvIEFjBn39qlseQ5jEVDSraQZsK+JBixX280tJTECSLLJGjsCzowdEW?=
 =?us-ascii?Q?xXLNPSOXnQvGeXVG93D4qsDPR/ujFIPadWacj75jLdaP3J5dRYik+JAjGr4x?=
 =?us-ascii?Q?U4qqLvJXfinjj6kKyB7AyrMu0ZTRoK9p25R1H88IfKVTopsHC5uRpQ4X1D0D?=
 =?us-ascii?Q?QUc9IBfxqEo3zfe2UlipamVqfHJ97Vx0Nb3/DPrSFQoBFxK+89AG5OgTPHNn?=
 =?us-ascii?Q?/WDiV0Y4GxuVlef0LLqXm+LEJGubRlH2aWdlhMJ4o9F2j+lXrDNoaKGj5pAi?=
 =?us-ascii?Q?psuDG5Vcy7c0CjX9M3txtiS9+3w4qHtrhn9rkl/lZ9wssS8zVDElroMHbhp/?=
 =?us-ascii?Q?EW4jjw/Z43KvmHulKPVXIa+tnvi82fqXKAq0FGbQT7SyKBbwJlhWcnxSfT5s?=
 =?us-ascii?Q?SFvJqIj4zc64xUjrVFirMgdx04z/ODCGhSrE+zqAgjior7rA0h5U980i7VH/?=
 =?us-ascii?Q?ONeAWRD3?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d66217-de98-4a41-5a60-08d8c21d9008
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 17:12:30.1043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8mNHh4XRFNyOXsdyGYZSWpUCcuE/sCgS0/M6kma6IH56TUC9+IK11tJbcWgtCwy2p7r6F9Gaxs9GNccKLAmL5Fz25Xm7filPYFmSITG7P4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1900
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will reduce parameter passing and enable using nbits as part
of future dynamic region parameter parsing.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 lib/bitmap.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 75006c4036e9..162e2850c622 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -487,24 +487,24 @@ EXPORT_SYMBOL(bitmap_print_to_pagebuf);
 
 /*
  * Region 9-38:4/10 describes the following bitmap structure:
- * 0	   9  12    18			38
- * .........****......****......****......
- *	    ^  ^     ^			 ^
- *      start  off   group_len	       end
+ * 0	   9  12    18			38	     N
+ * .........****......****......****..................
+ *	    ^  ^     ^			 ^	     ^
+ *      start  off   group_len	       end	 nbits
  */
 struct region {
 	unsigned int start;
 	unsigned int off;
 	unsigned int group_len;
 	unsigned int end;
+	unsigned int nbits;
 };
 
-static int bitmap_set_region(const struct region *r,
-				unsigned long *bitmap, int nbits)
+static int bitmap_set_region(const struct region *r, unsigned long *bitmap)
 {
 	unsigned int start;
 
-	if (r->end >= nbits)
+	if (r->end >= r->nbits)
 		return -ERANGE;
 
 	for (start = r->start; start <= r->end; start += r->group_len)
@@ -640,7 +640,8 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
 	struct region r;
 	long ret;
 
-	bitmap_zero(maskp, nmaskbits);
+	r.nbits = nmaskbits;
+	bitmap_zero(maskp, r.nbits);
 
 	while (buf) {
 		buf = bitmap_find_region(buf);
@@ -655,7 +656,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
 		if (ret)
 			return ret;
 
-		ret = bitmap_set_region(&r, maskp, nmaskbits);
+		ret = bitmap_set_region(&r, maskp);
 		if (ret)
 			return ret;
 	}
-- 
2.17.1

