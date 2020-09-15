Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE8526B01C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgIOWBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgIOV1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:27:52 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1F4C06178B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:16:56 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id i10so1705945wrq.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7yDwng4+Hj3dGnoK2YA+rQbDNoxu46t3AMw9ie+3lv0=;
        b=cyy2ohm5w6ggEbHNtfTyEPuLaPLW/r0sbYxz1pJiROpFFdODKk96Vv5nZGiCbAmxox
         uaF4I9gb5PcleAQxxYTgfSw4dKBlQ1jIM06fPnETtQ82McJ8++Rg4C8MKuJ03whix1K1
         bmAaZLjQYSxkpX0yQZc2/ajy2GuW1bMQ+n6UYo/GwpXvN+xmvGePfO6UXWUTKfi+So/v
         GJ5vLr67Mhy9RBtn7uZ2HCdyd0nf5XAsZCywwKYP9jfKgm+4vinlMhNN3oaMZUtsakYD
         o8bER/j0Xzed90ubZppJN+KpdH8VznlQmN6lK90xT0N/YPNCH5R7HSTlTChRvyF6FRX2
         4/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7yDwng4+Hj3dGnoK2YA+rQbDNoxu46t3AMw9ie+3lv0=;
        b=aUL0D5AEw1LH8eJyR59keBjL9Txhkcp2qRO8k35ot63CkjwBb4LJ3Za5YtDsiUiTps
         pTt+0oXAJs3bvWXCmWcbDJbnUlV74sLEyALtMgLEqLKkieAhKb9kvNsekYYH4SaSJsgy
         LKKnQIMMcsDEHvoILphzFNczTLoC9v4JeNUffHbGDx/Occfr+SstlMR42bBc8BA31DJL
         jIX/n9T3OOaPG7Px8nC8N0GVWbuwLLdvBdrewSeQ+UQb/LE4syTz4CqWsIDCgF5NhPXB
         GVE6ao3E3JR42OpClaThCHsvxeEk4tWhtJKWDQxgmyC8raGpW1AHFLHAG1vr46kjida2
         TQvw==
X-Gm-Message-State: AOAM532/qyRqjGDl+IUmwRpT1c5uva6FtumesY5DCrZ6osrRyVCfO04H
        3dglwbjIkTVGLD4DDsaHlKD22FxcdzeoJU80
X-Google-Smtp-Source: ABdhPJzTRyPDUOBFxI01fgHN2kmssDbF4Zb7r+npdVx5YvhJZ+SJU6VWf3cqQth+B2Mv2NIdDjznvYy/ahDUTD3H
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:e108:: with SMTP id
 y8mr1249357wmg.178.1600204614417; Tue, 15 Sep 2020 14:16:54 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:15:55 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <b83ab742bda81114249ef81870a6f30023192cf3.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 13/37] kasan, arm64: only use kasan_depth for software modes
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
Sender: linux-kernel-owner@vger.kernel.org
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
---
Change-Id: I6109ea96c8df41ef6d75ad71bf22c1c8fa234a9a
---
 arch/arm64/mm/kasan_init.c | 11 ++++++++---
 include/linux/kasan.h      | 14 ++++++++++----
 include/linux/sched.h      |  2 +-
 init/init_task.c           |  2 +-
 mm/kasan/common.c          |  2 ++
 mm/kasan/report.c          |  2 ++
 6 files changed, 24 insertions(+), 9 deletions(-)

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
index 18617d5c4cd7..894f4d9163ee 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -52,7 +52,7 @@ static inline void kasan_remove_zero_shadow(void *start,
 
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
 /* Enable reporting bugs after kasan_disable_current() */
 extern void kasan_enable_current(void);
@@ -60,6 +60,15 @@ extern void kasan_enable_current(void);
 /* Disable reporting bugs for current task */
 extern void kasan_disable_current(void);
 
+#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
+
+static inline void kasan_enable_current(void) {}
+static inline void kasan_disable_current(void) {}
+
+#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
+
+#ifdef CONFIG_KASAN
+
 void kasan_unpoison_memory(const void *address, size_t size);
 
 void kasan_unpoison_task_stack(struct task_struct *task);
@@ -110,9 +119,6 @@ static inline void kasan_unpoison_memory(const void *address, size_t size) {}
 
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
index a2321d35390e..41c7f1105eaa 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -51,6 +51,7 @@ void kasan_set_track(struct kasan_track *track, gfp_t flags)
 	track->stack = kasan_save_stack(flags);
 }
 
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 void kasan_enable_current(void)
 {
 	current->kasan_depth++;
@@ -60,6 +61,7 @@ void kasan_disable_current(void)
 {
 	current->kasan_depth--;
 }
+#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
 static void __kasan_unpoison_stack(struct task_struct *task, const void *sp)
 {
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index ddaf9d14ca81..8463e35b489f 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -295,8 +295,10 @@ static void print_shadow_for_address(const void *addr)
 
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
2.28.0.618.gf4bc123cb7-goog

