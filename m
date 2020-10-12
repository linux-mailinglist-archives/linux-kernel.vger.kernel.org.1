Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3EC28C321
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbgJLUp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389379AbgJLUpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:45:49 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F77C0613D7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:49 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id f19so7080459edx.18
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tw6DMQkn7MmrZPxZvgni0f9K6FMm37RVzTDthLVuabY=;
        b=uNjzCH5sRXfyYEF6BX2yrtFULaOlDagrBHD7QapAn4w7LUEfnIFYO7DfAhpH5vvGQH
         qV8j/UyywdMWrFHlY4B/B/rhAJnxYd44P6epIkh+pCZg5DDezqWq5czMWs/0Zx2LtW9i
         JBybkUXjfPYWH9Rm8WhTsfBBcwQoRq3pyYYHn1ucIwQRa7sepocw9O5Q5M5+Q9Ni1vlr
         yjpTUfyky6k5tTq+pEH/MO8A5ypTNpFIDwlmGTKvtT+Ysjmwavu+Azst01H9i8w1wqp2
         VEZ/AhS02nrEq3OPJmUMgpg3b6IBlIzEaR2qKzYMbvxg6Vhsqjz9nJEGo+A2Lxzodm1c
         LCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tw6DMQkn7MmrZPxZvgni0f9K6FMm37RVzTDthLVuabY=;
        b=q+wScQAdbc+Y7MJXORRXdcEnmATqJYI94d38kyAJVqRWzf5wMgYciMf6R2CY0H0Iq8
         nS1UAtIJI+PZ5bfKcuCTbct4UZoI+c/HKCqaFXs80k2PojQIeTMyyleyEXhQSei3P0ES
         wUulQ5DaHSYRR551q60Pwn/uOZG9dHW7zQVPdSbA82roL4+WisJ9GtpuYZV6rcbubSc5
         wkbAb8n9b6M58t6TvenMgbl/m2InLW83CNZBahIXMvjWUL3rjfa5c06kA7O88ZOQDh0u
         8fdl3uCBLvYErBmxIbNJwhbP2gBjqEZJILMCDPoPlkS5EA/e6iOB+1shIQZ1qEeMJXK4
         fR+g==
X-Gm-Message-State: AOAM5320cXM2MSweumoxHjPrIUzWA13RI73RPhAuAJfPRoGg0xFEnthj
        pJJ91uNTIZCOovc4iTwE6uIlxd08xq2Dh658
X-Google-Smtp-Source: ABdhPJwid2F17s1uDGJU7v348xRDwCe41ZClGL7HKQ97XmCuvEQgkYe6vbXT6Qid5Q02FR6x/4RvodztJuiPxTWX
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a17:906:7f05:: with SMTP id
 d5mr27995116ejr.362.1602535547465; Mon, 12 Oct 2020 13:45:47 -0700 (PDT)
Date:   Mon, 12 Oct 2020 22:44:29 +0200
In-Reply-To: <cover.1602535397.git.andreyknvl@google.com>
Message-Id: <3f1a714d11c03ce1783e835b8c7f93eecedaa7b0.1602535397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602535397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 23/40] kasan, arm64: only init shadow for software modes
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
index 7291b26ce788..4d35eaf3ec97 100644
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
2.28.0.1011.ga647a8990f-goog

