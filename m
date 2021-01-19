Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80002FBF89
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbhASSzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:55:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:48614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389648AbhASS1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:27:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 181D3236FB;
        Tue, 19 Jan 2021 17:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611077956;
        bh=B0nbVoxGa+C36Jr6OtipmAgpoS6EnZrHQCygC20qrDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MsJg6AXHEtuAuqFIh5+SYsRWNP8NhdiGwyA9ltZA6EBRCg0yIAiFsLWNbu6tCUnVg
         9+Fzbu3l+VLV5eT0fbKciA1BAbypqP8YJTFkbPFDjsKpI1zsGHIdmfbhFanuudyZur
         /HoieVnZIFS06hDPDFTJSirgmjPosvu1lHJ25wYQjERmgII6rR64K8nJrOXndh9OmV
         pqPY8o6L3k7uL4mb5FA8G1CeLPnYdHdYoXGkJvOrkwUjFtbuN7+t2TCcVMlZrrZY/E
         dM8YhDPUW9EzPaLewj53NdieI6D92/2tpiEdTgLRJR8qyb51W8MxIdOYNQvoTXqflM
         4t7t9uLR5FZ/w==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        =?UTF-8?q?Krzysztof=20Ol=C4=99dzki?= <ole@ans.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 2/4] x86/mmx: Use KFPU_387 for MMX string operations
Date:   Tue, 19 Jan 2021 09:39:00 -0800
Message-Id: <cd68d61ece035201804a06e6993a2bd06bfe298b.1611077835.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611077835.git.luto@kernel.org>
References: <cover.1611077835.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default kernel_fpu_begin() doesn't work on systems that support XMM but
haven't yet enabled CR4.OSFXSR.  This causes crashes when _mmx_memcpy() is
called too early because LDMXCSR generates #UD when the aforementioned bit
is clear.

Fix it by using kernel_fpu_begin_mask(KFPU_387) explicitly.

Fixes: 7ad816762f9b ("x86/fpu: Reset MXCSR to default in kernel_fpu_begin()")
Reported-by: Krzysztof Mazur <krzysiek@podlesie.net>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/lib/mmx_32.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/lib/mmx_32.c b/arch/x86/lib/mmx_32.c
index 4321fa02e18d..2a6ad7aa148a 100644
--- a/arch/x86/lib/mmx_32.c
+++ b/arch/x86/lib/mmx_32.c
@@ -26,6 +26,16 @@
 #include <asm/fpu/api.h>
 #include <asm/asm.h>
 
+/*
+ * For MMX, we use KFPU_387.  MMX instructions are not affected by MXCSR,
+ * but both AMD and Intel documentation states that even integer MMX
+ * operations will result in #MF if an exception is pending in FCW.
+ *
+ * We don't need EMMS afterwards because, after we call kernel_fpu_end(),
+ * any subsequent user of the 387 stack will reinitialize it using
+ * KFPU_387.
+ */
+
 void *_mmx_memcpy(void *to, const void *from, size_t len)
 {
 	void *p;
@@ -37,7 +47,7 @@ void *_mmx_memcpy(void *to, const void *from, size_t len)
 	p = to;
 	i = len >> 6; /* len/64 */
 
-	kernel_fpu_begin();
+	kernel_fpu_begin_mask(KFPU_387);
 
 	__asm__ __volatile__ (
 		"1: prefetch (%0)\n"		/* This set is 28 bytes */
@@ -127,7 +137,7 @@ static void fast_clear_page(void *page)
 {
 	int i;
 
-	kernel_fpu_begin();
+	kernel_fpu_begin_mask(KFPU_387);
 
 	__asm__ __volatile__ (
 		"  pxor %%mm0, %%mm0\n" : :
@@ -160,7 +170,7 @@ static void fast_copy_page(void *to, void *from)
 {
 	int i;
 
-	kernel_fpu_begin();
+	kernel_fpu_begin_mask(KFPU_387);
 
 	/*
 	 * maybe the prefetch stuff can go before the expensive fnsave...
@@ -247,7 +257,7 @@ static void fast_clear_page(void *page)
 {
 	int i;
 
-	kernel_fpu_begin();
+	kernel_fpu_begin_mask(KFPU_387);
 
 	__asm__ __volatile__ (
 		"  pxor %%mm0, %%mm0\n" : :
@@ -282,7 +292,7 @@ static void fast_copy_page(void *to, void *from)
 {
 	int i;
 
-	kernel_fpu_begin();
+	kernel_fpu_begin_mask(KFPU_387);
 
 	__asm__ __volatile__ (
 		"1: prefetch (%0)\n"
-- 
2.29.2

