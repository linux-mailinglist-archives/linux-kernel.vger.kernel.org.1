Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F6D2F782A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbhAOMBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:01:44 -0500
Received: from foss.arm.com ([217.140.110.172]:36748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbhAOMBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:01:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5777411B3;
        Fri, 15 Jan 2021 04:00:55 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACBD73F70D;
        Fri, 15 Jan 2021 04:00:53 -0800 (PST)
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
Subject: [PATCH v3 1/4] kasan, arm64: Add KASAN light mode
Date:   Fri, 15 Jan 2021 12:00:40 +0000
Message-Id: <20210115120043.50023-2-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115120043.50023-1-vincenzo.frascino@arm.com>
References: <20210115120043.50023-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architectures supported by KASAN HW can provide a light mode of
execution. On an MTE enabled arm64 hw for example this can be identified
with the asynch mode of execution.
In this mode, if a tag check fault occurs, the TFSR_EL1 register is
updated asynchronously. The kernel checks the corresponding bits
periodically.

KASAN requires a specific mode of execution to make use of this hw feature.

Add KASAN HW light execution mode.

Note: This patch adds the KASAN_ARG_MODE_LIGHT config option and the
"light" kernel command line option to enable the described feature.
This patch introduces the kasan_def.h header to make easier to propagate
the relevant enumerations to the architectural code.

Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/memory.h    |  2 +-
 arch/arm64/include/asm/mte-kasan.h |  5 +++--
 arch/arm64/kernel/mte.c            |  2 +-
 include/linux/kasan.h              |  1 +
 include/linux/kasan_def.h          | 10 ++++++++++
 mm/kasan/hw_tags.c                 | 19 ++++++++++++++++++-
 mm/kasan/kasan.h                   |  2 +-
 7 files changed, 35 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/kasan_def.h

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 18fce223b67b..3a7c5beb7096 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -231,7 +231,7 @@ static inline const void *__tag_set(const void *addr, u8 tag)
 }
 
 #ifdef CONFIG_KASAN_HW_TAGS
-#define arch_enable_tagging()			mte_enable_kernel()
+#define arch_enable_tagging(mode)		mte_enable_kernel(mode)
 #define arch_init_tags(max_tag)			mte_init_tags(max_tag)
 #define arch_get_random_tag()			mte_get_random_tag()
 #define arch_get_mem_tag(addr)			mte_get_mem_tag(addr)
diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
index 26349a4b5e2e..5402f4c8e88d 100644
--- a/arch/arm64/include/asm/mte-kasan.h
+++ b/arch/arm64/include/asm/mte-kasan.h
@@ -9,6 +9,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/kasan_def.h>
 #include <linux/types.h>
 
 /*
@@ -29,7 +30,7 @@ u8 mte_get_mem_tag(void *addr);
 u8 mte_get_random_tag(void);
 void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
 
-void mte_enable_kernel(void);
+void mte_enable_kernel(enum kasan_hw_tags_mode mode);
 void mte_init_tags(u64 max_tag);
 
 #else /* CONFIG_ARM64_MTE */
@@ -52,7 +53,7 @@ static inline void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
 	return addr;
 }
 
-static inline void mte_enable_kernel(void)
+static inline void mte_enable_kernel(enum kasan_hw_tags_mode mode)
 {
 }
 
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index dc9ada64feed..53a6d734e29b 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -151,7 +151,7 @@ void mte_init_tags(u64 max_tag)
 	write_sysreg_s(SYS_GCR_EL1_RRND | gcr_kernel_excl, SYS_GCR_EL1);
 }
 
-void mte_enable_kernel(void)
+void mte_enable_kernel(enum kasan_hw_tags_mode mode)
 {
 	/* Enable MTE Sync Mode for EL1. */
 	sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 5e0655fb2a6f..026031444217 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_KASAN_H
 #define _LINUX_KASAN_H
 
+#include <linux/kasan_def.h>
 #include <linux/static_key.h>
 #include <linux/types.h>
 
diff --git a/include/linux/kasan_def.h b/include/linux/kasan_def.h
new file mode 100644
index 000000000000..0a55400809c9
--- /dev/null
+++ b/include/linux/kasan_def.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KASAN_DEF_H
+#define _LINUX_KASAN_DEF_H
+
+enum kasan_hw_tags_mode {
+	KASAN_HW_TAGS_SYNC,
+	KASAN_HW_TAGS_ASYNC,
+};
+
+#endif /* _LINUX_KASAN_DEF_H */
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 55bd6f09c70f..6c3b0742f639 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -22,6 +22,7 @@
 enum kasan_arg_mode {
 	KASAN_ARG_MODE_DEFAULT,
 	KASAN_ARG_MODE_OFF,
+	KASAN_ARG_MODE_LIGHT,
 	KASAN_ARG_MODE_PROD,
 	KASAN_ARG_MODE_FULL,
 };
@@ -60,6 +61,8 @@ static int __init early_kasan_mode(char *arg)
 
 	if (!strcmp(arg, "off"))
 		kasan_arg_mode = KASAN_ARG_MODE_OFF;
+	else if (!strcmp(arg, "light"))
+		kasan_arg_mode = KASAN_ARG_MODE_LIGHT;
 	else if (!strcmp(arg, "prod"))
 		kasan_arg_mode = KASAN_ARG_MODE_PROD;
 	else if (!strcmp(arg, "full"))
@@ -105,9 +108,21 @@ static int __init early_kasan_fault(char *arg)
 }
 early_param("kasan.fault", early_kasan_fault);
 
+static inline int hw_init_mode(enum kasan_arg_mode mode)
+{
+	switch (mode) {
+	case KASAN_ARG_MODE_LIGHT:
+		return KASAN_HW_TAGS_ASYNC;
+	default:
+		return KASAN_HW_TAGS_SYNC;
+	}
+}
+
 /* kasan_init_hw_tags_cpu() is called for each CPU. */
 void kasan_init_hw_tags_cpu(void)
 {
+	enum kasan_hw_tags_mode hw_mode;
+
 	/*
 	 * There's no need to check that the hardware is MTE-capable here,
 	 * as this function is only called for MTE-capable hardware.
@@ -118,7 +133,8 @@ void kasan_init_hw_tags_cpu(void)
 		return;
 
 	hw_init_tags(KASAN_TAG_MAX);
-	hw_enable_tagging();
+	hw_mode = hw_init_mode(kasan_arg_mode);
+	hw_enable_tagging(hw_mode);
 }
 
 /* kasan_init_hw_tags() is called once on boot CPU. */
@@ -145,6 +161,7 @@ void __init kasan_init_hw_tags(void)
 	case KASAN_ARG_MODE_OFF:
 		/* If KASAN is disabled, do nothing. */
 		return;
+	case KASAN_ARG_MODE_LIGHT:
 	case KASAN_ARG_MODE_PROD:
 		static_branch_enable(&kasan_flag_enabled);
 		break;
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index cc4d9e1d49b1..78c09279327e 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -284,7 +284,7 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 #define arch_set_mem_tag_range(addr, size, tag) ((void *)(addr))
 #endif
 
-#define hw_enable_tagging()			arch_enable_tagging()
+#define hw_enable_tagging(mode)			arch_enable_tagging(mode)
 #define hw_init_tags(max_tag)			arch_init_tags(max_tag)
 #define hw_get_random_tag()			arch_get_random_tag()
 #define hw_get_mem_tag(addr)			arch_get_mem_tag(addr)
-- 
2.30.0

