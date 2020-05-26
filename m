Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09D71DF7E7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 17:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387925AbgEWPIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 May 2020 11:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387815AbgEWPIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 11:08:42 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E65C061A0E;
        Sat, 23 May 2020 08:08:41 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jcVlH-0002Qs-UX; Sat, 23 May 2020 17:08:31 +0200
Date:   Sat, 23 May 2020 17:08:31 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org
Subject: Re: [PATCH 3/8] srcu: Use local_lock() for per-CPU struct srcu_data
 access
Message-ID: <20200523150831.wdrthklakwm6wago@linutronix.de>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-4-bigeasy@linutronix.de>
 <20200520102407.GF317569@hirez.programming.kicks-ass.net>
 <20200520120608.mwros5jurmidxxfv@linutronix.de>
 <20200520184345.GU2869@paulmck-ThinkPad-P72>
 <20200522151255.rtqnuk2cl3dpruou@linutronix.de>
 <20200522173953.GI2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200522173953.GI2869@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-22 10:39:53 [-0700], Paul E. McKenney wrote:
> It looks good to me, but I have not yet tested it.  (Happy to let you
> take the first crack at rcutorture in any case, scenarios SRCU-P and
> SRCU-N.)

on it.

> > That check_init_srcu_struct() is needed, because otherwise:
> > 
> > | BUG: spinlock bad magic on CPU#2, swapper/0/1
> > |  lock: 0xffff88803ed28ac0, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> > | CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc6+ #81
> > | Call Trace:
> > |  dump_stack+0x71/0xa0
> > |  do_raw_spin_lock+0x6c/0xb0
> > |  _raw_spin_lock_irqsave+0x33/0x40
> > |  synchronize_srcu+0x24/0xc9
> > |  wakeup_source_remove+0x4d/0x70
> > |  wakeup_source_unregister.part.0+0x9/0x40
> > |  device_wakeup_enable+0x99/0xc0
> > 
> > I'm not sure if there should be an explicit init of `wakeup_srcu' or if
> > an srcu function (like call_srcu()) is supposed to do it.
> 
> It is fine.  Beforehand, that check_init_srcu_struct() would have been
> invoked very shortly thereafter from __call_srcu(), and there is no
> instead harm invoking it a few microseconds earlier.  ;-)

Oki. I wasn't sure if an explizit initialized on wakeup_srcu's side was
missing or if this is new since we use the lock earlier.

>  							Thanx, Paul

Sebastian
