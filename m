Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34082A712D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732711AbgKDXTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732689AbgKDXTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:19:43 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F10C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:19:43 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id l67so69148qte.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=d4Yc7AItymQNyKGF4tg/i8f/qZM6X5xLr7PA4bM2pG0=;
        b=im6MoqCKBPimqz1qFHzYTKjtM/SP4xbNj9lqr3+UxqrIDbQMPQjwIdXzthS7jpjGO4
         3EcJa8vpYK443mb9T3VXyXZ7BOIItSr4fq2re7sZ3t2jvFZWIc0hQAS+2H3OEqC2u7LZ
         dKT04KNcmFA0bmrZH178cjfaVWiCJ4PZ5Xs5gs/rC6ULLyS5ZLqfftn6OGZJhi5ELmIn
         j5tNBMwU7QhW6NXZFeB1ffQ3sT6D0/mVpwGLHCk/iMFPaArf+42hWgYqdAwUmUlMd0T/
         cC1waSCYw5qKAzMaV8/V5pfZ8vjWLa1kipuN91CKuTYipRSPTnZwhF9GmhgD2Rsrta6H
         qfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d4Yc7AItymQNyKGF4tg/i8f/qZM6X5xLr7PA4bM2pG0=;
        b=r8Hb5fN7UHgOcn2TtWwJ11Svimgx/cym738/Cu+lGUvSIy4edjDlZeSBj2V48jMyNn
         UiGxg/pyuoV/8hTeUf9nGjwcTp0+AwR4BbB7lLdd1ts5TgNDx1RXfJTtK3yTG6tS2K3H
         qBUgiBMd4hW1Yeobw0lS9BwyQJ5xmLojsNp9FhBOR3APQuuFxteLDRapQQQdqbpyXjWf
         UbFXKp3RliSvJ8ok4O/4OXN8NC77H73zsWxrsClHbOc2rK3Ikoioe22NRqjMQcZId6SH
         JO9arwo4NEZSlgLl0T0m9Y3jwUilrhrtHtSOV2DuLqByr35BBuo8ij9l5fm7ikQ8/4ft
         G9Wg==
X-Gm-Message-State: AOAM531+FcI5yWsIAdVJ/ZAc6YsLFHzo0HWMWRVTYt7n4KzjfxP2ifGV
        xQAhLsuzrNZPLjTmx4IvEqUSzArGi5aSO0Gv
X-Google-Smtp-Source: ABdhPJwX0nXmCdm5STp8GDmlwJmCmGhLQmNoNB8M224tUiklstu8Z5zoEBhqUpAe9orxivGxyeg98JncJ3U1EYl2
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:464f:: with SMTP id
 y15mr268562qvv.52.1604531982632; Wed, 04 Nov 2020 15:19:42 -0800 (PST)
Date:   Thu,  5 Nov 2020 00:18:30 +0100
In-Reply-To: <cover.1604531793.git.andreyknvl@google.com>
Message-Id: <82bba01b005a8a658596a77b2413adc16c8dfac5.1604531793.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v8 15/43] kasan, arm64: only init shadow for software modes
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

Hardware tag-based KASAN won't be using shadow memory. Only initialize
it when one of the software KASAN modes are enabled.

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
Change-Id: I055e0651369b14d3e54cdaa8c48e6329b2e8952d
---
 arch/arm64/include/asm/kasan.h |  8 ++++++--
 arch/arm64/mm/kasan_init.c     | 15 ++++++++++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
index b0dc4abc3589..f7ea70d02cab 100644
--- a/arch/arm64/include/asm/kasan.h
+++ b/arch/arm64/include/asm/kasan.h
@@ -13,6 +13,12 @@
 #define arch_kasan_get_tag(addr)	__tag_get(addr)
 
 #ifdef CONFIG_KASAN
+void kasan_init(void);
+#else
+static inline void kasan_init(void) { }
+#endif
+
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
 /*
  * KASAN_SHADOW_START: beginning of the kernel virtual addresses.
@@ -33,12 +39,10 @@
 #define _KASAN_SHADOW_START(va)	(KASAN_SHADOW_END - (1UL << ((va) - KASAN_SHADOW_SCALE_SHIFT)))
 #define KASAN_SHADOW_START      _KASAN_SHADOW_START(vabits_actual)
 
-void kasan_init(void);
 void kasan_copy_shadow(pgd_t *pgdir);
 asmlinkage void kasan_early_init(void);
 
 #else
-static inline void kasan_init(void) { }
 static inline void kasan_copy_shadow(pgd_t *pgdir) { }
 #endif
 
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index b24e43d20667..ffeb80d5aa8d 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -21,6 +21,8 @@
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
 
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
+
 static pgd_t tmp_pg_dir[PTRS_PER_PGD] __initdata __aligned(PGD_SIZE);
 
 /*
@@ -208,7 +210,7 @@ static void __init clear_pgds(unsigned long start,
 		set_pgd(pgd_offset_k(start), __pgd(0));
 }
 
-void __init kasan_init(void)
+static void __init kasan_init_shadow(void)
 {
 	u64 kimg_shadow_start, kimg_shadow_end;
 	u64 mod_shadow_start, mod_shadow_end;
@@ -269,6 +271,17 @@ void __init kasan_init(void)
 
 	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
+}
+
+#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) */
+
+static inline void __init kasan_init_shadow(void) { }
+
+#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
+
+void __init kasan_init(void)
+{
+	kasan_init_shadow();
 
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
-- 
2.29.1.341.ge80a0c044ae-goog

