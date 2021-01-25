Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D87302D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732464AbhAYVDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732091AbhAYTqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:46:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC13C061786
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:45:18 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611603916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+HfGl+/GNRNWyOzdbKkC1xj1Rzooe0KDoyRVThR3Nlg=;
        b=clmPMoknRh418hMyR5PARCW8L0F4YxQYAhEEa481ZIl9xs2VcCZHCovFAcO/9QsXfUuHLW
        3Fga5ZA+8q6QH/oaA4ij2n6m0fMkLd9neQYYu7V5R0RLWkZNAanbBIZFZmI+7diR0Rf0S3
        oIr5flHdVlYOeXy26RFAeZvIR+lWpIMgtdmu0aKcSlKwoOlk9EzYiw3h2PJkbFUMGVYpyh
        qf2xGmbQkkttzNmSv1Zzbkk7KYrfSWnpSu3poqRm3cLt+SPuXRAL0QIP4J3Yx2+ApIU5sl
        p7ZWQ2n2yZBaD3BK+Ukir3t8ZKgIaprV0qjhLX5Fg2CR/JzNNcHfH5DV+RuNfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611603916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+HfGl+/GNRNWyOzdbKkC1xj1Rzooe0KDoyRVThR3Nlg=;
        b=pJ5JG5Yp1uwjmPcVCzRpvfuiOeJyk5KW2np3SqmQrmtGEFsmRl0FFqU5OoOV0+2pj9CDFt
        Gglre1W/b78RFYDw==
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/4] tracing: Inline tracing_gen_ctx_flags()
Date:   Mon, 25 Jan 2021 20:45:09 +0100
Message-Id: <20210125194511.3924915-3-bigeasy@linutronix.de>
In-Reply-To: <20210125194511.3924915-1-bigeasy@linutronix.de>
References: <20210125140323.6b1ff20c@gandalf.local.home>
 <20210125194511.3924915-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inline tracing_gen_ctx_flags(). This allows to have one ifdef
CONFIG_TRACE_IRQFLAGS_SUPPORT.

This requires to move `trace_flag_type' so tracing_gen_ctx_flags() can
use it.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/20210125140323.6b1ff20c@gandalf.local.home
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/trace_events.h | 54 ++++++++++++++++++++++++++++++++++--
 kernel/trace/trace.c         | 38 ++-----------------------
 kernel/trace/trace.h         | 19 -------------
 3 files changed, 53 insertions(+), 58 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 091250b0895a3..67ae708de40d6 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -160,9 +160,57 @@ static inline void tracing_generic_entry_update(struct=
 trace_entry *entry,
 	entry->flags =3D			trace_ctx >> 16;
 }
=20
-unsigned int tracing_gen_ctx_flags(unsigned long irqflags);
-unsigned int tracing_gen_ctx(void);
-unsigned int tracing_gen_ctx_dec(void);
+unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status);
+
+enum trace_flag_type {
+	TRACE_FLAG_IRQS_OFF		=3D 0x01,
+	TRACE_FLAG_IRQS_NOSUPPORT	=3D 0x02,
+	TRACE_FLAG_NEED_RESCHED		=3D 0x04,
+	TRACE_FLAG_HARDIRQ		=3D 0x08,
+	TRACE_FLAG_SOFTIRQ		=3D 0x10,
+	TRACE_FLAG_PREEMPT_RESCHED	=3D 0x20,
+	TRACE_FLAG_NMI			=3D 0x40,
+};
+
+#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
+static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
+{
+	unsigned int irq_status =3D irqs_disabled_flags(irqflags) ?
+		TRACE_FLAG_IRQS_OFF : 0;
+	return tracing_gen_ctx_irq_test(irq_status);
+}
+static inline unsigned int tracing_gen_ctx(void)
+{
+	unsigned long irqflags;
+
+	local_save_flags(irqflags);
+	return tracing_gen_ctx_flags(irqflags);
+}
+#else
+
+static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
+{
+	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
+}
+static inline unsigned int tracing_gen_ctx(void)
+{
+	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
+}
+#endif
+
+static inline unsigned int tracing_gen_ctx_dec(void)
+{
+	unsigned int trace_ctx;
+
+	trace_ctx =3D tracing_gen_ctx();
+	/*
+	 * Subtract one from the preeption counter if preemption is enabled,
+	 * see trace_event_buffer_reserve()for details.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPTION))
+		trace_ctx--;
+	return trace_ctx;
+}
=20
 struct trace_event_file;
=20
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d3c3bb58cf022..20858c3f6a046 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2578,20 +2578,13 @@ enum print_line_t trace_handle_return(struct trace_=
seq *s)
 }
 EXPORT_SYMBOL_GPL(trace_handle_return);
=20
-unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
+unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
 {
-	unsigned int trace_flags =3D 0;
+	unsigned int trace_flags =3D irqs_status;
 	unsigned int pc;
=20
 	pc =3D preempt_count();
=20
-#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
-	if (irqs_disabled_flags(irqflags))
-		trace_flags |=3D TRACE_FLAG_IRQS_OFF;
-#else
-	trace_flags |=3D TRACE_FLAG_IRQS_NOSUPPORT;
-#endif
-
 	if (pc & NMI_MASK)
 		trace_flags |=3D TRACE_FLAG_NMI;
 	if (pc & HARDIRQ_MASK)
@@ -2607,33 +2600,6 @@ unsigned int tracing_gen_ctx_flags(unsigned long irq=
flags)
 	return (trace_flags << 16) | (pc & 0xff);
 }
=20
-unsigned int tracing_gen_ctx(void)
-{
-	unsigned long irqflags;
-
-#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
-	local_save_flags(irqflags);
-#else
-	irqflags =3D 0;
-#endif
-	return tracing_gen_ctx_flags(irqflags);
-}
-
-unsigned int tracing_gen_ctx_dec(void)
-{
-	unsigned int trace_ctx;
-
-	trace_ctx =3D tracing_gen_ctx();
-
-	/*
-	 * Subtract one from the preeption counter if preemption is enabled,
-	 * see trace_event_buffer_reserve()for details.
-	 */
-	if (IS_ENABLED(CONFIG_PREEMPTION))
-		trace_ctx--;
-	return trace_ctx;
-}
-
 struct ring_buffer_event *
 trace_buffer_lock_reserve(struct trace_buffer *buffer,
 			  int type,
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 8daf3a0758b12..93fb08ab8bb6b 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -136,25 +136,6 @@ struct kretprobe_trace_entry_head {
 	unsigned long		ret_ip;
 };
=20
-/*
- * trace_flag_type is an enumeration that holds different
- * states when a trace occurs. These are:
- *  IRQS_OFF		- interrupts were disabled
- *  IRQS_NOSUPPORT	- arch does not support irqs_disabled_flags
- *  NEED_RESCHED	- reschedule is requested
- *  HARDIRQ		- inside an interrupt handler
- *  SOFTIRQ		- inside a softirq handler
- */
-enum trace_flag_type {
-	TRACE_FLAG_IRQS_OFF		=3D 0x01,
-	TRACE_FLAG_IRQS_NOSUPPORT	=3D 0x02,
-	TRACE_FLAG_NEED_RESCHED		=3D 0x04,
-	TRACE_FLAG_HARDIRQ		=3D 0x08,
-	TRACE_FLAG_SOFTIRQ		=3D 0x10,
-	TRACE_FLAG_PREEMPT_RESCHED	=3D 0x20,
-	TRACE_FLAG_NMI			=3D 0x40,
-};
-
 #define TRACE_BUF_SIZE		1024
=20
 struct trace_array;
--=20
2.30.0

