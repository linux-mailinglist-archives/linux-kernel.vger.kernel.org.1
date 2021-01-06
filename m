Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E322EB733
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 01:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbhAFA5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 19:57:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbhAFA5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:57:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5177222227;
        Wed,  6 Jan 2021 00:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894633;
        bh=h+AMq7p+XkXwIOapaMS0m3bye6R942zGsf+4iuMVXZc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=DMoUtOnnYsiX6DEEJYn8WN3fV69OnKydY4xtmITjPFNIzQbymnaORJyuDPjnztiOb
         TwY/kCPGS9n1M/g8xpeU6L3uvpNqE/BRyVawo2DLlA5dJmPZScvJWJovmFBHVi+DCc
         3lVmrlWrRJZeWumWOwwJsT43VW1STYzD0F6Lgku94aT+jCbKDdiI4toPbTnc/vSIIg
         sy59GKaJYhClTEMtHucPI9JJIwvPNUMF6BqzgZP3UyRhzDHzWyZSp7+Gr60nMEGg7b
         GZI7ySUvXppf9zl7+Evw3kasZ2HpPASoTaRuDoBb2ab1ZeMkmSELZTK/7CmSXak7g3
         LWl7l4VmEjgUQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 176D435228C6; Tue,  5 Jan 2021 16:57:13 -0800 (PST)
Date:   Tue, 5 Jan 2021 16:57:13 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/6] Miscellaneous fixes for v5.12
Message-ID: <20210106005713.GA12492@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains miscellaneous fixes.

1.	Allow try_invoke_on_locked_down_task() with irqs disabled,
	courtesy of Peter Zijlstra.

2.	Remove duplicate include of percpu-rwsem.h, courtesy of Wang Qing.

3.	Add lockdep_assert_irqs_disabled() to rcu_sched_clock_irq()
	and callees.

4.	Add lockdep_assert_irqs_disabled() to raw_spin_unlock_rcu_node()
	macros.

5.	rcu-tasks: Add RCU-tasks self tests, courtesy of Uladzislau Rezki.

6.	Make TASKS_TRACE_RCU select IRQ_WORK.

						Thanx, Paul

------------------------------------------------------------------------

 locking/locktorture.c |    1 
 rcu/Kconfig           |    1 
 rcu/rcu.h             |   16 ++++++++--
 rcu/tasks.h           |   79 ++++++++++++++++++++++++++++++++++++++++++++++++++
 rcu/tree.c            |    4 ++
 rcu/tree_plugin.h     |    1 
 rcu/tree_stall.h      |    8 +++++
 sched/core.c          |    9 ++---
 8 files changed, 110 insertions(+), 9 deletions(-)
