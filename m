Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BAC1C58E4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgEEOTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730059AbgEEOQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:16 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706E0C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:16 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyMZ-00020R-LS; Tue, 05 May 2020 16:15:59 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 1B557FFC8D;
        Tue,  5 May 2020 16:15:59 +0200 (CEST)
Message-Id: <20200505135314.518622698@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:49:38 +0200
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
Subject: [patch V4 part 4 12/24] x86/idtentry: Provide IDTENTRY_XEN for XEN/PV
References: <20200505134926.578885807@linutronix.de>
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

XEN/PV has special wrappers for NMI and DB exceptions. They redirect these
exceptions through regular IDTENTRY points. Provide the necessary IDTENTRY
macros to make this work

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/idtentry.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -168,6 +168,18 @@ static __always_inline void __##func(str
 #define DECLARE_IDTENTRY_DEBUG		DECLARE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_DEBUG		DEFINE_IDTENTRY_IST
 
+/**
+ * DECLARE_IDTENTRY_XEN - Declare functions for XEN redirect IDT entry points
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Used for xennmi and xendebug redirections. No DEFINE as this is all ASM
+ * indirection magic.
+ */
+#define DECLARE_IDTENTRY_XEN(vector, func)				\
+	asmlinkage void xen_asm_exc_xen##func(void);			\
+	asmlinkage void asm_exc_xen##func(void)
+
 #else /* !__ASSEMBLY__ */
 
 /*
@@ -203,6 +215,10 @@ static __always_inline void __##func(str
 /* No ASM code emitted for NMI */
 #define DECLARE_IDTENTRY_NMI(vector, func)
 
+/* XEN NMI and DB wrapper */
+#define DECLARE_IDTENTRY_XEN(vector, func)				\
+	idtentry vector asm_exc_xen##func exc_##func has_error_code=0 sane=1
+
 #endif /* __ASSEMBLY__ */
 
 /*

