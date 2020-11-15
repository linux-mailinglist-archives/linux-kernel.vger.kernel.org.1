Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711472B34FE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 14:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgKONBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 08:01:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35250 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgKONBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 08:01:36 -0500
Date:   Sun, 15 Nov 2020 13:00:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605445293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=t74Thqzgdlk/N8CfftqxAAAQjKLl21LDsuS9FXRE2/o=;
        b=ywmTW1RMrK8Jcs5hyoYmMGeWvEMdyF8/Xo4ofIqpOyFtN9C8mMWOiKfIPTr/hwimrxePW2
        JLIC1Asm1O8n960jdgCAp/EBw076HGU+eyzk5QWo2b7H4MrYAgLUdgE75bzApQJNx105dS
        QpPuIkmlkTgqwcfmmR61r987ifrJ8r2Gewo0zTCpoZZi1AiMHhmqk+5DTHXrPwY9i4Lfzt
        0Gafz7lmWaiiGzphQiYVZKfstFcvwPK4+rB2gLGxYWHxs27V5GHDsddmi95I5Rxue+wtbM
        J2mABA3zgmkqELNjhGnic/U85520Jd68IUzYmHjQ1+C8dw4anGW0vh63tF8ToA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605445293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=t74Thqzgdlk/N8CfftqxAAAQjKLl21LDsuS9FXRE2/o=;
        b=QNjODCLw9HqEpTIXUHj7+6kN7XTuSAUA8SduJupuzelUcjdN+31MLK7gmyQjsFuTNql20b
        eKQW1XMAF9MmrADQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/urgent for v5.10-rc4
Message-ID: <160544524024.25051.12292089189937197323.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-11-15

up to:  d61fc96a3760: lockdep: Avoid to modify chain keys in validate_chain()


Two fixes for the locking subsystem:

  - Prevent an unconditional interrupt enable in a futex helper function
    which can be called from contexts which expect interrupts to stay
    disabled across the call.

  - Don't modify lockdep chain keys in the validation process as that
    causes chain inconsistency.

Thanks,

	tglx

------------------>
Boqun Feng (1):
      lockdep: Avoid to modify chain keys in validate_chain()

Dan Carpenter (1):
      futex: Don't enable IRQs unconditionally in put_pi_state()


 kernel/futex.c           |  5 +++--
 kernel/locking/lockdep.c | 19 +++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index ac328874f6e5..00259c7e288e 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -788,8 +788,9 @@ static void put_pi_state(struct futex_pi_state *pi_state)
 	 */
 	if (pi_state->owner) {
 		struct task_struct *owner;
+		unsigned long flags;
 
-		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
+		raw_spin_lock_irqsave(&pi_state->pi_mutex.wait_lock, flags);
 		owner = pi_state->owner;
 		if (owner) {
 			raw_spin_lock(&owner->pi_lock);
@@ -797,7 +798,7 @@ static void put_pi_state(struct futex_pi_state *pi_state)
 			raw_spin_unlock(&owner->pi_lock);
 		}
 		rt_mutex_proxy_unlock(&pi_state->pi_mutex, owner);
-		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
+		raw_spin_unlock_irqrestore(&pi_state->pi_mutex.wait_lock, flags);
 	}
 
 	if (current->pi_state_cache) {
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index b71ad8d9f1c9..d9fb9e19d2ed 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2765,7 +2765,9 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
  * (Note that this has to be done separately, because the graph cannot
  * detect such classes of deadlocks.)
  *
- * Returns: 0 on deadlock detected, 1 on OK, 2 on recursive read
+ * Returns: 0 on deadlock detected, 1 on OK, 2 if another lock with the same
+ * lock class is held but nest_lock is also held, i.e. we rely on the
+ * nest_lock to avoid the deadlock.
  */
 static int
 check_deadlock(struct task_struct *curr, struct held_lock *next)
@@ -2788,7 +2790,7 @@ check_deadlock(struct task_struct *curr, struct held_lock *next)
 		 * lock class (i.e. read_lock(lock)+read_lock(lock)):
 		 */
 		if ((next->read == 2) && prev->read)
-			return 2;
+			continue;
 
 		/*
 		 * We're holding the nest_lock, which serializes this lock's
@@ -3592,16 +3594,13 @@ static int validate_chain(struct task_struct *curr,
 
 		if (!ret)
 			return 0;
-		/*
-		 * Mark recursive read, as we jump over it when
-		 * building dependencies (just like we jump over
-		 * trylock entries):
-		 */
-		if (ret == 2)
-			hlock->read = 2;
 		/*
 		 * Add dependency only if this lock is not the head
-		 * of the chain, and if it's not a secondary read-lock:
+		 * of the chain, and if the new lock introduces no more
+		 * lock dependency (because we already hold a lock with the
+		 * same lock class) nor deadlock (because the nest_lock
+		 * serializes nesting locks), see the comments for
+		 * check_deadlock().
 		 */
 		if (!chain_head && ret != 2) {
 			if (!check_prevs_add(curr, hlock))

