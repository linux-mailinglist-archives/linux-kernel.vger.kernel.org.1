Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2264E28342C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 12:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgJEKta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 06:49:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgJEKt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 06:49:28 -0400
Received: from localhost.localdomain (unknown [94.238.213.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C333B20796;
        Mon,  5 Oct 2020 10:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601894967;
        bh=1yep4uErlBh5xLyzG9PMrEN2Jhe3VuEFejhyTxYX4ho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r5Yr0xHyny7i2js+tZAx9bJz7aQslfQWfDClE954o38EMseHPIrZPK/v2DG+Ij/3Q
         ThlZhWnkbxtQkn77OnLWA0Ltl6CICGnP6i2+hM+dSobADSA9C2e1r1WQLiUs7FBjbk
         +lFcfJDH45foDjvps5JZOk6hkPEaUSSfefM+hqJI=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 1/5] context_tracking: Introduce HAVE_CONTEXT_TRACKING_OFFSTACK
Date:   Mon,  5 Oct 2020 12:49:15 +0200
Message-Id: <20201005104919.5250-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201005104919.5250-1-frederic@kernel.org>
References: <20201005104919.5250-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Historically, context tracking had to deal with fragile entry code path,
ie: before user_exit() is called and after user_enter() is called, in
case some of those spots would call schedule() or use RCU. On such
cases, the site had to be protected between exception_enter() and
exception_exit() that save the context tracking state in the task stack.

Such sleepable fragile code path had many different origins: tracing,
exceptions, early or late calls to context tracking on syscalls...

Aside of that not being pretty, saving the context tracking state on
the task stack forces us to run context tracking on all CPUs, including
housekeepers, and prevents us to completely shutdown nohz_full at
runtime on a CPU in the future as context tracking and its overhead
would still need to run system wide.

Now thanks to the extensive efforts to sanitize x86 entry code, those
conditions have been removed and we can now get rid of these workarounds
in this architecture.

Create a Kconfig feature to express this achievement.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Phil Auld <pauld@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index af14a567b493..e6ec866e5648 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -572,6 +572,23 @@ config HAVE_CONTEXT_TRACKING
 	  protected inside rcu_irq_enter/rcu_irq_exit() but preemption or signal
 	  handling on irq exit still need to be protected.
 
+config HAVE_CONTEXT_TRACKING_OFFSTACK
+	bool
+	help
+	  Architecture neither relies on exception_enter()/exception_exit()
+	  nor on schedule_user(). Also preempt_schedule_notrace() and
+	  preempt_schedule_irq() can't be called in a preemptible section
+	  while context tracking is CONTEXT_USER. This feature reflects a sane
+	  entry implementation where the following requirements are met on
+	  critical entry code, ie: before user_exit() or after user_enter():
+
+	  - Critical entry code isn't preemptible (or better yet:
+	    not interruptible).
+	  - No use of RCU read side critical sections, unless rcu_nmi_enter()
+	    got called.
+	  - No use of instrumentation, unless instrumentation_begin() got
+	    called.
+
 config HAVE_TIF_NOHZ
 	bool
 	help
-- 
2.25.1

