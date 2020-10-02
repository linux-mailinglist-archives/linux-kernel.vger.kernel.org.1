Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0024281A45
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388372AbgJBR4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:56:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgJBR4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:56:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7649206DD;
        Fri,  2 Oct 2020 17:56:45 +0000 (UTC)
Date:   Fri, 2 Oct 2020 13:56:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [WARNING] kernel/rcu/tree.c:1058 rcu_irq_enter+0x15/0x20
Message-ID: <20201002135644.7903d0e5@gandalf.local.home>
In-Reply-To: <20200930181323.GF2628@hirez.programming.kicks-ass.net>
References: <20200917131647.2b55ebb1@gandalf.local.home>
        <20200930181323.GF2628@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 20:13:23 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Blergh, IIRC there's header hell that way. The sane fix is killing off
> that trace_*_rcuidle() disease.
> 
> But I think this will also cure it.

I guess you still don't build modules ;-). I had to add a
EXPORT_SYMBOL(lockdep_recursion) to get it to build, and then move the
checks within the irq disabling to get rid of the using cpu pointers within
preemptable code warnings

But it appears to solve the problem.

-- Steve

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 0e100c9784a5..70610f217b4e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -77,6 +77,7 @@ module_param(lock_stat, int, 0644);
 #endif
 
 DEFINE_PER_CPU(unsigned int, lockdep_recursion);
+EXPORT_SYMBOL(lockdep_recursion);
 
 static inline bool lockdep_enabled(void)
 {
@@ -4241,13 +4242,13 @@ void lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
 	if (subclass) {
 		unsigned long flags;
 
-		if (DEBUG_LOCKS_WARN_ON(!lockdep_enabled()))
-			return;
-
 		raw_local_irq_save(flags);
+		if (DEBUG_LOCKS_WARN_ON(!lockdep_enabled()))
+			goto out;
 		lockdep_recursion_inc();
 		register_lock_class(lock, subclass, 1);
 		lockdep_recursion_finish();
+out:
 		raw_local_irq_restore(flags);
 	}
 }
@@ -4928,15 +4929,15 @@ void lock_set_class(struct lockdep_map *lock, const char *name,
 {
 	unsigned long flags;
 
-	if (unlikely(!lockdep_enabled()))
-		return;
-
 	raw_local_irq_save(flags);
+	if (unlikely(!lockdep_enabled()))
+		goto out;
 	lockdep_recursion_inc();
 	check_flags(flags);
 	if (__lock_set_class(lock, name, key, subclass, ip))
 		check_chain_key(current);
 	lockdep_recursion_finish();
+out:
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_set_class);
@@ -4945,15 +4946,15 @@ void lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
 
-	if (unlikely(!lockdep_enabled()))
-		return;
-
 	raw_local_irq_save(flags);
+	if (unlikely(!lockdep_enabled()))
+		goto out;
 	lockdep_recursion_inc();
 	check_flags(flags);
 	if (__lock_downgrade(lock, ip))
 		check_chain_key(current);
 	lockdep_recursion_finish();
+out:
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_downgrade);
@@ -5041,16 +5042,18 @@ void lock_release(struct lockdep_map *lock, unsigned long ip)
 
 	trace_lock_release(lock, ip);
 
+	raw_local_irq_save(flags);
+
 	if (unlikely(!lockdep_enabled()))
-		return;
+		goto out;
 
-	raw_local_irq_save(flags);
 	check_flags(flags);
 
 	lockdep_recursion_inc();
 	if (__lock_release(lock, ip))
 		check_chain_key(current);
 	lockdep_recursion_finish();
+out:
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_release);
@@ -5060,15 +5063,17 @@ noinstr int lock_is_held_type(const struct lockdep_map *lock, int read)
 	unsigned long flags;
 	int ret = 0;
 
-	if (unlikely(!lockdep_enabled()))
-		return 1; /* avoid false negative lockdep_assert_held() */
-
 	raw_local_irq_save(flags);
+	if (unlikely(!lockdep_enabled())) {
+		ret = 1; /* avoid false negative lockdep_assert_held() */
+		goto out;
+	}
 	check_flags(flags);
 
 	lockdep_recursion_inc();
 	ret = __lock_is_held(lock, read);
 	lockdep_recursion_finish();
+out:
 	raw_local_irq_restore(flags);
 
 	return ret;
@@ -5081,15 +5086,16 @@ struct pin_cookie lock_pin_lock(struct lockdep_map *lock)
 	struct pin_cookie cookie = NIL_COOKIE;
 	unsigned long flags;
 
+	raw_local_irq_save(flags);
 	if (unlikely(!lockdep_enabled()))
-		return cookie;
+		goto out;
 
-	raw_local_irq_save(flags);
 	check_flags(flags);
 
 	lockdep_recursion_inc();
 	cookie = __lock_pin_lock(lock);
 	lockdep_recursion_finish();
+out:
 	raw_local_irq_restore(flags);
 
 	return cookie;
@@ -5100,15 +5106,16 @@ void lock_repin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 {
 	unsigned long flags;
 
+	raw_local_irq_save(flags);
 	if (unlikely(!lockdep_enabled()))
-		return;
+		goto out;
 
-	raw_local_irq_save(flags);
 	check_flags(flags);
 
 	lockdep_recursion_inc();
 	__lock_repin_lock(lock, cookie);
 	lockdep_recursion_finish();
+out:
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_repin_lock);
@@ -5117,15 +5124,16 @@ void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 {
 	unsigned long flags;
 
+	raw_local_irq_save(flags);
 	if (unlikely(!lockdep_enabled()))
-		return;
+		goto out;
 
-	raw_local_irq_save(flags);
 	check_flags(flags);
 
 	lockdep_recursion_inc();
 	__lock_unpin_lock(lock, cookie);
 	lockdep_recursion_finish();
+out:
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_unpin_lock);
@@ -5253,14 +5261,15 @@ void lock_contended(struct lockdep_map *lock, unsigned long ip)
 
 	trace_lock_acquired(lock, ip);
 
+	raw_local_irq_save(flags);
 	if (unlikely(!lock_stat || !lockdep_enabled()))
-		return;
+		goto out;
 
-	raw_local_irq_save(flags);
 	check_flags(flags);
 	lockdep_recursion_inc();
 	__lock_contended(lock, ip);
 	lockdep_recursion_finish();
+out:
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_contended);
@@ -5271,14 +5280,15 @@ void lock_acquired(struct lockdep_map *lock, unsigned long ip)
 
 	trace_lock_contended(lock, ip);
 
+	raw_local_irq_save(flags);
 	if (unlikely(!lock_stat || !lockdep_enabled()))
-		return;
+		goto out;
 
-	raw_local_irq_save(flags);
 	check_flags(flags);
 	lockdep_recursion_inc();
 	__lock_acquired(lock, ip);
 	lockdep_recursion_finish();
+out:
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_acquired);
