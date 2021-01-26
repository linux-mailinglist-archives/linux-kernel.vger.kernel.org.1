Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84752304E52
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390596AbhA0AZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:25:39 -0500
Received: from mail-mw2nam10on2073.outbound.protection.outlook.com ([40.107.94.73]:29950
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389488AbhAZRO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:14:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/47S7Ij2Qs4nYceN9SyYFjMMsdTJey1X2SSK6Ic9YgMB6ObISgXPy6S7ZX/uWYrq6ir/BEkdE4Qld6V2LGBXYjUP+Bsbp9cuaBEbJbfbTgv284g7m27qgKMdBO7TFo09JIMevVYyafkCASMClwAjQNcX3iFdFpVTOLqtxNqAna0bHzEcVxVyhV/HQZkBj8G61Z1wi90R3RtBuUqTSQjpBwtoN1/MvRXm1cydA20wHc7pOhyETP73rx0k63o4d0430NwuxgCCSkrPzTET1zEPQs18A+LoRHCnQy+m6lm/I6AVdgFuJwiPOtAzgFE3obIbTfRhrlneq+yB4zI7Rg1Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQx0qfBMM8wHufBhLjaxO9g+Y7BPmtFd3G/un0lX1tc=;
 b=f6DT69K6ORoVumLJAOqcrrtrNLC38F1KeWecofblW0aBYxJTuKp0DwHgCQQ7Q0vBQZ+0aG3GNyvEWfmadrY/SBtEP8lmSULuZNsN07JdI5/SsN3XeetRPZrgsoAK/xiwVAb15pMXFENGvjVKd3EPBkZ4U6CuYBcV840Jqm6NKbueKBdqQOdpchOfgKRTOgWEmTU+FTkBdFNcyBsJaKHoSA4frrO5GhI7LYEQLrVtky1awgaxkj4neIodPhjPnZQOnex1LR8593SiInvwsKIFq+ifs8By5voKPs+jAlbTOXGD1+xrI7hTLcosnCO12aB4dyC2rgK0S56xuv3uW+LqWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQx0qfBMM8wHufBhLjaxO9g+Y7BPmtFd3G/un0lX1tc=;
 b=E40WFXeGgixPbmGU0gACZZRlJZ/YZV3HgCxBsa3NsAkNpMsp+lB0vcEutaCYtgktwv2uetu0ru7c5YbweysDXcEaSCPiuswvAQE7/adB1sGKab4iHFsZbcgfBza9hAdb+KGlPP5FPYvEVDQJIbUCvo66cIk71x9dfIbvzZBx1Q4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR11MB1900.namprd11.prod.outlook.com (2603:10b6:3:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Tue, 26 Jan
 2021 17:12:33 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%4]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 17:12:33 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     lizefan@huawei.com, mingo@kernel.org, tglx@linutronix.de,
        josh@joshtriplett.org, yury.norov@gmail.com, peterz@infradead.org,
        paulmck@kernel.org, fweisbec@gmail.com, linux@rasmusvillemoes.dk,
        andriy.shevchenko@linux.intel.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 6/8] lib: bitmap: support "N" as an alias for size of bitmap
