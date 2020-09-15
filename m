Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F019A26A4C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgIOMNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgIOMHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:07:52 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0077C06178C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:57:34 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id c13so3520440oiy.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SjN6Sbz685HbGk+sJsbH1Fh1ldcWZ+Dadcn+VU5QALs=;
        b=AfE8TXNjYIEH8mopIpxb89YVNWZnRZk1pETmJZmj+XyDt4oJv3gi2ANzRqQnygCQG6
         0tS+dwpgz0zVU8eW4vcfxFE3jiIOLWK+VAjlkxKqSy/bWAag4yo5Z4+loQX7MHs/jz7Q
         jSTKVdtYc9B/qi9lh6mhQ9BmJlYwk2HsLQY9u8lwyYs8eg0Z1lSbxgxiXQzxUSck3+HV
         gKjZgdp8cMiMdXoo1jTIWxWLSYTz3KBiZ/1MH02a0zCbRBXYlW9xfaix/H6t0nj1e+DJ
         UvYJ39xsRVI7bKXw2q8ztf84RJcTcO2mVB7CojIZ69zAg+A1WVIXFByrR/T6pSrycK9t
         dC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SjN6Sbz685HbGk+sJsbH1Fh1ldcWZ+Dadcn+VU5QALs=;
        b=r44O1sxtAa43BWs0IQNOUFxIAIKwI96ugizZvJ2JNlSDWiFur08g7FzZjvuKuK2x7L
         vCsydKE0pTadncYyT/NIaZdv9cgcLeuMced8skE7lub84ngkmqTL0Ywi4caljTEk5Cuk
         e9wRv9p4RMQohnubMXVgURYCfMVKVgh/e8YLfyDeS9Brl/wULD+/sWVvpz8fXxjkW5LR
         b9EjOJ2fKLk/Vv/QVc3kRs+qrCVNx2vIB7xom4dg8Wg48Tk1amcXxBrJyHSDEJPy1L/v
         /DxMRcyi6j69jMGPUPxLtwqta+NXdo0Wy2hy6l6+znjOOrw+Usw1JAT8fYH6AQR35xjB
         POnA==
X-Gm-Message-State: AOAM532qcG8lidt73Hy9k9bMvSUmVQs06Jkjn8OqLr1cL10mRTlYiEn6
        6QXkRkjeKYvkMZ8JW+/BmZ0=
X-Google-Smtp-Source: ABdhPJy0g3+77p720ruEEmIRYo8NvtwDeWJFy9bJXpoJHU7rYYCSEX7NXjt/vhlyyBk6WsxQq4PNRw==
X-Received: by 2002:aca:60d5:: with SMTP id u204mr2900844oib.8.1600171052241;
        Tue, 15 Sep 2020 04:57:32 -0700 (PDT)
Received: from localhost.localdomain ([111.205.198.3])
        by smtp.gmail.com with ESMTPSA id y17sm5373055otq.68.2020.09.15.04.57.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 04:57:31 -0700 (PDT)
From:   qianjun.kernel@gmail.com
To:     tglx@linutronix.de, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Cc:     laoar.shao@gmail.com, qais.yousef@arm.com, urezki@gmail.com,
        jun qian <qianjun.kernel@gmail.com>
Subject: [PATCH V7 4/4] softirq: Allow early break the softirq processing loop
Date:   Tue, 15 Sep 2020 19:56:09 +0800
Message-Id: <20200915115609.85106-5-qianjun.kernel@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200915115609.85106-1-qianjun.kernel@gmail.com>
References: <20200915115609.85106-1-qianjun.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jun qian <qianjun.kernel@gmail.com>

Allow terminating the softirq processing loop without finishing the vectors.

Signed-off-by: jun qian <qianjun.kernel@gmail.com>
---
 kernel/softirq.c | 113 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 91 insertions(+), 22 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index cbb59b5..29cf079 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -254,6 +254,22 @@ static inline bool __softirq_needs_break(u64 start)
 	return false;
 }
 
+#define SOFTIRQ_PENDING_MASK ((1UL << NR_SOFTIRQS) - 1)
+
+/*
+ * The pending_next_bit is recorded for the next processing order when
+ * the loop is broken. This per cpu variable is to solve the following
+ * scenarios:
+ * Assume bit 0 and 1 are pending when the processing starts. Now it
+ * breaks out after bit 0 has been handled and stores back bit 1 as
+ * pending. Before ksoftirqd runs bit 0 gets raised again. ksoftirqd
+ * runs and handles bit 0, which takes more than the timeout. As a
+ * result the bit 0 processing can starve all other softirqs.
+ *
+ * so we need the pending_next_bit to record the next process order.
+ */
+DEFINE_PER_CPU(u32, pending_next_bit);
+
 asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
 	u64 start = sched_clock();
