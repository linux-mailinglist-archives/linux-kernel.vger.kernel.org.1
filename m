Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E092AE2CE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732592AbgKJWL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732485AbgKJWLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:11:46 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC526C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:45 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id v5so6229669wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=LK+ho829pHfUNxMsQpfFeZONsS3mumkNxCYvKzzjGVY=;
        b=Iu8mOEF+Li9wr5hKAd+tC0Mwca6uicD2b8KPgwTOydhUrA3B4aOlCl4MuBGmr5BvKP
         /UUvYx9LID/p6iPDXMv7qnWWabdkwfj+e+lMaUOpWxpNe1JoisxTBJgoHQALnnnR20Xv
         mRM9/hm+v9v5Qe40llhqaEAyJeaVz+IndNysIoUEPXZv5LTeEIPXtfmSEmReS3MYC/vc
         +oSRgyD+g4km4bb+mvn+cyMWJGqEBJfWkmkCFcX+73SOZ3GIG+SOVvVreCQfSloA7VbD
         LK1ozVQ+YcOVFThdLtwWbxcyX0QAVZWBzpsnURXP2Tw/vb7dn5clPxfj6N2ldpF+lxLR
         b8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LK+ho829pHfUNxMsQpfFeZONsS3mumkNxCYvKzzjGVY=;
        b=oazdAPyemf4/vxl+9XGLW4OUqyeIrKcu04VEoVQV0D1NIQZrW7jegDxFFW47jPbngL
         n6hXWXZU//qXWMoRRA1zwCheeROTSuav53bhjaqPG3R2qq8VrAT+odyNu124befOz6QC
         d9zYe2EJiN7iKolCDVftck8t/vS1MGGeYqrw52mUAAv1S2qa5p+82RhuecsxYNVMOIr+
         T8rISo3ZM63C0vz7raFmH43cbjQTw3xph8GQ6uqNYIyV5GSIi6B50dNf+mg/3OQ0S+kz
         75QDLLU4KCkd/4A2s+PJaExZSjoMhhLHjQvEIdgOKsURU157RwaZor1kPD8RYLU+uzhZ
         LIYw==
X-Gm-Message-State: AOAM532UWFS2cFDBTy/Zw9Pc8KYF85s865FiDqryMTImR3YH617p/lZQ
        mQEWJy6EdHHLfAqn7/7IcKYeFVO2oHnCPnGB
X-Google-Smtp-Source: ABdhPJzef0gbAHZj8RghJAAJMQiMzdnzsNe+ZmY4MQP/bt6+y3z+ulRgrVIQmKUJY1NZpXA/nMBKFSwf+beC9FzD
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:3c84:: with SMTP id
 j126mr226389wma.151.1605046304637; Tue, 10 Nov 2020 14:11:44 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:10:13 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <91b3defa17748a61d1432929a80890043ca8dcda.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 16/44] kasan, arm64: only use kasan_depth for software modes
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
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
index ffeb80d5aa8d..5172799f831f 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -273,17 +273,22 @@ static void __init kasan_init_shadow(void)
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 }
 
+static void __init kasan_init_depth(void)
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
index f6435b9f889c..979d598e1c30 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -51,6 +51,12 @@ static inline void *kasan_mem_to_shadow(const void *addr)
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
@@ -61,16 +67,13 @@ static inline void kasan_remove_zero_shadow(void *start,
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
@@ -121,9 +124,6 @@ static inline void kasan_unpoison_memory(const void *address, size_t size) {}
 
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
2.29.2.222.g5d2a92d10f8-goog

