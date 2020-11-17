Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B312B6A67
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgKQQg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgKQQg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:36:59 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D017CC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 08:36:58 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id 3so1997776wms.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 08:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=1AB7jWGDKqYLUDgu1C5v3wJ4U1VEzQNUsWCkMQleGjc=;
        b=NgPOtLVr3vxHbX4TvNNxUpe6EqYYLOZmMZP5lXvsFtFkS9aHzMKXS4gXEjWyXvfhj6
         lkxhDkZ5xXf3L8CJPu4KWEsmVjHlevFYkmL/PPwDPT+T1jKsW6cyQk/e5R/PCDkNu/20
         t7pY1X0Ff7JUk1WD3ftXrt35oJ1ORgDP1Ml1EYKWYbLiYQGPuvXBue/X0syo1m4wnZzG
         Oe1Vi9NArJP9TgLAr+PDMuTKgnzPWywIlfF5EaqEzIqff3p0WRt9RVIS3kZWitWHDeoJ
         GnLmp1nrhNu3EFPvUxUpz1StQCort44URbqqWrhtPBnH5sHqpimJaOcFP/EysmRBmDlG
         cVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=1AB7jWGDKqYLUDgu1C5v3wJ4U1VEzQNUsWCkMQleGjc=;
        b=TwNF3LTtQ6FubfvDEMUhc/zpSoMR824Vq/ZPSd9MsFNrbb3eT73iEucdSPgAK6mljK
         O9MFdduD5lr2CjqZ6/KaTXk13dU0RHGIwR8pLDHGYDblV11TmUgvhFa2jgb7vjvR3V5r
         WsoMkrwGwfLkiIMFtsQWBL3qjpahtUgSHMM/wwvp9wF6oSgtc008UR4eOXvKkT8l25TA
         vDWS8OUE2S/bgXjmb1QmYiZFuUasrDDIInbTx9ZUy7aR4JMmv3i9V0oT7X3lVjkFR5Zx
         8psbbOIoR3rKBfiYfywcQa0BjzkTeHnddvV/Mpiwk6oY4q/nYzVFaB8fcuQZGS7aPE3P
         qkOQ==
X-Gm-Message-State: AOAM531Gkvc9enRcVOQCN2B1UE7bQmIJ5Q+2o+w5IuAlEfzVydoy/VJX
        hRH4hxqOR4XLFz6cfnJNuKprbAOCBA==
X-Google-Smtp-Source: ABdhPJx+dUpTJoVqJNMHpC2Y4LofeI+h+gBPz+ugnc+RuKcKyfvLtiSI2Vf2z49tSNVd+vufXa9YG8PFQg==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a1c:791a:: with SMTP id l26mr22568wme.1.1605631016587;
 Tue, 17 Nov 2020 08:36:56 -0800 (PST)
Date:   Tue, 17 Nov 2020 17:36:41 +0100
Message-Id: <20201117163641.3389352-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH] kcsan: Avoid scheduler recursion by using non-instrumented preempt_disable()
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
versions of preempt_disable() that do not call into scheduler code.

Note, while this currently does not affect an unmodified kernel, it'd be
good to keep a KCSAN kernel working when KCSAN_SANITIZE := n is removed
from kernel/sched/Makefile to permit testing scheduler code with KCSAN
if desired.

Fixes: cd290ec24633 ("kcsan: Use tracing-safe version of prandom")
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 3994a217bde7..967b0b2f9d59 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -284,10 +284,18 @@ should_watch(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *
  */
 static u32 kcsan_prandom_u32_max(u32 ep_ro)
 {
-	struct rnd_state *state = &get_cpu_var(kcsan_rand_state);
-	const u32 res = prandom_u32_state(state);
+	struct rnd_state *state;
+	u32 res;
+
+	/*
+	 * Avoid recursion with scheduler by using non-tracing version of
+	 * preempt_disable() that do not call into scheduler code.
+	 */
+	preempt_disable_notrace();
+	state = raw_cpu_ptr(&kcsan_rand_state);
+	res = prandom_u32_state(state);
+	preempt_enable_no_resched_notrace();
 
-	put_cpu_var(kcsan_rand_state);
 	return (u32)(((u64) res * ep_ro) >> 32);
 }
 
-- 
2.29.2.299.gdc1121823c-goog

