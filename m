Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601A02A712E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732723AbgKDXTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732706AbgKDXTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:19:46 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F10AC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:19:46 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id gx12so51860ejb.18
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tnERJLSQMkNYv5nCg28tzBY5cjIpAsRRs2aOHq8rTuk=;
        b=HyGuQZMpQk+CJ5S+nBSByMdy3x2m1S7l9um7C0ebvb3INVZhZZKGpnoPXDoDetTWde
         8isHTWfKQeUt0qNNTue0qTv2s0CtpxeE8h6Piz/qkZ1J4k+B9rL7qsTX3pR8NPns9vrJ
         xw6ljoZSJWR5FqTMuHrcTlTUg030KK6onV2uUy6NThLqymox3m1jZJIVYlAs57reDs7k
         HxfSk/EVditVRieaY4ecmSk2Ba1Qlp1U+kAOezEiBF+oa+V6/QSKw3XWW9tHpwmu/WL9
         QL/FxHTJ4EbH2PYB0I5vPG7HXYhiKYoIKcHoOKxWf5eWmgaIk1+wp1iH/y9ruIZ5gvbX
         3RQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tnERJLSQMkNYv5nCg28tzBY5cjIpAsRRs2aOHq8rTuk=;
        b=FauIX+rvOlx2Ko4N6EJ00UWpXmRDYn46mUmz5/oTEqvTknmowwEO/iyQ2/cmKDzUzk
         BLOoq2ONsD8VhQWQAM2G+krTcLc5552scqDvRDBMw2WkG3w4KOSa3XAbtbPXE+QhOmql
         KuHI/J2yc7Wxjr25oKYYBtsLbwqxVGCWhICeA5D0trf2k7WgMFScJ1dxTHBfhULGpUWp
         VZgBUYBvfW+zm/0uEFiQlKzjy85itNfjcosLgZr6Rzr7V1zAKraL4plibZcOJIjmBFCE
         sC/ZtPXL2qBIA8VzjbSZyI4hDeb/72D7PCBwfrp+dETYFHX99bAZ10OqSc7YiUvs5Oq8
         BZ9g==
X-Gm-Message-State: AOAM531lp735ImMylcKHKkHIxUyzusyX7Kz3uwTW+BlMDYofQVBWd147
        vucBJVLpK8Q3FBIF+IO3NNUI6IMzihWIT3/V
X-Google-Smtp-Source: ABdhPJxVtsuYBox3ePrSsEvjI1qOT6r/u+DFGn747FXEgRreZEaoaEtPTyLgL+L/uzTnkLFIpYzmx6+a1SIxGwR6
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a17:906:3acd:: with SMTP id
 z13mr472324ejd.118.1604531985052; Wed, 04 Nov 2020 15:19:45 -0800 (PST)
Date:   Thu,  5 Nov 2020 00:18:31 +0100
In-Reply-To: <cover.1604531793.git.andreyknvl@google.com>
Message-Id: <b55775c898f1dad5c5e03f29fb19cfb3a70d50c7.1604531793.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v8 16/43] kasan, arm64: only use kasan_depth for software modes
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

