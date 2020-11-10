Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D672ADAA4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbgKJPkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:40:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:36416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731067AbgKJPk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:40:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD899207E8;
        Tue, 10 Nov 2020 15:40:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kcVkv-008eEE-Fa; Tue, 10 Nov 2020 10:40:25 -0500
Message-ID: <20201110154025.328193929@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 10 Nov 2020 10:38:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, stable-rt@vger.kernel.org
Subject: [PATCH RT 3/5] ptrace: fix ptrace_unfreeze_traced() race with rt-lock
References: <20201110153853.463368981@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.4.74-rt42-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Oleg Nesterov <oleg@redhat.com>

The patch "ptrace: fix ptrace vs tasklist_lock race" changed
ptrace_freeze_traced() to take task->saved_state into account, but
ptrace_unfreeze_traced() has the same problem and needs a similar fix:
it should check/update both ->state and ->saved_state.

Reported-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Fixes: "ptrace: fix ptrace vs tasklist_lock race"
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/ptrace.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 3075006d720e..3f7156f06b6c 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -197,8 +197,8 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
-	if (task->state != __TASK_TRACED)
-		return;
+	unsigned long flags;
+	bool frozen = true;
 
 	WARN_ON(!task->ptrace || task->parent != current);
 
@@ -207,12 +207,19 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
 	 * Recheck state under the lock to close this race.
 	 */
 	spin_lock_irq(&task->sighand->siglock);
-	if (task->state == __TASK_TRACED) {
-		if (__fatal_signal_pending(task))
-			wake_up_state(task, __TASK_TRACED);
-		else
-			task->state = TASK_TRACED;
-	}
+
+	raw_spin_lock_irqsave(&task->pi_lock, flags);
+	if (task->state == __TASK_TRACED)
+		task->state = TASK_TRACED;
+	else if (task->saved_state == __TASK_TRACED)
+		task->saved_state = TASK_TRACED;
+	else
+		frozen = false;
+	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+
+	if (frozen && __fatal_signal_pending(task))
+		wake_up_state(task, __TASK_TRACED);
+
 	spin_unlock_irq(&task->sighand->siglock);
 }
 
-- 
2.28.0


