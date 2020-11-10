Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E672AE2F6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732690AbgKJWMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732448AbgKJWLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:11:51 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF919C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:50 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id b6so6152252wrn.17
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=maJnPTI34+iFP5D0D1ra1sKb6Wkh8ktrMcPMtIoOl2Q=;
        b=i5hBOh9RkG0NtBiLauin8+U0dnodhBJY++QuqVmxbih6qE9QzKnp6MXv0elOa0QnuX
         VDbcr97hYxf/vU+BCk17vxtvkWYjYD8zZu1jwsip3U20sLvrNqE+M4hQPJy4s5Kh31l8
         9wBCLsU4SmoSw+d29LSCt53rPGQpPKi4CGfzNjuppNE7uzsAGMFQE0vZpTdStndvgDhI
         JmsHjSrckmBSvQHDcePh+33XCoaOAkiB5d0/8HURKy6EK2rEuUu7WRdyYL/swmbX5DZA
         Q+yC/ivCwdQIl4aztcvyrl8WhNdxVqFJvIzPERyFgvzrFjMRIn0SKWgGkejs89HLI3Te
         4QMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=maJnPTI34+iFP5D0D1ra1sKb6Wkh8ktrMcPMtIoOl2Q=;
        b=Pu4bXwgGfB8U8TJsh09phNDaTRMjMQQqn8ovTRWfcvTvGOb7M0OzQeoFYHtYG7Nt2A
         DjH8PGNhCdKfixaexaEUXte200ceUDY8XtgleLdf5GRZE2y6xCvREfWrHRQZRjtz93X7
         6R39ykbbYK0AP16wQz57yTCVzAenT9Z6VaZVLnnsA7wuQlIUjGxRRwWGOWcktLrribQz
         10IbeFjoqkZOlP9zSMabJCsIuSvETV+pJWEgQ9FhrhbUaTfpDAeVR0opmd2zsP99VlZo
         y8qjtw4xLrnpPwAWFl1FfXP89og1Ksd6yEUOFrgi/WaJmX2DhRDuWoYbsgJHtBCGciF5
         WQwA==
X-Gm-Message-State: AOAM5322U0iyu0TUO4ZTbAGOX1dBro6PnX0c+kI8Gmp/BCOW4BIdjDXN
        X6egBbXkcvQLozU/1Hb2/uXb1s42GPACMck9
X-Google-Smtp-Source: ABdhPJwcMGz9zwbkoIRH1a0Dxk0KI24yjcGI7yTmRvVHKglY5hkpLZW8pr+zYMwpADzqKzZ42BXHL3lqGq8ZwOhj
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:f7c7:: with SMTP id
 a7mr7030672wrq.347.1605046309488; Tue, 10 Nov 2020 14:11:49 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:10:15 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <8b8345f75fa75638328d684b826b1118e2649e30.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 18/44] kasan, arm64: rename kasan_init_tags and mark as __init
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

Rename kasan_init_tags() to kasan_init_sw_tags() as the upcoming hardware
tag-based KASAN mode will have its own initialization routine.
Also similarly to kasan_init() mark kasan_init_tags() as __init.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
Change-Id: I99aa2f7115d38a34ed85b329dadab6c7d6952416
---
 arch/arm64/kernel/setup.c  | 2 +-
 arch/arm64/mm/kasan_init.c | 2 +-
 include/linux/kasan.h      | 4 ++--
 mm/kasan/sw_tags.c         | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 133257ffd859..bb79b09f73c8 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -358,7 +358,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	smp_build_mpidr_hash();
 
 	/* Init percpu seeds for random tags after cpus are set up. */
-	kasan_init_tags();
+	kasan_init_sw_tags();
 
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 	/*
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index e35ce04beed1..d8e66c78440e 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -283,7 +283,7 @@ void __init kasan_init(void)
 	kasan_init_shadow();
 	kasan_init_depth();
 #if defined(CONFIG_KASAN_GENERIC)
-	/* CONFIG_KASAN_SW_TAGS also requires kasan_init_tags(). */
+	/* CONFIG_KASAN_SW_TAGS also requires kasan_init_sw_tags(). */
 	pr_info("KernelAddressSanitizer initialized\n");
 #endif
 }
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 979d598e1c30..1d6ec3325163 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -191,7 +191,7 @@ static inline void kasan_record_aux_stack(void *ptr) {}
 
 #ifdef CONFIG_KASAN_SW_TAGS
 
-void kasan_init_tags(void);
+void __init kasan_init_sw_tags(void);
 
 void *kasan_reset_tag(const void *addr);
 
@@ -200,7 +200,7 @@ bool kasan_report(unsigned long addr, size_t size,
 
 #else /* CONFIG_KASAN_SW_TAGS */
 
-static inline void kasan_init_tags(void) { }
+static inline void kasan_init_sw_tags(void) { }
 
 static inline void *kasan_reset_tag(const void *addr)
 {
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index d25f8641b7cd..b09a2c06abad 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -35,7 +35,7 @@
 
 static DEFINE_PER_CPU(u32, prng_state);
 
-void kasan_init_tags(void)
+void __init kasan_init_sw_tags(void)
 {
 	int cpu;
 
-- 
2.29.2.222.g5d2a92d10f8-goog

