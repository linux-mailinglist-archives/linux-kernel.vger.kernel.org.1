Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9019C2DA1C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503395AbgLNUi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503242AbgLNU0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:26:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C60CC06138C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:25:35 -0800 (PST)
Date:   Mon, 14 Dec 2020 20:22:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607977534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7p+/sBSXobwKU4s1Drv/pfDCf/bwyMUQmMyRVwaBUUI=;
        b=YCB+P+vIJrjbyl3zLLp8WmcURR5dlfkF75XDcBrkbwGjJoVnz1yohJY281rOSHaT1POmgM
        iZ0iX0RinnhLMgGm/LhVDkR2mUosrvoeOtAUCmtOoRhMuHpLqZBTCqpDonueSA5gECAxoF
        MOCzmhxqdPIxUAimKLDO+dKOWQYdELjlU9rjQq/IcY1um+cWqf2wSgGtFC/Z1/YxvFuPSt
        7Hc7MTMP4OsML13QBB94U5B6A9FKfgWAZjSWVUcoPEeClfv89HevdAWnKZCeTieqbxxgXC
        O4fP1N/AGDAbmlVHRi9MJM1F9PHP282kpuhPgbyAScXVmigRkMzTX8F64JV5mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607977534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7p+/sBSXobwKU4s1Drv/pfDCf/bwyMUQmMyRVwaBUUI=;
        b=vqzRPmSMUwVtzizZishdwJ9nRq6uvPeOxe6qny5riwc27rX5Lrtlrsg4Q8qsqza5/NlHum
        qfRzrBqZF+mZqSAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/fpu for v5.11-rc1
References: <160797732939.10793.9152151866806316627.tglx@nanos>
Message-ID: <160797734154.10793.1671535872493484817.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/fpu branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2020-12-14

up to:  cba08c5dc6dc: x86/fpu: Make kernel FPU protection RT friendly


X86 FPU updates:

 - Simplify the FPU protection for !RT kernels

 - Add the RT variant of FPU protections

Thanks,

	tglx

------------------>
Thomas Gleixner (2):
      x86/fpu: Simplify fpregs_[un]lock()
      x86/fpu: Make kernel FPU protection RT friendly


 arch/x86/include/asm/fpu/api.h | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index dcd9503b1098..a5aba4ab0224 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -29,17 +29,32 @@ extern void fpregs_mark_activate(void);
  * A context switch will (and softirq might) save CPU's FPU registers to
  * fpu->state and set TIF_NEED_FPU_LOAD leaving CPU's FPU registers in
  * a random state.
+ *
+ * local_bh_disable() protects against both preemption and soft interrupts
+ * on !RT kernels.
+ *
+ * On RT kernels local_bh_disable() is not sufficient because it only
+ * serializes soft interrupt related sections via a local lock, but stays
+ * preemptible. Disabling preemption is the right choice here as bottom
+ * half processing is always in thread context on RT kernels so it
+ * implicitly prevents bottom half processing as well.
+ *
+ * Disabling preemption also serializes against kernel_fpu_begin().
  */
 static inline void fpregs_lock(void)
 {
-	preempt_disable();
-	local_bh_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_disable();
+	else
+		preempt_disable();
 }
 
 static inline void fpregs_unlock(void)
 {
-	local_bh_enable();
-	preempt_enable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_enable();
+	else
+		preempt_enable();
 }
 
 #ifdef CONFIG_X86_DEBUG_FPU

