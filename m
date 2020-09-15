Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFA026B015
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgIOV7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbgIOV3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:29:24 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D49C061220
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:16 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id h9so3145740qvr.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=EjJhT+aBWvSW5tBYtrKg3j1ds+SSoe7l1pzkwlzhcIA=;
        b=qdt0h6m8e2SenBJw4pJS9GsmWMYLu8NOi7oiFi1Rv92NfIRxvfsipYsvTcVoKTlHpK
         Ldl1N8GaVV1DDSEH8gDfetZKkRP7pBl2PMclflpfKZ0+GuvAFrUbgnj8UHRW1PeVqPKD
         niVwylJdv1rwGbdXMO6yVLufFTifRYqPN8IRL9dlb3lShyFz9lUdQUDchKsof3qCxTxJ
         fxjh20xjN4Uo9czM6gCFVb342//Mymj0Uy2U7eZz2clrjyOh7LNARQ5heJbmWuvwMNQX
         dEvCNC6tym/ZlVJaD9vXUtlM8ZcY4zmvaaCRzhVF1QU9+QIzvtawZJJd0g2Jlxt5hUuz
         kYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EjJhT+aBWvSW5tBYtrKg3j1ds+SSoe7l1pzkwlzhcIA=;
        b=CnWVwUzj12AFmn6ZZ/2Wx2Haiov+gfGjOHzEYzRf4CnVebWopWtGE8fZwm811hWtQB
         PV6u9f8vWxoaQXTYco+GnWEd9OH7lRP8rZ5/QBhFeCSHaHnNxaN2RMnEoOSYNIXfY0Ug
         XGyyTtNTaPfG8L/olc+Na51xkzvejYyFB8oyv5WBMXGmuW6/SrIe/2jRwiT5gMhtdZPp
         VX32wDs4BndJpDs2aCK5ujrn/QZwMIrFPqSNCG9N+6MvLSZtf5GgZ2HkoKQk5YFjfSmh
         jTEV8jWBDRFmqqrW5wr8V5JG4rxM66U8dRGLDKrSdb9dk/zvB76BcsA2ou7rNpEuN1mY
         U+aA==
X-Gm-Message-State: AOAM532QBg2DFzEe4V7naTJ2j0TchmfEd6JAZbpRB3KPxVH2AdMrKjYq
        h6Y3v4EppqolHtcqk4bwMmb8Sjrzmp9cCuxu
X-Google-Smtp-Source: ABdhPJznItyo9JV9Agypgfsx+XA9jc3Pb/E/RCFXo1JU2ePp9jsJUkcTNA4b04dCI/jdX8/lZDQEsr4Nu3dvBCff
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:57cc:: with SMTP id
 y12mr3796349qvx.48.1600204635905; Tue, 15 Sep 2020 14:17:15 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:16:04 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <4ac1ed624dd1b0851d8cf2861b4f4aac4d2dbc83.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 22/37] arm64: mte: Add in-kernel MTE helpers
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
Sender: linux-kernel-owner@vger.kernel.org
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
 arch/arm64/include/asm/esr.h         |  1 +
 arch/arm64/include/asm/mte-helpers.h | 48 ++++++++++++++++++++++++++++
 arch/arm64/include/asm/mte.h         | 17 ++++++----
 arch/arm64/kernel/mte.c              | 48 ++++++++++++++++++++++++++++
 arch/arm64/lib/mte.S                 | 17 ++++++++++
 5 files changed, 125 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/include/asm/mte-helpers.h

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
diff --git a/arch/arm64/include/asm/mte-helpers.h b/arch/arm64/include/asm/mte-helpers.h
new file mode 100644
index 000000000000..5dc2d443851b
--- /dev/null
+++ b/arch/arm64/include/asm/mte-helpers.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 ARM Ltd.
+ */
+#ifndef __ASM_MTE_ASM_H
+#define __ASM_MTE_ASM_H
+
+#define __MTE_PREAMBLE		".arch armv8.5-a\n.arch_extension memtag\n"
+
+#define MTE_GRANULE_SIZE	UL(16)
+#define MTE_GRANULE_MASK	(~(MTE_GRANULE_SIZE - 1))
+#define MTE_TAG_SHIFT		56
+#define MTE_TAG_SIZE		4
+#define MTE_TAG_MASK		GENMASK((MTE_TAG_SHIFT + (MTE_TAG_SIZE - 1)), MTE_TAG_SHIFT)
+#define MTE_TAG_MAX		(MTE_TAG_MASK >> MTE_TAG_SHIFT)
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+#ifdef CONFIG_ARM64_MTE
+
+#define mte_get_ptr_tag(ptr)	((u8)(((u64)(ptr)) >> MTE_TAG_SHIFT))
+u8 mte_get_mem_tag(void *addr);
+u8 mte_get_random_tag(void);
+void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
+
+#else /* CONFIG_ARM64_MTE */
+
+#define mte_get_ptr_tag(ptr)	0xFF
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
+#endif /* __ASM_MTE_ASM_H  */
diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 1c99fcadb58c..82cd7c89edec 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -5,14 +5,13 @@
 #ifndef __ASM_MTE_H
 #define __ASM_MTE_H
 
