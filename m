Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E13E2A2F4C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgKBQG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgKBQF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:05:27 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8790BC061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:05:25 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id 13so3514495wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=d4Yc7AItymQNyKGF4tg/i8f/qZM6X5xLr7PA4bM2pG0=;
        b=T32phW7qTdq9kcSd5GtgEhtNi/LmGt8NgjkKImgHLRYKvZr1tqLQXwsKMPf0jCu8Ag
         dWW5TAZ6hw+UWMg/v271CSQcU1pOccja0Ph2S5m+Iz85trmJ+G2wdbOR1AVfgrfOuGc2
         fWuk8f1Nl3tEXY38xe2uh//fsCnFP/J7dUjvkOvRpzy6nBJl7a//pKnS7x3RawD7yKrB
         GI6Jt74mRqMe598MA98i1+mHERWwGmHvxSMWG3/z94X/kF0YhN7JDjrH8791K0lCQyxi
         fpHJx0cyvyKW/jd+2mLuDBK1lLPiP/485JyEcbmVq9gfrFIm8X2s5g0zx9FOSz49Yk7N
         rwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d4Yc7AItymQNyKGF4tg/i8f/qZM6X5xLr7PA4bM2pG0=;
        b=hlFDqAA02iSNzmLeEhiemYSXjAIZHVFRwtW8DB34U9UFOGXeM9LaZH/rjHZyy9qmxX
         D/u/S1frEBLe7DlK54XPTBkzdXxX0BerA2Deos9KuQlkJqsL9Yv4GrcbFJW/StxEByDh
         302VeeYIdNpkXAnz44fTS0F0nnazmG+V0G+T8vhMx9C/XizUFX/RGpaSlHk4ApK/a+GK
         XyRatpLiPiYnjF0twKWhDoQaZYoDbUYWEmc5vUCYZwmEMfGTHAcL3Qt3hpp4Kg2+VLRy
         1VyYnpVf5/7drN7C5lT9DZpmFBd3OC2Xw9DqzTelxzkrBJ1N0fghZkuiqeE1hiSiLUhD
         eftQ==
X-Gm-Message-State: AOAM531D3AN/XQr8mavvlIO8Cmo1/PTLSdv4vofJiU5CjGWPmeEXr3+M
        wkZW9HzyoSJolUiz/10WDzNzdwy2TS0FL7FM
X-Google-Smtp-Source: ABdhPJzF83tj7y9dhim3vCvql2zL9bIoIDWntnLoO7Tf6GtiQCiGTSmsgBQh8jTP4UlZRmOKJxUIWliBUq+bAbwh
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:e685:: with SMTP id
 r5mr22556902wrm.340.1604333124197; Mon, 02 Nov 2020 08:05:24 -0800 (PST)
Date:   Mon,  2 Nov 2020 17:04:04 +0100
In-Reply-To: <cover.1604333009.git.andreyknvl@google.com>
Message-Id: <02c3a4f12747cfdd57e75c3dec2c62482e521d38.1604333009.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 24/41] kasan, arm64: only init shadow for software modes
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

