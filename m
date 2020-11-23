Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC352C15DD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbgKWUJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730360AbgKWUIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:08:52 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899F4C061A4E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:08:52 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id e22so14373275qte.22
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=cvraDLvCJyIxw98+lt/3PDpM3Nirwfhsw5x/8diNIQE=;
        b=slyXwv8qG8zCsaA4IB1r95uezXa3k9HnCVXr070V4sFzCEE1mjh/Fw+pHJN4rlUyrc
         D6NOSxSCaPVKJN7mo61CZQTsjDkbf/8tKZVvkHy8LNC66jzzABGmLmVcxDfwKMeEaH6v
         DmOZKiibrCS6oW22020O9/15pI0X+vDa4FzXnqq4ZnQjmDVnODlzYShDRG3/MMC3ywB5
         Ujif5i6rqkX/OXd5BHDyhD1lZjDwuq3ohYIt3hz64zqk30rEnLnEaA8kDLOhJNHd7GWB
         wzF8CDFp6oAD3EhPZew1TobghKrw51OOtlOHIsQeCf/3w/SxEUkAP/U9cw6hhca41XmE
         v7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cvraDLvCJyIxw98+lt/3PDpM3Nirwfhsw5x/8diNIQE=;
        b=kfApp8fMxByAKO4n5/J91PxTFjwTl2LAOsWOAlvNJzGbNPkzdnNbw/v2bOGWJ8mPFh
         JxOhBrEwu4MvmlEPq9FiPL/hMaNUGbQFU2SvXe5CcULJghDY9UfYtC3hFpYXh2cxeX9R
         tsyq6kx51jfU31arOoeUCuWoHeUjgKDuZOFesbIHR5EG5Zd4jHN7Vouz59O7iHzoA0Vu
         nqDk1AVSZbrhc2S2bY+wSA9g/TxrxoQlO0ZHFGkT6ndeoWEze+bRSXVFe8JtOJBLiSYQ
         KDD15UmGOOuKIaKjSSMcJ3XgQxH6rVnb+I4UnnHOCgREjuqXFmyy0dGdeOgLZB5H4UUU
         TqNg==
X-Gm-Message-State: AOAM531Oiayc3sTSaW1BgBxM3Ml+GWplT0nV70CAgzFC7gR9gW/6oksA
        ozOvaVaaHHqd0c+AZGSziGIBwIoqa18C/fJo
X-Google-Smtp-Source: ABdhPJwPuuM8WrXDAAsPpYWCwtLA0QS3qrDwTNVKFknfRJG4EzSnfbKJpt82bY1nIj58y8ZcrppL+ieB35tTltaG
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:363:: with SMTP id
 t3mr1130705qvu.9.1606162131658; Mon, 23 Nov 2020 12:08:51 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:07:38 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <d1742eea2cd728d150d49b144e49b6433405c7ba.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 14/42] kasan, arm64: only init shadow for software modes
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
2.29.2.454.gaff20da3a2-goog

