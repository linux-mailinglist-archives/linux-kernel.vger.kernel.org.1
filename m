Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9112AE307
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbgKJWOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732452AbgKJWLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:11:44 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3672CC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:43 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id x22so176500qkb.16
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=g1D3QU7M8sz0sof3NdcHUc7FXuL+sBstwF4DigTeK5Y=;
        b=Seki+Rjk+6gglclmnRomIxzf7l8MDwdZnmHP40lRdAobeeBoRoYPoGvyQOSyWSjDdM
         hcdF+y8YrrNhDMLgVNBBNMAVXY5tKt8Z555dTSWt+CpOP6nKK+C081pYfxEDaBe/dTOS
         GLk8ss4cPTmIfstbDaFk/1o0WPFX5J6TVhAW3SewT5B+hp4IKbNav27L5kT6bXgPRxSt
         deCnQMSGZrgXYzrgb87nIT+7g4pP3so7a3ifNS90Mz6n1Ez43/1pxJq831oK9DouPXlz
         5Vn6OB0RCx+kwlD93G80yveo3aXuZJ2+4noPAmEdAu/GZvadGiDJvc9WJHinakDOXf80
         mqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g1D3QU7M8sz0sof3NdcHUc7FXuL+sBstwF4DigTeK5Y=;
        b=csSP83bRiyBbUEtdAFlF0gIaL/FjynP1G7vNZUQBqqU1E2BA80Q8ZPCGXFOCVb8RVx
         CZ5dq00zlgmf97KKtb7ZOMBW4cJojEvM0KPcdyKKspz2mjjjAFCFF2mtvr7JSVKIY/bZ
         OGDXf6LLT/CmN1Vf+D0OAsHIod40/CsYVbTFZou+pPInTU1JDmxqRqZhvZ40Qc2dQA1a
         m9Es9pblFefXJm8U3wUG3FKXxBrtRUg4a7Pn1FrXuIAdAJkYJNnD9Y6iTFOWFOJHXmDv
         eia2qzq5xMU2d6eR5CKoa7ZDjkjKkyg3r90bzdKjqnUKDFG6+hU6+S5Vkx5wgJh3Rfkh
         LjsQ==
X-Gm-Message-State: AOAM531ttZuUQgee8p2PwSxYiwJFLpKWpvWQ44Arl2HQIjvhn2bGcS2l
        rpq6aOgRURMd1g6N5Jvbek411e75dVzv+Suj
X-Google-Smtp-Source: ABdhPJzGvaD4Cz55sGiAr39q833nDETwoET26pPoOiQ4AAn2dd6MPHhhSIvSmZbkqYNj//IKqzhWtrPWZcw505/K
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:aa8f:: with SMTP id
 f15mr20400649qvb.46.1605046302266; Tue, 10 Nov 2020 14:11:42 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:10:12 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <3aae3b3f931618b4418af7992bff1e258e4eb1ad.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 15/44] kasan, arm64: only init shadow for software modes
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
2.29.2.222.g5d2a92d10f8-goog

