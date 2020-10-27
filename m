Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE8E29B5B0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 16:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1794970AbgJ0POj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 11:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1793891AbgJ0PIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:08:53 -0400
Received: from localhost.localdomain (i16-lef01-ix2-212-195-25-126.ft.lns.abo.bbox.fr [212.195.25.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E507222C8;
        Tue, 27 Oct 2020 15:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603811333;
        bh=zj5ZXXeG17+GCCEz681qCJgISi9Mt9/vla4/MgoSMX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z1fc+Hgg+WlNfaaAYz3Nhj3sN4I6SMv7MIOZSq1d9hKcvVfpfPXMfXJ24LliglSVV
         5NXgGGrXP/4bofJOlM19xec5nHg83T07C9lqe9BpVmiB+yM7aAKjWGdMcZY9/E76iy
         qRdXTvZYcpEPxEgJRBp9iFZ/75DEKAaZZUzYnFec=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 2/5] context_tracking:  Don't implement exception_enter/exit() on CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK
Date:   Tue, 27 Oct 2020 16:08:24 +0100
Message-Id: <20201027150827.148821-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027150827.148821-1-frederic@kernel.org>
References: <20201027150827.148821-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An architecture that provides this Kconfig feature doesn't need to
store the context tracking state on the task stack because its entry
code has been sanitized such that fragile path aren't preemptible
and special use of tracing and RCU read side critical sections in these
areas have been explicitly annotated.

Hence the exception_enter()/exception_exit() couple doesn't need to be
implemented in this case.

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

