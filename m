Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E742FBF8A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389736AbhASSz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:55:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:48622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387434AbhASS1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:27:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2349123731;
        Tue, 19 Jan 2021 17:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611077961;
        bh=Q7Wt0+lVfhHlWCEGnSufVJdo/kJ3Toujd33xSqH47fI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JAaQ3NtJflXhlixAMzk8fxDVZ2o1ICcpIYRZKUlPjH9KY8mhcSbgCVTc8idFG0vVV
         v6VKequGBAagyhm6RIjR2edmEvxKrV127aFdYta0Plk+v7ciAueYWiMN7y0y5XwF1b
         MtxwJyhJNtP9+sfykaBxyWEOiWOoz0JtzHY4zBf4sQCT3PIjhMLfKzex2PucbxrvtP
         nQ4GcxiIk0qWZSQhSQrfvfPC0m0giDPt0ZGjNuSN34exgtZAY9DNsKzHVmYxVFzR5w
         I1uGQC9VPt6/1n0breSBEyE/Xo+zrPuIoBhF3btiiw03PeBrSB/rECe84R1d5bYsss
         NhbTTCodOAw0g==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        =?UTF-8?q?Krzysztof=20Ol=C4=99dzki?= <ole@ans.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 3/4] x86/fpu: Make the EFI FPU calling convention explicit
Date:   Tue, 19 Jan 2021 09:39:01 -0800
Message-Id: <a2515090d8aa97f21d5dccf40402df8c8eb5a81d.1611077835.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611077835.git.luto@kernel.org>
References: <cover.1611077835.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EFI uses kernel_fpu_begin() to conform to the UEFI calling convention.
This specifically requires initializing FCW, whereas no sane 64-bit kernel
code should use legacy 387 operations that reference FCW.

This should enable us to safely change the default semantics of
kernel_fpu_begin() to stop initializing FCW on 64-bit kernels.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/efi.h     | 24 ++++++++++++++++++++----
 arch/x86/platform/efi/efi_64.c |  4 ++--
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index bc9758ef292e..f3201544fbf8 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -68,17 +68,33 @@ extern unsigned long efi_fw_vendor, efi_config_table;
 		#f " called with too many arguments (" #p ">" #n ")");	\
 })
 
+static inline void efi_fpu_begin(void)
+{
+	/*
+	 * The UEFI calling convention (UEFI spec 2.3.2 and 2.3.4) requires
+	 * that FCW and MXCSR (64-bit) must be initialized prior to calling
+	 * UEFI code.  (Oddly the spec does not require that the FPU stack
+	 * be empty.)
+	 */
+	kernel_fpu_begin_mask(KFPU_387 | KFPU_MXCSR);
+}
+
+static inline void efi_fpu_end(void)
+{
+	kernel_fpu_end();
+}
+
 #ifdef CONFIG_X86_32
 #define arch_efi_call_virt_setup()					\
 ({									\
-	kernel_fpu_begin();						\
+	efi_fpu_begin();						\
 	firmware_restrict_branch_speculation_start();			\
 })
 
 #define arch_efi_call_virt_teardown()					\
 ({									\
 	firmware_restrict_branch_speculation_end();			\
-	kernel_fpu_end();						\
+	efi_fpu_end();							\
 })
 
 #define arch_efi_call_virt(p, f, args...)	p->f(args)
@@ -107,7 +123,7 @@ struct efi_scratch {
 #define arch_efi_call_virt_setup()					\
 ({									\
 	efi_sync_low_kernel_mappings();					\
-	kernel_fpu_begin();						\
+	efi_fpu_begin();						\
 	firmware_restrict_branch_speculation_start();			\
 	efi_switch_mm(&efi_mm);						\
 })
@@ -119,7 +135,7 @@ struct efi_scratch {
 ({									\
 	efi_switch_mm(efi_scratch.prev_mm);				\
 	firmware_restrict_branch_speculation_end();			\
-	kernel_fpu_end();						\
+	efi_fpu_end();							\
 })
 
 #ifdef CONFIG_KASAN
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 8f5759df7776..f042040b5da1 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -848,7 +848,7 @@ efi_set_virtual_address_map(unsigned long memory_map_size,
 							 virtual_map);
 	efi_switch_mm(&efi_mm);
 
-	kernel_fpu_begin();
+	efi_fpu_begin();
 
 	/* Disable interrupts around EFI calls: */
 	local_irq_save(flags);
@@ -857,7 +857,7 @@ efi_set_virtual_address_map(unsigned long memory_map_size,
 			  descriptor_version, virtual_map);
 	local_irq_restore(flags);
 
-	kernel_fpu_end();
+	efi_fpu_end();
 
 	/* grab the virtually remapped EFI runtime services table pointer */
 	efi.runtime = READ_ONCE(systab->runtime);
-- 
2.29.2

