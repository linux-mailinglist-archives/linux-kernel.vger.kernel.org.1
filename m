Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339EA2B285D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgKMWTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgKMWRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:17:18 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCC1C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:16 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id u9so4004343wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=qSHoF8V+EFQagRk1pc/+G+fEj1DpiqE8G3KQ67JvFaY=;
        b=i6B5Haa+YawplhdxuFmKFa+r+hnc+L5C8ghYzATL/qizfxpyAbtG9Nv0UIdgf4H9Ia
         Acsyomj8SbIThkGpX01CBZcV2cFlwpKsxCPgqF5pfYb2sfl2WShXDf4Pl79lb2T6VB3b
         H9Oq9Z5N2TAv3DibQtH0DDa4VW5Mz6Ayp18szx28hfAEko6gac9ZCog11kxcGzh9hwJi
         3EI4TFeiVtbeSnZWV5KCuOumIaVilOQH+1AapfylaChLreGXC3Un3C9RvN7UGTqLNKhd
         IKSo6keqpI40Ztg2NfjdnJp+l0h64naJlFC0qwW0BFP4H7QeYfLAvBgZMBVxUHoM8nLm
         CvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qSHoF8V+EFQagRk1pc/+G+fEj1DpiqE8G3KQ67JvFaY=;
        b=dcZNQ+UJUBrMPrCe6qJHZnXCFOBku0xKfGc11naM04l0CY8iC25KT55AfDnV+aBSz+
         db5fUgOeKa9RjdykC6e3K/b90c1p+r0XbYI6d7mGHPuociea8d2T2edsrjpslrVhCpm1
         SKOTAv9iAlVysOGw/5cZ/2sKOi4WgwAsAUoi1k8ardxezpHvF4J2DvOICb73xw+pmUiz
         +eBlhAp1C2V+WmPe3Q5mDlzvbVRV4Nv98eyWqaEzPM91Dj6Kl8PdKhfNMBLWSW/l+yBI
         uEawZUxCcOjfKsSN4UKiFQr72XOh2Vg00/6A2yQ2e+Jj7cQ5Ao125hq9v7ARYySbP8mv
         +bTQ==
X-Gm-Message-State: AOAM530bmCv/SJOqGaK2SGDIIwdGh0MW+17PRCAOkx7LSE864JcrWUG2
        3vjA2lXazHJig5Z/if0UnI7A/EO2GDQ0r73m
X-Google-Smtp-Source: ABdhPJx/ETsSm1IXM6jCFI8Y4V3ATfHlh10wX6Qpvxl3hkDPugN4LuQ5r86F4AmjLK9FKoBEtsiQIuc64d5iTXz6
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:bcc1:: with SMTP id
 m184mr4399399wmf.132.1605305835550; Fri, 13 Nov 2020 14:17:15 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:15:53 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <6003966741503e98ca237ba056cf35cf0c7045a0.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 25/42] arm64: mte: Add in-kernel MTE helpers
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Provide helper functions to manipulate allocation and pointer tags for
kernel addresses.

Low-level helper functions (mte_assign_*, written in assembly) operate
tag values from the [0x0, 0xF] range. High-level helper functions
(mte_get/set_*) use the [0xF0, 0xFF] range to preserve compatibility
with normal kernel pointers that have 0xFF in their top byte.

MTE_GRANULE_SIZE and related definitions are moved to mte-def.h header
that doesn't have any dependencies and is safe to include into any
low-level header.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
Change-Id: I1b5230254f90dc21a913447cb17f07fea7944ece
---
 arch/arm64/include/asm/esr.h       |  1 +
 arch/arm64/include/asm/mte-def.h   | 15 ++++++++
 arch/arm64/include/asm/mte-kasan.h | 56 ++++++++++++++++++++++++++++++
 arch/arm64/include/asm/mte.h       | 20 +++++++----
 arch/arm64/kernel/mte.c            | 48 +++++++++++++++++++++++++
 arch/arm64/lib/mte.S               | 16 +++++++++
 6 files changed, 150 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/include/asm/mte-def.h
 create mode 100644 arch/arm64/include/asm/mte-kasan.h

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 22c81f1edda2..971c20ddfed4 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -105,6 +105,7 @@
 #define ESR_ELx_FSC		(0x3F)
 #define ESR_ELx_FSC_TYPE	(0x3C)
 #define ESR_ELx_FSC_EXTABT	(0x10)
