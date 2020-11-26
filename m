Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CC42C4EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 07:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388042AbgKZGbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 01:31:00 -0500
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com ([40.107.244.73]:28705
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388010AbgKZGa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 01:30:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHyCEhSZp6ummQ152NJDTgofZpy9WFnMwFd+LXjQ7EBaz8ePQiz5tvkjzCQNPeINejIuEbNC6/tZAOd1Q/RJ19masmxuy/NDYMGKuEr4xj4Pt26MOHOkKgQZONXA6zt96v1v9Kncckwwd5CTB0J46PMTuBJN+UIaFAPS8OB2T6wTm3lUtfYpLWk8LvD7r+cF7lJSxotriWSBDBEE7RE5iQ1Bdw6U4QZ18nCqweO2vkP9SIZPkdDxi0xNv++MVe2/vMOPw99pw4C0cy7ShRcYXG6UM1spdxuGRRBlZu7M+o9z0kiEy4s3P5yjCW0Xr3GBO6vPvXhMQ7iRbxVLcyMWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+DRlX8rbFAHXEn9CERl+7im98OIga9fsTFheGa8Xn4=;
 b=Px1NJi1hpRxNcTpVtDW+5QN34lwYnvwHa3xU+IESiLOH/lchsjXitjPavMLFmYeUUFUV/7Hto/DU2CgIF7/TayrcBvL4e5g+i2gkUNNWQN5tpKFdLkR8POttDc30j8bYFXHNMMwOp9KY2CfsW2JP3srtOCr7Gu9R1rEVGCCPWQqxWsiL8xK1KDk4bW5pOmkRWdLtSaYicUiQ+aWzF8XgUBIPcv6MFSnEqpkrqfkraWwYpTYmxO6nAx6CWUinhDhhsRrIZf1RMSc99dJOEzOcRgIa20gjujeT2hd+taFeczWjHz5xIDigkrV0CRCAcdyAoFr+eLMbupzlfuAjB+H+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+DRlX8rbFAHXEn9CERl+7im98OIga9fsTFheGa8Xn4=;
 b=JAKH5RHAgSXtU7TpmptnhRdiKiQxXsX1QyTIrut/jvtQ0lv56gH2yN18zzKKpZ/Sz4QkG+vgvk/t4tAo7iEHVbrfrk2CYDK+uEPk1WvqhkijsGYvH3e9eyWhSM1SW1K28DPBO0H499A5iK9iqsoBM9JKJs0gMnhK5yTg4yXMQ0E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2762.namprd11.prod.outlook.com (2603:10b6:5:c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.29; Thu, 26 Nov
 2020 06:30:55 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40%4]) with mapi id 15.20.3611.025; Thu, 26 Nov 2020
 06:30:55 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 2/3] clear_warn_once: bind a timer to written reset value
Date:   Thu, 26 Nov 2020 01:30:28 -0500
Message-Id: <20201126063029.2030-3-paul.gortmaker@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: d6aaba21-ae90-48c4-5348-08d891d4d443
X-MS-TrafficTypeDiagnostic: DM6PR11MB2762:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB2762197E36D55B92E08EA5E183F90@DM6PR11MB2762.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brbY4KN5qzS4dNv3csx8Ram6x72ZyIXDS7k0lW5hqZizQHD/S1IOOrl9tZjY+shQVpCnH/S3mLWQToPSaAonK9UOb2fMO4xZUo83yEpZsVAWkDRFUmxD6ylrnIkuF35n6DYE+JLKAXOVwBsNdV4IaNRNFG+IluPTedkIyoLsNJHEzcQ+TpSPBydzQERxMj65ZpS0lYiEpcD2WS5fAPvbGjlSAMnW7tRi/CxdK7q3wx1ufXKSPPuAn7xp60KXDXtUXIkMF0g4GHo9IHiDd4ao9H0LpIUdVE8Jg429M/Y5RHfPMZM6/iMx0nimOA/blNd2fItnJnIxMk9xrcRiKySCdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(39850400004)(376002)(2616005)(66946007)(6666004)(66476007)(44832011)(6512007)(66556008)(478600001)(956004)(2906002)(4326008)(5660300002)(8936002)(8676002)(6506007)(54906003)(186003)(16526019)(1076003)(52116002)(316002)(6486002)(86362001)(6916009)(36756003)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6ij9XsXHBmK5bTP55qL1/2DzB420CeX+Eq5Qhu3p28h+vZlf6gl5y0UfTgEw?=
 =?us-ascii?Q?gO4CfRroti+SuGj+0rXN1i1jInkcb9MAPQn+Hmnn1gbEw7VYeWpdD3LHW6Ws?=
 =?us-ascii?Q?Cz/SFMrjOmVwYPXMkcYK62ttyGgSF7tk8fPXlQv2cvdALFmhL2NPKlxtXn5V?=
 =?us-ascii?Q?CT9zAg1EjSoWc/1dkBBbdqUDoyhXJseag17xUf02dSWY59o6vLZwBnaZHNc6?=
 =?us-ascii?Q?A4kqqQidxtnwkCO2o2dZD3ZMJCFuQs4lzT9OiCo3HlDcRF1SROfxvsrvUQqC?=
 =?us-ascii?Q?TN7QVZ35Y4VGq+Xx/3HkgKq2H+tW3Mkf9iEtLjuYpYEH4Zcmgzcv5g8FAmlp?=
 =?us-ascii?Q?HYJhpO7OgAu3HBE4VhtfkHtIPfZH5yhoyG87bkbpJmrIbg1vDa6EfVNtJx8n?=
 =?us-ascii?Q?eIN/dPG6QWFc2icteavyDETPjOkeDiqg08dPpqItInlYOOT0Gvfast5/oCCs?=
 =?us-ascii?Q?uGU/dIsswDPhfA7lnJ6ZytlswSAirqeQcrkILriZGxWJ4suDBL/vu0i+lEfw?=
 =?us-ascii?Q?zW0oVwQ0POWrjrWoPygTE0dCM1gBsypxSdbTb9BOMRafKm2GhC9yB45lkypW?=
 =?us-ascii?Q?/i8Nu60TZNd7MXg28C2P9Bieg25ivbi5T2PicDOundILb1nfkS8U7n+8ca4y?=
 =?us-ascii?Q?DUQQi+YpyJ7Tl3kYvsR2vQICk7BfMl/lQpVnt2KhNC3nt7sTHDE5wXTpQgNy?=
 =?us-ascii?Q?VMbKA71ikvMGh16UZVv+g+eU1EkLaDtzjku9OO7nW1/VVtuI2H7W1ncq8qU0?=
 =?us-ascii?Q?u8XOKDVIvl5hcfuZj8/jTJ2QXUB/kqg61l1+CF5eEEyJzOWpjdFhzObsRFEX?=
 =?us-ascii?Q?lOB1utaIa+EfyJQCXWB+E8SRtJZ2JFuYckmB18aFkESGrHymAwg4BENVHiy2?=
 =?us-ascii?Q?mjZsTnBlc0bOit/i6UsZt6MrX50W5v5+lleGSFVEHJE42e4fhbTRcgo3QWNJ?=
 =?us-ascii?Q?pK5DdOsC9+Na5cXK2UAyk8D5uGkr764Pj7X0SkDPkJTBMnpO3Yp0qVHrePS7?=
 =?us-ascii?Q?T0q3?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6aaba21-ae90-48c4-5348-08d891d4d443
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 06:30:55.4336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKR1Rv2U+H8NeYTV0X+GeXXOyno9XRtAkYs/f0Rh2gNTSFUf8WKT8tzfiBxs3wP1aC0olSWI7I6q/PjEKZDJV0j1oqSaJj7Jaa/L5djYB80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2762
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing documentation has a write of "1" to clear/reset all the
WARN_ONCE and similar to the as-booted state, so they can possibly
be re-triggered again during debugging/testing.

