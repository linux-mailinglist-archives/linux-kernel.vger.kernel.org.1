Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5512A8A6A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbgKEXI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:08:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgKEXI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:08:57 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6F1420715;
        Thu,  5 Nov 2020 23:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617736;
        bh=ASQcl6/kvjNQnS00DAk1cDFUuC2e0kZnj1RAWJdVV4k=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=RVw66FG4NSmzSVajDJ3cvCmx4IjJed/I1aKVN5MW0Vvu+LMgIawsPI1p0hRYZa+oh
         XesIxJgdaCZ16mJhZyTBpqFDCsz702mtTe1fSBdjcMVeR3bPpuo9JtmAcakjg7AzsZ
         A4krdY6QJmRSU30nXlEoZQwwD1ZUPLHn8Nnn2u9I=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 860313522A76; Thu,  5 Nov 2020 15:08:56 -0800 (PST)
Date:   Thu, 5 Nov 2020 15:08:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/16] Miscellaneous fixes for v5.11
Message-ID: <20201105230856.GA18904@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains miscellaneous fixes:

1.	Don't invoke try_invoke_on_locked_down_task() with irqs disabled.

2.	Move x86's rcu_cpu_starting() earlier.

3.	Panic after fixed number of stalls.

4.	Update list.h comment to explicitly note circular lists.

5.	Implement rcu_segcblist_is_offloaded() config dependent.

6.	Fix single-CPU check in rcu_blocking_is_gp().

7.	Clarify nocb kthreads naming in RCU_NOCB_CPU config.

8.	Add a warning if CPU being onlined did not report QS already.

9.	Make struct kernel_param_ops definitions const.

10.	Fix ftrace recursion.

11.	nocb: Avoid raising softirq for offloaded ready-to-execute CBs.

12.	Prevent lockdep-RCU splats on lock acquisition/release.

13.	Fix a typo in rcu_blocking_is_gp() header comment.

14.	Do not report strict GPs for outgoing CPUs.

15.	Defer kvfree_rcu() allocation to a clean context.

16.	Take early exit on memory-allocation failure.

						Thanx, Paul

------------------------------------------------------------------------

 arch/x86/kernel/cpu/mtrr/mtrr.c |    2 
 arch/x86/kernel/smpboot.c       |    1 
 include/linux/kernel.h          |    1 
 include/linux/list.h            |    2 
 kernel/rcu/Kconfig              |   20 ++--
 kernel/rcu/rcu_segcblist.h      |    2 
 kernel/rcu/srcutree.c           |    4 
 kernel/rcu/tree.c               |  188 +++++++++++++++++++++++++---------------
 kernel/rcu/tree.h               |    2 
 kernel/rcu/tree_plugin.h        |    2 
 kernel/rcu/tree_stall.h         |   28 ++++-
 kernel/sysctl.c                 |   11 ++
 12 files changed, 178 insertions(+), 85 deletions(-)
