Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7215028342F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 12:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgJEKtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 06:49:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgJEKtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 06:49:33 -0400
Received: from localhost.localdomain (unknown [94.238.213.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD1192078E;
        Mon,  5 Oct 2020 10:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601894973;
        bh=cmNfiTiEFaEzS7i7+ax6M+OfXWovFZb9x0YWXzxnWvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=erITJzNW4V7UGb3B7N2gnPLIiplPHW9b5ubcVs6MxVmDGaMyzr0qMl1CYNDmUHjW5
         Wzd6L65RNlYnu7Fw67p+Ns97brjm9wsva32n99b+IRI6KgLM3qfHflkb/2GkYErB3F
         1YGmexU0F08yZpnTOmD2IGlQhRgbJKRQZndYKBys=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 4/5] context_tracking: Only define schedule_user() on !HAVE_CONTEXT_TRACKING_OFFSTACK archs
Date:   Mon,  5 Oct 2020 12:49:18 +0200
Message-Id: <20201005104919.5250-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201005104919.5250-1-frederic@kernel.org>
References: <20201005104919.5250-1-frederic@kernel.org>
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

Only a few archs use it now and those implementing
HAVE_CONTEXT_TRACKING_OFFSTACK definetly can't rely on it.

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
index d31a79e073e3..cb7afcfbb809 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4632,7 +4632,7 @@ void __sched schedule_idle(void)
 	} while (need_resched());
 }
 
-#ifdef CONFIG_CONTEXT_TRACKING
+#if defined(CONFIG_CONTEXT_TRACKING) && !defined(CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK)
 asmlinkage __visible void __sched schedule_user(void)
 {
 	/*
-- 
2.25.1

