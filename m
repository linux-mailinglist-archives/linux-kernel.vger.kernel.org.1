Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977BF2A1E65
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 14:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgKAN4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 08:56:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52972 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgKAN4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 08:56:32 -0500
Date:   Sun, 01 Nov 2020 13:56:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604238989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bF+mtfzp1Qnd0NNANysODcI5fE8rUcu5VdQv4w8RfTs=;
        b=I2EvT9Po3APj+MItw78w4wmk0j9G4w5ivkj+KwpB2Zah7mvgUht4r3eyPigNW2Px35gav2
        0q0BreGeh/Si02Rj6wUnopvT605XrOxGNpxBsg+yC+eYI+3VAUeD3hdGAIodAAQgKY142b
        fDOHsUimQsMAMVkSlixpWIaGcVdGYrruYW7TAhn1HHjG4p5iRxVXi6hlxXKA3w4c8ExQZl
        6bPkwKuenhOXWQ35uvbkfqCLZxlmOipI/sVay7wJzh3/3lbR5s2rb7i+GUic3DafMynS/u
        lXQ4QNUCP158NFuht65txBGE11RJlDh5iabPqcVamNIPzPNXkny5PKstdCXFCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604238989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bF+mtfzp1Qnd0NNANysODcI5fE8rUcu5VdQv4w8RfTs=;
        b=pLuur4EeJDXDHz21aCBO8sBrKpVoDP6Ry/aq+xHXChARu6Rvh3mSKCQ2Tf0D021LXspVEV
        d+82KK2vQhtQvHBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/urgent for v5.10-rc2
Message-ID: <160423896136.5667.9743580255833470691.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-11-01

up to:  1a39340865ce: lockdep: Fix nr_unused_locks accounting


A couple of locking fixes:

 - Fix incorrect failure injection handling on the fuxtex code

 - Prevent a preemption warning in lockdep when tracking local_irq_enable()
   and interrupts are already enabled

 - Remove more raw_cpu_read() usage from lockdep which causes state
   corruption on !X86 architectures.

 - Make the nr_unused_locks accounting in lockdep correct again.

Thanks,

	tglx

------------------>
Mateusz Nosek (1):
      futex: Fix incorrect should_fail_futex() handling

Peter Zijlstra (3):
      lockdep: Fix preemption WARN for spurious IRQ-enable
      locking/lockdep: Remove more raw_cpu_read() usage
      lockdep: Fix nr_unused_locks accounting


 kernel/futex.c           |  4 +++-
 kernel/locking/lockdep.c | 20 +++++++-------------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index a5876694a60e..39681bf8b06c 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1502,8 +1502,10 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_
 	 */
 	newval = FUTEX_WAITERS | task_pid_vnr(new_owner);
 
-	if (unlikely(should_fail_futex(true)))
+	if (unlikely(should_fail_futex(true))) {
 		ret = -EFAULT;
+		goto out_unlock;
+	}
 
 	ret = cmpxchg_futex_value_locked(&curval, uaddr, uval, newval);
 	if (!ret && (curval != uval)) {
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3e99dfef8408..b71ad8d9f1c9 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -84,7 +84,7 @@ static inline bool lockdep_enabled(void)
 	if (!debug_locks)
 		return false;
 
-	if (raw_cpu_read(lockdep_recursion))
+	if (this_cpu_read(lockdep_recursion))
 		return false;
 
 	if (current->lockdep_recursion)
@@ -4057,7 +4057,7 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
 	if (unlikely(in_nmi()))
 		return;
 
-	if (unlikely(__this_cpu_read(lockdep_recursion)))
+	if (unlikely(this_cpu_read(lockdep_recursion)))
 		return;
 
 	if (unlikely(lockdep_hardirqs_enabled())) {
@@ -4126,7 +4126,7 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 		goto skip_checks;
 	}
 
-	if (unlikely(__this_cpu_read(lockdep_recursion)))
+	if (unlikely(this_cpu_read(lockdep_recursion)))
 		return;
 
 	if (lockdep_hardirqs_enabled()) {
@@ -4396,6 +4396,9 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	if (unlikely(hlock_class(this)->usage_mask & new_mask))
 		goto unlock;
 
+	if (!hlock_class(this)->usage_mask)
+		debug_atomic_dec(nr_unused_locks);
+
 	hlock_class(this)->usage_mask |= new_mask;
 
 	if (new_bit < LOCK_TRACE_STATES) {
@@ -4403,19 +4406,10 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 			return 0;
 	}
 
-	switch (new_bit) {
-	case 0 ... LOCK_USED-1:
+	if (new_bit < LOCK_USED) {
 		ret = mark_lock_irq(curr, this, new_bit);
 		if (!ret)
 			return 0;
-		break;
-
-	case LOCK_USED:
-		debug_atomic_dec(nr_unused_locks);
-		break;
-
-	default:
-		break;
 	}
 
 unlock:

