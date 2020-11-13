Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7164B2B2814
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgKMWQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbgKMWQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:16:50 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CC6C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:16:49 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id z13so4678352wrm.19
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AsJkOJ42mgBB/RpOeNzMBcOw45undU7MsCeikCxw0wY=;
        b=jtDCsSASkhJrdVvv08oa/t2CYlSg7YgeVr2lKaZdyGX32BYggniNGXDaV36eYvWTpp
         epHb7jqQJ6jMbsO/xQCDJcMlM9+JJek4IwjWJaFPnGzcYQSnj4kWsrkqFODPftORl+vG
         82OlwJrZKti8gt0DfpMCawZLfDa2gdMyzxHtrH2wPwhklupqzkKP8Yctdz7b4XoOToAC
         SkxwqI7PpE/Q9xlA8PvORQ+pvkc8Hss3fbUQKo3CykYnfTF97iU7Z29Kd5FVF39tbYaq
         xk61Gs3UAXQIEB06nxxULs2aQ4wr/PDstaScPpqyUCMSJ2a5b+oHdjNzp00Hiqx2kRM1
         yHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AsJkOJ42mgBB/RpOeNzMBcOw45undU7MsCeikCxw0wY=;
        b=iKL83qP143aVmkgT9TePp86LSb/v9MN/o9mJyD+ryo9uIEv8uvSc7VHLAaT6/zKRUl
         JiWoUgVecwikxLiC/ZvkJit/IuNX6DMVoKHtXT6gNXdGGHpYcOKHUGQmDvqYlT3uk6wy
         61PuKeXXdylzdlHJxIBa2fjP2XeaoPh8MNBYuizjzzJbsvkgn/Ii6KP3TAbNu1gVN65G
         LXqZVC4KgiAlEHB5Dja00TK1oomljg3Ro3c4LlX/PLXCQhZ3Oe0mEf1vcmO7skiokPtE
         BVx7oen960KNNUbJz8mHSqvvMe00UbX8nnkZEtowHTZvOTnR3ymHBuWpHpIYODNZx8QD
         1Zeg==
X-Gm-Message-State: AOAM53174jWfszib31+Nf+2ktxMQzHSFataOMh6xhwGcM3UAJ2IYEPl0
        vD/TH9FlFOmxZ2UIFrfkVeSaG7HgUqpb0bST
X-Google-Smtp-Source: ABdhPJxo4MrSFgo4LBQaZOUmymVqMcG1hcFjM18H+V5FrKccNzzw2EezYLoej6MFVLEy0MG6pWsulzFmxKQnz6Du
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:f9c5:: with SMTP id
 w5mr5786688wrr.69.1605305808039; Fri, 13 Nov 2020 14:16:48 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:15:42 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <3d5b13c846573540ba224405f3f9c6ca6ef98e89.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 14/42] kasan, arm64: only init shadow for software modes
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
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
Reviewed-by: Alexander Potapenko <glider@google.com>
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
2.29.2.299.gdc1121823c-goog

