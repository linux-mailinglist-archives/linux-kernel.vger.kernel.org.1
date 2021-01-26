Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D11304E51
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390570AbhA0AZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:25:25 -0500
Received: from mail-mw2nam12on2078.outbound.protection.outlook.com ([40.107.244.78]:49408
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389407AbhAZROs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:14:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpw3i3u5ALD5ciYc96mNp8IfmFSU0wUNS69p8reKaDd6nmap6La8deWQZZtR9F+hJX0nCsIa0NZ05NKD7S4tK1GodCgD9projUgNc0c2dPYEFBK6gHIGx2FIQ3EsxhbMeFSDU/OEdTKpvhH7m6MyZQIFCauhF0wuIak41l6rxj8o3yU4MgOKP12ECK5eEtgqt2xabmqCKcZDWkYkiT6ot8xF8f6w+47Neu6fcQb80i72CQMnVtalQSI5cTKUdjBNjwbyYvnYkVh5dY5CBVw1FgeZH+tn7H5TdxobDNT+OIS9je7ZTqWc0WCnCHRKevVYc+EymXcPoFqL13C4N/f8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsIkxdxYsI238hH0HF0lWG5IuhLvKiSRBzzl3yjs+Us=;
 b=EqGX5YrUe5orb/u1pRi6YxEkmIDa4/xGWP+EsVgOIi2Pe25Zz+K5JABJn0he19PSTHal0oxHXlijZUP9Oo8vABznw9ioBkZMm4ScsZAx+24htgiRaQLTTd5nMtKmWC/3pu5DexZS4PG02UoCEr+hqDHNah7LAF6BArG8td7chjM40yOe6drfrp2TN9VG3ittpW3foYtIdn6mm2DAc7XMTmesI90D959Em8v7mFj8pU5xy6SLwQbz2wM61giL6wyufJVqYywP8VuZMD/V19hAXLYR+Jc8JnVdneJNEL//bQtu5vFhwynvsWNVgy8iSlL4XO428CuD8jlv6nDJb69Osw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsIkxdxYsI238hH0HF0lWG5IuhLvKiSRBzzl3yjs+Us=;
 b=orEuoadnZ1VmDItnONcyOFEEy+WnTEOtq0bRrFM2ms9mTGuAEAbarxI2NXXi3GrAgVVp9eXbclIMiHZCKxV9dLjrNsf+WNBBebdy9UxeLZlJq8nyHqCP6VqhV0IU1D4X6YgFVwGFnAYXmK7yidfnGZ5BfBF8gxFHamQArB3Ux7U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2763.namprd11.prod.outlook.com (2603:10b6:5:c6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Tue, 26 Jan
 2021 17:12:35 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%4]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 17:12:35 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     lizefan@huawei.com, mingo@kernel.org, tglx@linutronix.de,
        josh@joshtriplett.org, yury.norov@gmail.com, peterz@infradead.org,
        paulmck@kernel.org, fweisbec@gmail.com, linux@rasmusvillemoes.dk,
        andriy.shevchenko@linux.intel.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 8/8] rcu: deprecate "all" option to rcu_nocbs=
