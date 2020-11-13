Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5950B2B2876
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgKMWWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgKMWUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:20:25 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A422CC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:25 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id x85so7614123qka.14
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=u0fQxCBxmUxhMOfySImDDJJwP6bRFOpgmkJnBahaSB0=;
        b=r1t8fKl4uuOcWcbL/ueqRvVuuGcEPqzKT8WznSgyrrTLeFP98TCZYmgIsxP7hJRUIL
         UA2CQ6RqwhXxL5pbj5UZBnxHKj7OqZYU4/ykEQ2vFSNoEairvQ5DffreXNn7ZA2OblFy
         QESP9jI3hM9x5J9EegrsAz0SQtx2s5rUZfj8PzVPUbblnIVhT9ZUQxrQqGv9gkaVNgN4
         FoHyoW9HuPpwVeg7Pseve3oFgp2LEz2IWTH0SpHtt2ViCmh+xEMyYIdlpbP6QcyHVd4l
         Q3Oork8GgswLd4lgBz2p5tzr6rmuu2fvDobA96l+nwV1GonWfuKd/exDswWmQ0+mJ1rw
         1u+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u0fQxCBxmUxhMOfySImDDJJwP6bRFOpgmkJnBahaSB0=;
        b=TxJUD8v97JGPMAbWj3VXNb2eVqe5mEu7x3U03b5wZtCLswFczmTkoimG0+iORs+bWM
         UMm2+iqTVIxxEP9JeA7rVYZG90stsYMCT7X7WJI0dineekBRlwUKvQXX9EBcSezq5WbM
         M7y6CX6Z8FSaQXXtNf/Nocy1qvDdMZTr+UvNR4yPmSxd7PTDjmKq0iR1weOO2+d7fVhJ
         6JsO/qxDSFd+Kv4tg9KQaqiGCOhRUzHGsWMbK0DlgGXIc//VNiBDwGzKsmWYGGP7tvTS
         aK1AAX7KOyZE7wRGTSvPJdPNPjVroyg5AiskkH5pAywYrSpchedBiyGBbbTCM2GE9SGS
         x8Ew==
X-Gm-Message-State: AOAM531ooAlUgAQ5lEqYa7sPKAkwGV0M3RBnjPxk0GQEINgtwRau/AWt
        7lvV4CPwTI399Cmk7qFWk0suIJaJncgB0z3i
X-Google-Smtp-Source: ABdhPJzDRObTBajDl9iT1PbNpJcek6LGpoJ9nw4zlOW0zvL70FxU0UTFPIEWguVxCkQFV3wqiBJkCh4vS4JR1wzJ
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:f9c8:: with SMTP id
 j8mr4873782qvo.17.1605306024802; Fri, 13 Nov 2020 14:20:24 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:19:54 +0100
In-Reply-To: <cover.1605305978.git.andreyknvl@google.com>
Message-Id: <d65e2fc1d7fc03b7ced67e401ff1ea9143b3382d.1605305978.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v3 04/19] kasan, arm64: unpoison stack only with CONFIG_KASAN_STACK
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

There's a config option CONFIG_KASAN_STACK that has to be enabled for
KASAN to use stack instrumentation and perform validity checks for
stack variables.

There's no need to unpoison stack when CONFIG_KASAN_STACK is not enabled.
Only call kasan_unpoison_task_stack[_below]() when CONFIG_KASAN_STACK is
enabled.

Note, that CONFIG_KASAN_STACK is an option that is currently always
defined when CONFIG_KASAN is enabled, and therefore has to be tested
with #if instead of #ifdef.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://linux-review.googlesource.com/id/If8a891e9fe01ea543e00b576852685afec0887e3
---
 arch/arm64/kernel/sleep.S        |  2 +-
 arch/x86/kernel/acpi/wakeup_64.S |  2 +-
 include/linux/kasan.h            | 10 ++++++----
 mm/kasan/common.c                |  2 ++
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index ba40d57757d6..bdadfa56b40e 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -133,7 +133,7 @@ SYM_FUNC_START(_cpu_resume)
 	 */
 	bl	cpu_do_resume
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
 	mov	x0, sp
 	bl	kasan_unpoison_task_stack_below
 #endif
diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index c8daa92f38dc..5d3a0b8fd379 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -112,7 +112,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
 	movq	pt_regs_r14(%rax), %r14
 	movq	pt_regs_r15(%rax), %r15
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
 	/*
 	 * The suspend path may have poisoned some areas deeper in the stack,
 	 * which we now need to unpoison.
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 0c89e6fdd29e..f2109bf0c5f9 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -76,8 +76,6 @@ static inline void kasan_disable_current(void) {}
 
 void kasan_unpoison_range(const void *address, size_t size);
 
-void kasan_unpoison_task_stack(struct task_struct *task);
-
 void kasan_alloc_pages(struct page *page, unsigned int order);
 void kasan_free_pages(struct page *page, unsigned int order);
 
@@ -122,8 +120,6 @@ void kasan_restore_multi_shot(bool enabled);
 
 static inline void kasan_unpoison_range(const void *address, size_t size) {}
 
-static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
-
 static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
 static inline void kasan_free_pages(struct page *page, unsigned int order) {}
 
@@ -175,6 +171,12 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
 #endif /* CONFIG_KASAN */
 
+#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
+void kasan_unpoison_task_stack(struct task_struct *task);
+#else
+static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
+#endif
+
 #ifdef CONFIG_KASAN_GENERIC
 
 void kasan_cache_shrink(struct kmem_cache *cache);
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 0a420f1dbc54..7648a2452a01 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -64,6 +64,7 @@ void kasan_unpoison_range(const void *address, size_t size)
 	unpoison_range(address, size);
 }
 
+#if CONFIG_KASAN_STACK
 static void __kasan_unpoison_stack(struct task_struct *task, const void *sp)
 {
 	void *base = task_stack_page(task);
@@ -90,6 +91,7 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
 
 	unpoison_range(base, watermark - base);
 }
+#endif /* CONFIG_KASAN_STACK */
 
 void kasan_alloc_pages(struct page *page, unsigned int order)
 {
-- 
2.29.2.299.gdc1121823c-goog

