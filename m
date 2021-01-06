Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B0A2EB70D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 01:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbhAFAum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 19:50:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:53368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbhAFAuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:50:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0226F22E03;
        Wed,  6 Jan 2021 00:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894199;
        bh=RCfSBa6AomQi5E09zrPDAyL2+mAhfEepMXXhUQuxMrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hMRy9nojh3N56g3Gdmk0KVScjjnVuUKE0XtStujm1n2155Xo/1QVGS2BzBuzqtlp8
         MI2vl6tZuHf8ezYJH9maJOGiVrzqAYZVvGB80W/RIh5YNq4xW+ZmARz6CxXHW76XLO
         vXGb+NoEuHTF9fzH4IVXxg7SBcLbmCNzNhZlElcsKRu7dy8AaoUe6PJloidotZY3Yj
         P5+YxYd+3V+bed3bdh6MrGZg/TxFKd7SYTL5k+Jk2xaIJohqihEgeGxfxdpzVkxsBc
         dHx8VSXR8NVod7pdyeP/N93lfT+mBBt3FRswkN5iNcA12ZAk7g1db+Tz7A2JU/TnZ+
         rXTAAMFovd1fg==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, yury.norov@gmail.com, kernel-team@fb.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC cpumask 4/5] cpumask: Add "last" alias for cpu list specifications
Date:   Tue,  5 Jan 2021 16:49:55 -0800
Message-Id: <20210106004956.11961-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106004850.GA11682@paulmck-ThinkPad-P72>
References: <20210106004850.GA11682@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

It seems that a common configuration is to use the 1st couple cores
for housekeeping tasks, and or driving a busy peripheral that generates
a lot of interrupts, or something similar.

This tends to leave the remaining ones to form a pool of similarly
configured cores to take on the real workload of interest to the user.

So on machine A - with 32 cores, it could be 0-3 for "system" and then
4-31 being used in boot args like nohz_full=, or rcu_nocbs= as part of
setting up the worker pool of CPUs.

But then newer machine B is added, and it has 48 cores, and so while
the 0-3 part remains unchanged, the pool setup cpu list becomes 4-47.

Deployment would be easier if we could just simply replace 31 and 47
with "last" and let the system substitute in the actual number at boot;
a number that it knows better than we do.

No need to have custom boot args per node, no need to do a trial boot
in order to snoop /proc/cpuinfo and/or /sys/devices/system/cpu - no
more fencepost errors of using 32 and 48 instead of 31 and 47.

A generic token replacement is used to substitute "last" with the
number of CPUs present before handing off to bitmap processing.  But
it could just as easily be used to replace any placeholder token with
any other token or value only known at/after boot.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.rst |   7 ++
 lib/cpumask.c                                   | 112 +++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 7dd1224..5f441ef 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -83,6 +83,13 @@ will provide an empty/cleared cpu mask for the associated boot argument.
 Note that "all" and "none" are not necessarily valid/sensible input values
 for each available parameter expecting a CPU list.
 
+        foo_cpus=1,3,5,16-last
+
+will at runtime, replace "last" with the number of the last (highest number)
+present CPU on the system.  Thus a common deployment can be used on multiple
+systems with different total number of cores present, without needing to
+evaluate the total core count in advance on each system.
+
 This document may not be entirely up to date and comprehensive. The command
 "modinfo -p ${modulename}" shows a current list of all parameters of a loadable
 module. Loadable modules, after being loaded into the running kernel, also
diff --git a/lib/cpumask.c b/lib/cpumask.c
index 7fbcab8..97a005f 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/string.h>
+#include <linux/ctype.h>
 #include <linux/cpumask.h>
 #include <linux/export.h>
 #include <linux/memblock.h>
@@ -96,15 +97,97 @@ int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
 }
 EXPORT_SYMBOL(cpumask_next_wrap);
 
