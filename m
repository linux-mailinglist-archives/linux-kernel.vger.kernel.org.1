Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63A72EB70E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 01:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbhAFAul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 19:50:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbhAFAuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:50:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94E74206C0;
        Wed,  6 Jan 2021 00:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894198;
        bh=kXWkmsAfpPes7J0Ow4JJcP8beLCwopKXeDCqI31bZQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mzvHpptT6tyQgMMsDyTMRHeMKxLwvdE7Ffd5GfNYnOmxiPXXW1NvBmLNnfR4pf7/b
         CW5ECNLe15cxSP92uqjZzZYcrXnwuO+B7p7STbxavE3nRqhogcD9u+smuJ1LoauKwu
         tLkyTfJL2kSOanNA/aaprtG9K+n3s1I1lqStgyiYLQ7frxAo2heKSSMtfi0D185qpF
         ZbpMyv7bfRKUbmEBbB72zXR4ZOqxUP9wwSa7ne29l1gTaE9YzSkoj+dTs+3Lzqds7P
         X0zi+003UTMqWKhecBFiBYwee3Lg9e/WX2eAhigpBBbhbyibr04VIFFCFrEzow/26n
         U9JU+ya2PzI0Q==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, yury.norov@gmail.com, kernel-team@fb.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC cpumask 1/5] cpumask: Un-inline cpulist_parse for SMP; prepare for ascii helpers
Date:   Tue,  5 Jan 2021 16:49:52 -0800
Message-Id: <20210106004956.11961-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106004850.GA11682@paulmck-ThinkPad-P72>
References: <20210106004850.GA11682@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

In order to support convenience tokens like "all", and "none" and
"last" in CPU lists, we'll have to use string operations and expand
on what is currently a simple wrapper around the underlying bitmap
function call.

Rather than add header dependencies to cpumask.h and code more complex
operations not really appropriate for a header file, we prepare by
simply un-inlining it here and move it to the lib dir alongside the
other more complex cpumask functions.

Since lib/cpumask.c is built conditionally on CONFIG_SMP, and there
are non-SMP callers, we leave the one-line stub behind for that case.
If they want to check "0-0" is a valid range, they can still do it.
In the meantime, we can add the ascii helpers for CONFIG_SMP users.
The use of NR_CPUS vs. CONFIG_SMP is consistent with the existing file.

Aside from an additional exported symbol in the SMP case, no functional
changes are anticipated with this move.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/cpumask.h |  8 ++++++++
 lib/cpumask.c           | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 383684e..1f506e2 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -685,11 +685,19 @@ static inline int cpumask_parse(const char *buf, struct cpumask *dstp)
  * @dstp: the cpumask to set.
  *
  * Returns -errno, or 0 for success.
+ *
+ * There are instances of non-SMP callers of this, and the easiest way
+ * to remain 100% runtime compatible is to let them continue to have the
+ * one-line stub, while the SMP version in lib/cpumask.c gets improved.
  */
+#if NR_CPUS == 1
 static inline int cpulist_parse(const char *buf, struct cpumask *dstp)
 {
 	return bitmap_parselist(buf, cpumask_bits(dstp), nr_cpumask_bits);
 }
+#else
+int cpulist_parse(const char *buf, struct cpumask *dstp);
+#endif
 
 /**
  * cpumask_size - size to allocate for a 'struct cpumask' in bytes
diff --git a/lib/cpumask.c b/lib/cpumask.c
index 3592402..6e6e835 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -95,6 +95,19 @@ int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
 }
 EXPORT_SYMBOL(cpumask_next_wrap);
 
+/**
+ * cpulist_parse - extract a cpumask from a user string of ranges
+ * @buf: the buffer to extract from
+ * @dstp: the cpumask to set.
+ *
+ * Returns -errno, or 0 for success.
+ */
+int cpulist_parse(const char *buf, struct cpumask *dstp)
+{
+	return bitmap_parselist(buf, cpumask_bits(dstp), nr_cpumask_bits);
+}
+EXPORT_SYMBOL(cpulist_parse);
+
 /* These are not inline because of header tangles. */
 #ifdef CONFIG_CPUMASK_OFFSTACK
 /**
-- 
2.9.5

