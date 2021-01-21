Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F222FF80A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 23:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbhAUWgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 17:36:38 -0500
Received: from mail-co1nam11on2078.outbound.protection.outlook.com ([40.107.220.78]:64737
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726414AbhAUWgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:36:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUKBjE6AozQF0XuDJEcp9vfDa+CC103ldAsK6FsFXyrot9B8vjMVA5ii4M2UeV9HpPE4FxMGh7Cc85oiPjL7JqqcLSeu1ryn5WAxIZ2uKupEBEbivYjCDWB26F4w0H7/Mn51N4oaJ46cAOb80IgKOQHMMgnH4vUlW0Sm1EGRYUEP5YnkDDjXFx6s5SGySXkkxOCIs+sSrO3TwwEHDfRymRUNJRmJDdwbRucDoElAHsJlQsMINr1k/xym0Kh0+W+OFhnRJT14U42joYk/RAeZe2IxuVqMTTrCPVXauAwINYdB9DK8YMriVmR+8cmCUI5231C1zO2mZBSwHuXLzBcxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klpmG8ruLYplavEjwoU+UpEl0wLiTq9LnIFTjkAh1Ak=;
 b=Dbk0UVhr6cfbksz4s3S6sg2osKcjZI3KCLxWwPKiqEjgRY/IJCvK/fHBEW3nJKo56wXc1blAT55cvvNHSwq8gmB7pob69PvfabiyZDxFpWchb+4gdA0lXF3YhANeV6RRRYr4WgY1/1sN7EM+WTRJ94Esa5Ya2RNmrWqIaPPSSB5/j2r6PRsc65NGyWtSbftsOgPs8DPVCYs8r66TBv1zCQbCxrLE2IeEc1+fPuNWRXENelZ8q3jU8hOrWESB7qG9tkMZ+enyW87VgersdJEJOWN222ZBWPIXC4NdFgdSmXHBkCtUq4wQfWkW8g1SosSPI6I77bTkez8pr51MroX0rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klpmG8ruLYplavEjwoU+UpEl0wLiTq9LnIFTjkAh1Ak=;
 b=HQGrgB0ggijW05VVy4oJJOFRpe8g3TbQI9/d4XJHbt2LcJ9Y39SLxiJj2WevZW4t/nl5vyydj9ge6kmvszbXY8wlp8hWNOrX0vcG39SKPMA65PtwPtxETKO+Ofxf/f0VJt+anIuo+m5Q/NJPl0BUu1HHqxhRFlDV6eRosFvm1F4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2763.namprd11.prod.outlook.com (2603:10b6:5:c6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Thu, 21 Jan
 2021 22:34:23 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%4]) with mapi id 15.20.3784.013; Thu, 21 Jan 2021
 22:34:23 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Yury Norov <yury.norov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/3] rcu: dont special case "all" handling; let bitmask deal with it
