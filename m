Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE9C2F99D2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 07:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbhARGVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 01:21:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:54412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730524AbhARGV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 01:21:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84E7A22573;
        Mon, 18 Jan 2021 06:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610950845;
        bh=p0uFxpodUSlLSKHUVPiVgDuBk05sV4ZX/hEEbjugEMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rADhV9trsX96AXuulR4Ys8Tubj1bTlG1UahlL6S6f4OndiH+dl7Q2i3zoQ8ZKD1PU
         PvelvTkMPVb3alPgLlSW/adHyTA7HeJ6r+i7sx2omvZt96OiCZNG3RrkdsO1oTnXxT
         cHTTMSj6RSeFINLEAVQ5HYjVYKA3a0J36coNOG/23j/K1coFLzDMbDlXUi5qCmnP0J
         WUAJYOJYTeIxhz1HfHncgP9+3sKbR8KWO2dLbDS3XemR/HgkKDvTwxrIvTlLD2COnR
         2i0kg1T0L1LqrTfYjj2OFbb0mTQAKwdtwbUROmMa34vz9mMmcQPbVqVkPtez2Fl6e6
         /ZjHIPYJhL2uw==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        =?UTF-8?q?Krzysztof=20Ol=C4=99dzki?= <ole@ans.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 3/4] x86/fpu: Make the EFI FPU calling convention explicit
Date:   Sun, 17 Jan 2021 22:20:40 -0800
Message-Id: <49aeb632f155569c75ea3cd78e9028cf7ba776fe.1610950681.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610950681.git.luto@kernel.org>
References: <cover.1610950681.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EFI uses kernel_fpu_begin() to conform to the UEFI calling convention.
This specifically requires initializing FCW, whereas no sane 64-bit kernel
code should use legacy 387 operations that reference FCW.

Add KFPU_EFI to make this self-documenting, and use it in the EFI code.
This should enable us to safely change the default semantics of
kernel_fpu_begin() to stop initializing FCW on 64-bit kernels.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/efi.h     | 4 ++--
 arch/x86/include/asm/fpu/api.h | 7 +++++++
 arch/x86/platform/efi/efi_64.c | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index bc9758ef292e..c60be69a5c82 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -71,7 +71,7 @@ extern unsigned long efi_fw_vendor, efi_config_table;
 #ifdef CONFIG_X86_32
 #define arch_efi_call_virt_setup()					\
 ({									\
-	kernel_fpu_begin();						\
+	kernel_fpu_begin_mask(KFPU_EFI);				\
 	firmware_restrict_branch_speculation_start();			\
 })
 
@@ -107,7 +107,7 @@ struct efi_scratch {
 #define arch_efi_call_virt_setup()					\
 ({									\
 	efi_sync_low_kernel_mappings();					\
-	kernel_fpu_begin();						\
+	kernel_fpu_begin_mask(KFPU_EFI);				\
 	firmware_restrict_branch_speculation_start();			\
 	efi_switch_mm(&efi_mm);						\
 })
diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 133907a200ef..e95a06845443 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -25,6 +25,13 @@
 #define KFPU_XYZMM	_BITUL(1)	/* MXCSR will be initialized */
 #define KFPU_MMX	0		/* nothing gets initialized */
 
+/*
+ * The UEFI calling convention (UEFI spec 2.3.2 and 2.3.4) requires
+ * that FCW (32-bit and 64-bit) and MXCSR (64-bit) must be initialized
+ * prior to calling UEFI code.
+ */
+#define KFPU_EFI	(KFPU_387 | KFPU_XYZMM)
+
 extern void kernel_fpu_begin_mask(unsigned int kfpu_mask);
 extern void kernel_fpu_end(void);
 extern bool irq_fpu_usable(void);
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 8f5759df7776..c304c8da862b 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -848,7 +848,7 @@ efi_set_virtual_address_map(unsigned long memory_map_size,
 							 virtual_map);
 	efi_switch_mm(&efi_mm);
 
-	kernel_fpu_begin();
+	kernel_fpu_begin_mask(KFPU_EFI);
 
 	/* Disable interrupts around EFI calls: */
 	local_irq_save(flags);
-- 
2.29.2