Date:   Tue, 26 Jan 2021 12:11:41 -0500
Message-Id: <20210126171141.122639-9-paul.gortmaker@windriver.com>
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
Received: from yow-pgortmak-lx2.corp.ad.wrs.com (128.224.252.2) by YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 26 Jan 2021 17:12:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ed14574-7823-4654-7760-08d8c21d936f
X-MS-TrafficTypeDiagnostic: DM6PR11MB2763:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB27631A80B20F024C6490564583BC9@DM6PR11MB2763.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j36WeLco0S/s9GxpfsWQRmjDNQ6WQXMirSDz/L2E9Y/wMwQ1yH4sDO/pbj4oKwH1+wqhnIvDM3x8D1O3GYE9JUsEIyVl+fXvxOwcAk6xGiKzn+mDvjhMj71aWgx0THdiBpLbCUbuyXLnYy8PHlZeqRp6dB0gpEDLXcD1R5hseQrXRGkTjneSs2CdgfeTaNVT9rXsLHJ51HCwzLZHFaahmXktYfA9MYaG3jyjBY8Vfg7n9J53OK/A8J/wBMCbhpou2+skafsGXoJSnp7prEKH2r9OTSQrPKTOZM30DS9NagQkdFRZneOqTY3p2kVH6/W8FHQne902qN25XkaxBMf6n11HovwAC9YHUtl0lPvzskV1vDaYKTh3URL+lFv6RlDs3zVmR1VJYLuGXLbTZQs9RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(39850400004)(396003)(136003)(6666004)(86362001)(66946007)(316002)(8676002)(52116002)(186003)(26005)(2616005)(107886003)(1076003)(6512007)(66556008)(16526019)(478600001)(8936002)(83380400001)(6486002)(6506007)(5660300002)(2906002)(66476007)(956004)(44832011)(6916009)(36756003)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?EBdnTqlTwNp0wTq2+weQPONAdlSYw6itn0OsNaddKOPbVxHpou1DWxypwsvK?=
 =?us-ascii?Q?XhIjGfvz83dDid3l7KFAKwGc0cXAxM2hDwzqHphEBwSBPeKKv6SGvnuRxCGV?=
 =?us-ascii?Q?5mTMZxn0YTG0U/26ThcGqHC02ZfBVhpwuABsFoc1xIn8OUOrjfxUFwlVp6If?=
 =?us-ascii?Q?/gC6Ks+iwzTvWX9tyNrj+G1rIXw6lQIZ/9FVBWIkRL5bpWsGZCD0nUBiesZ+?=
 =?us-ascii?Q?+P8kaI+b09K6ZPF4PB1cvZPolA7IP33D6hKEGYRNILbClxmW1N0CTlFikDEg?=
 =?us-ascii?Q?/VYmJQPnWQ1W/JOwIU8BgEetze61Fg3GtGFASY5hh9IxUR+Y/oGzB7o2kCh+?=
 =?us-ascii?Q?W/pB+k5eWOANv2TcOfFx5iFIvCuiT9z+ya8o40qGQtLNfSH6p48kLfn0X406?=
 =?us-ascii?Q?MTJb8omorW5X8irNCIluUsLgKVY0JEWvn0wANPuNsvKLvfCTwivkfGuQdZhH?=
 =?us-ascii?Q?K6mvunV7H40C0d0BlLExc1M4MrIQfSbooFW7lBf4xY7whG/9SG5Qz0jV5/RE?=
 =?us-ascii?Q?UCcTKWYIKdYlOjMDCmdv0Lr44dGN+xeuy/QYsb4BiowfAFsmABNjs6K0wahc?=
 =?us-ascii?Q?fNe5uZivkL+43xa5eqcJ7FDFzbBUTdMupcqhJ2NfzmM2+sfLkyJ8u4wZLNGo?=
 =?us-ascii?Q?cv4AL1WDI8DnBinInuJxGDzC5E3Ea6wJgpvCJpv+3FcZ455E8Ka5W6c8LClK?=
 =?us-ascii?Q?fAfHppA3TVrFvWVchYc0Vk5lsLLdJeOxypKrWpJu3fPBH+esJJTkMywVHQ//?=
 =?us-ascii?Q?RkHlLKVg2OI5MdLr5shDxwDSk27b0QlciRK+p3xUnYz98ag+dmJHhMgyVkvI?=
 =?us-ascii?Q?xirXPGki9N6BgyOfRJMDQow9LUnUepEnUCf1/bk6Q2es4wPkWr+Vpl5ac9df?=
 =?us-ascii?Q?CRQKYbYgetZ7EvV60wuLlqCV9fy2XRxlnY5/mHwhpDqwFNZY4M/twK2lSahD?=
 =?us-ascii?Q?E6M9Ibk/9vuQI/9BmyO+6XleyIphaQq8b7PWvv/obVjd2kjVZ85D3gmG4LAv?=
 =?us-ascii?Q?iwhULglrxpQntOQUC/WBGDHxAJM65IiizpDMNIL+mfeJC088DdmTl89B8cLG?=
 =?us-ascii?Q?8mWtENOQ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed14574-7823-4654-7760-08d8c21d936f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 17:12:35.7585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: viKkh1oj+N7CSG30dH4DgweiV+EvCK6d80uUGHffCm7lzMNFWd2sFKHJmbavwMa+DKNN+IrUG8GwqRTd2pQ8TnwcHN8I/sWZ8kDS+C25nnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2763
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the core bitmap support now accepting "N" as a placeholder for
the end of the bitmap, "all" can be represented as "0-N" and has the
advantage of not being specific to RCU (or any other subsystem).

So deprecate the use of "all" by removing documentation references
to it.  The support itself needs to remain for now, since we don't
know how many people out there are using it currently, but since it
is in an __init area anyway, it isn't worth losing sleep over.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 +---
 kernel/rcu/tree_plugin.h                        | 6 ++----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a10b545c2070..a116c0ff0a91 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4037,9 +4037,7 @@
 				see CONFIG_RAS_CEC help text.
 
 	rcu_nocbs=	[KNL]
-			The argument is a cpu list, as described above,
-			except that the string "all" can be used to
-			specify every CPU on the system.
+			The argument is a cpu list, as described above.
 
 			In kernels built with CONFIG_RCU_NOCB_CPU=y, set
 			the specified list of CPUs to be no-callback CPUs.
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7e291ce0a1d6..56788dfde922 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1463,14 +1463,12 @@ static void rcu_cleanup_after_idle(void)
 
 /*
  * Parse the boot-time rcu_nocb_mask CPU list from the kernel parameters.
- * The string after the "rcu_nocbs=" is either "all" for all CPUs, or a
- * comma-separated list of CPUs and/or CPU ranges.  If an invalid list is
- * given, a warning is emitted and all CPUs are offloaded.
+ * If the list is invalid, a warning is emitted and all CPUs are offloaded.
  */
 static int __init rcu_nocb_setup(char *str)
 {
 	alloc_bootmem_cpumask_var(&rcu_nocb_mask);
-	if (!strcasecmp(str, "all"))
+	if (!strcasecmp(str, "all"))		/* legacy: use "0-N" instead */
 		cpumask_setall(rcu_nocb_mask);
 	else
 		if (cpulist_parse(str, rcu_nocb_mask)) {
-- 
2.17.1

