Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250D22D076D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 22:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgLFVku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 16:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgLFVku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 16:40:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19D4C0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 13:40:09 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607290807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=qdBhMtrI0eQa38m0gb5bqhyKq1hVq6WnHTslTr7nFjE=;
        b=ddaiGB9h7/CPh8CbLTJLMdeoba2RrmMR8rs1Va6zHiWymCEXTs9L8P0HxP8tE0hE9G/qZV
        a7vZkrz20QMQAoQO9RVdqSBW+4YkgwmnZloBA4Mdgqr5VvjuueACZjyGl26KXZSdZcfFrA
        udrRXLQ8z3UTwKueBfZeKB+0XwvWXyi5QjEcF8jetmFZWwfuiuQ6WZ9GT7xIoAehsMKtr8
        0ALgKybm4IUEoWTWPbYukWzlBonHx2kS+FukCL2y0wg0/gKGJwp9R9xLz9skKz+z1ktVju
        3xhFnrKiImFJy1AKnuKYYR2bS76AOrVrOkj/Gq3BCmoSlabIcWsxoMMQxiGJLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607290807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=qdBhMtrI0eQa38m0gb5bqhyKq1hVq6WnHTslTr7nFjE=;
        b=xhfswiY+fEMM6jbJycksCoLzsDDCSqv9/dChskSYjHusnZOyc7muWewalIDsV+n8Q+VyDZ
        tMLwiRGxt2gZ1zAA==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: timers: Move clearing of base::timer_running under base::lock
Date:   Sun, 06 Dec 2020 22:40:07 +0100
Message-ID: <87lfea7gw8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported KCSAN data races vs. timer_base::timer_running being set to
NULL without holding base::lock in expire_timers().

This looks innocent and most reads are clearly not problematic but for a
non-RT kernel it's completely irrelevant whether the store happens before
or after taking the lock. For an RT kernel moving the store under the lock
requires an extra unlock/lock pair in the case that there is a waiter for
the timer. But that's not the end of the world and definitely not worth the
trouble of adding boatloads of comments and annotations to the code. Famous
last words...

Reported-by: syzbot+aa7c2385d46c5eba0b89@syzkaller.appspotmail.com
Reported-by: syzbot+abea4558531bae1ba9fe@syzkaller.appspotmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timer.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1263,8 +1263,10 @@ static inline void timer_base_unlock_exp
 static void timer_sync_wait_running(struct timer_base *base)
 {
 	if (atomic_read(&base->timer_waiters)) {
+		raw_spin_unlock_irq(&base->lock);
 		spin_unlock(&base->expiry_lock);
 		spin_lock(&base->expiry_lock);
+		raw_spin_lock_irq(&base->lock);
 	}
 }
 
@@ -1448,14 +1450,14 @@ static void expire_timers(struct timer_b
 		if (timer->flags & TIMER_IRQSAFE) {
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn, baseclk);
-			base->running_timer = NULL;
 			raw_spin_lock(&base->lock);
+			base->running_timer = NULL;
 		} else {
 			raw_spin_unlock_irq(&base->lock);
 			call_timer_fn(timer, fn, baseclk);
+			raw_spin_lock_irq(&base->lock);
 			base->running_timer = NULL;
 			timer_sync_wait_running(base);
-			raw_spin_lock_irq(&base->lock);
 		}
 	}
 }
