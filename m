Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7060D29A958
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897711AbgJ0KQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:16:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46108 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897690AbgJ0KQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:16:31 -0400
Message-Id: <20201027101349.588965083@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603793790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=fhyVmyh5+YCzuIWOCCWmeRkSyPiSgkoPpHYTnro6jTQ=;
        b=OV2QY4cwJrvCFLZlAx3xvpty170HEeFFfpx0ME3Vm+HLqZyV4gfoxxXNPglyFmKjmKkFOP
        zuAbW/rk6tqC432lckcvMfgp4kNPKlCql4GX/hej+Jrb0ajNzagFVtLDNUE7SrqUDfDyUQ
        OaCvB1T5Ow8LCqGuVqu0vTzgrxttFatdzOdwCMIIy8u5ja4GDdQjwRJz8Q3cUxY4MBmxep
        tnU9TVvvdCAy5bSj7YMhIm+sqrwbBlPWRBsaBdV0MMfP9LArRuCoCLn2k3tE6mI7hW4pXs
        lqrxABX8puX98MhxNz1aG6m9kF6fQ5dJMRY7NqmgKUoA+mioxFq+hGUovxWuIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603793790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=fhyVmyh5+YCzuIWOCCWmeRkSyPiSgkoPpHYTnro6jTQ=;
        b=2Rz6UZgP8c2uzphIpNpUOoA8NuDB1mAfG1p4anE5CLai8po5A9Zo26u9awCiF6YSOQHIQA
        uhHqwZYG5j3hZvAw==
Date:   Tue, 27 Oct 2020 11:09:51 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 2/2] x86/fpu: Make kernel FPU protection RT friendly
References: <20201027100949.181320853@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Non RT kernels need to protect FPU against preemption and bottom half
processing. This is achieved by disabling bottom halfs via
local_bh_disable() which implictly disables preemption.

On RT kernels this protection mechanism is not sufficient because
local_bh_disable() does not disable preemption. It serializes bottom half
related processing via a CPU local lock.

As bottom halfs are running always in thread context on RT kernels
disabling preemption is the proper choice as it implicitly prevents bottom
half processing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/api.h |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -32,15 +32,27 @@ extern void fpregs_mark_activate(void);
  *
  * local_bh_disable() protects against both preemption and soft interrupts
  * on !RT kernels.
+ *
+ * On RT kernels local_bh_disable() is not sufficient because it only
+ * serializes soft interrupt related sections via a local lock, but stays
+ * preemptible. Disabling preemption is the right choice here as bottom
+ * half processing is always in thread context on RT kernels so it
+ * implicitly prevents bottom half processing as well.
  */
 static inline void fpregs_lock(void)
 {
-	local_bh_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_disable();
+	else
+		preempt_disable();
 }
 
 static inline void fpregs_unlock(void)
 {
-	local_bh_enable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_enable();
+	else
+		preempt_enable();
 }
 
 #ifdef CONFIG_X86_DEBUG_FPU

