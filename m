Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C81F2A4DA9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 18:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgKCR7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 12:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbgKCR7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:59:02 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB03FC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 09:59:01 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id f20so3961265edx.23
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 09:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=CjOul1VqaRkscFJ+dD4H59GaMNHUJMUL0L/eCnbi6QE=;
        b=rAGTbC3OB8Gr5wn9dTgBQq5E9lSZTCXB6/V/73NZWHmvm9QPQp4pGG4Ep3y8Bp8b4Q
         7qA+PrzO/03REN+nljLqGkHfPuFk66L40kt6Qw4C+nOxQhAlbQT7zkEuXkA+SR7RHNQ8
         DfNqS8wXgnUhoFbBJNTvBvTlp/lqdlvZ2PVJybT4H/8fjq3O6+rsf1PYLiQykW/wtIid
         WSSnY4RgZPwDx6OnF2NNsvNtxgt6dvNKuLwSRiYpzYkPNlxIr8TirE67iKv/Wy11oiGi
         FoV8KJQz2AyxYIha+sGd0U23UVWf2Q2nc384ZXDRY6LDA9oVhfwWkOVc9xwKs7u3/5L4
         XGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CjOul1VqaRkscFJ+dD4H59GaMNHUJMUL0L/eCnbi6QE=;
        b=Ny22PRJwFN6O+MdX+6iFo2zp9yxB1dRh/QLphlEH/TR4/RSJ2jtGAn0LVTlcbR2iur
         vmJyTEigg+fU5Dsz4N68Ny2H0qUiMwhzVuJVK4l99TGnLhkmb9omdSR3NBtyilRBS38d
         BnYOu3v4EaoxeF7mALgR3HgRQzP/kqgeXHnQBGCBxzG+TbpTlATphP5qgG9U+UvIs867
         Gg7rGZQoAYZ66mwx75eZTLBHwkMZkKZCHP4hjm+8vj+7ISSdKzYKfATATVNrb+HUXFOX
         fd3k8mv51ufxUV3Pz9zXmtqwl1kVliFbtMF4QfNVMMQB/YrFy/bx+opTP0zlK2IG1B2o
         m/Hg==
X-Gm-Message-State: AOAM532Bi70kQXfUvdHEhuzCMcGDN/zbRKunHHM6GldqRfAAr/UiGCnJ
        EZnrP4VaHiMCUulS8Q3arJCojUKugA==
X-Google-Smtp-Source: ABdhPJw7jn9Aw9p+ba9azss7oDHFoiQHb4Di3vC9AcakPZBAocSHGKh5dLfJKGFn7yyrZXAvfw6COGNsEA==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a05:6402:b6e:: with SMTP id
 cb14mr9832146edb.308.1604426340371; Tue, 03 Nov 2020 09:59:00 -0800 (PST)
Date:   Tue,  3 Nov 2020 18:58:34 +0100
In-Reply-To: <20201103175841.3495947-1-elver@google.com>
Message-Id: <20201103175841.3495947-3-elver@google.com>
Mime-Version: 1.0
References: <20201103175841.3495947-1-elver@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 2/9] x86, kfence: enable KFENCE for x86
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org, glider@google.com
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dave.hansen@linux.intel.com,
        rientjes@google.com, dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, hdanton@sina.com, mingo@redhat.com,
        jannh@google.com, Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, joern@purestorage.com,
        keescook@chromium.org, mark.rutland@arm.com, penberg@kernel.org,
        peterz@infradead.org, sjpark@amazon.com, tglx@linutronix.de,
        vbabka@suse.cz, will@kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Potapenko <glider@google.com>

Add architecture specific implementation details for KFENCE and enable
KFENCE for the x86 architecture. In particular, this implements the
required interface in <asm/kfence.h> for setting up the pool and
providing helper functions for protecting and unprotecting pages.

For x86, we need to ensure that the pool uses 4K pages, which is done
using the set_memory_4k() helper function.

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Co-developed-by: Marco Elver <elver@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
v7:
* Only not-present faults should be handled by kfence [reported by Jann Horn].

v5:
* MAJOR CHANGE: Switch to the memblock_alloc'd pool. Running benchmarks
  with the newly optimized is_kfence_address(), no difference between
  baseline and KFENCE is observed.
