Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BCA1C58D9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbgEEOQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730032AbgEEOQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61B0C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:11 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyMU-0001vg-N3; Tue, 05 May 2020 16:15:54 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 2AB3B1001F5;
        Tue,  5 May 2020 16:15:54 +0200 (CEST)
Message-Id: <20200505135314.137125609@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:49:34 +0200
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
Subject: [patch V4 part 4 08/24] x86/entry: Provide IDTENTRY_IST
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

Same as IDTENTRY but for exceptions which run on Interrupt STacks (IST) on
64bit. For 32bit this maps to IDTENTRY.

There are 3 variants which will be used:
      IDTENTRY_MCE
      IDTENTRY_DB
      IDTENTRY_NMI

These map to IDTENTRY_IST, but only the MCE and DB variants are emitting
ASM code as the NMI entry needs hand crafted ASM still.

The function defines do not contain any idtenter/exit calls as these
exceptions need special treatment.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 arch/x86/include/asm/idtentry.h |   54 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -132,6 +132,42 @@ static __always_inline void __##func(str
 #define DEFINE_IDTENTRY_RAW(func)					\
 __visible noinstr void func(struct pt_regs *regs)
 
+#ifdef CONFIG_X86_64
+/**
+ * DECLARE_IDTENTRY_IST - Declare functions for IST handling IDT entry points
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Maps to DECLARE_IDTENTRY_RAW
+ */
+#define DECLARE_IDTENTRY_IST(vector, func)				\
+	DECLARE_IDTENTRY_RAW(vector, func)
+
+/**
+ * DEFINE_IDTENTRY_IST - Emit code for IST entry points
+ * @func:	Function name of the entry point
+ *
+ * Maps to DEFINE_IDTENTRY_RAW
+ */
+#define DEFINE_IDTENTRY_IST(func)					\
+	DEFINE_IDTENTRY_RAW(func)
+
+#else	/* CONFIG_X86_64 */
+/* Maps to a regular IDTENTRY on 32bit for now */
+# define DECLARE_IDTENTRY_IST		DECLARE_IDTENTRY
+# define DEFINE_IDTENTRY_IST		DEFINE_IDTENTRY
+#endif	/* !CONFIG_X86_64 */
+
+/* C-Code mapping */
+#define DECLARE_IDTENTRY_MCE		DECLARE_IDTENTRY_IST
+#define DEFINE_IDTENTRY_MCE		DEFINE_IDTENTRY_IST
+
+#define DECLARE_IDTENTRY_NMI		DECLARE_IDTENTRY_IST
+#define DEFINE_IDTENTRY_NMI		DEFINE_IDTENTRY_IST
+
+#define DECLARE_IDTENTRY_DEBUG		DECLARE_IDTENTRY_IST
+#define DEFINE_IDTENTRY_DEBUG		DEFINE_IDTENTRY_IST
+
 #else /* !__ASSEMBLY__ */
 
 /*
@@ -149,6 +185,24 @@ static __always_inline void __##func(str
 #define DECLARE_IDTENTRY_RAW(vector, func)				\
 	DECLARE_IDTENTRY(vector, func)
 
+#ifdef CONFIG_X86_64
+# define DECLARE_IDTENTRY_MCE(vector, func)				\
+	idtentry_mce_db vector asm_##func func
+
+# define DECLARE_IDTENTRY_DEBUG(vector, func)				\
+	idtentry_mce_db vector asm_##func func
+
+#else
+# define DECLARE_IDTENTRY_MCE(vector, func)				\
+	DECLARE_IDTENTRY(vector, func)
+
+# define DECLARE_IDTENTRY_DEBUG(vector, func)				\
+	DECLARE_IDTENTRY(vector, func)
+#endif
+
+/* No ASM code emitted for NMI */
+#define DECLARE_IDTENTRY_NMI(vector, func)
+
 #endif /* __ASSEMBLY__ */
 
 /*