+#define ESR_ELx_FSC_MTE		(0x11)
 #define ESR_ELx_FSC_SERROR	(0x11)
 #define ESR_ELx_FSC_ACCESS	(0x08)
 #define ESR_ELx_FSC_FAULT	(0x04)
diff --git a/arch/arm64/include/asm/mte-def.h b/arch/arm64/include/asm/mte-def.h
new file mode 100644
index 000000000000..8401ac5840c7
--- /dev/null
+++ b/arch/arm64/include/asm/mte-def.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 ARM Ltd.
+ */
+#ifndef __ASM_MTE_DEF_H
+#define __ASM_MTE_DEF_H
+
+#define MTE_GRANULE_SIZE	UL(16)
+#define MTE_GRANULE_MASK	(~(MTE_GRANULE_SIZE - 1))
+#define MTE_TAG_SHIFT		56
+#define MTE_TAG_SIZE		4
+#define MTE_TAG_MASK		GENMASK((MTE_TAG_SHIFT + (MTE_TAG_SIZE - 1)), MTE_TAG_SHIFT)
+#define MTE_TAG_MAX		(MTE_TAG_MASK >> MTE_TAG_SHIFT)
+
+#endif /* __ASM_MTE_DEF_H  */
diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
new file mode 100644
index 000000000000..3a70fb1807fd
--- /dev/null
+++ b/arch/arm64/include/asm/mte-kasan.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 ARM Ltd.
+ */
+#ifndef __ASM_MTE_KASAN_H
+#define __ASM_MTE_KASAN_H
+
+#include <asm/mte-def.h>
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+/*
+ * The functions below are meant to be used only for the
+ * KASAN_HW_TAGS interface defined in asm/memory.h.
+ */
+#ifdef CONFIG_ARM64_MTE
+
+static inline u8 mte_get_ptr_tag(void *ptr)
+{
+	/* Note: The format of KASAN tags is 0xF<x> */
+	u8 tag = 0xF0 | (u8)(((u64)(ptr)) >> MTE_TAG_SHIFT);
+
+	return tag;
+}
+
+u8 mte_get_mem_tag(void *addr);
+u8 mte_get_random_tag(void);
+void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
+
+#else /* CONFIG_ARM64_MTE */
+
+static inline u8 mte_get_ptr_tag(void *ptr)
+{
+	return 0xFF;
+}
+
+static inline u8 mte_get_mem_tag(void *addr)
+{
+	return 0xFF;
+}
+static inline u8 mte_get_random_tag(void)
+{
+	return 0xFF;
+}
+static inline void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
+{
+	return addr;
+}
+
+#endif /* CONFIG_ARM64_MTE */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_MTE_KASAN_H  */
diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 1c99fcadb58c..cf1cd181dcb2 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -5,14 +5,16 @@
 #ifndef __ASM_MTE_H
 #define __ASM_MTE_H
 
-#define MTE_GRANULE_SIZE	UL(16)
-#define MTE_GRANULE_MASK	(~(MTE_GRANULE_SIZE - 1))
-#define MTE_TAG_SHIFT		56
-#define MTE_TAG_SIZE		4
+#include <asm/compiler.h>
+#include <asm/mte-def.h>
+
+#define __MTE_PREAMBLE		ARM64_ASM_PREAMBLE ".arch_extension memtag\n"
 
 #ifndef __ASSEMBLY__
 
