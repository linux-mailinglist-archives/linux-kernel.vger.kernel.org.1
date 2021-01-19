Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8500D2FC13A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404455AbhASSvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:51:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729955AbhASS22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:28:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E561A23788;
        Tue, 19 Jan 2021 17:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611077966;
        bh=gDQBy/lhT7uxnjZdWfroOY5doLXucHBA4FYtiVjs8v8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JXiZiUWZRFU5L2MNGv1RMd2D2R6UvJ/IQA+hTwEPtplYc4v1TEfkCQrnFt7exblCe
         osJqtXKdGuE8pNgQaKYoyUnY70Jsjejv0jwFT+OJc5Fv7VVNIuIgTv6ii3klxa8bpu
         /zJo1Dt/9AgJuAdZybVrBg9uixgBaSmpPPVgiB0pgt5S6GUZn+9Y1U8GynZ/9CmchQ
         in0XX9Y5N1E+DOf1jsFEVQqaDgg6IzViHieGZB7vEWrrPWZqq4XyBuHJtjFLpUkWCy
         BH7vKjim96veXDd2o92PbL9tCiawJFWo0wQzIYE4CqT0ouZRmGA54PsOgpnZphRqtD
         Et4ImPug+GOaA==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        =?UTF-8?q?Krzysztof=20Ol=C4=99dzki?= <ole@ans.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 4/4] x86/fpu/64: Don't FNINIT in kernel_fpu_begin()
Date:   Tue, 19 Jan 2021 09:39:02 -0800
Message-Id: <803d45a172a25314fdaec0a01aada8333d55df4e.1611077835.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611077835.git.luto@kernel.org>
References: <cover.1611077835.git.luto@kernel.org>
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

