Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5169D1C5928
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbgEEOOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729461AbgEEOOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DE2C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:05 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKQ-0000eu-Mv; Tue, 05 May 2020 16:13:46 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 262B71001F5;
        Tue,  5 May 2020 16:13:46 +0200 (CEST)
Message-Id: <20200505134100.681374113@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:28 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V4 part 1 26/36] printk: Prepare for nested printk_nmi_enter()
References: <20200505131602.633487962@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Mladek <pmladek@suse.com>

There is plenty of space in the printk_context variable. Reserve one byte
there for the NMI context to be on the safe side.

It should never overflow. The BUG_ON(in_nmi() == NMI_MASK) in nmi_enter()
will trigger much earlier.

Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200224121331.tnkvp6mmjchm4s2i@pathway.suse.cz
---
 kernel/printk/internal.h    |    8 +++++---
 kernel/printk/printk_safe.c |    4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -6,9 +6,11 @@
 
 #ifdef CONFIG_PRINTK
 
-#define PRINTK_SAFE_CONTEXT_MASK	 0x3fffffff
-#define PRINTK_NMI_DIRECT_CONTEXT_MASK	 0x40000000
-#define PRINTK_NMI_CONTEXT_MASK		 0x80000000
+#define PRINTK_SAFE_CONTEXT_MASK	0x007ffffff
+#define PRINTK_NMI_DIRECT_CONTEXT_MASK	0x008000000
+#define PRINTK_NMI_CONTEXT_MASK		0xff0000000
+
+#define PRINTK_NMI_CONTEXT_OFFSET	0x010000000
 
 extern raw_spinlock_t logbuf_lock;
 
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -295,12 +295,12 @@ static __printf(1, 0) int vprintk_nmi(co
 
 void notrace printk_nmi_enter(void)
 {
-	this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
+	this_cpu_add(printk_context, PRINTK_NMI_CONTEXT_OFFSET);
 }
 
 void notrace printk_nmi_exit(void)
 {
-	this_cpu_and(printk_context, ~PRINTK_NMI_CONTEXT_MASK);
+	this_cpu_sub(printk_context, PRINTK_NMI_CONTEXT_OFFSET);
 }
 
 /*

