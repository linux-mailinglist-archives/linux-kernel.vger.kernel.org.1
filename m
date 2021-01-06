Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08702EBD61
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 12:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbhAFL51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 06:57:27 -0500
Received: from foss.arm.com ([217.140.110.172]:40002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbhAFL50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 06:57:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B099F106F;
        Wed,  6 Jan 2021 03:56:40 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 117583F70D;
        Wed,  6 Jan 2021 03:56:38 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 1/4] kasan, arm64: Add KASAN light mode
Date:   Wed,  6 Jan 2021 11:55:16 +0000
Message-Id: <20210106115519.32222-2-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106115519.32222-1-vincenzo.frascino@arm.com>
References: <20210106115519.32222-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architectures supported by KASAN HW can provide a light mode of
execution. On an MTE enabled arm64 hw for example this can be identified
with the asynch mode of execution. If an async exception occurs, the
arm64 core updates a register which is asynchronously detected the next
time in which the kernel is accessed.

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
 arch/arm64/include/asm/mte-kasan.h |  5 ++--
 arch/arm64/kernel/mte.c            |  2 +-
 include/linux/kasan.h              |  1 +
 include/linux/kasan_def.h          | 39 ++++++++++++++++++++++++++++++
 mm/kasan/hw_tags.c                 | 24 +++---------------
 mm/kasan/kasan.h                   |  2 +-
 7 files changed, 50 insertions(+), 25 deletions(-)
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
index 26349a4b5e2e..79e612c31186 100644
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
+void mte_enable_kernel(enum kasan_arg_mode mode);
 void mte_init_tags(u64 max_tag);
 
 #else /* CONFIG_ARM64_MTE */
@@ -52,7 +53,7 @@ static inline void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
 	return addr;
 }
 
-static inline void mte_enable_kernel(void)
+static inline void mte_enable_kernel(enum kasan_arg_mode mode)
 {
 }
 
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index dc9ada64feed..24a273d47df1 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -151,7 +151,7 @@ void mte_init_tags(u64 max_tag)
 	write_sysreg_s(SYS_GCR_EL1_RRND | gcr_kernel_excl, SYS_GCR_EL1);
 }
 
-void mte_enable_kernel(void)
+void mte_enable_kernel(enum kasan_arg_mode mode)
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
index 000000000000..5e2b3ea5472b
--- /dev/null
+++ b/include/linux/kasan_def.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KASAN_DEF_H
+#define _LINUX_KASAN_DEF_H
+
+#ifdef CONFIG_KASAN
+enum kasan_arg_mode {
+	KASAN_ARG_MODE_DEFAULT,
+	KASAN_ARG_MODE_OFF,
+	KASAN_ARG_MODE_LIGHT,
+	KASAN_ARG_MODE_PROD,
+	KASAN_ARG_MODE_FULL,
+};
+
+enum kasan_arg_stacktrace {
+	KASAN_ARG_STACKTRACE_DEFAULT,
+	KASAN_ARG_STACKTRACE_OFF,
+	KASAN_ARG_STACKTRACE_ON,
+};
+
+enum kasan_arg_fault {
+	KASAN_ARG_FAULT_DEFAULT,
+	KASAN_ARG_FAULT_REPORT,
+	KASAN_ARG_FAULT_PANIC,
+};
+#else
+enum kasan_arg_mode {
+	KASAN_ARG_MODE_DEFAULT,
+};
+
+enum kasan_arg_stacktrace {
+	KASAN_ARG_STACKTRACE_DEFAULT,
+};
+
+enum kasan_arg_fault {
+	KASAN_ARG_FAULT_DEFAULT,
+};
+#endif
+
+#endif /* _LINUX_KASAN_DEF_H */
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 55bd6f09c70f..d5c6ad8b2c44 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -19,25 +19,6 @@
 
 #include "kasan.h"
 
-enum kasan_arg_mode {
-	KASAN_ARG_MODE_DEFAULT,
-	KASAN_ARG_MODE_OFF,
-	KASAN_ARG_MODE_PROD,
-	KASAN_ARG_MODE_FULL,
-};
-
-enum kasan_arg_stacktrace {
-	KASAN_ARG_STACKTRACE_DEFAULT,
-	KASAN_ARG_STACKTRACE_OFF,
-	KASAN_ARG_STACKTRACE_ON,
-};
-
-enum kasan_arg_fault {
-	KASAN_ARG_FAULT_DEFAULT,
-	KASAN_ARG_FAULT_REPORT,
-	KASAN_ARG_FAULT_PANIC,
-};
-
 static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
 static enum kasan_arg_stacktrace kasan_arg_stacktrace __ro_after_init;
 static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
@@ -60,6 +41,8 @@ static int __init early_kasan_mode(char *arg)
 
 	if (!strcmp(arg, "off"))
 		kasan_arg_mode = KASAN_ARG_MODE_OFF;
+	else if (!strcmp(arg, "light"))
+		kasan_arg_mode = KASAN_ARG_MODE_LIGHT;
 	else if (!strcmp(arg, "prod"))
 		kasan_arg_mode = KASAN_ARG_MODE_PROD;
 	else if (!strcmp(arg, "full"))
@@ -118,7 +101,7 @@ void kasan_init_hw_tags_cpu(void)
 		return;
 
 	hw_init_tags(KASAN_TAG_MAX);
-	hw_enable_tagging();
+	hw_enable_tagging(kasan_arg_mode);
 }
 
 /* kasan_init_hw_tags() is called once on boot CPU. */
@@ -145,6 +128,7 @@ void __init kasan_init_hw_tags(void)
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
2.29.2

