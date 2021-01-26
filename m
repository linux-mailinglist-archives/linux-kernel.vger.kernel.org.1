Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB56304E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390429AbhA0AY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:24:28 -0500
Received: from mail-dm6nam10on2068.outbound.protection.outlook.com ([40.107.93.68]:17655
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388845AbhAZRNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:13:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN2BwYCzYixXnWebPoVdPxf8sUfgO3CLQaPVstOB4yvtfi0olPRHBUCLBCLinah4HISC7QOPsrHkxpKDmioq++SgLJBjiXrDiXZpEst22K6dCHCjw2dyrU6r024K1Zxo7ZBLipF7v6tn9Wcwofqk44O1cyGLRr3XFnXZ8DZIzm6UrJ91oaiGhgGgkBjDPhd/NUVumzSrnG4sF1ZP02or8NbwzBnc1tm3384EqUbn2qmYhw4vmPJYwPlzvOPlmDkJd3Ts7wbW4PLnE1NpjFmK5WyE/ggH0ZpKgoMlOX+YIDampyu5LbeeJNhnXH7g7Ef9IfUa4sQp5Ybq0LOCJqSdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xKBBqOtSso/pUQ4H3PX7EE2ItVuDJJU5wgnG9Ou0vQ=;
 b=kLaQ/Z+227y/Hsibc+8BVE0lbagSwVEkVQhVxF4AsDh0mIv5BsJK2HpDJ8lJOHC0eqot04WvGrNWJSww6sbC7U0VIhvG/BIutaP7CiDHw9FiU9BXIu0ogsIWYV62nK1yYp2OzPHj/a5pj2cqatzQGEU1ZobWMdbkxu6JWymQm57kOylU+p3cm2rPLQBfTHCnE3Q21ehqBM3nhvEJ84rKwTl27wktSp+50GpYtbnV0vdg7v5ba0d5HJdDx5NOGL28qyego+JqjQSFyimLYr5rZx4abaEir4vYhluS22pjhw8Sz3+YsKgp+K8aghK417Q0+OnynUBAZ9wo6tKhpJF67A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xKBBqOtSso/pUQ4H3PX7EE2ItVuDJJU5wgnG9Ou0vQ=;
 b=dFQa83+p8puMBZLficzKItxLVek1twHVMf2j3GGMoY2AY/I64pm5s2fGFLcq2PJGll8SLhtuzMVdpNQxVKpdWvbK4rsaECZ6Rr/F48A0NPuT/RFlZXl9EAn1HW5ZsDWMffNG64xUEUeUYpOvEqdl/9DUyHWFS8bShierDfLe8FE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2763.namprd11.prod.outlook.com (2603:10b6:5:c6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Tue, 26 Jan
 2021 17:12:26 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%4]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 17:12:26 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     lizefan@huawei.com, mingo@kernel.org, tglx@linutronix.de,
        josh@joshtriplett.org, yury.norov@gmail.com, peterz@infradead.org,
        paulmck@kernel.org, fweisbec@gmail.com, linux@rasmusvillemoes.dk,
        andriy.shevchenko@linux.intel.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH v3 0/8] support for bitmap (and hence CPU) list "N" abbreviation
