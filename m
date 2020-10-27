Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72D429A959
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897725AbgJ0KQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:16:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46104 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897688AbgJ0KQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:16:30 -0400
Message-Id: <20201027101349.455380473@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603793788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=UIWijzAC3J28IOH9T8IK0qCaF/M9RF7arvqT9VIChlQ=;
        b=LJJla/WYWR0o1eUqBuoXX1899CjoxyXdLlfwUjX8T3XMTvsAXEbciwTCqYD1QzpAFXNn1f
        nzO2dg4vAnZePTKy0Z1aoDNLceNachkVnu0dqaSNurxeB/oC/RMpD/psXjG/pUUPuoK8wr
        vc+lhnN21PA1Eg3XgM2fehHSanJyJPh2FPWgSfO4IFM2PA5sfz+6YrALu4xzN7+J39SEpy
        WA9UgjYRZh+Cn0IG11e2PuYevz5eZJNYwLpg8gqfEHbGiUaCajLhPPuU1H6MK7I52Y6Tnv
        7WfbMSbekvtJJNA4omcw1DGjcuPiE307xsioE4fUIbnMTzJmsHp5KaAKXmHQEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603793788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=UIWijzAC3J28IOH9T8IK0qCaF/M9RF7arvqT9VIChlQ=;
        b=RTV/xQUAtaFg0MFhXf2HjsyWWQb4y8jBbwe1o5mBUjIwWZqreWHHC8XZ22OMPoz7zzg5q4
        iFLSFQTsNB9ZrPCw==
Date:   Tue, 27 Oct 2020 11:09:50 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 1/2] x86/fpu: Simplify fpregs_[un]lock()
References: <20201027100949.181320853@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in disabling preemption and then disabling bottom
halfs.

Just disabling bottom halfs is sufficient as it implicitly disables
preemption on !RT kernels.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/api.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -29,17 +29,18 @@ extern void fpregs_mark_activate(void);
  * A context switch will (and softirq might) save CPU's FPU registers to
  * fpu->state and set TIF_NEED_FPU_LOAD leaving CPU's FPU registers in
  * a random state.
+ *
+ * local_bh_disable() protects against both preemption and soft interrupts
+ * on !RT kernels.
  */
 static inline void fpregs_lock(void)
 {
-	preempt_disable();
 	local_bh_disable();
 }
 
 static inline void fpregs_unlock(void)
 {
 	local_bh_enable();
-	preempt_enable();
 }
 
 #ifdef CONFIG_X86_DEBUG_FPU

