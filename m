Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9282C4EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 07:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388033AbgKZGa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 01:30:58 -0500
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com ([40.107.244.73]:28705
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388013AbgKZGa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 01:30:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5pzYt4Cv9la1qbM0PcUCpY7mB9oGQ0e1bndaLTkuPzciPf0pESDzrkIgEMz/yun7fO2WuGtN99/gycHBY/K+XpY2kQ9tqk2nN0sfXzcF2JR341mbnuJZjKbITl2l5eHzAWq6aXLoNDDjainL8X4kg8ClF7cvOt8lXOyegjq3uUeqx/ApsW/QToARdGhwqwagBhnn0yY7UnfYdc5hUMniLeQk6yWSuuEdCqRfxVEluLSy04BERJHtC8v3oCDaqpKDe/4THOKCSeBzpMzW+YFWkDzesZ5TebZj1CjsAgGm3aDw4jOl2uEHaaFSWwm1s2PAGlr89wL1Bx0l4hKmg3pmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wzJ5giwPjPHW7Q26WpTetrLZtanimzgoB/feXqV/vo=;
 b=bTXQQFrdDxd2HKQSYc00dvO4Nu6AGtYhQWKL+XTu0jHGQGkccgd1q+b45PFM4t2GGZPD7C6WWaYXHwor9rDu9FUVZlBsbkozxJ+yR1L8OpNUZHyMzHtMMqIkbrcCCVtvkob7pD8d1MkCUsGCuwJu1pSRch4vi/TqKSocgrXCM/dzdPEF1Qi/qloFlI+EqOJmDaom9XZ7LupH0Yz509FHiHZp7SbI1s2aCdh/0bPuA8N16TuHRX6h3oILh1ThdRdtldNAOuOVeFn5JF3c8iwd6Uzg8D4zswY3Fz3H30Z5l3efgj7qr6xE4/qlh/7GgiYEWNv+X8XYTb4vprC4AyLZ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wzJ5giwPjPHW7Q26WpTetrLZtanimzgoB/feXqV/vo=;
 b=kRcsfx4/caP7MNUvXicbzUBPl4rfTRSUwwphdydbnTf6uTq83dATwSVMygtwxIrqfUqD7sQ86MfzHKM/alSnJ2iy3wCo7neNKU87c+AvkaFe4suMNUG6T6OMvQevE7iMaEKTnqlJ6WBjr5Tjm78F8+NhAfpsY50LyZ3Nucu5N5Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2762.namprd11.prod.outlook.com (2603:10b6:5:c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.29; Thu, 26 Nov
 2020 06:30:54 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40%4]) with mapi id 15.20.3611.025; Thu, 26 Nov 2020
 06:30:54 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 1/3] clear_warn_once: expand debugfs to include read support
