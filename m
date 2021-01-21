Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0842FF808
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 23:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbhAUWgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 17:36:24 -0500
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com ([40.107.223.70]:16993
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbhAUWgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:36:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiE4mM6wGpydQKKg09u9ndb+8KxLeSGhTOYhnlNYM8Pk7kz6b9Pv0opl4Nl0VYxms13d+TwmrbDaz8ibo09CvSs9h4sSue9rjUpdlNmVzo1O54Q0c+P7oS0a19aAsMbJHqUDs48DA1ZMNX8uQcf3jLLLLkB6RwR8I72bnKxgB9JA7uc3yTUXm7ywmxnHisvhjZ65JFEIITcayeBZ6Zjd1m2Rkpl9h3YL+/iVn08sndIfdk4T+PW/i4A+hnGbjs2txB0KM/nv+nsPPHGW926klpRDIQMHpqAX5Sl//vWYklqKsMvSlzkSJJawGkqF7k/6a6feDfmBubmJp+oEnpbFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWwMx/dnqeojVDs8IDV+uQYU6Hra+zngHTFAICS4CLY=;
 b=ldw2AfA/RUPouh583QFlDS4Dmj5zOLHITPnBW3eFtsZlrylzw004qFtf0xP1MBml51RlSZGHC91zBx39InXl3uwoNKbkJszJ0ou8stYLrRq3/7iXXwfWMMgsYf3ScXiX1EQTKWV+55JF/jBLo6suhXf28n+slbVs5yxF8FrLXa5wGkMPzYyFBujOJZ/pk5vnN5vNcQl4ozbvcj3jPrYKcZzH/g1tjDG9JX8Xas1tIqt60kNIfs2yHcTV2PJn2PcWJ/viklq4EOXxDhkseZ4RcRQcClkE8ZdbVsYczblj3mpCse3EtP6VUJBRdXylk4yRYpY/ZV3mjlTD+g7TiRPjUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWwMx/dnqeojVDs8IDV+uQYU6Hra+zngHTFAICS4CLY=;
 b=HisYTVkCenJ7dFM9K/isqWy7su5kcjRLB4sioBpDo8FHZJCAI6v29nRr6mF2QwuFBE/m2sYtiBIhagWYzsTW3+0B3STMMtzeKsJgQqwum68utUm/+5D+FVg/ZR+cGk8PifV+3cNPyLhxWTrCpXB/VrezHA/mpwE32dJ8avTXnhc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2763.namprd11.prod.outlook.com (2603:10b6:5:c6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Thu, 21 Jan
 2021 22:34:22 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%4]) with mapi id 15.20.3784.013; Thu, 21 Jan 2021
 22:34:22 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Yury Norov <yury.norov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Li Zefan <lizefan@huawei.com>
