Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEB129F528
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgJ2T2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgJ2T1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:27:08 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514C5C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:27:07 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id b23so303100wmj.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=oI/HbLx6/V9Mgdsl45doZaYB4b1VS6zKA72TKwwbKIw=;
        b=JIIuHmSb8Zt7WBQJyCrMArWrki/niVacUm63sKgimEhHoU8mQn9GWxJ4w4UZx4RpFw
         pMeIaPMaJEETlG52pbiQ6lUGasxv2itQqiQG3zpIJ94gxCxSPiLqPYJ/C3wSqfjDbKqa
         nRco8sQxisfRkLS6JnwspHtU02zN4PpXRacD44+eHaxXhsQarva5RyR+KUb7zetqy11G
         xJn5MYWkN6rHJPCUSrPXs0xhzsYwyDmI5wWd0UwdBvU2TrOlLrSyxbnQaqrXAmVlT/Wr
         wuq6L9l/zTgfGB4qaVY2ejS8smNMdc7oFHTmHuwScWNj0xhNyRf9QJNDHg8lV4MxGael
         A2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oI/HbLx6/V9Mgdsl45doZaYB4b1VS6zKA72TKwwbKIw=;
        b=nQ/ydVzMD4sB77hgc390vvw7zAxbxH6fxsl86UET/E5ZzK8dWDOXAgXKS20bDgF6cJ
         HNMMjGO8/nDmzy1tdmt4wXIxHVUB529Ir9nIcJrvVOiw4op06d99ZkreMXs720ePoORa
         eIpewPiPsT2qn1+wTS4SMcbxgf297TGwFIL1aUvk3PvM7zhg80ezR9obrUQFoFn0K2qu
         lZ0/QaT0sxzuUEaGFxHoN7liYbiiYAjzhizPneU2JLgnSYRkVRWkhvQqM3FHPwwqDOy6
         XCRW8BnOMBr2hPfmPKIi+Au1uasLid5bfgS8t6VKagR+n7rucp2VzOmvOoML2m5lJN7Z
         MgNA==
X-Gm-Message-State: AOAM533h/fIl4Yqs4DHV8fyZUWepbs5rFX1bDDBbp51fIUBt6MFpywks
        aovTOC+2tNxcozbDUCkzL+MRKphDmFo++1A3
X-Google-Smtp-Source: ABdhPJyIw7Vqk/FDzoTj75xIw3DeJogNIkP+Z0f/Iwx/QHEhHMDr7Xkdr8TNA06BxPdwwrvWITuCEmdq/ZFHYzDe
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:2dc4:: with SMTP id
 t187mr417857wmt.53.1603999625934; Thu, 29 Oct 2020 12:27:05 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:25:45 +0100
In-Reply-To: <cover.1603999489.git.andreyknvl@google.com>
Message-Id: <0a56e9333c945e928c9a20c70451bcf818c4c60d.1603999489.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603999489.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 24/40] kasan, arm64: only use kasan_depth for software modes
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

Hardware tag-based KASAN won't use kasan_depth. Only define and use it
when one of the software KASAN modes are enabled.

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
Change-Id: I6109ea96c8df41ef6d75ad71bf22c1c8fa234a9a
---
 arch/arm64/mm/kasan_init.c | 11 ++++++++---
 include/linux/kasan.h      | 18 +++++++++---------
 include/linux/sched.h      |  2 +-
 init/init_task.c           |  2 +-
 mm/kasan/common.c          |  2 ++
 mm/kasan/report.c          |  2 ++
 6 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index ffeb80d5aa8d..69c692b58f23 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -273,17 +273,22 @@ static void __init kasan_init_shadow(void)
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 }
 
+void __init kasan_init_depth(void)
+{
+	init_task.kasan_depth = 0;
+}
+
 #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) */
 
 static inline void __init kasan_init_shadow(void) { }
 
+static inline void __init kasan_init_depth(void) { }
+
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
 void __init kasan_init(void)
 {
 	kasan_init_shadow();
-
-	/* At this point kasan is fully initialized. Enable error messages */
-	init_task.kasan_depth = 0;
+	kasan_init_depth();
 	pr_info("KernelAddressSanitizer initialized\n");
 }
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index bfb21d5fd279..8d3d3c21340d 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -49,6 +49,12 @@ static inline void *kasan_mem_to_shadow(const void *addr)
 int kasan_add_zero_shadow(void *start, unsigned long size);
 void kasan_remove_zero_shadow(void *start, unsigned long size);
 
+/* Enable reporting bugs after kasan_disable_current() */
+extern void kasan_enable_current(void);
+
+/* Disable reporting bugs for current task */
+extern void kasan_disable_current(void);
+
 #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
 static inline int kasan_add_zero_shadow(void *start, unsigned long size)
@@ -59,16 +65,13 @@ static inline void kasan_remove_zero_shadow(void *start,
 					unsigned long size)
 {}
 
+static inline void kasan_enable_current(void) {}
+static inline void kasan_disable_current(void) {}
+
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
 #ifdef CONFIG_KASAN
 
-/* Enable reporting bugs after kasan_disable_current() */
-extern void kasan_enable_current(void);
-
-/* Disable reporting bugs for current task */
-extern void kasan_disable_current(void);
-
 void kasan_unpoison_memory(const void *address, size_t size);
 
 void kasan_unpoison_task_stack(struct task_struct *task);
@@ -119,9 +122,6 @@ static inline void kasan_unpoison_memory(const void *address, size_t size) {}
 
 static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
 
-static inline void kasan_enable_current(void) {}
-static inline void kasan_disable_current(void) {}
-
 static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
 static inline void kasan_free_pages(struct page *page, unsigned int order) {}
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 063cd120b459..81b09bd31186 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1197,7 +1197,7 @@ struct task_struct {
 	u64				timer_slack_ns;
 	u64				default_timer_slack_ns;
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	unsigned int			kasan_depth;
 #endif
 
diff --git a/init/init_task.c b/init/init_task.c
index a56f0abb63e9..39703b4ef1f1 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -176,7 +176,7 @@ struct task_struct init_task
 	.numa_group	= NULL,
 	.numa_faults	= NULL,
 #endif
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	.kasan_depth	= 1,
 #endif
 #ifdef CONFIG_KCSAN
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 543e6bf2168f..d0b3ff410b0c 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -46,6 +46,7 @@ void kasan_set_track(struct kasan_track *track, gfp_t flags)
 	track->stack = kasan_save_stack(flags);
 }
 
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 void kasan_enable_current(void)
 {
 	current->kasan_depth++;
@@ -55,6 +56,7 @@ void kasan_disable_current(void)
 {
 	current->kasan_depth--;
 }
+#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
 static void __kasan_unpoison_stack(struct task_struct *task, const void *sp)
 {
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index b18d193f7f58..af9138ea54ad 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -292,8 +292,10 @@ static void print_shadow_for_address(const void *addr)
 
 static bool report_enabled(void)
 {
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	if (current->kasan_depth)
 		return false;
+#endif
 	if (test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags))
 		return true;
 	return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
-- 
2.29.1.341.ge80a0c044ae-goog

