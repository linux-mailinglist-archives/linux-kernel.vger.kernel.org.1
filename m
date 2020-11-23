Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCAB2C0B55
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732410AbgKWNXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 08:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731551AbgKWNXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 08:23:07 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78901C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 05:23:07 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id b10so13476664qtb.16
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 05:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=t3/TP+aeGOrrYIoQsNoDeJwx7Pw16YuC73tVL3PfhCA=;
        b=i/NiRwJL0aJluZg5rY8KsCulRKgc+UIE+SwCY7gUAxgnPZ1DfIy6g+p0imKJ5QTcXP
         rHXztNfebMNml29UfXm28PtR8/4STJ4lZ5Zndp7+57cfD6oYhY5k7r4uxl2nLK2NFrzb
         GVmbvB5Jn6H8aq49me8QP2RKQzFDwSpcos382cVgK8t/+hWCBgKCkrrv3G9jyOHYPDP+
         9YTddxXG16wpfVLk6VXqatc4mquxTBkAQ4hPcNdiUqPfeiOLjt4scvJrn91LLrwRW9s9
         SRnhWSXu0XrUiJF6hWAajTwzYHYcMPjg5d5iiyWD3h5m93ag9utQnds5R+bI5o1PuBWj
         bnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=t3/TP+aeGOrrYIoQsNoDeJwx7Pw16YuC73tVL3PfhCA=;
        b=KndAaUtmhmMGU4Ly0sIr7vixNRnE5ViHw1+BC41ItNYqTg4q+axo+qm4tGZtx+B+pA
         JSyV/e1nNzOdLY+OFHHkNEwQ1V9NjIzxcycQ5PrqhWGbTfT5r7cgKbmzeVMlAZz+JpvZ
         hMbtCTf73VVeO/c1JdZPOq8APHd4plYkb4MrMsncBNdp586JykJaTEg13C//kpD6tzOS
         AAOvljWMmYEcuo0S97J3ZTiUF4mXLTkuKtZ/NI//nMdGHRRmd7mp8M2Z9ruIN77FUNwC
         bpb/HXfRbBkVN2a5lnlnuLUf+qVNzgksYdZcfLLtcYelYwQQWXHtEez/AFMgnfnSecGz
         xhcw==
X-Gm-Message-State: AOAM531WsCq0Hy//9T85iO4B9n0R7TlrliwlSy+a3iCVQ09rZ6Cj5iav
        SuHlrnabcw0ALHjhUcg+IQixkvmJ3Q==
X-Google-Smtp-Source: ABdhPJyi3sQ41pGPGDDNk6GR3kRu1nWMRGVpWjvKEjGZvzaSlIDMjPCg7+tYy46kUauCfGMXwtMg/n0wlg==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a0c:b5a6:: with SMTP id g38mr13953823qve.31.1606137786488;
 Mon, 23 Nov 2020 05:23:06 -0800 (PST)
Date:   Mon, 23 Nov 2020 14:23:00 +0100
Message-Id: <20201123132300.1759342-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2] kcsan: Avoid scheduler recursion by using non-instrumented preempt_{disable,enable}()
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

When enabling KCSAN for kernel/sched (remove KCSAN_SANITIZE := n from
kernel/sched/Makefile), with CONFIG_DEBUG_PREEMPT=y, we can observe
recursion due to:

	check_access() [via instrumentation]
	  kcsan_setup_watchpoint()
	    reset_kcsan_skip()
	      kcsan_prandom_u32_max()
	        get_cpu_var()
		  preempt_disable()
		    preempt_count_add() [in kernel/sched/core.c]
		      check_access() [via instrumentation]

Avoid this by rewriting kcsan_prandom_u32_max() to only use safe
versions of preempt_disable() and preempt_enable() that do not call into
scheduler code.

Note, while this currently does not affect an unmodified kernel, it'd be
good to keep a KCSAN kernel working when KCSAN_SANITIZE := n is removed
from kernel/sched/Makefile to permit testing scheduler code with KCSAN
if desired.

Fixes: cd290ec24633 ("kcsan: Use tracing-safe version of prandom")
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Update comment to also point out preempt_enable().
---
 kernel/kcsan/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 3994a217bde7..10513f3e2349 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -284,10 +284,19 @@ should_watch(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *
  */
 static u32 kcsan_prandom_u32_max(u32 ep_ro)
 {
-	struct rnd_state *state = &get_cpu_var(kcsan_rand_state);
-	const u32 res = prandom_u32_state(state);
+	struct rnd_state *state;
+	u32 res;
+
+	/*
+	 * Avoid recursion with scheduler by using non-tracing versions of
+	 * preempt_disable() and preempt_enable() that do not call into
+	 * scheduler code.
+	 */
+	preempt_disable_notrace();
+	state = raw_cpu_ptr(&kcsan_rand_state);
+	res = prandom_u32_state(state);
+	preempt_enable_no_resched_notrace();
 
-	put_cpu_var(kcsan_rand_state);
 	return (u32)(((u64) res * ep_ro) >> 32);
 }
 
-- 
2.29.2.454.gaff20da3a2-goog

