Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA33824B775
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 12:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgHTKyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 06:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730649AbgHTKxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:53:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12277C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 03:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=+3LcwP8mI7PPHQDysYeVzqOJCDzhxzrSNPhTjZzLUU0=; b=hZS2cXaUn4eboEcZ4fB3SH665m
        l7TxTzF40qShMvNdODNwPVa1sxSIzgc8u4qtooyxQ2ADvk78ZUFUeZwrqPKMwBpQ95FYPSxq2AlSF
        BOouAod3Kj69itJ0/D8R+wrH+D8xt6Ek4UosBjA6hwUYb9RM1muTBe8XhHDhyECoKdoWNPkssCwS1
        eFoEjuawQh0e7yG3M7nKERtqZoQOYLGU25jA9sNa8jDC1b058MO5r+hfK2lXZLV53tmsoEUj1hc6T
        7xDZzKEK2iZGpiCmL26irL5w0kDC+dCXcvEXosI6lw1SUXdtwhAomvLHarpvAyWy9GgvnIyrIvVHz
        Z1RjTdFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8iBU-0007Xw-VV; Thu, 20 Aug 2020 10:52:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D34953060F2;
        Thu, 20 Aug 2020 12:52:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4B2E22C38827D; Thu, 20 Aug 2020 12:52:36 +0200 (CEST)
Message-ID: <20200820104905.353155876@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 20 Aug 2020 12:38:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 5/7] x86/debug: Remove handle_debug(.user) argument
References: <20200820103832.486877479@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/traps.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -783,25 +783,18 @@ static __always_inline unsigned long deb
  *
  * May run on IST stack.
  */
-static void handle_debug(struct pt_regs *regs, unsigned long dr6, bool user)
+static void handle_debug(struct pt_regs *regs, unsigned long dr6)
 {
 	struct task_struct *tsk = current;
 	bool user_icebp;
 	int si_code;
 
 	/*
-	 * If DR6 is zero, no point in trying to handle it. The kernel is
-	 * not using INT1.
-	 */
-	if (!user && !dr6)
-		return;
-
-	/*
 	 * If dr6 has no reason to give us about the origin of this trap,
 	 * then it's very likely the result of an icebp/int01 trap.
 	 * User wants a sigtrap for that.
 	 */
-	user_icebp = user && !dr6;
+	user_icebp = !dr6;
 
 	/* Store the virtualized DR6 value */
 	tsk->thread.debugreg6 = dr6;
@@ -874,7 +867,13 @@ static __always_inline void exc_debug_ke
 		regs->flags &= ~X86_EFLAGS_TF;
 	}
 
-	handle_debug(regs, dr6, false);
+	/*
+	 * The kernel doesn't use INT1
+	 */
+	if (!dr6)
+		goto out;
+
+	handle_debug(regs, dr6);
 
 out:
 	instrumentation_end();
@@ -904,7 +903,7 @@ static __always_inline void exc_debug_us
 	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 
-	handle_debug(regs, dr6, true);
+	handle_debug(regs, dr6);
 
 	instrumentation_end();
 	irqentry_exit_to_user_mode(regs);


