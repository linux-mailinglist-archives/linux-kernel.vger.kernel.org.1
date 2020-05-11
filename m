Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BB01CE2A6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 20:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbgEKS1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 14:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731152AbgEKS1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:27:31 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89321C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:27:31 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYD8o-0003O2-8G; Mon, 11 May 2020 20:27:02 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id C49A9FFBF8; Mon, 11 May 2020 20:27:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: Re: [patch V4 part 2 10/18] x86/entry/64: Check IF in __preempt_enable_notrace() thunk
In-Reply-To: <87k11j4ogb.fsf@nanos.tec.linutronix.de>
References: <20200505134112.272268764@linutronix.de> <20200505134341.087595319@linutronix.de> <CALCETrVpSj9fVyUHp-Q_tT-xLgTfYR5JFv52AsOuGJsDYeN3-Q@mail.gmail.com> <87k11l4d7l.fsf@nanos.tec.linutronix.de> <87k11j4ogb.fsf@nanos.tec.linutronix.de>
Date:   Mon, 11 May 2020 20:27:00 +0200
Message-ID: <87r1vq5nuz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> Thomas Gleixner <tglx@linutronix.de> writes:
>> Let me stare into that again.
>
> There are a few preempt_disable/enable() pairs in some of the helper
> functions which are called in various places. That means we would have
> to chase all of them and provide 'naked' helpers for these particular
> call chains. I'll fix the changelog and add a comment to make clear what
> this is about.

I actually sat down and chased it. It's mostly the tracing code - again,
particularly the hardware latency tracer. There is really no point to
invoke that from the guts of nmi_enter() and nmi_exit().

Neither for #DB, #BP nor #MCE there is a reason to invoke that at
all. If someone does hardware latency analysis then #DB and #BP should
not be in use at all. If so, shrug. If #MCE hits, then the hardware
induced latency is the least of the worries.

So the only relevant place is actually NMI which wants to be tracked to
avoid false positives. But that tracking really can wait to the point
where the NMI has actually reached halfways stable state.

The other place which as preempt_disable/enable_notrace() in it is
rcu_is_watching() but it's trivial enough to provide a naked version for
that.

Thanks,

        tglx

8<------------------
Subject: nmi, tracing: Provide nmi_enter/exit_notrace()
From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 11 May 2020 10:57:16 +0200

To fully isolate #DB and #BP from instrumentable code it's necessary to
avoid invoking the hardware latency tracer on nmi_enter/exit().

Provide nmi_enter/exit() variants which are not invoking the hardware
latency tracer. That allows to put calls explicitely into the call sites
outside of the kprobe handling.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: New patch
---
 include/linux/hardirq.h |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -77,28 +77,38 @@ extern void irq_exit(void);
 /*
  * nmi_enter() can nest up to 15 times; see NMI_BITS.
  */
-#define nmi_enter()						\
+#define nmi_enter_notrace()					\
 	do {							\
 		arch_nmi_enter();				\
 		printk_nmi_enter();				\
 		lockdep_off();					\
-		ftrace_nmi_enter();				\
 		BUG_ON(in_nmi() == NMI_MASK);			\
 		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
 		rcu_nmi_enter();				\
 		lockdep_hardirq_enter();			\
 	} while (0)
 
-#define nmi_exit()						\
+#define nmi_enter()						\
+	do {							\
+		nmi_enter_notrace();				\
+		ftrace_nmi_enter();				\
+	} while (0)
+
+#define nmi_exit_notrace()					\
 	do {							\
 		lockdep_hardirq_exit();				\
 		rcu_nmi_exit();					\
 		BUG_ON(!in_nmi());				\
 		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
-		ftrace_nmi_exit();				\
 		lockdep_on();					\
 		printk_nmi_exit();				\
 		arch_nmi_exit();				\
 	} while (0)
 
+#define nmi_exit()						\
+	do {							\
+		ftrace_nmi_exit();				\
+		nmi_exit_notrace();				\
+	} while (0)
+
 #endif /* LINUX_HARDIRQ_H */
