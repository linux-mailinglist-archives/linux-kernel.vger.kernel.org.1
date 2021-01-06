Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258AB2EB711
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 01:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbhAFAuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 19:50:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:53340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbhAFAuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:50:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B673F22227;
        Wed,  6 Jan 2021 00:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894198;
        bh=C2yf3BknGOpHZFxazEamymA3rsOUn4jMELiJWCDEFd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fBKMCg3lX2CW6+T8nqyeC8WFBsiNHzILDzX5NpC4tc1hQjDKK6PlO6BNgm+VAGkGq
         rD9BFzgXzm0J1kuvPA4l/9dUD+vrDUU4hURGWrj7t2cdGQMDyTgtHH3hMbj/8AFugZ
         bZaxe0g7uhG2utSlTiJxp1lEcQACxVbz71E6D7xsDOPwskMH5RYgYKH7RbJ2bbJVgR
         BivY62r//0ehA6b9QfKUIdMXrvb4JgvRtMgVZpIX8cuxaNoewXNdZzelVCt/uucv85
         wTQtXdcegbUFDdMd3ySSOOR01oxOE6O2ZMLBElVkMXw+Lezs5G0+5yWKsWOEzZ78or
         BxLHkrnuz0CpA==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, yury.norov@gmail.com, kernel-team@fb.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC cpumask 2/5] cpumask: Make "all" alias global and not just RCU
Date:   Tue,  5 Jan 2021 16:49:53 -0800
Message-Id: <20210106004956.11961-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106004850.GA11682@paulmck-ThinkPad-P72>
References: <20210106004850.GA11682@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

It is probably better that we don't have subsystem specific
abbreviations or aliases for generic CPU list specifications.

Hence we move the "all" from RCU out to lib/ so that it can be
used in any instance where CPU lists are being parsed.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.rst |  7 +++++++
 Documentation/admin-guide/kernel-parameters.txt |  4 +---
 kernel/rcu/tree_plugin.h                        | 13 ++++---------
 lib/cpumask.c                                   |  6 ++++++
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 06fb1b4..cdf4e81 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -68,6 +68,13 @@ For example one can add to the command line following parameter:
 
 where the final item represents CPUs 100,101,125,126,150,151,...
 
+The following convenience aliases are also accepted and used:
+
+        foo_cpus=all
+
+is equivalent to "foo_cpus=0-N" -- where "N" is the numerically last CPU on
+the system, thus avoiding looking up the value in "/sys/devices/system/cpu"
+in advance on each deployed system.
 
 
 This document may not be entirely up to date and comprehensive. The command
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c722ec1..0f4379b 100644
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
index 7e291ce..642ebd6 100644
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
diff --git a/lib/cpumask.c b/lib/cpumask.c
index 6e6e835..9f8ff72 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -2,6 +2,7 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include <linux/cpumask.h>
 #include <linux/export.h>
 #include <linux/memblock.h>
@@ -104,6 +105,11 @@ EXPORT_SYMBOL(cpumask_next_wrap);
  */
 int cpulist_parse(const char *buf, struct cpumask *dstp)
 {
+	if (!strcmp(buf, "all")) {
+		cpumask_setall(dstp);
+		return 0;
+	}
+
 	return bitmap_parselist(buf, cpumask_bits(dstp), nr_cpumask_bits);
 }
 EXPORT_SYMBOL(cpulist_parse);
-- 
2.9.5

