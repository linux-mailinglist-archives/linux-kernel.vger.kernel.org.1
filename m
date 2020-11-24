Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B962C2389
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732475AbgKXLCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732447AbgKXLCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:02:18 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F87C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 03:02:17 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id y26so739810wmj.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 03:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=fdbbxX9duAWgf2y7mstvbp1Lae/Ec3vzbHyR2vvOgmg=;
        b=X0Lj0mwaSvu4qZrPjZugnl8qdlhLi5GuXrksevPmXh2u5AnPC/IiFfBh6jYarxsea5
         aV7X5ChefqiV3NzSdMClMZLxkwKpYv3/uqDjrGX+z8NgmRtuweKUSO4zaUIMuv4uRGC7
         NvGFqKn/fjzw2tvajodi/Td2SQw15MZNp+Q0fn69g2+hO16s6hJZG0ToOWqXkivRaAE7
         qMgCAx/b28O148n2Ihj07ulBY/d62VujVMoOVYB71aTRShs4dVhmf1GcWeAh0eWWGLJ5
         lbjS0xa4iWqKkHTBRc3d8I/UrtsU815ATv5aP99KVZsuSbh/Ha9ZFmcv6a/8yFMEE9mb
         0zDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=fdbbxX9duAWgf2y7mstvbp1Lae/Ec3vzbHyR2vvOgmg=;
        b=PyQTg+P1velgDeGASshByV5RYmqNdjNiFxDrB9l6YJcM8YKjMMLsF7S1Lj0bmgiBuL
         DJLvI0oG9ObutRlAxjs+a2W/EDDr9TED8mn5uGEn8Sx8t/gXrph27hMcVaot9rerKs3Q
         SkgoozNb2msUtr2tHvAsOx+1rdnGiAJvaYX/elVotI7CuFLoB8AuFyuGEcY8pul3hb6T
         5ylq+j5Nznq6J4TOR74DqqbFH24T3n1Ps+t9u7eAKmq0FYrrhwSLNXmC8ht+4+D0ILrf
         VXv0xsJde9ghGmx11JgDUYb6l7gmJHyptbns/dFa/H/wUofN8bMgpMBoWUil6o6U1x+6
         QrOg==
X-Gm-Message-State: AOAM530A8ommHK2jQhBLlJFE/KwMn0oyrxS9R3W1VSbOcoiJNh2atiBg
        YEvz9p0ZAZ2iDAI04wwUMx226jKT+A==
X-Google-Smtp-Source: ABdhPJxbdI+rGUnItzEXwUdDDMgPES5R0lGI/io3S5IxRMQ9UJImuuBL79VsWDWaaL8x8sJ70mQ6xT8TQA==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a5d:60cb:: with SMTP id x11mr4977240wrt.0.1606215736589;
 Tue, 24 Nov 2020 03:02:16 -0800 (PST)
Date:   Tue, 24 Nov 2020 12:02:09 +0100
Message-Id: <20201124110210.495616-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v3 1/2] kcsan: Rewrite kcsan_prandom_u32_max() without prandom_u32_state()
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     will@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@kernel.org, mark.rutland@arm.com, boqun.feng@gmail.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite kcsan_prandom_u32_max() to not depend on code that might be
instrumented, removing any dependency on lib/random32.c. The rewrite
implements a simple linear congruential generator, that is sufficient
for our purposes (for udelay() and skip_watch counter randomness).

The initial motivation for this was to allow enabling KCSAN for
kernel/sched (remove KCSAN_SANITIZE := n from kernel/sched/Makefile),
with CONFIG_DEBUG_PREEMPT=y. Without this change, we could observe
recursion:

	check_access() [via instrumentation]
	  kcsan_setup_watchpoint()
	    reset_kcsan_skip()
	      kcsan_prandom_u32_max()
	        get_cpu_var()
		  preempt_disable()
		    preempt_count_add() [in kernel/sched/core.c]
		      check_access() [via instrumentation]

Note, while this currently does not affect an unmodified kernel, it'd be
good to keep a KCSAN kernel working when KCSAN_SANITIZE := n is removed
from kernel/sched/Makefile to permit testing scheduler code with KCSAN
if desired.

Fixes: cd290ec24633 ("kcsan: Use tracing-safe version of prandom")
Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Rewrite kcsan_prandom_u32_max() without lib/random32.c!

v2: https://lkml.kernel.org/r/20201123132300.1759342-1-elver@google.com
* Update comment to also point out preempt_enable().

v1: https://lkml.kernel.org/r/20201117163641.3389352-1-elver@google.com
---
 kernel/kcsan/core.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 3994a217bde7..3bf98db9c702 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -12,7 +12,6 @@
 #include <linux/moduleparam.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>
-#include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
 
@@ -101,7 +100,7 @@ static atomic_long_t watchpoints[CONFIG_KCSAN_NUM_WATCHPOINTS + NUM_SLOTS-1];
 static DEFINE_PER_CPU(long, kcsan_skip);
 
 /* For kcsan_prandom_u32_max(). */
-static DEFINE_PER_CPU(struct rnd_state, kcsan_rand_state);
+static DEFINE_PER_CPU(u32, kcsan_rand_state);
 
 static __always_inline atomic_long_t *find_watchpoint(unsigned long addr,
 						      size_t size,
@@ -275,20 +274,17 @@ should_watch(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *
 }
 
 /*
- * Returns a pseudo-random number in interval [0, ep_ro). See prandom_u32_max()
- * for more details.
- *
- * The open-coded version here is using only safe primitives for all contexts
- * where we can have KCSAN instrumentation. In particular, we cannot use
- * prandom_u32() directly, as its tracepoint could cause recursion.
+ * Returns a pseudo-random number in interval [0, ep_ro). Simple linear
+ * congruential generator, using constants from "Numerical Recipes".
  */
 static u32 kcsan_prandom_u32_max(u32 ep_ro)
 {
-	struct rnd_state *state = &get_cpu_var(kcsan_rand_state);
-	const u32 res = prandom_u32_state(state);
+	u32 state = this_cpu_read(kcsan_rand_state);
+
+	state = 1664525 * state + 1013904223;
+	this_cpu_write(kcsan_rand_state, state);
 
-	put_cpu_var(kcsan_rand_state);
-	return (u32)(((u64) res * ep_ro) >> 32);
+	return state % ep_ro;
 }
 
 static inline void reset_kcsan_skip(void)
@@ -639,10 +635,14 @@ static __always_inline void check_access(const volatile void *ptr, size_t size,
 
 void __init kcsan_init(void)
 {
+	int cpu;
+
 	BUG_ON(!in_task());
 
 	kcsan_debugfs_init();
-	prandom_seed_full_state(&kcsan_rand_state);
+
+	for_each_possible_cpu(cpu)
+		per_cpu(kcsan_rand_state, cpu) = (u32)get_cycles();
 
 	/*
 	 * We are in the init task, and no other tasks should be running;
-- 
2.29.2.454.gaff20da3a2-goog

