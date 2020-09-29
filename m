Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C384427CF6C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbgI2Ni5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI2Nis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:38:48 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16528C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:38:48 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id o13so2979130qtl.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1b8StUxuKVuYd1wam6EMRlTfs7xw+c/0eMbKAsoXFrU=;
        b=d25sdqTRKnNfZKW7kuWY3HtLW+C+GmUN+n5VmyhHB1XUqvDqPmidO1bbCNS4iSezQf
         OAi00db1yuNkLFRlJjsI0//2wlaaJSYdIgsqT0SmyOgTFQHU/9Ddo2tknD95IflErqt7
         FQyrL+BerDfu2w3Fi4dSIThjb7Sn5W13yeIJYbq9bJLqKpNNfrukW9VsL/Lr4zN7pCoV
         uCdz8jQ0S9m83vb/3Nwejb9iKbHY6c8ogUQwLPIJs9nTP+o2ho1GpDXhihOc7GrasyU/
         hjUBS/6za9IXrJ0HAMQj2LK3RHq8BKyZkDFimnmcsQGSNSdGCX8jDIUu70lSL9SuEm06
         rK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1b8StUxuKVuYd1wam6EMRlTfs7xw+c/0eMbKAsoXFrU=;
        b=t/mQFYlQfEZxLVrn6CPbBq+IEH8Hcldk0irgDZ5/qLDZNBsKjbinpDak8hnvsmY0Z/
         Pw2ySYFPb2bIKZLyBrwQeG7VNqUyvrA+5WaghWxLJ454D+DFaYCUbmuiOrO/ZBLpJKEs
         EGJpPLA2bVYoO6rsGeOOkIj6n8eUEKVvK6iO8oBEjwmfUQzHIp8kf0/78LsQmNQGDJan
         TzPuSg+cDYeGOXiO+GeOSiHmGnC0O6sZ43Kgz/Y9gB+57ujNUj5r597vl776U74xOU7b
         O9GXZdG0ldc7875TmI1slsl+pprDexyC4px/WynjKLYHc/BpN0zqdAtc+c7rnVAOIT0A
         z/Dw==
X-Gm-Message-State: AOAM533ySZyFjMdyHX3jern4spNG9dVj4LeWgQRBgKfNEeEUxYvQ3lIi
        jO4Fn2IOjL68pWKLp24rESMTat1KOg==
X-Google-Smtp-Source: ABdhPJwyguPmT4Rf0i2UiKmi5OgPQew05alW5ddxHiPxbIGHcxizsfd5RmyXpXS3OYqxt7SfjqAmV+7UQA==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:ad4:4e4e:: with SMTP id eb14mr4552265qvb.41.1601386726953;
 Tue, 29 Sep 2020 06:38:46 -0700 (PDT)
Date:   Tue, 29 Sep 2020 15:38:05 +0200
In-Reply-To: <20200929133814.2834621-1-elver@google.com>
Message-Id: <20200929133814.2834621-3-elver@google.com>
Mime-Version: 1.0
References: <20200929133814.2834621-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 02/11] x86, kfence: enable KFENCE for x86
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org, glider@google.com
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dave.hansen@linux.intel.com,
        rientjes@google.com, dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, hdanton@sina.com, mingo@redhat.com,
        jannh@google.com, Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, keescook@chromium.org,
        mark.rutland@arm.com, penberg@kernel.org, peterz@infradead.org,
        sjpark@amazon.com, tglx@linutronix.de, vbabka@suse.cz,
        will@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
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
v4:
* Define __kfence_pool_attrs.
---
 arch/x86/Kconfig              |  2 ++
 arch/x86/include/asm/kfence.h | 60 +++++++++++++++++++++++++++++++++++
 arch/x86/mm/fault.c           |  4 +++
 3 files changed, 66 insertions(+)
 create mode 100644 arch/x86/include/asm/kfence.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7101ac64bb20..e22dc722698c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -144,6 +144,8 @@ config X86
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN			if X86_64
 	select HAVE_ARCH_KASAN_VMALLOC		if X86_64
+	select HAVE_ARCH_KFENCE
+	select HAVE_ARCH_KFENCE_STATIC_POOL
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS		if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if MMU && COMPAT
diff --git a/arch/x86/include/asm/kfence.h b/arch/x86/include/asm/kfence.h
new file mode 100644
index 000000000000..98fb1cd80026
--- /dev/null
+++ b/arch/x86/include/asm/kfence.h
@@ -0,0 +1,60 @@
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
+/* The alignment should be at least a 4K page. */
+#define __kfence_pool_attrs __aligned(PAGE_SIZE)
+
+/*
+ * The page fault handler entry function, up to which the stack trace is
+ * truncated in reports.
+ */
+#define KFENCE_SKIP_ARCH_FAULT_HANDLER "asm_exc_page_fault"
+
+/* Force 4K pages for __kfence_pool. */
+static inline bool arch_kfence_initialize_pool(void)
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
+/* Protect the given page and flush TLBs. */
+static inline bool kfence_protect_page(unsigned long addr, bool protect)
+{
+	unsigned int level;
+	pte_t *pte = lookup_address(addr, &level);
+
+	if (!pte || level != PG_LEVEL_4K)
+		return false;
+
+	if (protect)
+		set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_PRESENT));
+	else
+		set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
+
+	flush_tlb_one_kernel(addr);
+	return true;
+}
+
+#endif /* _ASM_X86_KFENCE_H */
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 6e3e8a124903..423e15ad5eb6 100644
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
@@ -701,6 +702,9 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	}
 #endif
 
+	if (kfence_handle_page_fault(address))
+		return;
+
 	/*
 	 * 32-bit:
 	 *
-- 
2.28.0.709.gb0816b6eb0-goog

