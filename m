Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3081F27CB07
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbgI2MYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729777AbgI2LfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:35:09 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20518C0613DF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 04:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=DjU0La5QsoHHU3N/iP5NR7BNOKT7gs7FCGIaZPbhNwc=; b=ZN5LjK5F3woZOpGU9pQh/O2ve3
        JWUzoZJgYu4GzSvyFV4D18VOaTMJ3ROWWJkCwtngwCfJoFeDFN4rPd9Z9yzy3L44HtX7+Jd86Ivh1
        HEaMAOwjb33cJHF0IGOqdzvfAsFaFetyp8sVi1ys5NVI7VGmqrajlzzgovz4rtzfay7nDMgLkbtnq
        fJ18GtkTZNVEMGC8J8rL3skVJazmvD/xwQnBASZFMPamFaLpK4yBlmSxfX6RG29kMJoH/hUm5JbK2
        OIwbbG0QTD0LbYNOMERsmkf5Y26/nchkZPEe9fosepwVCVpr4DOI2YpyGMRC/XsKyDKiaa9eSy7iY
        08IFsEYg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNDtA-00020q-IP; Tue, 29 Sep 2020 11:33:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C97B23062BA;
        Tue, 29 Sep 2020 13:33:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 81EF6200D4C48; Tue, 29 Sep 2020 13:33:40 +0200 (CEST)
Date:   Tue, 29 Sep 2020 13:33:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paul McKenney <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, kim.phillips@amd.com
Subject: [PATCH] rcu,ftrace: Fix ftrace recursion
Message-ID: <20200929113340.GN2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kim reported that perf-ftrace made his box unhappy. It turns out that
commit:

  ff5c4f5cad33 ("rcu/tree: Mark the idle relevant functions noinstr")

removed one too many notrace. Probably due to there not being a helpful
comment.

Reinstate the notrace and add a comment to avoid loosing it again.

Fixes: ff5c4f5cad33 ("rcu/tree: Mark the idle relevant functions noinstr")
Reported-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/rcu/tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ee5e595501e8..33020d84ec6b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1098,8 +1098,11 @@ noinstr bool __rcu_is_watching(void)
  * CPU can safely enter RCU read-side critical sections.  In other words,
  * if the current CPU is not in its idle loop or is in an interrupt or
  * NMI handler, return true.
+ *
+ * Must be notrace because __ftrace_ops_list_func() / ftrace_ops_assist_func()
+ * will call this (for every function) outside of recursion protection.
  */
-bool rcu_is_watching(void)
+notrace bool rcu_is_watching(void)
 {
 	bool ret;
 
