Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D37E2C15D9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbgKWUI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730575AbgKWUI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:08:58 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D616C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:08:58 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id y21so99779wma.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Cs2ewUzarS5QIIwyBJDQZ4khSVYirNCbxYZ99CeZWdo=;
        b=WUct1EW0/45SbEo1Wd94pR9bmlHBk0spPS1gGG0tQf+aaoWQm9vH1OXWCs6I6zspkq
         kCKTmxoRoMDbXjmVa/YDqXgclS4VI/BAvEGLoEn9bBa7dIqOMiwmxKfnkdycYmPPVuZX
         /7qnoA3hrYbpjmU/BtmGDsCKOP4Bq1YUuEwRgYPBwTQ4KdyQtHyf6e1wwCgUP3/GkOFY
         s2QbI1yG5PTVhTX0uwp7PyqQAEEHOOpFjWOMl1/luGXi4d1nRa1face/qAUiHxG+9d75
         xDTGrbzHzbs0CyVuq3vt87IOayaLdbzeymrLSaYyDR3RzPyKXqxvWGNqb+t5pQEwlt5n
         CEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Cs2ewUzarS5QIIwyBJDQZ4khSVYirNCbxYZ99CeZWdo=;
        b=OiMWbU/xfyB3BBexEnx3DYadelmBmtL1OicQkigMkeTsMjtVNl1f1TrxWNWHAgtlSk
         q/FMqnL3PHd2Vs+oLNRIgBNOF1NnugdvMnaCpDE5gqP4cyUS78ke3MtRm5ED+twB02ib
         EP2a3x9gKxgz+r6DECnYw+VSP0r0noOdBGWjY+BadF9BKdXzpvjwQZ+BX3zYuDvd/XQ3
         tCcqXpTq7jfvlkN7XnLcAI7jyRuZy9zyyGcPPfHo/ajBCvAJy/9XFn3EI3ZEj5+ntUKP
         e1VLgkibslbG/oJxmGbTCaXsPU0q43lbWK9qjJ3Jek79BxP6Y0PvBdj5LbOKCQ/3X+4a
         oi2g==
X-Gm-Message-State: AOAM532hw99RhDFwpG3gRfCkxW8vvnttC+mc8auhVnRsPu8tGnpFjmoz
        vJTPiGPVEImykVB1XPuEjVCosPYh/50z5J3o
X-Google-Smtp-Source: ABdhPJxqI6+90Bwq9lUGedXDGjcOQWQVZ0CvQ0BfvywQUPnH1rHLFxtB2q5xtYCqtqhg/oI7VUjbA6AJk53CtwNI
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:2cd5:: with SMTP id
 l21mr605185wmc.182.1606162136904; Mon, 23 Nov 2020 12:08:56 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:07:40 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <29a30ea4e1750450dd1f693d25b7b6cb05913ecf.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 16/42] kasan, arm64: move initialization message
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
2.29.2.454.gaff20da3a2-goog

