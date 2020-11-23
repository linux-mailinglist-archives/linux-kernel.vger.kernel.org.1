Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27262C1646
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbgKWUPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731687AbgKWUPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:15:04 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7355FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:15:04 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id n19so319488wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=+fKBF8tk63anOpwt8A+LLR3Qf9R2P9gh2kXJ7NwYZig=;
        b=SgzwKhZ3R7W8sEp5bQojT95yPgII8yrnXK5PJm+8HBvCo7ZvvLUdSItbJK1GypiV78
         xMXJN2ddUn+Rv5nTs1g2AGrivz1eSBhSPLPPA0QfNA5m8rvl5htFaDg+0OiuZ7J/Z4dS
         pBPZAOVwDwTyJETT3lYeHe/k41kbPwac0mKH7x+6K9Awsno7hCRm9BB3ODF4CwyYxbBb
         G/yNMKKAjoXIdmarVhQ6zhe2BlfpgbEKX1VJckdMF2Vp3Qmqjp1x2TA8rHeXavGGXT3o
         pguxCy6HrmCIuVEzT6REGnEXnVZH6DRhHApxMhlMXIOz6uRXZ/7IANmJlnuv3lgicWs2
         YVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+fKBF8tk63anOpwt8A+LLR3Qf9R2P9gh2kXJ7NwYZig=;
        b=RwwnZyo2TySJnBZe2aKGFG55VTs8iHryZUvoSubMqClXqjumNZ3nOl2xHUNda6EoBl
         TkpiBGblcUktD3eLMMlEuZuFL8SLF9DEXbWuV3DFa/lt02Vm+94xvaGkJY1qgM53GT8W
         /j7JNWNgyAhGuSKuzEkqg/PMfwVLUIj0wgRbmanyboQ7Cw7vSHJ4afJ2nCkiEmqo0QzF
         L3Rgso1BIk39Ffloe6wfYXUvEWz9K+1ad6o4/hAFtEVCcQ4h9+v3S43/7l0RWFqvCneb
         s+n9+M7zgNsN6IRpWa9m5uYnj6LAzGZnnrBKOBXqNOGDT9QSEKcv8hM6WPEk4cxr3F7b
         goEA==
X-Gm-Message-State: AOAM533SByBMzrdYm1zXSIU10/3Z+1iPez8s4Ougxjxe0juSwQ/yRX48
        tqWGuJxSGqpT4OC9m6Q0dqge2Z2Rc9Ir49wO
X-Google-Smtp-Source: ABdhPJy/rTCKa1eqa4mc4yEePlJFS2fAIHVEaaW/JgmCKkRtM+WiCe9SRu9w0wLP/xG8lUZlsreU6FcBRJ22hAo7
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:ce:: with SMTP id
 u14mr639471wmm.150.1606162503128; Mon, 23 Nov 2020 12:15:03 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:14:34 +0100
In-Reply-To: <cover.1606162397.git.andreyknvl@google.com>
Message-Id: <d09dd3f8abb388da397fd11598c5edeaa83fe559.1606162397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606162397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v4 04/19] kasan, arm64: unpoison stack only with CONFIG_KASAN_STACK
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
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
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
2.29.2.454.gaff20da3a2-goog

