Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97895280B26
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387625AbgJAXMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733002AbgJAXLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:11:44 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56AAC0613E5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:11:43 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id f2so25132wml.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=9dHZTsumEZWfULwt3pS8Ru/v3DARM8JrrMIGCjKgew4=;
        b=kAwG9u97bCzLrZgf6inNIL09Cegg9FKXXZ9bN2z7RLfhsbFWRKI+YM9DwNzd0ZS6P1
         +vL7HKmzwa++VP7RUaYeQLZeS0WuU8OJFwczzdKx4vuuMKtSYi1AT/GTiFg2SpDpA1XU
         422MKbOxcN21ylaDG7UVDcN1u5YPMk09RaHt5+ZiAebQdruKYx7ESyQ4tTQ53tlDZU9v
         BEsI1YJgo64pN8UwdkT6ltu0YmNw0h+gzQ9NUB16ScREeTelq9KCCwTdCZieWAzrdxar
         NCuqMvbLMhjlpHGnooVyWAN6hMgUMaiR1EEwRNpgn5LsNALh/8WFDpJyrJYdEbPGxa8F
         8mCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9dHZTsumEZWfULwt3pS8Ru/v3DARM8JrrMIGCjKgew4=;
        b=mJFAfYsEm0fqn2yFryQaJqbNLnryucAKCgPEUgNBabTAaWe4w77Y1S0BUz9Wq9/Ecr
         at+I570lI/yOUJn8nfiBko3DeAF6oUuZ56v7pI7t/8j9m3k81lAaoDPTY+0wHX1Pt7dS
         AOpnVR0tpm/nmb5Ll0QMH68sjTFQw1p2KCZHra7ZoZV93slJzhXrHlSnToTIyzmzKHu5
         E0aKrIyVVgGdUycwcsIFgBVUp1IDevJj2CXQgVCd5LXGVPQZSX+dYymWpiNG6zTAKhiH
         2b5nl9m09F1vw0n0qIp7bEKgfB1Ax9JbFim2lUA9c6cHLWvboyPESUlA5Gs3U/BAdCkH
         Zc3Q==
X-Gm-Message-State: AOAM531bQ1sFz1qGftvx8uESaG+ATWaEg9WcqsA8+bR1Se2WTCEzsdwV
        5dsHpwluMvAlRqtDr+1NhCcly5B2Bbb+crwQ
X-Google-Smtp-Source: ABdhPJxygbv/A4MXJCXS9jBh2B2q8Nw12YMwQWTEmcCCSbzYOo+OAJCL77WkpVfHU7iDklbmp0vAvJAr1x/3GkJw
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:408a:: with SMTP id
 n132mr2166937wma.45.1601593902336; Thu, 01 Oct 2020 16:11:42 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:25 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <96d3ade8c6e050fefc597531fa2889e67ed75349.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 24/39] arm64: mte: Add in-kernel MTE helpers
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
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
index 035003acfa87..bc0dc66a6a27 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -103,6 +103,7 @@
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
index 03ca6d8b8670..ede1ea65428c 100644
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
2.28.0.709.gb0816b6eb0-goog