But having them auto-reset once a day, or once a week, might shed
valuable information to a sysadmin on what the system is doing.

Here we extend the existing debugfs variable to bind a timer to the
written value N, so that it will reset every N seconds, for N>1.
Writing a zero will clear any previously set timer value.

The pre-existing behaviour of writing N=1 will do a one-shot clear.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 .../admin-guide/clearing-warn-once.rst        |  9 ++++++
 kernel/panic.c                                | 32 +++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/Documentation/admin-guide/clearing-warn-once.rst b/Documentation/admin-guide/clearing-warn-once.rst
index 211fd926cf00..93cf3ba0b57d 100644
--- a/Documentation/admin-guide/clearing-warn-once.rst
+++ b/Documentation/admin-guide/clearing-warn-once.rst
@@ -7,3 +7,12 @@ echo 1 > /sys/kernel/debug/clear_warn_once
 
 clears the state and allows the warnings to print once again.
 This can be useful after test suite runs to reproduce problems.
+
+Values greater than one set a timer for a periodic state reset; e.g.
+
+echo 3600 > /sys/kernel/debug/clear_warn_once
+
+will establish an hourly state reset, effectively turning WARN_ONCE
+into a long period rate-limited warning.
+
+Writing a value of zero (or one) will remove any previously set timer.
diff --git a/kernel/panic.c b/kernel/panic.c
index 1d425970a50c..a23eb239fb17 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -655,6 +655,7 @@ EXPORT_SYMBOL(__warn_printk);
 /* Support resetting WARN*_ONCE state */
 
 static u64 warn_once_reset;
+static bool warn_timer_active;
 
 static void do_clear_warn_once(void)
 {
@@ -662,6 +663,14 @@ static void do_clear_warn_once(void)
 	memset(__start_once, 0, __end_once - __start_once);
 }
 
+static void timer_warn_once(struct timer_list *timer)
+{
+	do_clear_warn_once();
+	timer->expires = jiffies + warn_once_reset * HZ;
+	add_timer(timer);
+}
+static DEFINE_TIMER(warn_reset_timer, timer_warn_once);
+
 static int warn_once_get(void *data, u64 *val)
 {
 	*val = warn_once_reset;
@@ -672,6 +681,29 @@ static int warn_once_set(void *data, u64 val)
 {
 	warn_once_reset = val;
 
+	if (val > 1) {		/* set/reset new timer */
+		unsigned long expires = jiffies + val * HZ;
+
+		if (warn_timer_active) {
+			mod_timer(&warn_reset_timer, expires);
+		} else {
+			warn_timer_active = 1;
+			warn_reset_timer.expires = expires;
+			add_timer(&warn_reset_timer);
+		}
+		return 0;
+	}
+
+	if (warn_timer_active) {
+		del_timer_sync(&warn_reset_timer);
+		warn_timer_active = 0;
+	}
+	warn_once_reset = 0;
+
+	if (val == 0)		/* cleared timer, we are done */
+		return 0;
+
+	/* Getting here means val == 1  --->  so clear existing data */
 	do_clear_warn_once();
 	return 0;
 }
-- 
2.25.1

