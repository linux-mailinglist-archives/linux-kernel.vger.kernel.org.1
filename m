Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEBC2A7A5B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbgKEJVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgKEJVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:21:43 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01BBC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 01:21:41 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id s4so501303qvn.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 01:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=bFemS5lF24Ay3Ly62yBwjbW4q0e7c3wKlLqU+bgvo/I=;
        b=t80j7HIkdOHjMvPsNgoTiHKDwLTSbbxs4r9tjdU+10dGrdNtqKxpqaREpU+3ayq/MB
         N7yoiB1TX3u2HLE1gPPsK+5KyONXCzikTUU70qJrkAOswvwdFIGm/ZHTGRIF1myFYNvX
         gT76CeRW5NIxPYUdekpRxX5Qtx917w1WrmBCjnNb+O3LL3BUOq6GKIickj0JgS/wrzZh
         tnN3XzwreN9vw3POtf3HOKJdfwKxqDdsz6D82h0+AmaKXK8VJCtYRz95tF8aqayKWmRA
         hQXUB/KsfuwI+totA/KXGvMm4KbBHpJEzA6LZA8ge529ZMUWdw1+jkRVLSELOqAram/D
         krjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=bFemS5lF24Ay3Ly62yBwjbW4q0e7c3wKlLqU+bgvo/I=;
        b=dSBjB+kJ8vzQccODsmse+QTHbDdB6uUpg5oLYmS9jhO1VHFNJKBnrAGdvVAZux0ZRb
         oArqWqbpRyBNOaNLspeWvh+dXSsrRRuyTpNgVduoPxeI23HNx6CeJLL/zJQhSs2+1ni4
         NxWRhaEWvKeenbFjZ68ZYTt0UWdknyhQIT481tNVVy317jVgeNmpAhESb2dB+cKvVDYf
         wVYZyEDoRjbaWYWBs8jlXo8x39rfdcZjmlHRTmEqhhMBGFDMaJjy8WLjSbS6nQzdWJpc
         GYfvxuTdRFsnaBhw/4BXWkNFSPwZx9ga7zIwEMG4LRoY//pz1bZD7R4QjD/YETIBbUNa
         xu7Q==
X-Gm-Message-State: AOAM533OYHbeNRjO0ShdstXWmmeoYzSV+7fv64oWAL0kaR6bc2x3nJm2
        nMMOU+qw5Y2cOhjlVdmvUiZpwuQ+aQ==
X-Google-Smtp-Source: ABdhPJwTuchlHWol+5p0JL/YFUwph8F//VmgiSWrHzJencdZwxUeO0yVeJhMboPyL7otHYjKt3OXyFDKcg==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a0c:b44a:: with SMTP id e10mr1321540qvf.4.1604568101175;
 Thu, 05 Nov 2020 01:21:41 -0800 (PST)
Date:   Thu,  5 Nov 2020 10:21:33 +0100
Message-Id: <20201105092133.2075331-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH] kfence: Use pt_regs to generate stack trace on faults
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, jannh@google.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of removing the fault handling portion of the stack trace based
on the fault handler's name, just use struct pt_regs directly.

Change kfence_handle_page_fault() to take a struct pt_regs, and plumb it
through to kfence_report_error() for out-of-bounds, use-after-free, or
invalid access errors, where pt_regs is used to generate the stack
trace.

If the kernel is a DEBUG_KERNEL, also show registers for more
information.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 arch/arm64/include/asm/kfence.h |  2 --
 arch/arm64/mm/fault.c           |  2 +-
 arch/x86/include/asm/kfence.h   |  6 ----
 arch/x86/mm/fault.c             |  2 +-
 include/linux/kfence.h          |  5 +--
 mm/kfence/core.c                | 10 +++---
 mm/kfence/kfence.h              |  4 +--
 mm/kfence/report.c              | 63 +++++++++++++++++++--------------
 8 files changed, 48 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/kfence.h
index 5ac0f599cc9a..6c0afeeab635 100644
--- a/arch/arm64/include/asm/kfence.h
+++ b/arch/arm64/include/asm/kfence.h
@@ -5,8 +5,6 @@
 
 #include <asm/cacheflush.h>
 
