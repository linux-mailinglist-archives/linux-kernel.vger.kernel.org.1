Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D31C2B6879
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732791AbgKQPQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:16:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729184AbgKQPQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:16:56 -0500
Received: from localhost.localdomain (unknown [176.167.180.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BE6A24631;
        Tue, 17 Nov 2020 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605626216;
        bh=EA92mlwnn2FIrXqeN1njpixgQF+mxkoEqe6JtJn0iEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yVCCWaRmdTc8JkvliEkjOcyFV8cJ2M+dPTSqgg6j3vDj8H3Sbhi0CHtfz7KHYsbDl
         qGkBqBpIAud23dqizRj7CXmqST4vC4VRzIlxhvZvLb63i/zyVlwKEDWoQeOfxDYmGW
         uCpcof4NWbMwgEuAs71OeQyDZ6PvPsS+/SJUophI=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 4/5] context_tracking: Only define schedule_user() on !HAVE_CONTEXT_TRACKING_OFFSTACK archs
Date:   Tue, 17 Nov 2020 16:16:36 +0100
Message-Id: <20201117151637.259084-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201117151637.259084-1-frederic@kernel.org>
References: <20201117151637.259084-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

schedule_user() was traditionally used by the entry code's tail to
preempt userspace after the call to user_enter(). Indeed the call to
user_enter() used to be performed upon syscall exit slow path which was
right before the last opportunity to schedule() while resuming to
userspace. The context tracking state had to be saved on the task stack
and set back to CONTEXT_KERNEL temporarily in order to safely switch to
another task.

Only a few archs use it now (namely sparc64 and powerpc64) and those
implementing HAVE_CONTEXT_TRACKING_OFFSTACK definetly can't rely on it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Phil Auld <pauld@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c23d7cb5aee3..44426e5acde2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4631,7 +4631,7 @@ void __sched schedule_idle(void)
 	} while (need_resched());
 }
 
-#ifdef CONFIG_CONTEXT_TRACKING
+#if defined(CONFIG_CONTEXT_TRACKING) && !defined(CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK)
 asmlinkage __visible void __sched schedule_user(void)
 {
 	/*
-- 
2.25.1

