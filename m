Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B3329F0B7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgJ2QDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgJ2QDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:03:10 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8136EC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:03:10 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dk16so3945365ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6RiNh+xw13flIoAZUkUs9G9pCczPNgzc7lY84mk0ux0=;
        b=Nu56KtDH4+1HlcGjFwHUuR07KJIAKqLUHqkTxd5yk4HjoFH488cSBS/eH58jKTyTA/
         B1JJ8KpYQGBxCZioyqJPfSMOUgoll0Ledyjvg5RLnVUTWjpl4iw2DWFygbLxh0HwKgoF
         8vn4ofsdj+E11CgtqBVnXtOgoUZqtp/sJUkUaYDzKVpBCNShiW7LvdW6aApmV53C5mWr
         rsG7fe4DisK16yutZHfZ8jQ5rY4MaoYKjAr3hkS5wcC+6ka5DNtSfNllx0N/vEfwcRCo
         jpCvW6hsO9tXz7iNUbeuzPP0dQwBw26Ot2/xQJoGnGdVoDVLP3GoOkSIIgpsmpFEl4Ie
         wDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6RiNh+xw13flIoAZUkUs9G9pCczPNgzc7lY84mk0ux0=;
        b=CGZ/ATf1qscGkzYuGOrlLm9DoBbKoL/knVkpfmfo8zrFaqkM3zFbShXw5RXPr1im/s
         5oqEg8OKZQIbyav715SSB6vBN9KrNTKverR7blA+oIQ3S/ku88Q9EtY1TKARD3ylqPhk
         sCv2d1W9JtTvOJQO0ghVWv4I0QP6nNH0YFhRMC9lz52C/JrH8c8c6BXQbzYbswnZx4OD
         b1TkvDMeuqyhsOFJ+i7p0bzeNJOQ8hDsPERhvQDiG/fjVcOpdqUexFNOiohU4I80IyQ1
         GmnoTanuVK2OL37mu2fDpT3YzwAO3c8VQs3mGNylYWEJOR72rgV8DjYryDsd9/SXVLzn
         SQ6Q==
X-Gm-Message-State: AOAM530c/dTZDRj0Dw11qXGlbA/tlb3DlHBo2CR2ZeyNoRuHai3cNNGm
        /RxxmVDhimji3ET4Ui8ZnH4=
X-Google-Smtp-Source: ABdhPJxcx+ReKF0R8V1ADz0Bq2lMca4nI7+iyozc3l4MgHbkkY4LmrOGJnfEjmOWkGN6kz2J5s3xOw==
X-Received: by 2002:a17:906:4742:: with SMTP id j2mr4615458ejs.247.1603987389231;
        Thu, 29 Oct 2020 09:03:09 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id y1sm1776525edj.76.2020.10.29.09.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:03:08 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2] x86/boot/64: Use TEST %reg,%reg instead of CMP $0,%reg
Date:   Thu, 29 Oct 2020 17:02:58 +0100
Message-Id: <20201029160258.139216-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use TEST %reg,%reg which sets the zero flag in the same way
as CMP $0,%reg, but the encoding uses one byte less.

v2: Correct commit subject

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/boot/compressed/head_64.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 017de6cc87dc..e94874f4bbc1 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -241,12 +241,12 @@ SYM_FUNC_START(startup_32)
 	leal	rva(startup_64)(%ebp), %eax
 #ifdef CONFIG_EFI_MIXED
 	movl	rva(efi32_boot_args)(%ebp), %edi
-	cmp	$0, %edi
+	testl	%edi, %edi
 	jz	1f
 	leal	rva(efi64_stub_entry)(%ebp), %eax
 	movl	rva(efi32_boot_args+4)(%ebp), %esi
 	movl	rva(efi32_boot_args+8)(%ebp), %edx	// saved bootparams pointer
-	cmpl	$0, %edx
+	testl	%edx, %edx
 	jnz	1f
 	/*
 	 * efi_pe_entry uses MS calling convention, which requires 32 bytes of
@@ -592,7 +592,7 @@ SYM_CODE_START(trampoline_32bit_src)
 	movl	%eax, %cr0
 
 	/* Check what paging mode we want to be in after the trampoline */
-	cmpl	$0, %edx
+	testl	%edx, %edx
 	jz	1f
 
 	/* We want 5-level paging: don't touch CR3 if it already points to 5-level page tables */
@@ -622,7 +622,7 @@ SYM_CODE_START(trampoline_32bit_src)
 
 	/* Enable PAE and LA57 (if required) paging modes */
 	movl	$X86_CR4_PAE, %eax
-	cmpl	$0, %edx
+	testl	%edx, %edx
 	jz	1f
 	orl	$X86_CR4_LA57, %eax
 1:
-- 
2.26.2