+/*
+ * Basically strstr() but given "foo", ignore "foobar", "myfoo", "foofoo"
+ * and "foo2bar" -- i.e. any case where the token is a word fragment.
+ */
+static char *cpumask_find_token(const char *str, const char *token)
+{
+	char *here = strstr(str, token);
+	size_t tlen = strlen(token);
+
+	if (!here)
+		return NULL;
+
+	while (here) {
+		size_t offset = here - str;
+		char prev, next = str[offset + tlen];
+
+		if (offset)
+			prev = str[offset - 1];
+		else
+			prev = '\0';
+
+		if (!(isalnum(prev) || isalnum(next)))
+			break;
+
+		here = strstr(here + tlen, token);
+	}
+
+	return here;
+}
+
+/*
+ * replace old token with new token: Given a convenience or placeholder
+ * token "last" and an associated value not known until boot, of say 1234,
+ * replace instances of "last" with "1234".
+ *
+ * For example src = "1,3,last,7-last,9,lastly,last-2047\0"  results in a
+ *            dest = "1,3,1234,7-1234,9,lastly,1234-2047\0"
+ *
+ * The destination string may be shorter than, equal to, or longer than
+ * the source string -- based on whether the new token strlen is shorter
+ * than, equal to, or longer than the old token strlen.
+ * The caller must allocate dest space accordingly with that in mind.
+ */
+
+static void cpulist_replace_token(char *dest, const char *src,
+			   const char *old_token, const char *new_token)
+{
+	const char *src_start = src;
+	char *dest_start = dest, *here;
+	const size_t olen = strlen(old_token);
+	const size_t nlen = strlen(new_token);
+
+	here = cpumask_find_token(src_start, old_token);
+	if (!here) {
+		strcpy(dest, src);
+		return;
+	}
+
+	while (here) {
+		size_t offset = here - src_start;
+
+		strncpy(dest_start, src_start, offset);
+		dest_start += offset;
+		src_start += offset;
+
+		strcpy(dest_start, new_token);
+		dest_start += nlen;
+		src_start += olen;
+
+		strcpy(dest_start, src_start);	/* remainder of string */
+		here = cpumask_find_token(src_start, old_token);
+	}
+}
+
 /**
  * cpulist_parse - extract a cpumask from a user string of ranges
  * @buf: the buffer to extract from
  * @dstp: the cpumask to set.
  *
  * Returns -errno, or 0 for success.
+ *
+ * Marked __ref because memblock_*() are __meminit and we use them for
+ * any early calls before slab is available.
  */
-int cpulist_parse(const char *buf, struct cpumask *dstp)
+int __ref cpulist_parse(const char *buf, struct cpumask *dstp)
 {
+	int r;
+	char *cpulist, last_cpu[5];	/* NR_CPUS <= 9999 */
+	size_t len = strlen(buf) + 1;	/* don't forget '\0' */
+	bool early = !slab_is_available();
+
 	if (!strcmp(buf, "all")) {
 		cpumask_setall(dstp);
 		return 0;
@@ -115,7 +198,32 @@ int cpulist_parse(const char *buf, struct cpumask *dstp)
 		return 0;
 	}
 
-	return bitmap_parselist(buf, cpumask_bits(dstp), nr_cpumask_bits);
+	/*
+	 * strlen("last") means "len" is OK up to NR_CPUS <= 9999.
+	 */
+	if (early)
+		cpulist = memblock_alloc(len, SMP_CACHE_BYTES);
+	else
+		cpulist = kzalloc(len, GFP_KERNEL);
+
+	if (cpulist == NULL)
+		return -ENOMEM;
+
+	/*
+	 * bitmap_parselist has no concept of "last" CPU, so we have to
+	 * replace "last" with a real number in dest copy of the string.
+	 */
+	sprintf(last_cpu, "%d", cpumask_last(cpu_present_mask));
+	cpulist_replace_token(cpulist, buf, "last", last_cpu);
+
+	r = bitmap_parselist(cpulist, cpumask_bits(dstp), nr_cpumask_bits);
+
+	if (early)
+		memblock_free((phys_addr_t)cpulist, len);
+	else
+		kfree(cpulist);
+
+	return r;
 }
 EXPORT_SYMBOL(cpulist_parse);
 
-- 
2.9.5