@@ -261,8 +277,11 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	unsigned int max_restart = MAX_SOFTIRQ_RESTART;
 	struct softirq_action *h;
 	unsigned long pending;
+	unsigned long pending_left, pending_again;
 	unsigned int vec_nr;
 	bool in_hardirq;
+	int next_bit;
+	unsigned long flags;
 
 	/*
 	 * Mask out PF_MEMALLOC as the current task context is borrowed for the
@@ -283,25 +302,66 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 	local_irq_enable();
 
-	for_each_set_bit(vec_nr, &pending, NR_SOFTIRQS) {
-		int prev_count;
-
-		__clear_bit(vec_nr, &pending);
-
-		h = softirq_vec + vec_nr;
-
-		prev_count = preempt_count();
-
-		kstat_incr_softirqs_this_cpu(vec_nr);
+	/*
+	 * pending_left means that the left bits unhandled when the loop is
+	 * broken without finishing the vectors. These bits will be handled
+	 * first in the next time. pending_again means that the new bits is
+	 * generated in the other time. These bits should be handled after
+	 * the pending_left bits have been handled.
+	 *
+	 * For example
+	 * If the pending bits is 1101010110, and the loop is broken after
+	 * the bit4 is handled. Then, the pending_next_bit will be 5, and
+	 * the pending_left is 1101000000, the pending_again is 000000110.
+	 */
+	next_bit = __this_cpu_read(pending_next_bit);
+	pending_left = pending &
+		(SOFTIRQ_PENDING_MASK << next_bit);
+	pending_again = pending &
+		(SOFTIRQ_PENDING_MASK >> (NR_SOFTIRQS - next_bit));
+
+	while (pending_left || pending_again) {
+		if  (pending_left) {
+			pending = pending_left;
+			pending_left = 0;
+		} else if (pending_again) {
+			pending = pending_again;
+			pending_again = 0;
+		} else
+			break;
+		for_each_set_bit(vec_nr, &pending, NR_SOFTIRQS) {
+			int prev_count;
+
+			__clear_bit(vec_nr, &pending);
+
+			h = softirq_vec + vec_nr;
+
+			prev_count = preempt_count();
+
+			kstat_incr_softirqs_this_cpu(vec_nr);
+
+			trace_softirq_entry(vec_nr);
+			h->action(h);
+			trace_softirq_exit(vec_nr);
+			if (unlikely(prev_count != preempt_count())) {
+				pr_err("huh, entered softirq %u %s %p with preempt_count %08x, exited with %08x?\n",
+				       vec_nr, softirq_to_name[vec_nr], h->action,
+				       prev_count, preempt_count());
+				preempt_count_set(prev_count);
+			}
 
-		trace_softirq_entry(vec_nr);
-		h->action(h);
-		trace_softirq_exit(vec_nr);
-		if (unlikely(prev_count != preempt_count())) {
-			pr_err("huh, entered softirq %u %s %p with preempt_count %08x, exited with %08x?\n",
-			       vec_nr, softirq_to_name[vec_nr], h->action,
-			       prev_count, preempt_count());
-			preempt_count_set(prev_count);
+			/* Allow early break to avoid big sched delay */
+			if (pending && __softirq_needs_break(start)) {
+				__this_cpu_write(pending_next_bit, vec_nr + 1);
+				/*
+				 * Ensure that the remaining pending bits will be
+				 * handled in the next time.
+				 */
+				local_irq_save(flags);
+				or_softirq_pending(pending | pending_again);
+				local_irq_restore(flags);
+				break;
+			}
 		}
 	}
 
@@ -309,12 +369,21 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		rcu_softirq_qs();
 	local_irq_disable();
 
-	pending = local_softirq_pending();
-	if (pending) {
-		if (!__softirq_needs_break(start) && --max_restart)
-			goto restart;
+	/* get the unhandled bits */
+	pending |= pending_again;
+	if (!pending)
+		/*
+		 * If all of the pending bits have been handled,
+		 * reset the pending_next_bit to 0.
+		 */
+		__this_cpu_write(pending_next_bit, 0);
 
+	if (pending)
 		wakeup_softirqd();
+	else if (!__softirq_needs_break(start) && --max_restart) {
+		pending = local_softirq_pending();
+		if (pending)
+			goto restart;
 	}
 
 	lockdep_softirq_end(in_hardirq);
-- 
1.8.3.1