Date:   Tue, 26 Jan 2021 12:11:39 -0500
Message-Id: <20210126171141.122639-7-paul.gortmaker@windriver.com>
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
Received: from yow-pgortmak-lx2.corp.ad.wrs.com (128.224.252.2) by YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 26 Jan 2021 17:12:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 713cb274-0868-4c79-0973-08d8c21d9219
X-MS-TrafficTypeDiagnostic: DM5PR11MB1900:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR11MB1900C07B4F1B9ED9B54B583B83BC9@DM5PR11MB1900.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c+wJk6B3sNrw+ZFADkMHUG6LArEhukfBmn17LW9QX62QovyZdnpmWFKjCyv95pMcaWY43TIKCz9JyKa6sSPlFGa8p32xyoQea30wX2axU4AyM0YhYau67dH2ZabmTvReH/HbTSlcASnM990EoB/aNiKiA94AfJvqHakUqtvsV2elVlxIXmDeOS+/Q9mQcu+5KqH/d43eJLevj32FnuFCD+306PFO9Nes5yq81GJS+PiL8xoH5mX2drObBgdiFeTe3WOqe7p2Ln7fz7h5wd7ezytUDoj8ySYiFpFSJUtm8PJOY4jzkR/ZGRgHnzQaaCqmLPU5wbCT44MUzcp0nA7oC6TQb8wTgET9T2piIo5Ce1stKEkz4zDKRrIjfSfhtdyd7WWqoxxNV+tm0XrQB1uZQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39850400004)(366004)(136003)(346002)(6506007)(6486002)(83380400001)(2906002)(66476007)(8936002)(16526019)(5660300002)(4326008)(36756003)(52116002)(956004)(6916009)(44832011)(2616005)(7416002)(66946007)(26005)(316002)(8676002)(186003)(86362001)(6512007)(107886003)(66556008)(1076003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3zDGUiu9ZmQq8dvxip/o1HQGOiDBj2aun7uPldE1X0ELUZr5DO37ikcZirTT?=
 =?us-ascii?Q?m67XNlWTkHfyTzoeF8agK0Aov7tl2eFqi9/bbUhRfoRNHLlw5KKxleZJ1s7o?=
 =?us-ascii?Q?RjHTC1hCr/Nmt/vOBRN/+iRMa/lLgumP3XPiO59gvjSRVer7onVvNa54VPye?=
 =?us-ascii?Q?rn7tZawqQr+v/jkPdfxSd2HXln6237vgl68iaAylfASa0P8wT/M3hqhj4DPL?=
 =?us-ascii?Q?6Xi2czKYvBp/9fiWVngEety9+0esT+lg9en7QrjyFt77beRYP97EjuWs72mH?=
 =?us-ascii?Q?IS1dFpT3WuaDO/xJ8BMckOO0A72+/Y2Ur5aRMsiKWE/FGYt6rVBrGWvfDfj4?=
 =?us-ascii?Q?SYfPy6JCtlo0v2GYfoD8Agh6anBlBqS9EZWdJPKgcf/k8MzP1D0XC1odA3Pj?=
 =?us-ascii?Q?OS5H+h7EPEJAMPxT5X9uMQwo4eVM2+Pvmygy+vgT7cBTDdc8OV3TfhDvIKFp?=
 =?us-ascii?Q?cJ0ayJcR4EsId0QStmKEZ4p0VKmM2GdCfye+/L4Hu7vpsT8qEyZbGEo6RNeA?=
 =?us-ascii?Q?Dk/3PkxtGcsYYWqqrYaSY5b8oPU4VLEhxOyHY4jEFSg1/cP6cDZ3fdHmB3I3?=
 =?us-ascii?Q?qTYy9SXKTC0+wn2wiBrtQYgF3YP7xKDVliVRuF8jHRRaT9YAqjOj+Fvk/MZz?=
 =?us-ascii?Q?OJALC6KuRcbFRj3nU1hZFvD1VlCsLkz9NGslZMVdHGgntocU/gJOTU6Bbv4o?=
 =?us-ascii?Q?Xm/aoNcvmzSllQaYwB1czjSeUlJETzV/FplVnWvpLvShx/BO/BrzZl4paQkR?=
 =?us-ascii?Q?wtWe5lfh0XKAmimdSXtSRM4718SozzYYUGGxXUI2OZ8Z0Qd/qpKt9vF94SLY?=
 =?us-ascii?Q?2MXxypFawRo7x2KmTm6Kd5lBt7burMhv9YD2lMNraPhhub72wlhiU0h3j91P?=
 =?us-ascii?Q?haGUbEj97ou9pK0i6xsLtm8MknwDIsnY+3eSfpa+n0X3hAVhaB08AQxGa40/?=
 =?us-ascii?Q?E+k7Fl7JWMpZA5PZSrnNlSaqRB+naGCPiss9x1y6d6XDxikJmSS5Y4G/QYhh?=
 =?us-ascii?Q?c6xsQDDJ7rhohT38DedqQYScF7oZIWasJSRb2sDpuccB8/piqhPU6UCe0Ll+?=
 =?us-ascii?Q?4L614CTm?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713cb274-0868-4c79-0973-08d8c21d9219
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 17:12:33.5134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6XD1QkdGXqlqb5/RT96IDGjbar/4KFroLTrPIxuYcGZ1NuydJqpxzz6+qp+Xk9tE7Z4nNnxAnkLBwvKQvgjfRlf/qV+PSs+LLZXCdU04o0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1900
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While this is done for all bitmaps, the original use case in mind was
for CPU masks and cpulist_parse() as described below.

It seems that a common configuration is to use the 1st couple cores for
housekeeping tasks.  This tends to leave the remaining ones to form a
pool of similarly configured cores to take on the real workload of
interest to the user.

So on machine A - with 32 cores, it could be 0-3 for "system" and then
4-31 being used in boot args like nohz_full=, or rcu_nocbs= as part of
setting up the worker pool of CPUs.

But then newer machine B is added, and it has 48 cores, and so while
the 0-3 part remains unchanged, the pool setup cpu list becomes 4-47.

Multiple deployment becomes easier when we can just simply replace 31
and 47 with "N" and let the system substitute in the actual number at
boot; a number that it knows better than we do.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 Documentation/admin-guide/kernel-parameters.rst |  2 ++
 lib/bitmap.c                                    | 12 ++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 682ab28b5c94..850917f19476 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -68,6 +68,8 @@ For example one can add to the command line following parameter:
 
 where the final item represents CPUs 100,101,125,126,150,151,...
 
+The value "N" can be used to represent the numerically last CPU on the system,
+i.e "foo_cpus=16-N" would be equivalent to "16-31" on a 32 core system.
 
 
 This document may not be entirely up to date and comprehensive. The command
diff --git a/lib/bitmap.c b/lib/bitmap.c
index f65be2f148fd..2fdd00b312c3 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -519,11 +519,17 @@ static int bitmap_check_region(const struct region *r)
 	return 0;
 }
 
-static const char *bitmap_getnum(const char *str, unsigned int *num)
+static const char *__bitmap_getnum(const char *str, unsigned int nbits,
+				    unsigned int *num)
 {
 	unsigned long long n;
 	unsigned int len;
 
+	if (str[0] == 'N') {
+		*num = nbits - 1;
+		return str + 1;
+	}
+
 	len = _parse_integer(str, 10, &n);
 	if (!len)
 		return ERR_PTR(-EINVAL);
@@ -533,7 +539,7 @@ static const char *bitmap_getnum(const char *str, unsigned int *num)
 	*num = n;
 	return str + len;
 }
-#define bitmap_getrnum(s, r, pos) bitmap_getnum(s, &(r->pos))
+#define bitmap_getrnum(s, r, pos) __bitmap_getnum(s, r->nbits, &(r->pos))
 
 static inline bool end_of_str(char c)
 {
@@ -626,6 +632,8 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
  * From each group will be used only defined amount of bits.
  * Syntax: range:used_size/group_size
  * Example: 0-1023:2/256 ==> 0,1,256,257,512,513,768,769
+ * The value 'N' can be used as a dynamically substituted token for the
+ * maximum allowed value; i.e (nmaskbits - 1).
  *
  * Returns: 0 on success, -errno on invalid input strings. Error values:
  *
-- 
2.17.1

