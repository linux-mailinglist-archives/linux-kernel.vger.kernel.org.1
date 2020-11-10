Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED342AC9EE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 01:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbgKJA4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 19:56:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:54382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731372AbgKJA4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 19:56:36 -0500
Received: from localhost.localdomain (i15-lef02-th2-89-83-252-17.ft.lns.abo.bbox.fr [89.83.252.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAB1120870;
        Tue, 10 Nov 2020 00:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604969795;
        bh=uJeon2zP9TBqtmay/pfkSlutJH7LXMfUFLS1zmgCfCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DiXIGqNlaZ4jP0kWSj2kE2Pq7BKGtFOaNzstZ9ZBmvoE1HAlKIkzdAOZ6yFzud8gM
         YlqZFNSjTxIURNnk71Uv1x46MeHLjsxFE1T6jg2hKvwDgCaC3DClT4tJCOY7Ezi2UH
         U3H+bEb1ZhLpyYePi4A11gWTb67CyZPgUTC7/yhs=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 7/7] preempt/dynamic: Support dynamic preempt with preempt= boot option
Date:   Tue, 10 Nov 2020 01:56:09 +0100
Message-Id: <20201110005609.40989-8-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110005609.40989-1-frederic@kernel.org>
References: <20201110005609.40989-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

Support the preempt= boot option and patch the static call sites
accordingly.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
[remove the mad scientist experiments]
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/core.c | 67 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6715caa17ea7..84ac05d2df3a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -12,6 +12,7 @@
 
 #include "sched.h"
 
+#include <linux/entry-common.h>
 #include <linux/nospec.h>
 
 #include <linux/kcov.h>
@@ -4772,9 +4773,73 @@ DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func());
 EXPORT_STATIC_CALL(preempt_schedule_notrace);
 #endif
 
-
 #endif /* CONFIG_PREEMPTION */
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
+/*
+ * SC:cond_resched
+ * SC:might_resched
+ * SC:preempt_schedule
+ * SC:preempt_schedule_notrace
+ * SC:irqentry_exit_cond_resched
+ *
+ *
+ * NONE:
+ *   cond_resched               <- __cond_resched
+ *   might_resched              <- RET0
+ *   preempt_schedule           <- NOP
+ *   preempt_schedule_notrace   <- NOP
+ *   irqentry_exit_cond_resched <- NOP
+ *
+ * VOLUNTARY:
+ *   cond_resched               <- __cond_resched
+ *   might_resched              <- __cond_resched
+ *   preempt_schedule           <- NOP
+ *   preempt_schedule_notrace   <- NOP
+ *   irqentry_exit_cond_resched <- NOP
+ *
+ * FULL:
+ *   cond_resched               <- RET0
+ *   might_resched              <- RET0
+ *   preempt_schedule           <- preempt_schedule
+ *   preempt_schedule_notrace   <- preempt_schedule_notrace
+ *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
+ */
+static int __init setup_preempt_mode(char *str)
+{
+	if (!strcmp(str, "none")) {
+		static_call_update(cond_resched, __cond_resched);
+		static_call_update(might_resched, __static_call_return0);
+		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
+		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
+		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
+		pr_info("Dynamic Preempt: %s\n", str);
+	} else if (!strcmp(str, "voluntary")) {
+		static_call_update(cond_resched, __cond_resched);
+		static_call_update(might_resched, __cond_resched);
+		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
+		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
+		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
+		pr_info("Dynamic Preempt: %s\n", str);
+	} else if (!strcmp(str, "full")) {
+		static_call_update(cond_resched, __static_call_return0);
+		static_call_update(might_resched, __static_call_return0);
+		static_call_update(preempt_schedule, __preempt_schedule_func());
+		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func());
+		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+		pr_info("Dynamic Preempt: %s\n", str);
+	} else {
+		pr_warn("Dynamic Preempt: Unsupported preempt mode %s, default to full\n", str);
+		return 1;
+	}
+	return 0;
+}
+__setup("preempt=", setup_preempt_mode);
+
+#endif /* CONFIG_PREEMPT_DYNAMIC */
+
+
 /*
  * This is the entry point to schedule() from kernel preemption
  * off of irq context.
-- 
2.25.1

