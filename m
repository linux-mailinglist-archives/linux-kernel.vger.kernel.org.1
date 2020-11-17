Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1832B6877
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbgKQPQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:16:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729184AbgKQPQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:16:52 -0500
Received: from localhost.localdomain (unknown [176.167.180.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6889124631;
        Tue, 17 Nov 2020 15:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605626212;
        bh=FvrcgOwRQqA3JQo/zYz9ubzMQ19I1dvemD5ADrXjbag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=feyzuP55I9cbs54OGJMyV/Hbh3aJ/E4B1LuD/y8cKnzQ2+FD3m7tHKs3vs5ARsudO
         7/xYXwI0NfkElE8dkKvxlPeHxsKszsAV1TJwL9SYWkjbs+REn3SaYtpsam2Jncx4wC
         sgjDFMI0crqvAzSUNu3af7qz5fAPuATPCZsMN4x4=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 2/5] context_tracking:  Don't implement exception_enter/exit() on CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK
Date:   Tue, 17 Nov 2020 16:16:34 +0100
Message-Id: <20201117151637.259084-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201117151637.259084-1-frederic@kernel.org>
References: <20201117151637.259084-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The typical steps with context tracking are:

1) Task runs in userspace
2) Task enters the kernel (syscall/exception/IRQ)
3) Task switches from context tracking state CONTEXT_USER to
   CONTEXT_KERNEL (user_exit())
4) Task does stuff in kernel
5) Task switches from context tracking state CONTEXT_KERNEL to
   CONTEXT_USER (user_enter())
6) Task exits the kernel

If an exception fires between 5) and 6), the pt_regs and the context
tracking disagree on the context of the faulted/trapped instruction.
CONTEXT_KERNEL must be set before the exception handler, that's
unconditional for those handlers that want to be able to call into
schedule(), but CONTEXT_USER must be restored when the exception exits
whereas pt_regs tells that we are resuming to kernel space.

This can't be fixed with storing the context tracking state in a per-cpu
or per-task variable since another exception may fire onto the current
one and overwrite the saved state. Also the task can schedule. So it
has to be stored in a per task stack.

This is how exception_enter()/exception_exit() paper over the problem:

5) Task switches from context tracking state CONTEXT_KERNEL to
   CONTEXT_USER (user_enter())
5.1) Exception fires
5.2) prev_state = exception_enter() // save CONTEXT_USER to prev_state
                                    // and set CONTEXT_KERNEL
5.3) Exception handler
5.4) exception_enter(prev_state) // restore CONTEXT_USER
5.5) Exception resumes
6) Task exits the kernel

The condition to live without exception_enter()/exception_exit() is to
forbid exceptions and IRQs between 2) and 3) and between 5) and 6), or if
any is allowed to trigger, it won't call into context tracking, eg: NMIs,
and it won't schedule. These requirements are met by architectures
supporting CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK and those can
therefore afford not to implement this hack.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Phil Auld <pauld@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/context_tracking.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index d53cd331c4dd..bceb06498521 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -51,7 +51,8 @@ static inline enum ctx_state exception_enter(void)
 {
 	enum ctx_state prev_ctx;
 
-	if (!context_tracking_enabled())
+	if (IS_ENABLED(CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK) ||
+	    !context_tracking_enabled())
 		return 0;
 
 	prev_ctx = this_cpu_read(context_tracking.state);
@@ -63,7 +64,8 @@ static inline enum ctx_state exception_enter(void)
 
 static inline void exception_exit(enum ctx_state prev_ctx)
 {
-	if (context_tracking_enabled()) {
+	if (!IS_ENABLED(CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK) &&
+	    context_tracking_enabled()) {
 		if (prev_ctx != CONTEXT_KERNEL)
 			context_tracking_enter(prev_ctx);
 	}
-- 
2.25.1

