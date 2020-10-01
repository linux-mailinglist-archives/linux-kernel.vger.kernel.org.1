Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55306280B1E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387566AbgJAXLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387496AbgJAXLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:11:20 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5DDC0613E4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:11:19 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id b17so101410ejb.20
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=CEk0EFBZADwM2R3bxadynAWU1zHiLtW/CrSHzr2Y4Kk=;
        b=MhEOyfxKBrhjQFiHW6Z1JA0Xjxc72Uxp3aMy/jFpXBBBM6+RXzkdMrfUxRsyj5fQh6
         fJBRt6W4NptDf5AmwnU5Q/07TVVZD4hofpz+w9Z4TunGPjvd+L0Pl6541VvpYQq+vjMq
         e+LPCedyS8cyfBnkl9upiQiNeXzAffIk1ziBkq2Ne2PYANOfIfhUbURXdmNZSAA+rHxo
         9HFhbwSXUF6MOXszU4lxvLYSAnM3ws5X824CqcGgjsx87KWxyObjI3VAb/Bf9qzZX+rT
         5I+JxUepscITR39WUD74DGlIabrMNkrKkvnlR/Em0ragiRIbe85A55N/YCEEyhDZb0mf
         XFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CEk0EFBZADwM2R3bxadynAWU1zHiLtW/CrSHzr2Y4Kk=;
        b=iEvJtw5GWRquj0KMVEhG9QDKr7brf5UOam8hrE/5/79PVE3KpGZZUJL4uJXWfOP1D1
         EKWjCgtvt7BVY+wQuekFAciaXreWeAvp3FSKz+WOp3YBPxuPHBD0PHwl7GNkCbPsqG6F
         STULfBeSmzTjpU9FFGuLgr7xn4LhJ4AhntKLE4mp7s7T8Ym1W9OW9owEXbMyI5aVU9hk
         Y/4pkWmIbOg7FiFqEyyzn1ptd3Zkg4TmzAlTSUbZthUMaGoVKO/4XQBVNFbbwITRW3Hu
         1Gk25PhbRqyb6HI5ZjBbDTIQT4204pJyNRYGSKkZ+xsS7KM8eekL/HnIGyV/uirwU20q
         YX4Q==
X-Gm-Message-State: AOAM533bjhIho4cPSoLA9aMeAPZYQtHXVCn2eRSMQdsKhjCk/T5q3ckw
        Q+LCM4gYaWD8pe2/aBnJe9yoZEZ/E4YFkk2C
X-Google-Smtp-Source: ABdhPJxnFAdiPwF6dSJmdbWA7jTZKgNkHGkRFR06h3uQPxmHOcz1KSZUJeMTXBwfB5WKRI/k85WXriIskHwHNlUT
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a17:906:5509:: with SMTP id
 r9mr10806797ejp.12.1601593878339; Thu, 01 Oct 2020 16:11:18 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:15 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <e940b95aa82b2976ecf7fcfa18627038b6f7fb47.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 14/39] kasan, arm64: only init shadow for software modes
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
2.28.0.709.gb0816b6eb0-goog

