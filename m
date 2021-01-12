Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E852F3FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395110AbhALXBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 18:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732525AbhALXBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 18:01:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D4EC061795
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 15:01:03 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610492462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V3VcMaNAnS5DFS8St8UE1/STiFhKNlHQt73PRBf24+I=;
        b=DaPLP/NyAVXZL/ViHl/ajSDvUjI7+Boqj3dZaKoFmbxjA7rwaMtJ3VNFptqyxnRgmSh8fL
        4D6H65dZ5DIVlhPsVnQH5UNunk3ea4vkuLLm1luJiFzZ5iekKKzSNjznYsG3oYfvOUp0Ec
        NigSKAAKJl4j6z9Boq5GBeWgt1mZ0qubUkajFrqNo1cB2w0NYvkE67tLVvREVVAG9ENpPh
        VL1PKr+SFQKNh3Mkp7H6RZrDKGZsNbkyDU1eC8INrYk+CL7cDK+bA8pGVG6KG9c20bdpd4
        qR6u1k3Vvt2WHf9zIzCFK0TF0eUsr5KoAmOnPeMIkr9Ba7BteKKewBY0kMYuGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610492462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V3VcMaNAnS5DFS8St8UE1/STiFhKNlHQt73PRBf24+I=;
        b=VzPCGit3Dro7aVwCOgfbmJ3XybyEyQSCFs9WRuVjYIST7GSoq5PVnoTa8WUuVLNBhXZpYt
        quTmgDNwgUTyx1Ag==
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/3] tracing: Use in_serving_softirq() to deduct softirq status.
Date:   Wed, 13 Jan 2021 00:00:56 +0100
Message-Id: <20210112230057.2374308-3-bigeasy@linutronix.de>
In-Reply-To: <20210112230057.2374308-1-bigeasy@linutronix.de>
References: <20210112230057.2374308-1-bigeasy@linutronix.de>
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
index 679112d3b3da9..416b63e05960e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2596,8 +2596,7 @@ unsigned int _tracing_gen_ctx_flags(unsigned long irq=
flags)
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

