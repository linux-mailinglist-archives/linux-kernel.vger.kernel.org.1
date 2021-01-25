Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6C0302D22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbhAYVAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:00:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44192 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732079AbhAYTqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:46:05 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611603916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Km5SJItv6vGFevpuGof9Afj4xHUJh01jllniSFh/Jg=;
        b=as4tk/yjdFml+YqxceQVKVDYAtwSzoGqun/EGHt7F25LcG9zUo5pXUD6z+zWyYUSoIIkkG
        IFnLRkdLjYryzjPE4k//+27zbQsTbb79sf8IqkvF77nQ1+6ZKiMsJfSvxyo+A9Xd+ZRmqr
        YNBwVMtYX3cVPOtc4ivChwu6SD45szkyufmNorsKP0dk07EuVIHfPwHg2+lmVyjblEzQVX
        zICCR8cM+b8AeWSj02HLC2CPamtRNrs2VD4w1kjkRUPbWotwkrnM4J2ASMN7k9C7s1Q622
        pvbrsEASP3/ReY8J8rzeLBd9yWaUWasBVcIjEXGzCm65CZo7NrVfqrbQxXzifQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611603916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Km5SJItv6vGFevpuGof9Afj4xHUJh01jllniSFh/Jg=;
        b=MMxuVg5MYIse+M1aF9zSjlOq4HDg3t6SOfHZCZASZnV3ZfIO5McoIr40/Y0xJM3AcGYQxh
        hGDnILlbx54QhICA==
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/4] tracing: Use in_serving_softirq() to deduct softirq status.
Date:   Mon, 25 Jan 2021 20:45:10 +0100
Message-Id: <20210125194511.3924915-4-bigeasy@linutronix.de>
In-Reply-To: <20210125194511.3924915-1-bigeasy@linutronix.de>
References: <20210125140323.6b1ff20c@gandalf.local.home>
 <20210125194511.3924915-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PREEMPT_RT does not report "serving softirq" because the tracing core
looks at the preemption counter while PREEMPT_RT does not update it
while processing softirqs in order to remain preemptible. The
information is stored somewhere else.
The in_serving_softirq() macro and the SOFTIRQ_OFFSET define are still
working but not on the preempt-counter.

Use in_serving_softirq() macro which works on PREEMPT_RT. On !PREEMPT_RT
the compiler (gcc-10 / clang-11) is smart enough to optimize the
in_serving_softirq() related read of the preemption counter away.
The only difference I noticed by using in_serving_softirq() on
!PREEMPT_RT is that gcc-10 implemented tracing_gen_ctx_flags() as
reading FLAG, jmp _tracing_gen_ctx_flags(). Without in_serving_softirq()
it inlined _tracing_gen_ctx_flags() into tracing_gen_ctx_flags().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/trace/trace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 20858c3f6a046..75612d953fe04 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2589,8 +2589,7 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int ir=
qs_status)
 		trace_flags |=3D TRACE_FLAG_NMI;
 	if (pc & HARDIRQ_MASK)
 		trace_flags |=3D TRACE_FLAG_HARDIRQ;
-
-	if (pc & SOFTIRQ_OFFSET)
+	if (in_serving_softirq())
 		trace_flags |=3D TRACE_FLAG_SOFTIRQ;
=20
 	if (tif_need_resched())
--=20
2.30.0

