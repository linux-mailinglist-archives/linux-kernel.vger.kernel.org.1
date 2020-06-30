Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08FE20EDB6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 07:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgF3FpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 01:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbgF3FpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:45:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998E7C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 22:45:14 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593495912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bweLYgZBl1IENL2ym5a8mMVA1JxobXtf3lMm0MWSC6M=;
        b=SjzxcQ33aSzkaUfXjQaVM6ZC6jN9T5etUlo+mkra3PPNzDTwRmwyJCO1blzcwO/cA56kfW
        mxBSxb4O+MjbplQzn6l4NpENsiMCvAC/kytKMIOokv9JPItnrtePPreRYlC4yqmr/c6tYi
        pG6PIu7BIrP8El6oGNfFXV9gZMQy5zAShwY7YKLMHEXDXMYpsyF4FSOmsdm1ss2nHurgYU
        qmHRYPkqBbLqjrJCObGX/v8v+qUEXLIIyq1f3SoMwb373ipzCM5Y5x+6c+0SFnQuF10R6v
        rceGtZIXklCUeE2Dj9Qa1tqentJX0yCXXewrouSQKHxoVoErOpmPWgc0gKKj5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593495912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bweLYgZBl1IENL2ym5a8mMVA1JxobXtf3lMm0MWSC6M=;
        b=YAzQ5APQW4rQ29+FJxBVBInQ4NBJ2BlX2lNlVqElJ8nluaaeWtUWNe8lQOnX+ykxzjZoYF
        digGTd4xtKcIxBCg==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v3 04/20] lockdep: Add preemption enabled/disabled assertion APIs
Date:   Tue, 30 Jun 2020 07:44:36 +0200
Message-Id: <20200630054452.3675847-5-a.darwish@linutronix.de>
In-Reply-To: <20200630054452.3675847-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200630054452.3675847-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asserting that preemption is enabled or disabled is a critical sanity
check.  Developers are usually reluctant to add such a check in a
fastpath as reading the preemption count can be costly.

Extend the lockdep API with macros asserting that preemption is disabled
or enabled. If lockdep is disabled, or if the underlying architecture
does not support kernel preemption, this assert has no runtime overhead.

References: f54bb2ec02c8 ("locking/lockdep: Add IRQs disabled/enabled assertion APIs: ...")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/lockdep.h | 18 ++++++++++++++++++
 lib/Kconfig.debug       |  1 +
 2 files changed, 19 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index fd04b9e96091..53eff6b26fac 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -548,6 +548,22 @@ do {									\
 	WARN_ON_ONCE(debug_locks && !this_cpu_read(hardirq_context));	\
 } while (0)
 
+#define lockdep_assert_preemption_enabled()				\
+do {									\
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
+		     debug_locks			&&		\
+		     (preempt_count() != 0		||		\
+		      !this_cpu_read(hardirqs_enabled)));		\
+} while (0)
+
+#define lockdep_assert_preemption_disabled()				\
+do {									\
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
+		     debug_locks			&&		\
+		     (preempt_count() == 0		&&		\
+		      this_cpu_read(hardirqs_enabled)));		\
+} while (0)
+
 #else
 # define might_lock(lock) do { } while (0)
 # define might_lock_read(lock) do { } while (0)
@@ -556,6 +572,8 @@ do {									\
 # define lockdep_assert_irqs_enabled() do { } while (0)
 # define lockdep_assert_irqs_disabled() do { } while (0)
 # define lockdep_assert_in_irq() do { } while (0)
+# define lockdep_assert_preemption_enabled() do { } while (0)
+# define lockdep_assert_preemption_disabled() do { } while (0)
 #endif
 
 #ifdef CONFIG_PROVE_RAW_LOCK_NESTING
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d74ac0fd6b2d..e5e2e632b749 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1118,6 +1118,7 @@ config PROVE_LOCKING
 	select DEBUG_RWSEMS
 	select DEBUG_WW_MUTEX_SLOWPATH
 	select DEBUG_LOCK_ALLOC
+	select PREEMPT_COUNT if !ARCH_NO_PREEMPT
 	select TRACE_IRQFLAGS
 	default n
 	help
-- 
2.20.1

