Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028F3222CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 22:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgGPUWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 16:22:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35644 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgGPUWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:22:12 -0400
Message-Id: <20200716202044.513392123@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594930930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Y2SHKIg3d09X3KJBrNwW2XZetpUVfZoIFiXHXPkfTYg=;
        b=kCwtwdHjbxBsaEOATNflG0Q+SxSLJF0b0UxQU0pDmYTvN7rKFsSHN1gJhkHnpPOK72IYOH
        Ca4n6J0wrmIWJ7xcHn6xxxnAGQSEdN6FZmaryBY1DDI+wXY9hTppHzRH9oJbWZ+3LO93ME
        unQcMMrEzbPtxBSjAjkopxBUurbqBv/cnORQEmqkcbrbI5iPpWKcXRZDGpoQfK2FVYpoqh
        CLc+611Lxj+uF779AeOQtYdvjU70VUiQ3VrymDZbV/k/DtE5pWSKVgmavSbJz9DYSpdo01
        nBtvMK0K22yn6Fa3EeShlM2SJmiZN2Yyx7Aw5rKEGEYdJmXdsgNu0oRabf4yWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594930930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Y2SHKIg3d09X3KJBrNwW2XZetpUVfZoIFiXHXPkfTYg=;
        b=by81ztZ7DHjtsQ1h5+gy677Tsiw5oYNpeVyswA+K/mvINjp/z0r9esFsXS+dWAT3vUNYad
        pYtFhtCHB3NGkuCA==
Date:   Thu, 16 Jul 2020 22:19:24 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [patch V2 1/5] posix-cpu-timers: Split run_posix_cpu_timers()
References: <20200716201923.228696399@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split it up as a preparatory step to move the heavy lifting out of
interrupt context.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1080,27 +1080,12 @@ static inline bool fastpath_timer_check(
 	return false;
 }
 
-/*
- * This is called from the timer interrupt handler.  The irq handler has
- * already updated our counts.  We need to check if any timers fire now.
- * Interrupts are disabled.
- */
-void run_posix_cpu_timers(void)
+static void __run_posix_cpu_timers(struct task_struct *tsk)
 {
-	struct task_struct *tsk = current;
 	struct k_itimer *timer, *next;
 	unsigned long flags;
 	LIST_HEAD(firing);
 
-	lockdep_assert_irqs_disabled();
-
-	/*
-	 * The fast path checks that there are no expired thread or thread
-	 * group timers.  If that's so, just return.
-	 */
-	if (!fastpath_timer_check(tsk))
-		return;
-
 	lockdep_posixtimer_enter();
 	if (!lock_task_sighand(tsk, &flags)) {
 		lockdep_posixtimer_exit();
@@ -1151,6 +1136,27 @@ void run_posix_cpu_timers(void)
 }
 
 /*
+ * This is called from the timer interrupt handler.  The irq handler has
+ * already updated our counts.  We need to check if any timers fire now.
+ * Interrupts are disabled.
+ */
+void run_posix_cpu_timers(void)
+{
+	struct task_struct *tsk = current;
+
+	lockdep_assert_irqs_disabled();
+
+	/*
+	 * The fast path checks that there are no expired thread or thread
+	 * group timers.  If that's so, just return.
+	 */
+	if (!fastpath_timer_check(tsk))
+		return;
+
+	__run_posix_cpu_timers(tsk);
+}
+
+/*
  * Set one of the process-wide special case CPU timers or RLIMIT_CPU.
  * The tsk->sighand->siglock must be held by the caller.
  */

