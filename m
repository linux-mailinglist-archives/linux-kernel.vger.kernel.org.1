Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C2626AF92
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgIOV3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgIOVQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:16:53 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62127C06178A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:16:53 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id m25so258034wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IohLAiQritHYDUsEyFojJvH0Itf5Q6tgZwjJNHAxVZI=;
        b=KwKBifrTZVrDXaHnoOdwHc/M5dni2e323Mp+mNPmCsK0W8O7Y8VXJVi3AE5Jo+ENnk
         EkGS8GuntJzkIIof+6wo2+RelNqEkT8AzAWR+IYpLFmN9+9mhgXciRNcQQBmCWFxXwOW
         mm18KrwH9w5clj7/igQ6hoHVFcw9+8yJ1xmQfA93dgtSY5QSor7XXk5jyo+crlVKAWnp
         btvVEGqWSJknyo34NzbkH+W5g8uCKLArOGU++xd3ifOZaGtxnNyjf/e3LxwCnrnbNtRQ
         4iW7Q/YXlGnFBNG8pOB2sAvLVRvRfNRGuUGU+X9u/OAZqVMesvc6GxLKobPKyE9Sgi9E
         xvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IohLAiQritHYDUsEyFojJvH0Itf5Q6tgZwjJNHAxVZI=;
        b=lYaek0+Lj0vb4dWMlZCCnmxLJHDgOYW8HptxUFhEQF6K8GywynV9IHn7u4PLdbmf2H
         x9oq35JmUnyxpVVeYodwUz3FrViKq+HCrFWpl5wT0KmGjH3r9yPiep6jL2XsUloV38DO
         PBR8tS8GVtFQMra2uv0jSkG7UooCaxHkby0cJ49glqGQxGq6arkVsx9R6HF7GiKyAS70
         6k/GPmj05L+s9ADuXewY5/vsW/mphK5UnFrhaSnX0zm9Kgv/rAfuPedPGWtWVggbWPVn
         dwMYszmjwQebPMhJAX44XQhWbOXMxXKDjoDeUV1aBT+hgiMODppE0JNMoRfhpMzd5E63
         tX4w==
X-Gm-Message-State: AOAM530J2pfwdAoMQo9pWZyJJhRlMgYlaJyFKCLk5VrC2AQnMByR5cNl
        7meBOsrEyia2S1vthRQANA+BHgoDBrDRqUF5
X-Google-Smtp-Source: ABdhPJw1CmWQAP9tJjtlXp/HfdjCVKqfCNtO3HPAI+fWlLqJnWhmg0N55nUWjB6VKGB/XuTbHQN3196z0TpRBXCx
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:cf01:: with SMTP id
 o1mr23727593wrj.421.1600204612062; Tue, 15 Sep 2020 14:16:52 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:15:54 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <2d009928ca496df0d7c061749c6a74d9ad36588c.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 12/37] kasan, arm64: only init shadow for software modes
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

Hardware tag-based KASAN won't be using shadow memory. Only initialize
it when one of the software KASAN modes are enabled.

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
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
2.28.0.618.gf4bc123cb7-goog