Date:   Thu, 26 Nov 2020 01:30:27 -0500
Message-Id: <20201126063029.2030-2-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126063029.2030-1-paul.gortmaker@windriver.com>
References: <20201126063029.2030-1-paul.gortmaker@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::25) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hackbox.wrs.com (128.224.252.2) by YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Thu, 26 Nov 2020 06:30:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13cda8db-edd0-4282-cbfa-08d891d4d3ce
X-MS-TrafficTypeDiagnostic: DM6PR11MB2762:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB27628DE3B996120601664A8083F90@DM6PR11MB2762.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QxrFPxQVEz+LZCfi/Nr97gZj9KO9lJknu4Gw0PdIkIOcOkQ9aKqu2D1RbHr/DrmlymsWCkVSL4v2vljgkH84T0gMDdmWE7TXuQibtwyfZfMOZAZcKhEgG99CkombtOcIt2KTuuvfN7gqSJJroxyAYqpKrFjV41RiZ81suv0ZMRdMMZuM+gdeEKQKVfIvUqz6R2sXJ8P8Khut6Y9NdQdkpZ47qn4KKDlnnilFFmrs93ICfZGtzdU6CvjywppHGb5YrodEgbfDO0cz4R/BtoGDdQ6Z/5UWxlAH+uHQtpYI/NhnC6+2P3iK0efuLCU6Z2Nk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(39850400004)(376002)(2616005)(66946007)(6666004)(66476007)(44832011)(6512007)(66556008)(478600001)(956004)(2906002)(4326008)(5660300002)(8936002)(8676002)(6506007)(54906003)(186003)(16526019)(1076003)(52116002)(316002)(6486002)(86362001)(6916009)(36756003)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YNhcLc9OU5zIZPTlt9d3Nu0yZRK9Fg5haX3+PpfGYr8MECtlvVzSjRfYRrq4?=
 =?us-ascii?Q?W3NOo45WfexQmYBGcNldXbOzcqQ+BkiwGX65mZ91R5cpU9qpKe1gIe3k6wuw?=
 =?us-ascii?Q?Zgd0FKCdQzIq9LbZKA3fEG2nzoNjRjDPArt3ZQL/u20Wydfp2kDy/yCryXdF?=
 =?us-ascii?Q?3NQCKInx3yqo0YNqI9fVn6yEms7u0WGu3NVSgiHi2O6QF7tfzrPuKYN9BXC+?=
 =?us-ascii?Q?XMuAwXZWcHLG+YeHHBmMJsbieVemEB/pkcxhxR7vSPcwrZSFf9ErLxpIxyZp?=
 =?us-ascii?Q?mlhhlCJS3Dj0jBnYnN7vdUAy8RWCsLKcfxRP25sEW8PPL+64mGRdIbH2Opzr?=
 =?us-ascii?Q?DKO8kH5t2qqylMkaglPNVbQITpNJldM6e41ZzzP62rkPBI8smjLVpYMbrOqv?=
 =?us-ascii?Q?WXaLZmFQpOTg1xuvl2cOK4qtYdv1+UT2dokjp4w6yXNLZFoctKTGxthRLhxe?=
 =?us-ascii?Q?ZOmrgyV/GMFZvlGyU3OjcDiOTkTD8VRS78VjpFahE3s1eJtGob6hR2QENrY5?=
 =?us-ascii?Q?c6S3mrXzUyqnjnbdnce1EdBz+jVBo5EMQRVyx6SnJlj6VKkrnY7bz0icEYrc?=
 =?us-ascii?Q?8bvqHNF83ajPbjdZYPQ7zrMRqFub+f9R2QUXTiUOSa7Cy6RKZMaNqI6hGxGp?=
 =?us-ascii?Q?ci7eD+Uy0eesLxl8ky/gjU76QH6g6xjBVpfXGyq2rqTnOnMxdXdKvrtBhVjo?=
 =?us-ascii?Q?/rBx6t+/5R4J/B23FXHdtCQP0aTuu34I8U3P16nxXsQxTv/LHiYV044i43xN?=
 =?us-ascii?Q?wbPJPUvpkoVT6853nFKAadQZGJGx2noUaE5bcryXhn31h4GIFsOIhOPD0stK?=
 =?us-ascii?Q?RZFhqEVCtEe+wdwWqeiOW+OlMXRb3u36UKPQaJY5KSpmpr4w/bmz+p0KgewB?=
 =?us-ascii?Q?jltQex8r8xaPzraUJgzo++pIJ8kJI1yJ0vmgtKoHT4eqRlBds9FDeOUDkeCu?=
 =?us-ascii?Q?WvJWNOLD4NLCVjGWXEOkppPfoecoSGYkjevLVv5ZT5tPSV1DIv+Dh7rsRwKk?=
 =?us-ascii?Q?J6z/?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13cda8db-edd0-4282-cbfa-08d891d4d3ce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 06:30:54.6799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BP6209z8oYr4esyNIaZQ6aiSu0G44tW2xAIBW8og4goITUzZZqygxxgD5ihoJBIyzrbGxjse8v/9tcOBo1ToZpgDM+Y6w7lJv3ipwjAZyo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2762
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing clear_warn_once variable is write-only; used as per the
documentation to reset the warn_once to as-booted state with:

	echo 1 > /sys/kernel/debug/clear_warn_once

The objective is to expand on that functionality, which requires the
debugfs variable to be read/write and not just write-only.

Here, we deal with the debugfs boilerplate associated with converting
it from write-only to read-write, in order to factor that out for easier
review, and for what may be a possible future useful bisect point.

Existing functionality is unchanged - the only difference is that we
have tied in a variable that lets you now read the variable and see
the last value written.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 kernel/panic.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 332736a72a58..1d425970a50c 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -654,21 +654,36 @@ EXPORT_SYMBOL(__warn_printk);
 
 /* Support resetting WARN*_ONCE state */
 
-static int clear_warn_once_set(void *data, u64 val)
+static u64 warn_once_reset;
+
+static void do_clear_warn_once(void)
 {
 	generic_bug_clear_once();
 	memset(__start_once, 0, __end_once - __start_once);
+}
+
+static int warn_once_get(void *data, u64 *val)
+{
+	*val = warn_once_reset;
+	return 0;
+}
+
+static int warn_once_set(void *data, u64 val)
+{
+	warn_once_reset = val;
+
+	do_clear_warn_once();
 	return 0;
 }
 
-DEFINE_DEBUGFS_ATTRIBUTE(clear_warn_once_fops, NULL, clear_warn_once_set,
-			 "%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(clear_warn_once_fops, warn_once_get, warn_once_set,
+			 "%llu\n");
 
 static __init int register_warn_debugfs(void)
 {
 	/* Don't care about failure */
-	debugfs_create_file_unsafe("clear_warn_once", 0200, NULL, NULL,
-				   &clear_warn_once_fops);
+	debugfs_create_file_unsafe("clear_warn_once", 0600, NULL,
+				   &warn_once_reset, &clear_warn_once_fops);
 	return 0;
 }
 
-- 
2.25.1

