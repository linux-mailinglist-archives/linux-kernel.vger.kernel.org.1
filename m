Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C342AE32A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbgKJWUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732143AbgKJWUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:20:39 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31613C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:20:39 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id m15so82545qvx.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tEdtRhABI1InYFpD5ltmIm/evviW/mtmaENcJYt1lmc=;
        b=Lw7P323OF/2i72kWQuJ4l8inThWAnZLsOW9ThJ12RKxjoJxpzU7FXD1KV+6+q4wFpg
         l/r4+g+lNCXzgzXgK1lygyyUKCtzwpfHl/3OlTnMhhMRfVDtB2PdYon8ei3bzhD2Vqtt
         Wo3uUi7dX96xLBACxd53V6ueiGeSZymzkpvnmaVcbe+7AHrMitDwaS52oyIZ68DrTouD
         k4aflKbowlt0EK7lot+JEbexzRr4RzOeeQC1v96jGdm7Fx8vBNCN0QhyaFYecRjubCKf
         y4BPPQEw0TRxyeg4FETviyB1G271O7T0w4aKkUqb+DvRw5ABtXAGXbngmp+oaS/px1Mw
         omsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tEdtRhABI1InYFpD5ltmIm/evviW/mtmaENcJYt1lmc=;
        b=juYCs+9JJy124C3RIdJ0xxD+xA45T3/Yfb9RSH0y6XEYF6jOfPbB/yQNPUeckVi7Os
         142vzcWJ78Bcjt4+NohxDepEEG8n+Yto1qk0EmPME/cz48ApF1RLeDxMgHXSRK91LOuY
         mHq1a0j6mKvX7+6Q6cx4LqH3c2LlmIng1AiGEihYydn/14lpz8cRdOeTk4GgZx/rWIho
         9MIq0kswOY5X94gTrL51JI7eWVCvonePhmYiGob/J6NXa4Qk34c0/+mMPCfiSAtY1g75
         7r7nQOBisMlTYX32bGVUBmYQI5cdWGaaz/Nyg5PfOJXtvWnYj3V5qPZoP6WFEKm1ZqTP
         k73g==
X-Gm-Message-State: AOAM531gJj3o5N+6I1gU5dpoTRfn1YmWrAF6Rke70oZLGuM2aWyxyBhO
        TpboFSRV4gej00HciOga9aY9GvoKYSbWKmSh
X-Google-Smtp-Source: ABdhPJxqgq6UfWHyoMS9rSSpgTD3+0B/UNYGVxM4mfhk/kYijiMY8uMFuj8WQnHSvWCojmtQAUsNukGtycyjiBdC
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:6a7:: with SMTP id
 s7mr22500256qvz.2.1605046838323; Tue, 10 Nov 2020 14:20:38 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:20:08 +0100
In-Reply-To: <cover.1605046662.git.andreyknvl@google.com>
Message-Id: <7e95d4739f5617b2c1acf52f37e01f1ca83750b5.1605046662.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v2 04/20] kasan, arm64: unpoison stack only with CONFIG_KASAN_STACK
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
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
index f22bdef82111..b9b9db335d87 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -76,8 +76,6 @@ static inline void kasan_disable_current(void) {}
 
 void kasan_unpoison_memory(const void *address, size_t size);
 
-void kasan_unpoison_task_stack(struct task_struct *task);
-
 void kasan_alloc_pages(struct page *page, unsigned int order);
 void kasan_free_pages(struct page *page, unsigned int order);
 
@@ -122,8 +120,6 @@ void kasan_restore_multi_shot(bool enabled);
 
 static inline void kasan_unpoison_memory(const void *address, size_t size) {}
 
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
2.29.2.222.g5d2a92d10f8-goog

