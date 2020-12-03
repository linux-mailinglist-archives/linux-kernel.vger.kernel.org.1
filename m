Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EEE2CD828
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 14:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbgLCNrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 08:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbgLCNrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 08:47:14 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E61C061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 05:46:28 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id p6so1171001plo.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 05:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JErqEL3Kt1t6tToJTJ1Pn1JRLO1Zs+7MWme3Tdimg78=;
        b=JV4eYdQZRw+Yb66bxR42sldm6rw8NSQ5vr8syNUCLabgEhVApzhlrdEQHuPqlbOarz
         Xs+1JnO9txbHKxVo1iD5TPafZopHiXmr+B7g+nhMR22InPBXlLAAhzI/Tx8S+3StXPTV
         o20yA9bycfAh/7ZRj+GAHD+1sCjfhJN+YiLE6YqpfBXow9zs7ibu3+0a703JteGCCrM/
         CdufyuuY9ZDxTSNCFe6uS/Fd1OlSgKXQgHZbex6C9X6VvJL+GpwZtUEmLjcwCYYYepd1
         IR6nluVAOATHmpGZSBFm+r8OEDjVxmc20N/DCMnm5XCfbXvx0n/0JPvR96mjypPHihJx
         cFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JErqEL3Kt1t6tToJTJ1Pn1JRLO1Zs+7MWme3Tdimg78=;
        b=Gjm69J/OzPkjrm8b/USJ7Y6VbWIo/GiMmt9MMY944OvzEI49nF/65BDDqSsk9YHUSa
         t7DEU4W5XnD6C+ZIHtALlj6X8G8S6VBkVV4ze29m69O6qflSp5ssVUWI3m7V5td/kTzv
         oYmqsjjO10/PMqilOU+8oN7yi57llRI3x6Rv4eH8uRqhIBVqEmYtR7hqg9+wXK3XdbUk
         fISc1CDvZcZmbepeVa/kXh0S0Fs5PWZ6zgr6Q/+R2GVLKKx0QFiOLQ+pyQjBKHC4MmiY
         /QzxaVYcyZJtgHJKFUuaMiKtOIuE+gaXoigVIXyMAyCyybgy6cDRz9i05px4vZFCAJ/m
         +MuA==
X-Gm-Message-State: AOAM533mYM7UPgNIylv9AfwPMErds5dI1Lyk0vnMXtRZaji87WSBKQVb
        HyqFRip0wADaQ6cBkhyQN6g=
X-Google-Smtp-Source: ABdhPJy+agSTa9bz623sYXmRq0iNnq9vLOqIQt627/WjWTu+kjBKo9iXanNcWMsfaeqkDShz8NVmlg==
X-Received: by 2002:a17:90a:bb83:: with SMTP id v3mr3115372pjr.28.1607003188368;
        Thu, 03 Dec 2020 05:46:28 -0800 (PST)
Received: from localhost.localdomain.localdomain ([115.238.43.130])
        by smtp.gmail.com with ESMTPSA id a23sm1562831pju.31.2020.12.03.05.46.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2020 05:46:27 -0800 (PST)
From:   Mingzhe Yang <cainiao666999@gmail.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        nivedita@alum.mit.edu, ardb@kernel.org, keescook@chromium.org,
        jroedel@suse.de, linux-kernel@vger.kernel.org,
        Mingzhe Yang <cainiao666999@gmail.com>
Subject: [PATCH] x86_64: coding style and whitespace fixup
Date:   Thu,  3 Dec 2020 21:46:02 +0800
Message-Id: <1607003162-18444-1-git-send-email-cainiao666999@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some whitespace issues.

Signed-off-by: Mingzhe Yang <cainiao666999@gmail.com>
---
 arch/x86/boot/compressed/head_64.S | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 017de6c..57b3cf4 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -151,7 +151,7 @@ SYM_FUNC_START(startup_32)
 
 	/* Target address to relocate to for decompression */
 	addl	BP_init_size(%esi), %ebx
-	subl	$ rva(_end), %ebx
+	subl	$rva(_end), %ebx
 
 /*
  * Prepare for entering 64 bit mode
@@ -186,7 +186,7 @@ SYM_FUNC_START(startup_32)
 
 	/* Build Level 4 */
 	leal	rva(pgtable + 0)(%ebx), %edi
-	leal	0x1007 (%edi), %eax
+	leal	0x1007(%edi), %eax
 	movl	%eax, 0(%edi)
 	addl	%edx, 4(%edi)
 
@@ -282,7 +282,7 @@ SYM_FUNC_START(efi32_stub_entry)
 
 	call	1f
 1:	pop	%ebp
-	subl	$ rva(1b), %ebp
+	subl	$rva(1b), %ebp
 
 	movl	%esi, rva(efi32_boot_args+8)(%ebp)
 SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
@@ -372,7 +372,7 @@ SYM_CODE_START(startup_64)
 
 	/* Target address to relocate to for decompression */
 	movl	BP_init_size(%rsi), %ebx
-	subl	$ rva(_end), %ebx
+	subl	$rva(_end), %ebx
 	addq	%rbp, %rbx
 
 	/* Set up the stack */
@@ -512,7 +512,7 @@ SYM_FUNC_START_ALIAS(efi_stub_entry)
 	and	$~0xf, %rsp			/* realign the stack */
 	movq	%rdx, %rbx			/* save boot_params pointer */
 	call	efi_main
-	movq	%rbx,%rsi
+	movq	%rbx, %rsi
 	leaq	rva(startup_64)(%rax), %rax
 	jmp	*%rax
 SYM_FUNC_END(efi64_stub_entry)
@@ -727,7 +727,7 @@ SYM_FUNC_START(efi32_pe_entry)
 
 	call	1f
 1:	pop	%ebx
-	subl	$ rva(1b), %ebx
+	subl	$rva(1b), %ebx
 
 	/* Get the loaded image protocol pointer from the image handle */
 	leal	-4(%ebp), %eax
-- 
1.8.3.1