* Suggested by Jann Horn:
  * Move x86 kfence_handle_page_fault before oops handling.
  * WARN_ON in kfence_protect_page if non-4K pages.
  * Better comments for x86 kfence_protect_page.

v4:
* Define __kfence_pool_attrs.
---
 arch/x86/Kconfig              |  1 +
 arch/x86/include/asm/kfence.h | 65 +++++++++++++++++++++++++++++++++++
 arch/x86/mm/fault.c           |  5 +++
 3 files changed, 71 insertions(+)
 create mode 100644 arch/x86/include/asm/kfence.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f6946b81f74a..c9ec6b5ba358 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -144,6 +144,7 @@ config X86
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN			if X86_64
 	select HAVE_ARCH_KASAN_VMALLOC		if X86_64
+	select HAVE_ARCH_KFENCE
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS		if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if MMU && COMPAT
diff --git a/arch/x86/include/asm/kfence.h b/arch/x86/include/asm/kfence.h
new file mode 100644
index 000000000000..beeac105dae7
--- /dev/null
+++ b/arch/x86/include/asm/kfence.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_X86_KFENCE_H
+#define _ASM_X86_KFENCE_H
+
+#include <linux/bug.h>
+#include <linux/kfence.h>
+
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+#include <asm/set_memory.h>
+#include <asm/tlbflush.h>
+
+/*
+ * The page fault handler entry function, up to which the stack trace is
+ * truncated in reports.
+ */
+#define KFENCE_SKIP_ARCH_FAULT_HANDLER "asm_exc_page_fault"
+
+/* Force 4K pages for __kfence_pool. */
+static inline bool arch_kfence_init_pool(void)
+{
+	unsigned long addr;
+
+	for (addr = (unsigned long)__kfence_pool; is_kfence_address((void *)addr);
+	     addr += PAGE_SIZE) {
+		unsigned int level;
+
+		if (!lookup_address(addr, &level))
+			return false;
+
+		if (level != PG_LEVEL_4K)
+			set_memory_4k(addr, 1);
+	}
+
+	return true;
+}
+
+/* Protect the given page and flush TLB. */
+static inline bool kfence_protect_page(unsigned long addr, bool protect)
+{
+	unsigned int level;
+	pte_t *pte = lookup_address(addr, &level);
+
+	if (WARN_ON(!pte || level != PG_LEVEL_4K))
+		return false;
+
+	/*
+	 * We need to avoid IPIs, as we may get KFENCE allocations or faults
+	 * with interrupts disabled. Therefore, the below is best-effort, and
+	 * does not flush TLBs on all CPUs. We can tolerate some inaccuracy;
+	 * lazy fault handling takes care of faults after the page is PRESENT.
+	 */
+
+	if (protect)
+		set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_PRESENT));
+	else
+		set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
+
+	/* Flush this CPU's TLB. */
+	flush_tlb_one_kernel(addr);
+	return true;
+}
+
+#endif /* _ASM_X86_KFENCE_H */
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 82bf37a5c9ec..e42db2836438 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -9,6 +9,7 @@
 #include <linux/kdebug.h>		/* oops_begin/end, ...		*/
 #include <linux/extable.h>		/* search_exception_tables	*/
 #include <linux/memblock.h>		/* max_low_pfn			*/
+#include <linux/kfence.h>		/* kfence_handle_page_fault	*/
 #include <linux/kprobes.h>		/* NOKPROBE_SYMBOL, ...		*/
 #include <linux/mmiotrace.h>		/* kmmio_handler, ...		*/
 #include <linux/perf_event.h>		/* perf_sw_event		*/
@@ -725,6 +726,10 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	if (IS_ENABLED(CONFIG_EFI))
 		efi_recover_from_page_fault(address);
 
+	/* Only not-present faults should be handled by KFENCE. */
+	if (!(error_code & X86_PF_PROT) && kfence_handle_page_fault(address))
+		return;
+
 oops:
 	/*
 	 * Oops. The kernel tried to access some bad page. We'll have to
-- 
2.29.1.341.ge80a0c044ae-goog