+#include <linux/bitfield.h>
 #include <linux/page-flags.h>
+#include <linux/types.h>
 
 #include <asm/pgtable-types.h>
 
@@ -45,7 +47,9 @@ long get_mte_ctrl(struct task_struct *task);
 int mte_ptrace_copy_tags(struct task_struct *child, long request,
 			 unsigned long addr, unsigned long data);
 
-#else
+void mte_assign_mem_tag_range(void *addr, size_t size);
+
+#else /* CONFIG_ARM64_MTE */
 
 /* unused if !CONFIG_ARM64_MTE, silence the compiler */
 #define PG_mte_tagged	0
@@ -80,7 +84,11 @@ static inline int mte_ptrace_copy_tags(struct task_struct *child,
 	return -EIO;
 }
 
-#endif
+static inline void mte_assign_mem_tag_range(void *addr, size_t size)
+{
+}
+
+#endif /* CONFIG_ARM64_MTE */
 
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_MTE_H  */
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 52a0638ed967..8f99c65837fd 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -13,10 +13,13 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/thread_info.h>
+#include <linux/types.h>
 #include <linux/uio.h>
 
+#include <asm/barrier.h>
 #include <asm/cpufeature.h>
 #include <asm/mte.h>
+#include <asm/mte-kasan.h>
 #include <asm/ptrace.h>
 #include <asm/sysreg.h>
 
@@ -72,6 +75,51 @@ int memcmp_pages(struct page *page1, struct page *page2)
 	return ret;
 }
 
+u8 mte_get_mem_tag(void *addr)
+{
+	if (!system_supports_mte())
+		return 0xFF;
+
+	asm(__MTE_PREAMBLE "ldg %0, [%0]"
+	    : "+r" (addr));
+
+	return mte_get_ptr_tag(addr);
+}
+
+u8 mte_get_random_tag(void)
+{
+	void *addr;
+
+	if (!system_supports_mte())
+		return 0xFF;
+
+	asm(__MTE_PREAMBLE "irg %0, %0"
+	    : "+r" (addr));
+
+	return mte_get_ptr_tag(addr);
+}
+
+void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
+{
+	void *ptr = addr;
+
+	if ((!system_supports_mte()) || (size == 0))
+		return addr;
+
+	/* Make sure that size is MTE granule aligned. */
+	WARN_ON(size & (MTE_GRANULE_SIZE - 1));
+
+	/* Make sure that the address is MTE granule aligned. */
+	WARN_ON((u64)addr & (MTE_GRANULE_SIZE - 1));
+
+	tag = 0xF0 | tag;
+	ptr = (void *)__tag_set(ptr, tag);
+
+	mte_assign_mem_tag_range(ptr, size);
+
+	return ptr;
+}
+
 static void update_sctlr_el1_tcf0(u64 tcf0)
 {
 	/* ISB required for the kernel uaccess routines */
diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
index cceed41bba15..e63890292bc1 100644
--- a/arch/arm64/lib/mte.S
+++ b/arch/arm64/lib/mte.S
@@ -149,3 +149,19 @@ SYM_FUNC_START(mte_restore_page_tags)
 
 	ret
 SYM_FUNC_END(mte_restore_page_tags)
+
+/*
+ * Assign allocation tags for a region of memory based on the pointer tag
+ *   x0 - source pointer
+ *   x1 - size
+ *
+ * Note: The address must be non-NULL and MTE_GRANULE_SIZE aligned and
+ * size must be non-zero and MTE_GRANULE_SIZE aligned.
+ */
+SYM_FUNC_START(mte_assign_mem_tag_range)
+1:	stg	x0, [x0]
+	add	x0, x0, #MTE_GRANULE_SIZE
+	subs	x1, x1, #MTE_GRANULE_SIZE
+	b.gt	1b
+	ret
+SYM_FUNC_END(mte_assign_mem_tag_range)
-- 
2.29.2.299.gdc1121823c-goog

