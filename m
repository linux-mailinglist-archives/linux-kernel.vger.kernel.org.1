Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E9C2A7372
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733148AbgKEACr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgKEACq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:02:46 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2223C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 16:02:45 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id x10so30904qvo.22
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 16:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=75cYXImCPyiWQ9SKzSdNGkBAnxoIkaWvKX26xtnhUe0=;
        b=PRQZtB1dufXLPUzgGaqIbaWhMXmesRjAadeDWIt74dEP8Lfsgm2ryEy6s7q8fzmlIV
         IWJOdm09vXFCNhnpM8EQA7rqqWqjMR9RQQq+tdXuXK3ckY+h7vf59jeSgqtX019vBSLK
         j8ygqaBGulNwu0YsR9bBAAvVI10PL05Y3wtvXuXQxic2EsEZyEkhcax1ETvG7h0+ymCX
         e50LJMX71RYCnHJ+gYJyjhKhP+EGhLi7Hl2CmIlnTEpAV9+5QzbT4cIQ3P6MRc7P6q8P
         Mm3sjdpxfFKeB/L9pqme/H+/pNL5HjbpvJH5LX3yE30dm0HKjUCMmqsnucEmfIgriAJ6
         xrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=75cYXImCPyiWQ9SKzSdNGkBAnxoIkaWvKX26xtnhUe0=;
        b=TogUeShW4Q4ODE8slYaKDIHT5CViLsSul4Qontk/+4B+HU4l/R+vtQ0xVEILvWuf+/
         7pVI2ZOjmocn/fiIS5pYUmvdE0DzTuNZLJJIv39e66sXMPLIKpvEgKiZETwLvWzMMCCr
         lCagrgb8HxYJyWACktA0/+Oe+AyFR09s/4JfnwTgg+J/sanb8HG2/Zix+/l7tWdX8gX9
         CY8IJ+xIORgLFmZHutGmkepungo7Z5kiyZXPESxnSDe3uTw8w09kAysYoxWiCpckVT8i
         +dI216iOFIgsEDtgW6NubV21hWXUyICD0utPysxPBmdib6kA8wZqjrFNPqaC3q9i+mty
         DLIg==
X-Gm-Message-State: AOAM530TQNNksDlivv9aatvLQvasjOcVzZ0M7XPuM2KXhcs80oNl6OXT
        PV3bcSKoYPCDnqtan5La/Uc1mgieDO7CQcOa
X-Google-Smtp-Source: ABdhPJw7NtC8X2ma+DihzOyHxYwzEo/bH3H1mERPSZkcC0cm1czCOnJJGd/mJicu4ukRtxMsLfXt8UL78l7IEHSt
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4443:: with SMTP id
 l3mr356156qvt.53.1604534564913; Wed, 04 Nov 2020 16:02:44 -0800 (PST)
Date:   Thu,  5 Nov 2020 01:02:14 +0100
In-Reply-To: <cover.1604534322.git.andreyknvl@google.com>
Message-Id: <16e48c6ca3f6ea0cb80d3555723a723bef85270d.1604534322.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604534322.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 04/20] kasan, arm64: unpoison stack only with CONFIG_KASAN_STACK
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
index 42a556c5d67c..2c37a39b76ed 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -74,8 +74,6 @@ static inline void kasan_disable_current(void) {}
 
 void kasan_unpoison_memory(const void *address, size_t size);
 
-void kasan_unpoison_task_stack(struct task_struct *task);
-
 void kasan_alloc_pages(struct page *page, unsigned int order);
 void kasan_free_pages(struct page *page, unsigned int order);
 
@@ -120,8 +118,6 @@ void kasan_restore_multi_shot(bool enabled);
 
 static inline void kasan_unpoison_memory(const void *address, size_t size) {}
 
-static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
-
 static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
 static inline void kasan_free_pages(struct page *page, unsigned int order) {}
 
@@ -173,6 +169,12 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
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
index a880e5a547ed..a3e67d49b893 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -58,6 +58,7 @@ void kasan_disable_current(void)
 }
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
+#if CONFIG_KASAN_STACK
 static void __kasan_unpoison_stack(struct task_struct *task, const void *sp)
 {
 	void *base = task_stack_page(task);
@@ -84,6 +85,7 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
 
 	kasan_unpoison_memory(base, watermark - base);
 }
+#endif /* CONFIG_KASAN_STACK */
 
 void kasan_alloc_pages(struct page *page, unsigned int order)
 {
-- 
2.29.1.341.ge80a0c044ae-goog

