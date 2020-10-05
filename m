Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDA128342D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 12:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgJEKtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 06:49:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgJEKt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 06:49:29 -0400
Received: from localhost.localdomain (unknown [94.238.213.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B953B2078E;
        Mon,  5 Oct 2020 10:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601894969;
        bh=zj5ZXXeG17+GCCEz681qCJgISi9Mt9/vla4/MgoSMX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jKTVrEjeoYtW/z/3tzzngd/ELeCfPGmU8F6lw2j8OktZ8cTpcupq22kWquAC52U0f
         6SqTlCvjGGP3NwlmA6Q0Y+wA3Xgo34EpPTku+pBqf7/XYcCclJOC1hVRmbUFBDnVuD
         70d21xVB91qXnv+G2VplXneg53Sic7M7gXChIlq4=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 2/5] context_tracking:  Don't implement exception_enter/exit() on CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK
Date:   Mon,  5 Oct 2020 12:49:16 +0200
Message-Id: <20201005104919.5250-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201005104919.5250-1-frederic@kernel.org>
References: <20201005104919.5250-1-frederic@kernel.org>
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