-#define KFENCE_SKIP_ARCH_FAULT_HANDLER "el1_sync"
-
 static inline bool arch_kfence_init_pool(void) { return true; }
 
 static inline bool kfence_protect_page(unsigned long addr, bool protect)
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 2d60204b4ed2..183d1e6dd9e0 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -323,7 +323,7 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
 	} else if (addr < PAGE_SIZE) {
 		msg = "NULL pointer dereference";
 	} else {
-		if (kfence_handle_page_fault(addr))
+		if (kfence_handle_page_fault(addr, regs))
 			return;
 
 		msg = "paging request";
diff --git a/arch/x86/include/asm/kfence.h b/arch/x86/include/asm/kfence.h
index beeac105dae7..2f3f877a7a5c 100644
--- a/arch/x86/include/asm/kfence.h
+++ b/arch/x86/include/asm/kfence.h
@@ -11,12 +11,6 @@
 #include <asm/set_memory.h>
 #include <asm/tlbflush.h>
 
-/*
- * The page fault handler entry function, up to which the stack trace is
- * truncated in reports.
- */
-#define KFENCE_SKIP_ARCH_FAULT_HANDLER "asm_exc_page_fault"
-
 /* Force 4K pages for __kfence_pool. */
 static inline bool arch_kfence_init_pool(void)
 {
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e42db2836438..53d732161b4f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -727,7 +727,7 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 		efi_recover_from_page_fault(address);
 
 	/* Only not-present faults should be handled by KFENCE. */
-	if (!(error_code & X86_PF_PROT) && kfence_handle_page_fault(address))
+	if (!(error_code & X86_PF_PROT) && kfence_handle_page_fault(address, regs))
 		return;
 
 oops:
diff --git a/include/linux/kfence.h b/include/linux/kfence.h
index ed2d48acdafe..98a97f9d43cd 100644
--- a/include/linux/kfence.h
+++ b/include/linux/kfence.h
@@ -171,6 +171,7 @@ static __always_inline __must_check bool kfence_free(void *addr)
 /**
  * kfence_handle_page_fault() - perform page fault handling for KFENCE pages
  * @addr: faulting address
+ * @regs: current struct pt_regs (can be NULL, but shows full stack trace)
  *
  * Return:
  * * false - address outside KFENCE pool,
@@ -181,7 +182,7 @@ static __always_inline __must_check bool kfence_free(void *addr)
  * cases KFENCE prints an error message and marks the offending page as
  * present, so that the kernel can proceed.
  */
-bool __must_check kfence_handle_page_fault(unsigned long addr);
+bool __must_check kfence_handle_page_fault(unsigned long addr, struct pt_regs *regs);
 
 #else /* CONFIG_KFENCE */
 
@@ -194,7 +195,7 @@ static inline size_t kfence_ksize(const void *addr) { return 0; }
 static inline void *kfence_object_start(const void *addr) { return NULL; }
 static inline void __kfence_free(void *addr) { }
 static inline bool __must_check kfence_free(void *addr) { return false; }
-static inline bool __must_check kfence_handle_page_fault(unsigned long addr) { return false; }
+static inline bool __must_check kfence_handle_page_fault(unsigned long addr, struct pt_regs *regs) { return false; }
 
 #endif
 
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 9d597013cd5d..9358f42a9a9e 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -212,7 +212,7 @@ static inline bool check_canary_byte(u8 *addr)
 		return true;
 
 	atomic_long_inc(&counters[KFENCE_COUNTER_BUGS]);
-	kfence_report_error((unsigned long)addr, addr_to_metadata((unsigned long)addr),
+	kfence_report_error((unsigned long)addr, NULL, addr_to_metadata((unsigned long)addr),
 			    KFENCE_ERROR_CORRUPTION);
 	return false;
 }
@@ -351,7 +351,7 @@ static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool z
 	if (meta->state != KFENCE_OBJECT_ALLOCATED || meta->addr != (unsigned long)addr) {
 		/* Invalid or double-free, bail out. */
 		atomic_long_inc(&counters[KFENCE_COUNTER_BUGS]);
-		kfence_report_error((unsigned long)addr, meta, KFENCE_ERROR_INVALID_FREE);
+		kfence_report_error((unsigned long)addr, NULL, meta, KFENCE_ERROR_INVALID_FREE);
 		raw_spin_unlock_irqrestore(&meta->lock, flags);
 		return;
 	}
@@ -752,7 +752,7 @@ void __kfence_free(void *addr)
 		kfence_guarded_free(addr, meta, false);
 }
 
-bool kfence_handle_page_fault(unsigned long addr)
+bool kfence_handle_page_fault(unsigned long addr, struct pt_regs *regs)
 {
 	const int page_index = (addr - (unsigned long)__kfence_pool) / PAGE_SIZE;
 	struct kfence_metadata *to_report = NULL;
@@ -815,11 +815,11 @@ bool kfence_handle_page_fault(unsigned long addr)
 
 out:
 	if (to_report) {
-		kfence_report_error(addr, to_report, error_type);
+		kfence_report_error(addr, regs, to_report, error_type);
 		raw_spin_unlock_irqrestore(&to_report->lock, flags);
 	} else {
 		/* This may be a UAF or OOB access, but we can't be sure. */
-		kfence_report_error(addr, NULL, KFENCE_ERROR_INVALID);
+		kfence_report_error(addr, regs, NULL, KFENCE_ERROR_INVALID);
 	}
 
 	return kfence_unprotect(addr); /* Unprotect and let access proceed. */
diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
index f115aabc2052..fa3579d03089 100644
--- a/mm/kfence/kfence.h
+++ b/mm/kfence/kfence.h
@@ -99,8 +99,8 @@ enum kfence_error_type {
 	KFENCE_ERROR_INVALID_FREE,	/* Invalid free. */
 };
 
-void kfence_report_error(unsigned long address, const struct kfence_metadata *meta,
-			 enum kfence_error_type type);
+void kfence_report_error(unsigned long address, struct pt_regs *regs,
+			 const struct kfence_metadata *meta, enum kfence_error_type type);
 
 void kfence_print_object(struct seq_file *seq, const struct kfence_metadata *meta);
 
diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index 0fdaa3ddf1b4..4dedc2ff8f28 100644
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -5,6 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/lockdep.h>
 #include <linux/printk.h>
+#include <linux/sched/debug.h>
 #include <linux/seq_file.h>
 #include <linux/stacktrace.h>
 #include <linux/string.h>
@@ -36,7 +37,6 @@ static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries
 {
 	char buf[64];
 	int skipnr, fallback = 0;
-	bool is_access_fault = false;
 
 	if (type) {
 		/* Depending on error type, find different stack entries. */
@@ -44,8 +44,12 @@ static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries
 		case KFENCE_ERROR_UAF:
 		case KFENCE_ERROR_OOB:
 		case KFENCE_ERROR_INVALID:
-			is_access_fault = true;
-			break;
+			/*
+			 * kfence_handle_page_fault() may be called with pt_regs
+			 * set to NULL; in that case we'll simply show the full
+			 * stack trace.
+			 */
+			return 0;
 		case KFENCE_ERROR_CORRUPTION:
 		case KFENCE_ERROR_INVALID_FREE:
 			break;
@@ -55,26 +59,21 @@ static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries
 	for (skipnr = 0; skipnr < num_entries; skipnr++) {
 		int len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skipnr]);
 
-		if (is_access_fault) {
-			if (!strncmp(buf, KFENCE_SKIP_ARCH_FAULT_HANDLER, len))
-				goto found;
-		} else {
-			if (str_has_prefix(buf, "kfence_") || str_has_prefix(buf, "__kfence_") ||
-			    !strncmp(buf, "__slab_free", len)) {
-				/*
-				 * In case of tail calls from any of the below
-				 * to any of the above.
-				 */
-				fallback = skipnr + 1;
-			}
-
-			/* Also the *_bulk() variants by only checking prefixes. */
-			if (str_has_prefix(buf, "kfree") ||
-			    str_has_prefix(buf, "kmem_cache_free") ||
-			    str_has_prefix(buf, "__kmalloc") ||
-			    str_has_prefix(buf, "kmem_cache_alloc"))
-				goto found;
+		if (str_has_prefix(buf, "kfence_") || str_has_prefix(buf, "__kfence_") ||
+		    !strncmp(buf, "__slab_free", len)) {
+			/*
+			 * In case of tail calls from any of the below
+			 * to any of the above.
+			 */
+			fallback = skipnr + 1;
 		}
+
+		/* Also the *_bulk() variants by only checking prefixes. */
+		if (str_has_prefix(buf, "kfree") ||
+		    str_has_prefix(buf, "kmem_cache_free") ||
+		    str_has_prefix(buf, "__kmalloc") ||
+		    str_has_prefix(buf, "kmem_cache_alloc"))
+			goto found;
 	}
 	if (fallback < num_entries)
 		return fallback;
@@ -152,13 +151,20 @@ static void print_diff_canary(unsigned long address, size_t bytes_to_show,
 	pr_cont(" ]");
 }
 
-void kfence_report_error(unsigned long address, const struct kfence_metadata *meta,
-			 enum kfence_error_type type)
+void kfence_report_error(unsigned long address, struct pt_regs *regs,
+			 const struct kfence_metadata *meta, enum kfence_error_type type)
 {
 	unsigned long stack_entries[KFENCE_STACK_DEPTH] = { 0 };
-	int num_stack_entries = stack_trace_save(stack_entries, KFENCE_STACK_DEPTH, 1);
-	int skipnr = get_stack_skipnr(stack_entries, num_stack_entries, &type);
 	const ptrdiff_t object_index = meta ? meta - kfence_metadata : -1;
+	int num_stack_entries;
+	int skipnr = 0;
+
+	if (regs) {
+		num_stack_entries = stack_trace_save_regs(regs, stack_entries, KFENCE_STACK_DEPTH, 0);
+	} else {
+		num_stack_entries = stack_trace_save(stack_entries, KFENCE_STACK_DEPTH, 1);
+		skipnr = get_stack_skipnr(stack_entries, num_stack_entries, &type);
+	}
 
 	/* Require non-NULL meta, except if KFENCE_ERROR_INVALID. */
 	if (WARN_ON(type != KFENCE_ERROR_INVALID && !meta))
@@ -222,7 +228,10 @@ void kfence_report_error(unsigned long address, const struct kfence_metadata *me
 
 	/* Print report footer. */
 	pr_err("\n");
-	dump_stack_print_info(KERN_ERR);
+	if (IS_ENABLED(CONFIG_DEBUG_KERNEL) && regs)
+		show_regs(regs);
+	else
+		dump_stack_print_info(KERN_ERR);
 	pr_err("==================================================================\n");
 
 	lockdep_on();
-- 
2.29.1.341.ge80a0c044ae-goog

