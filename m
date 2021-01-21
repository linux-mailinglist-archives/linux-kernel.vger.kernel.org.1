Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07CE2FE175
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 06:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbhAUFTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:19:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:46930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbhAUFKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 00:10:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 898782396F;
        Thu, 21 Jan 2021 05:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611205796;
        bh=gDQBy/lhT7uxnjZdWfroOY5doLXucHBA4FYtiVjs8v8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMysyBFlBjAiDq2743w3VfPcn9UcZtffoaVtARxKpv0V9BsQwTtfTVbdCCLCkEwCk
         Ykqlud3nwGw7+4PUTp4Ivp46iDqAMOAfiQTBX827v+tNmWcFki0/SUxQ1okXG+S2oS
         tTtTRkNVdhaGjUElEZkq0Bd4WG6di6VU7sBMgaCuXIOto1pPtKS11c1lqR5vtXZlvP
         ibazhm/bFYBbDrER0rnw6do+hcZ66kuy3AN/UFd7a2RAbc/okKHoRdp/zAFuf0jM+e
         mPvFQ7K+jt/MD3XPlYo4JHJalK5W34zGAN19A8kZwMxqgaU3SqGOsaLecJW/v+gQUh
         Nl4vdGv+PYXDQ==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        =?UTF-8?q?Krzysztof=20Ol=C4=99dzki?= <ole@ans.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 4/4] x86/fpu/64: Don't FNINIT in kernel_fpu_begin()
Date:   Wed, 20 Jan 2021 21:09:51 -0800
Message-Id: <57f8841ccbf9f3c25a23196c888f5f6ec5887577.1611205691.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611205691.git.luto@kernel.org>
References: <cover.1611205691.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remaining callers of kernel_fpu_begin() in 64-bit kernels don't use 387
instructions, so there's no need to sanitize the FPU state.  Skip it to get
most of the performance we lost back.

Reported-by: Krzysztof Olędzki <ole@ans.pl>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/fpu/api.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 38f4936045ab..435bc59d539b 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -32,7 +32,19 @@ extern void fpregs_mark_activate(void);
 /* Code that is unaware of kernel_fpu_begin_mask() can use this */
 static inline void kernel_fpu_begin(void)
 {
+#ifdef CONFIG_X86_64
+	/*
+	 * Any 64-bit code that uses 387 instructions must explicitly request
+	 * KFPU_387.
+	 */
+	kernel_fpu_begin_mask(KFPU_MXCSR);
+#else
+	/*
+	 * 32-bit kernel code may use 387 operations as well as SSE2, etc,
+	 * as long as it checks that the CPU has the required capability.
+	 */
 	kernel_fpu_begin_mask(KFPU_387 | KFPU_MXCSR);
+#endif
 }
 
 /*
-- 
2.29.2

