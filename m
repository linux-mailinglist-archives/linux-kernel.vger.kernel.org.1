Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B53F2B2820
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgKMWRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgKMWQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:16:55 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0504DC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:16:54 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id s128so7635654qke.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=9CcY7cnQj8/ZsaLGH95ZEDucryFMFL6l1gyKldTtU/U=;
        b=LT5CFhYHaN8omWk5Uxml6lUvURFHI0+sBfS54fERR9cl7aj5uCi6KAEnNmK8+RcWMn
         orCocB9w08pWBpuLAS5lYsnFtkwJrX/d8CIF7I203aWNv9OxGPQkdNFzJEVC89GXcByC
         h5/FNp916fJGFkKmdAsElpoh7Y9VwSiRSxV5fAN8VOO6WvalHa/gbFxAJJ4XXdHYdYsV
         QSYnG4Dcn9CFEijD12xw9hq7NK3VzoJPBDRXfTs/YfzCn/RP72oBX+Z3NeNpk5q97Dz4
         zwjGtK/wKGqJ24ZTJy/ao6jjUp/MbxBvCGk116FNIFy2dyI+dJMNvZQUKve+Jqn8QVTI
         Rm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9CcY7cnQj8/ZsaLGH95ZEDucryFMFL6l1gyKldTtU/U=;
        b=sP9jvzlnvsf+KSvqr8HvrcKDZ5tSAR3+/eMWx1QleS7xCTakgX33j8HR5xOHc5dHm/
         U/UFEdQ2to+1qGs2elxwIF50J0UCAfrkB48FHv4+B+0zxVUAIr0I0WIfaFJq7nB8+42F
         m9SrdhdfdH6l/KqUQYZWYuHYfNOk+XdyMRMzkVX2WbOu44FfRJqp/IYczI+M9ReGjwpR
         X+0jCqIoUwiGepC/h0EXIuA+jREpy27GKT2kjTfzJ2a3ZXaLRoHaAZBmNPPGqdTX8WP9
         mtfd9cZV1p7gN2l6AD5qzEbUWiFWdO2DXqePIMeivPk0lQnFcevpoo2nT6Hq2xaM33DP
         Eiuw==
X-Gm-Message-State: AOAM532MRKvvhnayu/L/6aZP5hqQvch2anDz4aquDTYQY64uv9N36htO
        bwJJ0PSDYcke5yoiaAPYTbMNDoc1Azy5LU94
X-Google-Smtp-Source: ABdhPJyiAX644hwQFHmDLOuMlOvFdeD1Qx/fNQM4q6Bp+omGxRcM85yv7R/X+J3UtiGUFsdzMjYeCrG67ukgzQc7
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:ec4e:: with SMTP id
 n14mr4382317qvq.7.1605305813183; Fri, 13 Nov 2020 14:16:53 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:15:44 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <031e7a7e501534c0ec5d77f6733d63ac56513d1f.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 16/42] kasan, arm64: move initialization message
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

Software tag-based KASAN mode is fully initialized with kasan_init_tags(),
while the generic mode only requires kasan_init(). Move the
initialization message for tag-based mode into kasan_init_tags().

Also fix pr_fmt() usage for KASAN code: generic.c doesn't need it as it
doesn't use any printing functions; tag-based mode should use "kasan:"
instead of KBUILD_MODNAME (which stands for file name).

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
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
index 67642acafe92..da3608187c25 100644
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
index 64540109c461..9445cf4ccdc8 100644
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
2.29.2.299.gdc1121823c-goog

