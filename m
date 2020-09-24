Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93B7277BE1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 00:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgIXWvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 18:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgIXWv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 18:51:26 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2ACC0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:26 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id y25so283585ejj.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=WSKmYtIIRd6kxfe5CKlrOgcFvBqAzMyIV7HUyA4uuco=;
        b=Pjdl2utZ2uKdW6u0Dzi1KrmC+/5RfwoxKbGoz9gCPBjl+b5noBBNfsbspaCt5V0pQY
         xsbDOs5zHwl3qy3dB4cBcj4iTZppXDHPYO+dSq44lp2650QMtk0TbW4VfjrRyfqOaH2i
         gcQ25GEI3riSbti1sWMobhhJSM2iMyZry0aTfIHb550f2k09euoTM01n2rxDr90f0bHM
         lQA8kcYLlqDakrIjEHBh6RQe7W8PZhEPjtNW47F9RyI+n73aoqjYVA/q2zXHs/ggsFbj
         ABSDtSKicMtEEX8f3AK2aMtBhhpAzK0xakBgOPowZ7Pmk6aQK4eSUM79QUdTvNhO5wMh
         8vUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WSKmYtIIRd6kxfe5CKlrOgcFvBqAzMyIV7HUyA4uuco=;
        b=BS7x5r0+f3Yn50vyLCF0MnhZAdxWZHKgRp5lnoTi9z4+4Gopjwmsn4zvcSp4eTI+cH
         kAvrdzwYJ8xfOg7Z65g3Qewzy0K9WYiO/s90KoEqqY4oRDXA5IwIGoPOnpn6/37MzzLC
         dsiCN6zTe2anqg7HkcxaoCQIglBC8tU/T8lLzi3aovEc35M2s3DT8hbNrHFjW+kW8tJs
         dVpHo1UKC77SFx97Cur6AJmif20/IKJzM6zFS7dJcfzZI9neyjERr5yMOmk4eFeAiajM
         h2fBRYXb2aPoRepwX0fRQ6Y7Gz37OX3AF2NOrSXuE7lcRHPDf+I3BBdCZ5R+XYjKE/5F
         RsUA==
X-Gm-Message-State: AOAM533oLJNeU9sEHus4MsmVskZKbiITs5i0D+cnjCt/cOoGRn1nLfeG
        lz//Nal6LxEtFvn94/Y3NkW3GC+hhRQFKhXo
X-Google-Smtp-Source: ABdhPJwUSOgoRD2AOF+tbmV9ovrlIIGaxyO+tontblprCpuBMAygrqcaZHb8CXYXsyJFbiVnU6kaRN3PZng7WHm6
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a17:906:5008:: with SMTP id
 s8mr918984ejj.408.1600987884775; Thu, 24 Sep 2020 15:51:24 -0700 (PDT)
Date:   Fri, 25 Sep 2020 00:50:21 +0200
In-Reply-To: <cover.1600987622.git.andreyknvl@google.com>
Message-Id: <dcf9114b08b57bd4b2721936e194f082f52780d0.1600987622.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 14/39] kasan, arm64: only init shadow for software modes
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
2.28.0.681.g6f77f65b4e-goog

