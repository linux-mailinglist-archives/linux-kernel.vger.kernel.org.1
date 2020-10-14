Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438EB28E804
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 22:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388537AbgJNUo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 16:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388200AbgJNUoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 16:44:55 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB88C0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 13:44:55 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id l15so384667wmh.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 13:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Jb27DzgR4IKP5v5pwQruBqbER0RzES4crWan7oQ9jac=;
        b=uaQGYSwBpt8wEWnHpqu5ORNnmQNuhf0vqH2nDCmWhL7Hb/BuP7SQtbew7r53LyxTAn
         8Ys9HwjQxkJ38OfUhNru9hNfpD/qZpUqtozrR56elJD9Wd7NnDiCoQL9CVUxSudE3Y0y
         c7GGmYxMv5DmneuyUGjw4dQ9S9HliHUjI6V14BomxK3C6evHnAjZnHzepI7UoAqxXS6y
         cTYp2zxCyv+DtJZlY2VnT5iaHQO8kq+4EcDNsYk4T32OFhw4FdrpRuMUI+lnG0cyoOJY
         DmTfQI8qmiKn5UrvM4XzzBrbbNYa0tBLEekehS0HJArCVgVamwk619jUsJZwsHK4Ce04
         6n6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Jb27DzgR4IKP5v5pwQruBqbER0RzES4crWan7oQ9jac=;
        b=fxaWxp+q3RGylnYyvgRlq0SYBzGu4c0voknF6ZS030izsKoDQVssi+SZUbM0k/63sO
         48ikY0G/CuXWsyTfgD5Jki6TA2R3TaeSI35g+4nJDBQSqrDWj0DzjsHd6Ls5cGR12+VT
         H1chNNvJd3GohkeoKamTVoE3QRCEAPIM68LwAKI79wROxspEOEeE40jqUvrOz+DSgDae
         9WlyccIKjEAB5ydYhw/9VKaHS5B69+XiyrTZPcsKBU8VR0U/+xr3t8Sazlmuf/ymhoea
         Woh97RFg72/C+10FP5iLWEGhXXY++HsDg7Wkqb645ulvtgB+4kiaFJqoUpuMCkCSh8Y+
         4r+w==
X-Gm-Message-State: AOAM530FUEgnc46y1uXwahWF4TMKq0cE22/96lGUcimx/9JUrTvRPe0Z
        1yfMEy4494uipYKA9m+IqR9uFGRFv2/Dimm8
X-Google-Smtp-Source: ABdhPJzjCdz9j8/QTVwhuC5jK0ycsFa4Tde9e+psT+rJIXrn5DYLcJG2qqqtoaTvFbIZ8bfCtmYJAtJr9LorUzK6
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:3b8a:: with SMTP id
 i132mr609269wma.178.1602708294026; Wed, 14 Oct 2020 13:44:54 -0700 (PDT)
Date:   Wed, 14 Oct 2020 22:44:32 +0200
In-Reply-To: <cover.1602708025.git.andreyknvl@google.com>
Message-Id: <a84636e18c42929492dd05dd5e01128b36196852.1602708025.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH RFC 4/8] kasan: unpoison stack only with CONFIG_KASAN_STACK
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
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
index 3f3f541e5d5f..7be9fb9146ac 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -68,8 +68,6 @@ static inline void kasan_disable_current(void) {}
 
 void kasan_unpoison_memory(const void *address, size_t size);
 
-void kasan_unpoison_task_stack(struct task_struct *task);
-
 void kasan_alloc_pages(struct page *page, unsigned int order);
 void kasan_free_pages(struct page *page, unsigned int order);
 
@@ -114,8 +112,6 @@ void kasan_restore_multi_shot(bool enabled);
 
 static inline void kasan_unpoison_memory(const void *address, size_t size) {}
 
-static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
-
 static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
 static inline void kasan_free_pages(struct page *page, unsigned int order) {}
 
@@ -167,6 +163,12 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
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
2.28.0.1011.ga647a8990f-goog