Date:   Tue, 26 Jan 2021 12:11:33 -0500
Message-Id: <20210126171141.122639-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::15) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-pgortmak-lx2.corp.ad.wrs.com (128.224.252.2) by YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 26 Jan 2021 17:12:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed687d77-a195-463f-be0d-08d8c21d8de5
X-MS-TrafficTypeDiagnostic: DM6PR11MB2763:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB2763350ABECE193E8A56437483BC9@DM6PR11MB2763.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CHeo1UqyC1s/DwKxyxBodpGcXEGSYwIH2hX+z5mIMkkOeU+SI9epQqAiJgEJ2qkVkE1De+uzcOFwLd/aY6GXfGW847j/nUabr7cIabsLBdBdZiSliXaEYulTmQYTmy0j4r78yiOr+Zr4Z9EVvO28J6kLHGWFxCu9DGR2h4elJRDAYju0utXv2AoE79TuBq70SpiHjUqZYmFCPSMgk6kp7pDuC6lR3jImz25AiqEbk+bHR69b1kEEvdKANZce5AuWs72kX2mhEbjWInhldQ3LEMtd126jmnxJAL30gAM9NTNejTy6ceR7CnUs03ZQ11JhN4EsugtLL3zIu35FipVAgWWQjzaRnilKwjoLuNEkDO58vdIzcHhsnq57gf5DZdrDVPz9zemLVLUZ7NvXUpi62XkednlnotZW5PxFdO+l/sdsmP2A5Q+3LNjCMjRNQpVttD4DdvlXc6slhxFG+qwveA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(39850400004)(396003)(136003)(6666004)(86362001)(66946007)(316002)(8676002)(52116002)(186003)(26005)(2616005)(107886003)(1076003)(6512007)(66556008)(16526019)(478600001)(8936002)(83380400001)(6486002)(6506007)(5660300002)(2906002)(66476007)(956004)(44832011)(6916009)(36756003)(4326008)(7416002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FcSsV7DcnO4GGMLQvXKyNKsb3OF2IYdUHsyIyoTgPeaXbaUpx1P4MKswSU7c?=
 =?us-ascii?Q?v3Qk/BxHxlwSBWZd1BpKj9kQxaClDP5hrarp0Sc5EGq5E4wkl0SJjVi8+7Dx?=
 =?us-ascii?Q?KJvcq8bX7HfwObreBhE3Iei5dlaK/jffcZIZ4tWRCN0bolnxSeotKEYAZrUF?=
 =?us-ascii?Q?gLqTD4+pn4IDWAGWQ9+BpinI8ZUS+7IJnW3ZJnCc8MqXCwl11jvRj1StU3PB?=
 =?us-ascii?Q?WF8GooRcSL7OtzW7yfRDpFQQRO/BuG6T91k8LfJNYUL5jo5ma6EbtPdcl12b?=
 =?us-ascii?Q?wg3Tjk+/3XfHzwQsHJcWz8+BhSLWmMwxhs/e8TpC1WPg9a6Z7TOSFRkrEogO?=
 =?us-ascii?Q?z2HnCF5P9zOAKs8qBGMAsriQ66ltDKCJws04a95tnwHM1fSrBN1zlLFa5Mk2?=
 =?us-ascii?Q?mGX6vb1ZnbLWdVOPv1wutXms4cV1/4yLBL9Qe5I81o+cg7KuUD5CFnXgBzJV?=
 =?us-ascii?Q?fWl5MJxmm+eaTGU+StaEk/CQojt4WsvWsZdsTVy235c+ZhgVW0jmp9VWi0bw?=
 =?us-ascii?Q?cf0YtKN/K1nA/tTi/x2sNjQpRIBrWffPLDIxLNeqs5GGDZpkrKJQMDZ9rD4U?=
 =?us-ascii?Q?yKwNi3zmTL97+dB5meeMwAudSK9PNVX0MxC0kLmxD1YyVqaIMXH9NSoiYJdW?=
 =?us-ascii?Q?kv5GH5f3VZZsIjNTBfJ0wqs7We5UYlfLLaw4NhDtm8CwoxTOGRpdQxx11Rtm?=
 =?us-ascii?Q?0P42USA5hb4zmahs4jl9dmR5UDfckT7ivsplD7Rp90X17MHZzqcgOzw7CfEI?=
 =?us-ascii?Q?MCFKfVIo3brX1Gj3tywTCvmPvQLLPWmJXjukRqyUvKC7vZywsbB1s8B69o0O?=
 =?us-ascii?Q?XuovCv2aD/jzXVeUc3jvMqhznfq/FdM0I5j/ofYjlx5btUmEv81xVfi1+k7Y?=
 =?us-ascii?Q?Ih1hUZjmwrawOl5CPyCJpm2N/KPsi19FB/MiUfaCBxwFA+7BHDWvDqorCTQo?=
 =?us-ascii?Q?to7PHcn5zDO/8dnx7fh8oX4qlb/lIy2r39VKu3qvMC0+94ZXhRruG3UX0W4U?=
 =?us-ascii?Q?bzxrbBxPTZBH7S6Lu4z6VwsSYFIrzO+aEKrFhjGdq4cviO3aAVFc4O3Ufj+Z?=
 =?us-ascii?Q?O444PzjC?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed687d77-a195-463f-be0d-08d8c21d8de5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 17:12:26.5211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGAHmt+6PZYcXMTrqNoPKmfGTLi0fLcI7F+7LRGMu13758PqLq3FbRwlC65iojyCGvJMnohoYI4ceEtD91PI1nQax1/UMXFDz0Vff/9BIvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2763
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The basic objective here was to add support for "nohz_full=8-N" and/or
"rcu_nocbs="4-N" -- essentially introduce "N" as a portable reference
to the last core, evaluated at boot for anything using a CPU list.

The thinking behind this, is that people carve off a few early CPUs to
support housekeeping tasks, and perhaps dedicate one to a busy I/O
peripheral, and then the remaining pool of CPUs out to the end are a
part of a commonly configured pool used for the real work the user
cares about.

Extend that logic out to a fleet of machines - some new, and some
nearing EOL, and you've probably got a wide range of core counts to
contend with - even though the early number of cores dedicated to the
system overhead probably doesn't vary.

This change would enable sysadmins to have a common bootarg across all
such systems, and would also avoid any off-by-one fencepost errors that
happen for users who might briefly forget that core counts start at zero.

Originally I did this at the CPU subsys level, but Yury suggested it
be moved down further to bitmap level itself, which made the core 
implementation [6/8] smaller and less complex, but the series longer.

New self tests are added to better exercise what bitmap range/region
currently supports, and new tests are added for the new "N" support.

Also tested boot arg and the post-boot cgroup use case as per below:

   root@hackbox:~# cat /proc/cmdline 
   BOOT_IMAGE=/boot/bzImage root=/dev/sda1 rcu_nocbs=2,3,8-N:1/2
   root@hackbox:~# dmesg|grep Offl
   rcu:     Offload RCU callbacks from CPUs: 2-3,8,10,12,14.

   root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
   
   root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo 10-N > cpuset.cpus
   root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
   10-15
   root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo N-N:N/N > cpuset.cpus
   root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
   15

This was on a 16 core machine with CONFIG_NR_CPUS=16 in .config file.

Note that "N" is a dynamic quantity, and can change scope if the bitmap
is changed in size.  So at the risk of stating the obvious, don't use it
for "burn_eFuse=128-N" or "secure_erase_firmware=32-N" type stuff.

Paul.
---

[v1: https://lore.kernel.org/lkml/20210106004850.GA11682@paulmck-ThinkPad-P72/

[v2: push code down from cpu subsys to core bitmap code as per
 Yury's comments.  Change "last" to simply be "N" as per PeterZ.]
 https://lore.kernel.org/lkml/20210121223355.59780-1-paul.gortmaker@windriver.com/

[v3: Allow "N" to be used anywhere in the region spec, i.e. "N-N:N/N" vs.
 just being allowed at end of range like "0-N".  Add new self-tests.  Drop
 "all" and "none" aliases as redundant and not worth the extra complication. ]

Cc: Li Zefan <lizefan@huawei.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---

Paul Gortmaker (8):
  lib: test_bitmap: clearly separate ERANGE from EINVAL tests.
  lib: test_bitmap: add more start-end:offset/len tests
  lib: bitmap: fold nbits into region struct
  lib: bitmap: move ERANGE check from set_region to check_region
  lib: bitmap_getnum: separate arg into region and field
  lib: bitmap: support "N" as an alias for size of bitmap
  lib: test_bitmap: add tests for "N" alias
  rcu: deprecate "all" option to rcu_nocbs=

 .../admin-guide/kernel-parameters.rst         |  2 +
 .../admin-guide/kernel-parameters.txt         |  4 +-
 kernel/rcu/tree_plugin.h                      |  6 +--
 lib/bitmap.c                                  | 46 ++++++++++--------
 lib/test_bitmap.c                             | 48 ++++++++++++++++---
 5 files changed, 72 insertions(+), 34 deletions(-)

-- 
2.17.1

