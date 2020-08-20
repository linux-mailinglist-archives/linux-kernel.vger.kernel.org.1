Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D1324B064
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 09:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgHTHud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 03:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgHTHuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:50:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86924C061383
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=FVA3agAYNH03NGG2EyaMJvjyPHeKiT2gHRMfl74rZEg=; b=XQ8E8gXowzXI4xMrerFcNycRrL
        Z8AqszcKj5PV+4Eod+GJ6uIRRZlg1+HB/wB+odgZ/f6KV5ztaYJR+Y6sP9oX2Hzt8WNS/GVVjypU3
        gQeJGQPtI/p2zGH7stR8P0Vx6QuZ8e63mcKLD5U5cPkzTK+o2xGub1zyiN3X7gZRrck3d7lqTDUkV
        rON76Z9Zg7yRLLilkNQBZGvsZ2bhS/e/ChTbJcxM0kvWVkvHvPG7Uh8S6Xp/yGsr5mXySJ4FgQXyC
        1tgR09P1apsSwGnK5FStc+s9vH712yOSfaYmUEExxDvKI2rkurpHW+iF5x92ZXawXz3zppw2z+UfT
        +j2+resQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8fKX-0000Mm-77; Thu, 20 Aug 2020 07:49:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EDA25306E56;
        Thu, 20 Aug 2020 09:49:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7327728B7E847; Thu, 20 Aug 2020 09:49:43 +0200 (CEST)
Message-ID: <20200820074640.810404638@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 20 Aug 2020 09:30:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org
Cc:     npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        peterz@infradead.org
Subject: [PATCH 9/9] lockdep,trace: Expose tracepoints
References: <20200820073031.886217423@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lockdep tracepoints are under the lockdep recursion counter, this
has a bunch of nasty side effects:

 - TRACE_IRQFLAGS doesn't work across the entire tracepoint

 - RCU-lockdep doesn't see the tracepoints either, hiding numerous
   "suspicious RCU usage" warnings.

Pull the trace_lock_*() tracepoints completely out from under the
lockdep recursion handling and completely rely on the trace level
recusion handling -- also, tracing *SHOULD* not be taking locks in any
case.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5044,6 +5044,8 @@ void lock_acquire(struct lockdep_map *lo
 {
 	unsigned long flags;
 
+	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
+
 	if (unlikely(current->lockdep_recursion)) {
 		/* XXX allow trylock from NMI ?!? */
 		if (lockdep_nmi() && !trylock) {
@@ -5068,7 +5070,6 @@ void lock_acquire(struct lockdep_map *lo
 	check_flags(flags);
 
 	current->lockdep_recursion++;
-	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
 	__lock_acquire(lock, subclass, trylock, read, check,
 		       irqs_disabled_flags(flags), nest_lock, ip, 0, 0);
 	lockdep_recursion_finish();
@@ -5080,13 +5081,15 @@ void lock_release(struct lockdep_map *lo
 {
 	unsigned long flags;
 
+	trace_lock_release(lock, ip);
+
 	if (unlikely(current->lockdep_recursion))
 		return;
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
+
 	current->lockdep_recursion++;
-	trace_lock_release(lock, ip);
 	if (__lock_release(lock, ip))
 		check_chain_key(current);
 	lockdep_recursion_finish();
@@ -5272,8 +5275,6 @@ __lock_acquired(struct lockdep_map *lock
 		hlock->holdtime_stamp = now;
 	}
 
-	trace_lock_acquired(lock, ip);
-
 	stats = get_lock_stats(hlock_class(hlock));
 	if (waittime) {
 		if (hlock->read)
@@ -5292,6 +5293,8 @@ void lock_contended(struct lockdep_map *
 {
 	unsigned long flags;
 
+	trace_lock_contended(lock, ip);
+
 	if (unlikely(!lock_stat || !debug_locks))
 		return;
 
@@ -5301,7 +5304,6 @@ void lock_contended(struct lockdep_map *
 	raw_local_irq_save(flags);
 	check_flags(flags);
 	current->lockdep_recursion++;
-	trace_lock_contended(lock, ip);
 	__lock_contended(lock, ip);
 	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
@@ -5312,6 +5314,8 @@ void lock_acquired(struct lockdep_map *l
 {
 	unsigned long flags;
 
+	trace_lock_acquired(lock, ip);
+
 	if (unlikely(!lock_stat || !debug_locks))
 		return;
 


