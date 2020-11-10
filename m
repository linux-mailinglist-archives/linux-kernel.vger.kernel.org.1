Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DE12AE2CD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732557AbgKJWLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732541AbgKJWLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:11:50 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB0CC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:48 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id c8so1160276wrh.16
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IoTt6hT7gjXNpuAqI7B1fpPr1ifOz5U3TNuE4drki+I=;
        b=IQSSQ/5EvtXOsAvA0C4gkWpk8iXWU9aT3frgkKOn9n43N1HbrXin9vh+pzPIB1/ava
         bvVxJDr0s4FNZM+rtEtbMO1C14wCfbs7vpGUkRxBhDH8MgmyJhnyxPjseaiUbL4nQWlH
         /AFMTOuKXmAU6Nw1T6lombpIsqsS2b3spIy/Q3IIJruxk1+PrXzIlwAmwArSVjKfC6nY
         oQbQoOAe6MiOhBAZRa7iW/NS3vA/tv5MbyZxwEujKb7Q3dOnQhEUbYR1kvnb9vBQ7nmS
         ZbOV37+rKxzlfGgVlloORrL/4LtZm0TBIEC1J1HWdieWQv9Nwav+DZPMoA/rJJZ04iI5
         zuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IoTt6hT7gjXNpuAqI7B1fpPr1ifOz5U3TNuE4drki+I=;
        b=OGihZzmVrkhTtLOlBtmZgm4rSS4q29y2jC4D8oYP+fxJEQua6aNmW+5B9znI4StdDe
         oFMdyo/s4xNSwF51hV6Fw7FZfL5/0KcLUnosWN5dTAx2vfEe4wwy5yZr18yLR2qBVIqK
         VHSOp9J5bUGeEfHLRjl/iArxMYl+zPCdOqsxa/bmf51cBfcK55mD4bhPGsU7IKwIZZur
         HZZ6jvJLb2ifC8njYVVXPrh6+BZ5/jElOe5tufgrgOg56IOQT5HvLr8OlkL3FZ8OyXIa
         +8OU4PXZFox++CH5byERFHtCwSBJiBqfwvjPHnCQeb9UIB+QPgzlwrDq73A1KX5a1rkY
         GvNg==
X-Gm-Message-State: AOAM531a+ONXQQtt9uOLuFm0iUHQ9J+fb4fkXBs0684tdADJ7u9JlMgX
        6xLXnh0ISBrT8c8PpMSfZ8H2DuO+BI0FJWtA
X-Google-Smtp-Source: ABdhPJxlyTfY00I9Cm6jRHzeHsN65kONp0z7f8pA/CcTE+RdvC5javSmbyoyRnujM9tyakI7PvL3qJSZ8WPmwtc0
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:7219:: with SMTP id
 n25mr232465wmc.61.1605046307132; Tue, 10 Nov 2020 14:11:47 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:10:14 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <619cb0edad35d946c4796976c25bddb5b3eb0c56.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 17/44] kasan, arm64: move initialization message
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

Software tag-based KASAN mode is fully initialized with kasan_init_tags(),
while the generic mode only requires kasan_init(). Move the
initialization message for tag-based mode into kasan_init_tags().

Also fix pr_fmt() usage for KASAN code: generic.c doesn't need it as it
doesn't use any printing functions; tag-based mode should use "kasan:"
instead of KBUILD_MODNAME (which stands for file name).

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
Change-Id: Iddca9764b30ff0fab1922f26ca9d4f39b6f22673
---
 arch/arm64/include/asm/kasan.h |  9 +++------
 arch/arm64/mm/kasan_init.c     | 13 +++++--------
 mm/kasan/generic.c             |  2 --
 mm/kasan/sw_tags.c             |  4 +++-
 4 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
index f7ea70d02cab..0aaf9044cd6a 100644
--- a/arch/arm64/include/asm/kasan.h
+++ b/arch/arm64/include/asm/kasan.h
@@ -12,14 +12,10 @@
 #define arch_kasan_reset_tag(addr)	__tag_reset(addr)
 #define arch_kasan_get_tag(addr)	__tag_get(addr)
 
-#ifdef CONFIG_KASAN
-void kasan_init(void);
-#else
-static inline void kasan_init(void) { }
-#endif
-
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
+void kasan_init(void);
+
 /*
  * KASAN_SHADOW_START: beginning of the kernel virtual addresses.
  * KASAN_SHADOW_END: KASAN_SHADOW_START + 1/N of kernel virtual addresses,
@@ -43,6 +39,7 @@ void kasan_copy_shadow(pgd_t *pgdir);
 asmlinkage void kasan_early_init(void);
 
 #else
+static inline void kasan_init(void) { }
 static inline void kasan_copy_shadow(pgd_t *pgdir) { }
 #endif
 
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 5172799f831f..e35ce04beed1 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -278,17 +278,14 @@ static void __init kasan_init_depth(void)
 	init_task.kasan_depth = 0;
 }
 
-#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) */
-
-static inline void __init kasan_init_shadow(void) { }
-
-static inline void __init kasan_init_depth(void) { }
-
-#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
-
 void __init kasan_init(void)
 {
 	kasan_init_shadow();
 	kasan_init_depth();
+#if defined(CONFIG_KASAN_GENERIC)
+	/* CONFIG_KASAN_SW_TAGS also requires kasan_init_tags(). */
 	pr_info("KernelAddressSanitizer initialized\n");
+#endif
 }
+
+#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index e1af3b6c53b8..adb254df1b1d 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -9,8 +9,6 @@
  *        Andrey Konovalov <andreyknvl@gmail.com>
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index b2638c2cd58a..d25f8641b7cd 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -6,7 +6,7 @@
  * Author: Andrey Konovalov <andreyknvl@google.com>
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define pr_fmt(fmt) "kasan: " fmt
 
 #include <linux/export.h>
 #include <linux/interrupt.h>
@@ -41,6 +41,8 @@ void kasan_init_tags(void)
 
 	for_each_possible_cpu(cpu)
 		per_cpu(prng_state, cpu) = (u32)get_cycles();
+
+	pr_info("KernelAddressSanitizer initialized\n");
 }
 
 /*
-- 
2.29.2.222.g5d2a92d10f8-goog