-#define MTE_GRANULE_SIZE	UL(16)
-#define MTE_GRANULE_MASK	(~(MTE_GRANULE_SIZE - 1))
-#define MTE_TAG_SHIFT		56
-#define MTE_TAG_SIZE		4
+#include <asm/mte-helpers.h>
 
 #ifndef __ASSEMBLY__
 
+#include <linux/bitfield.h>
 #include <linux/page-flags.h>
+#include <linux/types.h>
 
 #include <asm/pgtable-types.h>
 
@@ -45,7 +44,9 @@ long get_mte_ctrl(struct task_struct *task);
 int mte_ptrace_copy_tags(struct task_struct *child, long request,
 			 unsigned long addr, unsigned long data);
 
-#else
+void mte_assign_mem_tag_range(void *addr, size_t size);
+
+#else /* CONFIG_ARM64_MTE */
 
 /* unused if !CONFIG_ARM64_MTE, silence the compiler */
 #define PG_mte_tagged	0
@@ -80,7 +81,11 @@ static inline int mte_ptrace_copy_tags(struct task_struct *child,
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
index 52a0638ed967..e238ffde2679 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -13,8 +13,10 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/thread_info.h>
+#include <linux/types.h>
 #include <linux/uio.h>
 
+#include <asm/barrier.h>
 #include <asm/cpufeature.h>
 #include <asm/mte.h>
 #include <asm/ptrace.h>
@@ -72,6 +74,52 @@ int memcmp_pages(struct page *page1, struct page *page2)
 	return ret;
 }
 
+u8 mte_get_mem_tag(void *addr)
+{
+	if (system_supports_mte())
+		asm volatile(ALTERNATIVE("ldr %0, [%0]",
+					 __MTE_PREAMBLE "ldg %0, [%0]",
+					 ARM64_MTE)
+			     : "+r" (addr));
+
+	return 0xF0 | mte_get_ptr_tag(addr);
+}
+
+u8 mte_get_random_tag(void)
+{
+	u8 tag = 0xF;
+	u64 addr = 0;
+
+	if (system_supports_mte()) {
+		asm volatile(ALTERNATIVE("add %0, %0, %0",
+					 __MTE_PREAMBLE "irg %0, %0",
+					 ARM64_MTE)
+			     : "+r" (addr));
+
+		tag = mte_get_ptr_tag(addr);
+	}
+
+	return 0xF0 | tag;
+}
+
+void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
+{
+	void *ptr = addr;
+
+	if ((!system_supports_mte()) || (size == 0))
+		return addr;
+
+	/* Make sure that size is aligned. */
+	WARN_ON(size & (MTE_GRANULE_SIZE - 1));
+
+	tag = 0xF0 | (tag & 0xF);
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
index 03ca6d8b8670..cc2c3a378c00 100644
--- a/arch/arm64/lib/mte.S
+++ b/arch/arm64/lib/mte.S
@@ -149,3 +149,20 @@ SYM_FUNC_START(mte_restore_page_tags)
 
 	ret
 SYM_FUNC_END(mte_restore_page_tags)
+
+/*
+ * Assign allocation tags for a region of memory based on the pointer tag
+ *   x0 - source pointer
+ *   x1 - size
+ *
+ * Note: size must be non-zero and MTE_GRANULE_SIZE aligned
+ */
+SYM_FUNC_START(mte_assign_mem_tag_range)
+	/* if (src == NULL) return; */
+	cbz	x0, 2f
+1:	stg	x0, [x0]
+	add	x0, x0, #MTE_GRANULE_SIZE
+	sub	x1, x1, #MTE_GRANULE_SIZE
+	cbnz	x1, 1b
+2:	ret
+SYM_FUNC_END(mte_assign_mem_tag_range)
-- 
2.28.0.618.gf4bc123cb7-goog

