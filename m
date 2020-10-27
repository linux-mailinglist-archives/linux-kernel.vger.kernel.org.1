Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB21629C545
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1824919AbgJ0SGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:06:47 -0400
Received: from mail-wr1-f74.google.com ([209.85.221.74]:35641 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508620AbgJ0OQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:16:45 -0400
Received: by mail-wr1-f74.google.com with SMTP id t3so827710wrq.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=amWdP6FV7IwvIOgrtWK6Wa5LLRx0C6kQ2UzTi3lX/Ww=;
        b=lqYJFavIH+U4gFwR4Ufpqsg9KCYNXbJ3F8gnrRSYEHQI3/A9+te13dBCntzIVhHjPA
         yM/u2APl511RqstDqN55oOyS5UP4F22H/qyDB5WR7vaX3lk9aNkuR0sQDMgO4HTJoT2P
         nUddrSTOur3uISgb2z/F6hHZ6MIYXhpIqkCKj2iS3tCmoXeHvH04eMp18wWCBfWo3H9C
         IWJ3GPgBuk64n7JwdO61szS3AlX7mUf1cu8NrRaBk+3UmrzTr4PXcXohLQCOyybY0a39
         ZogLQhigFh5RhWSVOsR8UYLQRHv3SabS6DfurmVtNpuvQc1oCiGBsU8hyksRke4zFsLy
         e1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=amWdP6FV7IwvIOgrtWK6Wa5LLRx0C6kQ2UzTi3lX/Ww=;
        b=WHwfWh4391Alk9pV1hvgLLGL8sJrcl0PFW+yljOvIFfI9lHxiPpp0qVQZ9+G1lqnYN
         YUDp1ubsi49q87/rTYS9/iLccdhOxRTx20l+Oq00vbjF+3E9GGj4NaPxsy99bCXWK0Uv
         3Y/65kINPwXhQkUtROzuD4Jd3J0WnCAf9z5EDiKvu/fW9LohCYYA8U9GzEYFtqmJjKJm
         2LhcZv3Z3c2TomwjIv3VtQn3MTnUWZ5SJgWtrx4j1FWRs966xqN+KiAB9qDY7mcmrRsO
         OWzaUdYdYCr6ki/vTsz7LpubhofX8was+TDCoCLeqssh/IjNfhDyBLkhj5j4FRd6/UWK
         0KxQ==
X-Gm-Message-State: AOAM533oXTfQ4yKf1uCuGsPqTh7w85otRA6neiQu7o+x8a/nwtTz1rcR
        Yn9q02L7xmCy2oFOaMBJJ7UbQz/n/A==
X-Google-Smtp-Source: ABdhPJxg2TfSVwFzHU/1bZA22yprPnzmXJsVKmsjs/zjJxuqWYfMpJQfyT+LsH4Tz15aeMtqUAjINyxpZw==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:adf:eac6:: with SMTP id o6mr3348520wrn.117.1603808201007;
 Tue, 27 Oct 2020 07:16:41 -0700 (PDT)
Date:   Tue, 27 Oct 2020 15:15:59 +0100
In-Reply-To: <20201027141606.426816-1-elver@google.com>
Message-Id: <20201027141606.426816-3-elver@google.com>
Mime-Version: 1.0
References: <20201027141606.426816-1-elver@google.com>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [PATCH v5 2/9] x86, kfence: enable KFENCE for x86
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
 arch/x86/mm/fault.c           |  4 +++
 3 files changed, 70 insertions(+)
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
index 82bf37a5c9ec..380638745f42 100644
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
@@ -725,6 +726,9 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	if (IS_ENABLED(CONFIG_EFI))
 		efi_recover_from_page_fault(address);
 
+	if (kfence_handle_page_fault(address))
+		return;
+
 oops:
 	/*
 	 * Oops. The kernel tried to access some bad page. We'll have to
-- 
2.29.0.rc2.309.g374f81d7ae-goog

