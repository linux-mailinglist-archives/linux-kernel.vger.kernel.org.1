Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480E1300D7C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 21:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbhAVUNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 15:13:23 -0500
Received: from foss.arm.com ([217.140.110.172]:49772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbhAVOMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:12:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 701DD139F;
        Fri, 22 Jan 2021 06:11:37 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C33203F66E;
        Fri, 22 Jan 2021 06:11:35 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v7 1/4] arm64: mte: Add asynchronous mode support
Date:   Fri, 22 Jan 2021 14:11:22 +0000
Message-Id: <20210122141125.36166-2-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210122141125.36166-1-vincenzo.frascino@arm.com>
References: <20210122141125.36166-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MTE provides an asynchronous mode for detecting tag exceptions. In
particular instead of triggering a fault the arm64 core updates a
register which is checked by the kernel after the asynchronous tag
check fault has occurred.

Add support for MTE asynchronous mode.

The exception handling mechanism will be added with a future patch.

Note: KASAN HW activates async mode via kasan.mode kernel parameter.
The default mode is set to synchronous.
The code that verifies the status of TFSR_EL1 will be added with a
future patch.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/memory.h    |  3 ++-
 arch/arm64/include/asm/mte-kasan.h |  9 +++++++--
 arch/arm64/kernel/mte.c            | 16 ++++++++++++++--
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index cedfc9e97bcc..df96b9c10b81 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -231,7 +231,8 @@ static inline const void *__tag_set(const void *addr, u8 tag)
 }
 
 #ifdef CONFIG_KASAN_HW_TAGS
-#define arch_enable_tagging()			mte_enable_kernel()
+#define arch_enable_tagging_sync()		mte_enable_kernel_sync()
+#define arch_enable_tagging_async()		mte_enable_kernel_async()
 #define arch_set_tagging_report_once(state)	mte_set_report_once(state)
 #define arch_init_tags(max_tag)			mte_init_tags(max_tag)
 #define arch_get_random_tag()			mte_get_random_tag()
diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
index 3748d5bb88c0..8ad981069afb 100644
--- a/arch/arm64/include/asm/mte-kasan.h
+++ b/arch/arm64/include/asm/mte-kasan.h
@@ -29,7 +29,8 @@ u8 mte_get_mem_tag(void *addr);
 u8 mte_get_random_tag(void);
 void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
 
-void mte_enable_kernel(void);
+void mte_enable_kernel_sync(void);
+void mte_enable_kernel_async(void);
 void mte_init_tags(u64 max_tag);
 
 void mte_set_report_once(bool state);
@@ -55,7 +56,11 @@ static inline void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
 	return addr;
 }
 
-static inline void mte_enable_kernel(void)
+static inline void mte_enable_kernel_sync(void)
+{
+}
+
+static inline void mte_enable_kernel_async(void)
 {
 }
 
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index c63b3d7a3cd9..92078e1eb627 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -153,11 +153,23 @@ void mte_init_tags(u64 max_tag)
 	write_sysreg_s(SYS_GCR_EL1_RRND | gcr_kernel_excl, SYS_GCR_EL1);
 }
 
-void mte_enable_kernel(void)
+static inline void __mte_enable_kernel(const char *mode, unsigned long tcf)
 {
 	/* Enable MTE Sync Mode for EL1. */
-	sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
+	sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, tcf);
 	isb();
+
+	pr_info_once("MTE: enabled in %s mode at EL1\n", mode);
+}
+
+void mte_enable_kernel_sync(void)
+{
+	__mte_enable_kernel("synchronous", SCTLR_ELx_TCF_SYNC);
+}
+
+void mte_enable_kernel_async(void)
+{
+	__mte_enable_kernel("asynchronous", SCTLR_ELx_TCF_ASYNC);
 }
 
 void mte_set_report_once(bool state)
-- 
2.30.0

