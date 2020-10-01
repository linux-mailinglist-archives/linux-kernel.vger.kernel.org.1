Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D95F280B10
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387554AbgJAXLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387417AbgJAXLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:11:24 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6223AC0613E5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:11:22 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id l1so175178edv.14
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=92IUkL/SNCDmD7qK6l96e97eKQ8ygsmQO8JGCSzDuVY=;
        b=roiIrwI2c7jtBrIEIJbW5Xb1YawXgQz1fXDeWiGoj0T1eC50vljEcDokL8hV5gZfjV
         baCxciaCJHZlf3Mw8qYYTQwVpgD6uXumo7GrQi+Mn89i0lT2epckJ8xiwAqq4tb2Ofb2
         PkDwH1bmZOkjXv3GXZR4qwM0IsZAuZzJST7x41Nwe6b8ZoFIT2W0DkbNgF66rY4z1GS0
         DO8rNYk+HY4W0gmsZpkdV1a2z9fiPdrf4AQexw3hZTGupNbVJBb/Fo1P1YD+HnVijzTY
         Wcv3zilVxRxcX+uoR0h2Muf73vkSuMDk2vqx5nJvMYVVydmQ+JEmM05te6Rtuwv7Rmav
         wBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=92IUkL/SNCDmD7qK6l96e97eKQ8ygsmQO8JGCSzDuVY=;
        b=ts6zn3K6kIe9ddyXP1r7szIrRddiR6r85lpK3aFUR4OTCWuhb2mV9/6u9SNSFEBDC2
         fnCQVkK5ViFRJaDd+qWJYANo3WeoDuJZM0A1fdHGRD2BEgkCLxE9EKjj+WQpKr55r6QJ
         P41V2B25rktimNUagvqqDD/UPG4/YVkBYDwZjehZD/t4gThwsOi7YLBA+/YzJ6vXrJBS
         bLeS1DGSnBAqJ4XbY2FeIBrRB/lio3cufRXfub4Nf9AlpXRw0NNlHfWrU3xRZ7scWXql
         NWwNyCwuXDyVFjjTNT28OsoZAWDFoVLIp/SvSHuEfRooPXNuO+9gGWXDCFLOOfCTXxpp
         ut0A==
X-Gm-Message-State: AOAM530hkLUZFXtUNLZpNua09bexmJypN+QE3wFcYO8VfSYhBS8MHZI5
        Zst6R8YkgfcT9IEbPKtF+B0D5m3c43brDnWo
X-Google-Smtp-Source: ABdhPJzqrqKFcyxXzLyAR9lR5JQhN705nd0jUDVupCenXiX7io1yaFPuGvMb/TPin43dB+UL9lWlFAJFca4lq3NQ
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:aa7:cb8f:: with SMTP id
 r15mr11051920edt.356.1601593880984; Thu, 01 Oct 2020 16:11:20 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:16 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <6998b1dc79eb19f6d95dee449319865bf396199d.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 15/39] kasan, arm64: only use kasan_depth for software modes
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
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
index 4d35eaf3ec97..b6b9d55bb72e 100644
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
index c07175e6ad76..2dadaf2be6d2 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -43,6 +43,12 @@ static inline void *kasan_mem_to_shadow(const void *addr)
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
@@ -53,16 +59,13 @@ static inline void kasan_remove_zero_shadow(void *start,
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
@@ -113,9 +116,6 @@ static inline void kasan_unpoison_memory(const void *address, size_t size) {}
 
 static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
 
-static inline void kasan_enable_current(void) {}
-static inline void kasan_disable_current(void) {}
-
 static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
 static inline void kasan_free_pages(struct page *page, unsigned int order) {}
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index afe01e232935..db38b7ecf46d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1192,7 +1192,7 @@ struct task_struct {
 	u64				timer_slack_ns;
 	u64				default_timer_slack_ns;
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	unsigned int			kasan_depth;
 #endif
 
diff --git a/init/init_task.c b/init/init_task.c
index f6889fce64af..b93078f1708b 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -173,7 +173,7 @@ struct task_struct init_task
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
index f28eec5acdf6..91b869673148 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -290,8 +290,10 @@ static void print_shadow_for_address(const void *addr)
 
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
2.28.0.709.gb0816b6eb0-goog