Date:   Thu, 21 Jan 2021 17:33:54 -0500
Message-Id: <20210121223355.59780-3-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121223355.59780-1-paul.gortmaker@windriver.com>
References: <20210121223355.59780-1-paul.gortmaker@windriver.com>
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::24) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-pgortmak-lx2.corp.ad.wrs.com (128.224.252.2) by YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Thu, 21 Jan 2021 22:34:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 695601e5-0530-44c1-41d2-08d8be5cb3ad
X-MS-TrafficTypeDiagnostic: DM6PR11MB2763:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB2763096A99E59EC17A66EF6D83A19@DM6PR11MB2763.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPn+GuvHUsyF9bZz/396Zr2Pp4rUXCEcfj6HtkIjbiz62uQeXLOgGdbVfDtPFT70GMgWSIJTZ7IDrrWslDhK7VLvpJwe/fM9EpD4XG6G0Thvc4aCQzfKyQRv5/bKZXMQB8wn76Z6FoIj1y9htQaDDQcEE8XCGNGI6SDQPV7m4cyiIlqPD9U5pJh34qBDnYTM0jvUnZ5EFtvotwqjZy1N+SXYTPfcgxeJCwyTcaHcDjH1tMP9coSPzKGNE1N9mH0RiIikCeWkLv3y96VYy2PTiY33E9baiIz4iyqgBFdQ7dLE3xgUnuE/B6qBFhuYpl3hrwmc6luCR+gp8XlRGS+BZ79So/nwjphkVmEP318tWhK9V89ETxdE5J2g2KpYh3NZ/DyMblOZZU7ZYnZnCq5md0m2yTKD2KuFqaeTldAGGBqVwz5oAAbdkv0bPwTW2GQx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39850400004)(346002)(136003)(396003)(4326008)(66556008)(66946007)(8676002)(478600001)(6666004)(8936002)(6486002)(86362001)(66476007)(6512007)(36756003)(1076003)(44832011)(2906002)(2616005)(6916009)(83380400001)(316002)(26005)(5660300002)(54906003)(186003)(956004)(52116002)(16526019)(6506007)(192303002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?t1r6qvvEH6nEwXjnYlcYnwPJmM9mJAaxqlQFgIlCSeJ1fg2FsmycN+iPuH5b?=
 =?us-ascii?Q?lrangmVnoYwtxcbMXr5OwlCSQOdVLmsnTarFGCCFOMa1trBP5w1aQScYum0F?=
 =?us-ascii?Q?lc+ocYPLdoICVg3uenq6kJMUsU6Jv7ANWp5yCu4wGlAbXp9CMxR+M3dTWQMZ?=
 =?us-ascii?Q?KHeVRbTPSNUoWHDLQuMraH87Sjp4JLZslv3jCGs+1mQBBBaEuJIZkJxUVWK5?=
 =?us-ascii?Q?UvSSftJQ41fawzpet6S7gdRpeN/lNKpLuyhc11y4mpRmUvsY70PPCtzlKRlg?=
 =?us-ascii?Q?N5O14nQBGPV+960ogt03vvboDETa4nZQH652QOgiC8ZYzLttObAMuLcR/JeG?=
 =?us-ascii?Q?uF5euZUI6jDYRwQEtTRfx6cI4AKnuQLIbp15oT6PX7778Lcxh52Nr3DEAaMH?=
 =?us-ascii?Q?dbN1EXBzBNCHyckohgOC3g+Uz36RivL+Dd1+JjpTuApd6B0vIFV62n9Ok/Yv?=
 =?us-ascii?Q?Yz66H7oGhoueoPfAGrVv2YH4H8GI1MN549FHaqKK+Ss5SLadeV4eqzrwBVpg?=
 =?us-ascii?Q?0Z1fMnfJQO4bMakGf3RIFkgjVGPbFDG5gq0Rx/2CZ4FQzFPmh8C+n7dkIvDX?=
 =?us-ascii?Q?MJIv+t0XZmX63JxeakJ8qGUeW2jNUNyecFREoXwJro2is7Q7BbfkyEj5Mxm+?=
 =?us-ascii?Q?T+PbBjwIVm3fnxWavTu+s52hpY83F4H1aCVEmqSMbv2GDObSEzJ4WBz7LZio?=
 =?us-ascii?Q?uyhDIw9mG1ujqp+0UJEFb3CmrFKaMASgZGZzIRRkm9R/8dBY5xu/PJ7MNSog?=
 =?us-ascii?Q?r/Rda4FTx+L1oPsEBszV7X7Bglu+qT//2AfXnjcq/b+v4mSoHLbmja/sdvkD?=
 =?us-ascii?Q?5IDy4o+/kmwFaryt7ZxZ99twJH0DzNt0+K/NGTkEOhkMdNvrnmPdrT0KT8ci?=
 =?us-ascii?Q?qEfpTaWp31UbnVrGyowQt9DupeuoJVZzbYGCjWQDc/CmErnMpUOoaVOgtnq+?=
 =?us-ascii?Q?X7aFEHdmJ9VkzzxPBLMcDHMlnXxX9mQPgI90tX7fBmnRBeyWh2456atp3ikl?=
 =?us-ascii?Q?DSvI?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 695601e5-0530-44c1-41d2-08d8be5cb3ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 22:34:23.4815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jx0nzHEnFdhe36JEUpPt3S403xGE6vzs4otTenmMkiHDz6mH26HNu+b4VSN4ASl7eK7C8vk7+yd4xD1KpBfi8eqC/lf1d/hROfdqETv3udU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2763
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the core bitmap parse code respects the "all" parameter, there
is no need for RCU to have its own special check for it.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 +---
 kernel/rcu/tree_plugin.h                        | 13 ++++---------
 2 files changed, 5 insertions(+), 12 deletions(-)

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
index 7e291ce0a1d6..642ebd6569c7 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1463,20 +1463,15 @@ static void rcu_cleanup_after_idle(void)
 
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
+	if (cpulist_parse(str, rcu_nocb_mask)) {
+		pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
 		cpumask_setall(rcu_nocb_mask);
-	else
-		if (cpulist_parse(str, rcu_nocb_mask)) {
-			pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
-			cpumask_setall(rcu_nocb_mask);
-		}
+	}
 	return 1;
 }
 __setup("rcu_nocbs=", rcu_nocb_setup);
-- 
2.17.1

