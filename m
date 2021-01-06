Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4462EBFD5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 15:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbhAFOtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 09:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbhAFOtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:49:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1F9C061357
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 06:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=LvhqLjzhDb+9q4vjYXmSZl5pgFD1dILWN5ao2jB2EEc=; b=gGUClaRFQCQfVUfPGMSMXWNKbH
        eKg19pnE6gZMHsxIj90MiaO1Rzj/27tWVwFrMvPOkKsnzAvRqT9W3Rya4PMclBY1Yl5TWibQjQQtb
        qadNF8Fa6rpd/WBdD5/H4OgjQ4C8oOWF2Zl5w7xG5ZWgTqUvhXaB+WLhV4JCVjfBMiXGreNCNmqTu
        WpCr0qoBVOmK0SIilncIA9h1OqjROVgTqlzLsfapRmUqD9Q0wKiJBSSb4nUtiqOsucC/BPl6GRaFM
        e2YGezuFTlxqFXSHkB8JJAgm+tCDwYmIqp7dAsXt2NrEcgNwLxotYQDrVlsOUBrlPNonZK+HuT+0Z
        M223hylw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kxA3J-002QUb-2z; Wed, 06 Jan 2021 14:45:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28887307967;
        Wed,  6 Jan 2021 15:44:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B18CE202A3CED; Wed,  6 Jan 2021 15:44:42 +0100 (CET)
Message-ID: <20210106144017.779081583@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 06 Jan 2021 15:36:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, jpoimboe@redhat.com, sfr@canb.auug.org.au,
        tony.luck@intel.com
Subject: [RFC][PATCH 6/6] x86/mce: Dont use noinstr for now
References: <20210106143619.479313782@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We call do_machine_check() from a 'safe' context, instrumentation
should be possible. However, due to the nature of the beast, MCE is
fragile and we really rather would not want to hit additional code.

Currently this is done by marking do_machine_check() as noinstr,
however there's at least one objtool warning because of that:

  vmlinux.o: warning: objtool: do_machine_check()+0x650: call to queue_task_work() leaves .noinstr.text section

trying to fix that leads down a rabbit-hole. A _lot_ of code would end
up having to be marked noinstr outside of the MCE code. While
possible, doing so is undesired because it would hide it from
instrumentation for all other users.

Instead of using noinstr, kill instrumentation for all of mce/. This
switches MCE over to a best-effort but non-validated mode. Doing
better will require a significant investment of time and effort.

The obvious problem with tracing the MCE is that the tracer will
trigger a further MCE and we DIE an instant death.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/cpu/mce/Makefile |    7 +++++++
 arch/x86/kernel/cpu/mce/core.c   |    6 +-----
 2 files changed, 8 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/cpu/mce/Makefile
+++ b/arch/x86/kernel/cpu/mce/Makefile
@@ -1,4 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
+
+# No instrumentation for MCE code
+KASAN_SANITIZE := n
+UBSAN_SANITIZE := n
+KCOV_INSTRUMENT := n
+ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
+
 obj-y				=  core.o severity.o genpool.o
 
 obj-$(CONFIG_X86_ANCIENT_MCE)	+= winchip.o p5.o
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1299,7 +1299,7 @@ static void queue_task_work(struct mce *
  * backing the user stack, tracing that reads the user stack will cause
  * potentially infinite recursion.
  */
-noinstr void do_machine_check(struct pt_regs *regs)
+void do_machine_check(struct pt_regs *regs)
 {
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
@@ -1987,10 +1987,6 @@ static __always_inline void exc_machine_
 		return;
 
 	irq_state = irqentry_nmi_enter(regs);
-	/*
-	 * The call targets are marked noinstr, but objtool can't figure
-	 * that out because it's an indirect call. Annotate it.
-	 */
 	instrumentation_begin();
 
 	machine_check_vector(regs);