Subject: [PATCH v2 0/3] :support for bitmap (and hence CPU) list abbreviations
Date:   Thu, 21 Jan 2021 17:33:52 -0500
Message-Id: <20210121223355.59780-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::24) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-pgortmak-lx2.corp.ad.wrs.com (128.224.252.2) by YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Thu, 21 Jan 2021 22:34:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7f05814-b67a-4213-94e4-08d8be5cb2e9
X-MS-TrafficTypeDiagnostic: DM6PR11MB2763:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB2763493003ADF8FAFE77558983A19@DM6PR11MB2763.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOP1j0AWTYb4rkHdE990k0KJkYBtivhp7kZTrKVWfpT8KTeU295tNChYxzqt2Bj1jzAAAFDHrbcMiwEsQKfwrzkOvzZqCIRUy4qqo7TI6xRYVY8qWcqTL74lUtxnx+7crHil4PfUhem7MGzSCyrOxNKD0hpn58dNS8NsBn27Eez9AHJXKkaGXpryRzCGRgwAJuE2nG8m7by0CqNPduQmbeBcYYqzboINUE2gJVQk8DBNc+ps/+K4IPuIcwacI7w3vJnXZu/YuTYttMDeChoxvkMC3v49IHfxxtvCOpNWG0NJCkM3hFk4PSuoIctyh4nlWNWAfeUopcT2ypSGMOBYYJOvgoXfNFMs/KcEFsBcWJ2TmTQ3uFPvA3g709+fTEUoZbDUqOoP9/gMzyOs4UxLLb1t+1DMPSSt72wUCPRJlFEWn7UL1ZMyWeqn49+CIeNRmPZVJ/50amowu0o8WBnLjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39850400004)(346002)(136003)(396003)(4326008)(66556008)(66946007)(8676002)(478600001)(6666004)(8936002)(6486002)(86362001)(66476007)(6512007)(36756003)(1076003)(44832011)(2906002)(2616005)(6916009)(83380400001)(316002)(26005)(5660300002)(54906003)(186003)(956004)(52116002)(16526019)(966005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?j1CcHyaKOHxBbzEEI5r4tUxSUEPKM0iOOKpUofE9FZr6EjvbYJHENC2ly4CY?=
 =?us-ascii?Q?H2Bb9Ni13V/k4bMcCpzh1Z40e0U2W5LX3j0dQiIb1UTXDrarsGt90t0GqDkN?=
 =?us-ascii?Q?/qU3mhN2liPbserROdn53hgRQ08Iz5uWL/28r9hPpKNT7nhVYL4vahfT4Ajl?=
 =?us-ascii?Q?vhriofObW+mdwwpu6FCm/H5XOWwKOXfMu5H+T954xnmc5xTmuMNmfQJo9tGA?=
 =?us-ascii?Q?ordKzdVxyt//h+OVfGGec3thjxQb2N87UeFQnmACbvsUSBnPxyNEcIGJdLA6?=
 =?us-ascii?Q?s/v2OFqJR1YUeYUsNX3Fjk/ZQ/ZmwUbdjlD6mdQJV0cH4FSAgoUy+imKLUcO?=
 =?us-ascii?Q?mvR5mIHkONEdBlMo4cir45dgcgQfIMuDRxVX3CV8bpGv0Iv+9Ix3RcMl/OHS?=
 =?us-ascii?Q?jJ0KgnfmJXeun8qkwpi7KaSm/PTCH8cPhlHqIkXtjssJau8yyG/+vrXFmDnP?=
 =?us-ascii?Q?7+jRb0/QrZ/KCJgkRxyVaPI/O+moXG9vUwaKfj8Bj6sHmRzIugLoA7AJJl4F?=
 =?us-ascii?Q?RRNhdYUJa7OxKTqRxDLNuvnIqmSaU+dHgSOs7HU+bT1gZ2BIGpOWCchJNTfq?=
 =?us-ascii?Q?t6afXtTZ9dcvAGBosku+4ogu13gdFZoro1E1ehvr1cLQkyOJucc2nSHeeGhQ?=
 =?us-ascii?Q?jGK+BW3etxM9temejZLlPSj8LQMFLGxDs+a9/RPITDtlWMarMWaem09yehGm?=
 =?us-ascii?Q?lqc1eF5VkRfnhaPezOAAXud+85CAV1cWazo9vRBRBXi8oIoIEAb38bcuQNKH?=
 =?us-ascii?Q?43iWRzgNGzQunYwLBx3L7hrBjGdwAF5U7RpZwU2q5iXeh6FtvPG3oUGVcOd/?=
 =?us-ascii?Q?3YxEP9Z9P49zgYK6BvkdwGlHSWFySOixy1n8QD53fj7c+/ehSUhBcKhwHY3b?=
 =?us-ascii?Q?SyTffn6N4BSpccYuuBUBxHavVuuoUC7z3h0w4TRwgh43z3AOcdo7dUy8tGs6?=
 =?us-ascii?Q?KoqOk8PghAkgUkRJ+NTKooU1rE7n4VM/13szp7yCfcrn9xLPkfft+nL12Txh?=
 =?us-ascii?Q?nCxB?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f05814-b67a-4213-94e4-08d8be5cb2e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 22:34:22.3136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BrUI9nGTAYFDX8CK5P1Yb4/Lxg+0nJSIevOI18sZNgViyE7582J/51F19QWmC7KlAHFejGes11OopcOgS6fFeiw3Gz27ZpqmdDCudzzEjXU=
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
happen for users who might briefly forget that core counts start at
zero.

Looking around before starting, I noticed RCU already had a short-form
abbreviation "all" -- but if we want to treat CPU lists in a uniform
matter, then tokens shouldn't be implemented at a subsystem level and
hence be subsystem specific; each with their own variations.

So I moved "all" to global use - for boot args, and for cgroups.  Then
I added the inverse "none" and finally, the one I wanted -- "N".

Originally I did this at the CPU subsys level, but Yury suggested it
be moved down further to bitmap level itself, and that was good advice.
Things got smaller and less complex.

The use of "N" isn't a standalone word like "all" or "none".  It will
be a part of a complete range specification, possibly with CSV separate
ranges before and after; like "nohz_full=5,6,8-N" or "nohz_full=2-N:3/4"

Also tested the post-boot cgroup use case as per below:

   root@hackbox:/sys/fs/cgroup/cpuset# mkdir foo
   root@hackbox:/sys/fs/cgroup/cpuset# cd foo
   root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
   
   root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo 10-N > cpuset.cpus
   root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
   10-15
   root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo all > cpuset.cpus
   root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
   0-15
   root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo none > cpuset.cpus
   root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
   
   root@hackbox:/sys/fs/cgroup/cpuset/foo#

This was on a 16 core machine with CONFIG_NR_CPUS=16 in .config file.

Note that "N" is a dynamic quantity, and can change scope if the bitmap
is changed in size.  So at the risk of stating the obvious, don't use it
for "burn_eFuse=128-N" or "secure_erase_firmware=32-N" type stuff.

Paul.
---

[v1: https://lore.kernel.org/lkml/20210106004850.GA11682@paulmck-ThinkPad-P72/

[v2: push code down from cpu subsys to core bitmap code as per
 Yury's comments.  Change "last" to simply be "N" as per PeterZ.

 Combination of the two got rid of needing strword() and greatly
 reduced complexity and footprint of the change -- thanks! ]

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>


Paul Gortmaker (3):
  lib: add "all" and "none" as valid ranges to bitmap_parselist()
  rcu: dont special case "all" handling; let bitmask deal with it
  lib: support N as end of range in bitmap_parselist()

 .../admin-guide/kernel-parameters.rst         | 15 +++++++++++
 .../admin-guide/kernel-parameters.txt         |  4 +--
 kernel/rcu/tree_plugin.h                      | 13 +++------
 lib/bitmap.c                                  | 27 +++++++++++++++----
 4 files changed, 42 insertions(+), 17 deletions(-)

-- 
2.17.1

