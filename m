Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44AA1C5927
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgEEOOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729191AbgEEOOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:00 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18B4C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:00 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKM-0000bq-TF; Tue, 05 May 2020 16:13:43 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 6CF14FFC8D;
        Tue,  5 May 2020 16:13:42 +0200 (CEST)
Message-Id: <20200505134100.376598577@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:25 +0200
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
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 1 23/36] bug: Annotate WARN/BUG/stackfail as noinstr safe
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

Warnings, bugs and stack protection fails from noinstr sections, e.g. low
level and early entry code, are likely to be fatal.

Mark them as "safe" to be invoked from noinstr protected code to avoid
annotating all usage sites. Getting the information out is important.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/bug.h |    3 +++
 include/asm-generic/bug.h  |    9 +++++++--
 kernel/panic.c             |    4 +++-
 3 files changed, 13 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -70,13 +70,16 @@ do {									\
 #define HAVE_ARCH_BUG
 #define BUG()							\
 do {								\
+	instr_begin();						\
 	_BUG_FLAGS(ASM_UD2, 0);					\
 	unreachable();						\
 } while (0)
 
 #define __WARN_FLAGS(flags)					\
 do {								\
+	instr_begin();						\
 	_BUG_FLAGS(ASM_UD2, BUGFLAG_WARNING|(flags));		\
+	instr_end();						\
 	annotate_reachable();					\
 } while (0)
 
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -83,14 +83,19 @@ extern __printf(4, 5)
 void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 		       const char *fmt, ...);
 #define __WARN()		__WARN_printf(TAINT_WARN, NULL)
-#define __WARN_printf(taint, arg...)					\
-	warn_slowpath_fmt(__FILE__, __LINE__, taint, arg)
+#define __WARN_printf(taint, arg...) do {				\
+		instr_begin();						\
+		warn_slowpath_fmt(__FILE__, __LINE__, taint, arg);	\
+		instr_end();						\
+	} while (0)
 #else
 extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 #define __WARN()		__WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
 #define __WARN_printf(taint, arg...) do {				\
+		instr_begin();						\
 		__warn_printk(arg);					\
 		__WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
+		instr_end();						\
 	} while (0)
 #define WARN_ON_ONCE(condition) ({				\
 	int __ret_warn_on = !!(condition);			\
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -662,10 +662,12 @@ device_initcall(register_warn_debugfs);
  * Called when gcc's -fstack-protector feature is used, and
  * gcc detects corruption of the on-stack canary value
  */
-__visible void __stack_chk_fail(void)
+__visible noinstr void __stack_chk_fail(void)
 {
+	instr_begin();
 	panic("stack-protector: Kernel stack is corrupted in: %pB",
 		__builtin_return_address(0));
+	instr_end();
 }
 EXPORT_SYMBOL(__stack_chk_fail);
 

