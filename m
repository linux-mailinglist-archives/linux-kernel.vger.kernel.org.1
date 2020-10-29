Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0699F29EE3D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgJ2O3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbgJ2O3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:29:30 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840FCC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:29:29 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id o18so3261663edq.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieYbNfrpvl3YjXeEpMZWQJdvJciBRCPSDnvRRC/ZPD8=;
        b=GxdOJq8o9OOj2/OgUSNG9jV7aaF6WZM2NcmoO+y+uU6A5lui7tDRGns1iDXBoz0xfi
         WpD/c9d+DqVWqcmuimY9Zxe18wCe4S513wOsmUafSCpS+wdSO3sAkW7EOl1hwnClLp/n
         5x5Ks3L2364yZp5Ez7S2ZvCKA/epB86spukVRkl7DchpxZ4SWCCusehd6cuQr4hKtD1X
         HpPzl3muJ/+TGbhZmxaMCJJZT/040UXbrmr6rGxU8aMTRy0GnAUEQFD/Nec82XtiBf/r
         Z6FYDeFs5W2rLsGhVtRcEPRCi0BrZQnHTYukAVPfSN81K5KcpbytkqOgTqvkagCbdYcG
         +A/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieYbNfrpvl3YjXeEpMZWQJdvJciBRCPSDnvRRC/ZPD8=;
        b=Wb3TDUgUMaZ1tqOZ6uJJvgEoLZcKIuqkwBNVX3cTDKo3ZQRAltwR63RQqKLqusZmas
         weRSI0SnMLrbohj2foakpSJ7T2W8c+42qxLUu36Qa8JMB6/gt7sxjHIxpCCpEXrvdNmY
         7CaXmZ53HLulEdVqfi2ISIo0Dg+qjozHH7/Ni2Ld1GC/8AV/lptVzg87pUAEm0zfHpNX
         qzZyqrqSARDJ3xwF5qMgrCoTdSpWiQBVUAUJGq+PRT3Oa34Q50BIM0L5+wQI2CHlMEs1
         QYl9H21RSayCqqNNpcFsWJu616infFoJlNn5S6kgBeK/RfbGUtfPIfKE7HaHu6DVgWx2
         YG4A==
X-Gm-Message-State: AOAM533o44J9U1QxMmQZjGnvOs1kmTzODX4+91Ano8RnrLDhU3gee89a
        9zal3S68A2ktEysC1U1yEW0=
X-Google-Smtp-Source: ABdhPJwa1aUp+YP8tYM9VSAL29UZA++LxnvKAmuDXzvYIa1HZLNNNEy2RjOM5aeUM1IlBpM9smONVA==
X-Received: by 2002:aa7:d28c:: with SMTP id w12mr4453550edq.282.1603981768304;
        Thu, 29 Oct 2020 07:29:28 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id rs18sm1581947ejb.69.2020.10.29.07.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 07:29:27 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/entry/64: Use TEST %reg,%reg instead of CMP $0,%reg
Date:   Thu, 29 Oct 2020 15:29:15 +0100
Message-Id: <20201029142915.131752-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use TEST %reg,%reg which sets the zero flag in the same way
as CMP $0,%reg, but the encoding uses one byte less.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
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

