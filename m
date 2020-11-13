Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A356F2B281C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgKMWRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgKMWRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:17:01 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B624C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:16:57 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id 91so4476857wrk.17
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AllKQJimzn7hLgi4RPYa1jCIh9marG6fXAU7bboN0mo=;
        b=i4IRzr7+/eoQ+lnOGtTQBdgWb0fu4qQkB84Tq9FFV9rbuaL+X/H6CRSgpdHesjdSVb
         Pz9YHO9ZH9NU1SRYhQkZfRsdqoXyHbKk8tQihGE6SOyzKDQGPHfHATaMl9qStufrRUXw
         vhIYdeeoG0sJwGl9GbDxi64sp1bCNfn9Q+XUcCZV8srHJ4ThQ4brshPp/aoL+iz0nT40
         lvWuDWVE317WTnn4s/i/xxHldZIGVC1mtM3sGVscptrrHQI9Jl3dnhnv5Gofe7t+vo//
         SKp7T0eyyilA7jlo09AsI8TXoNBFcXtA5J5w9jV4PdDb8sXJHO4H9/fQH6BVEWRCIKuh
         UB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AllKQJimzn7hLgi4RPYa1jCIh9marG6fXAU7bboN0mo=;
        b=BggYcqlFj7tKCiYjV/pSCm3IzndcvzIn9WysOgxJCxYS+TuzHxbM+Wazd/ZCB/sJ7G
         8dSclLoMJT5mPDHAA+v5qP9IcdBSM8F9YDiRbQKVtyHB9zRomK/af3F8e9yOnsqcFwKi
         jUfXTO/9rV/ZQmrrNkxDJA9Wi1T6E+juOFAwDOoUfO1lWnGJqzyLD+l8HTMVtHWvZudY
         rFznhhsR449oUF2KaLSY2Yvz0LQSU136xFILhm3Ou/1JHBu1H8OV3/KJTGWHKQbq/Cio
         VnHLzeaHm+1LtUghztVCL17NdxXqpdFjzJzvo5H7MNDyie0l+c3x2HR53dXpHtW378QT
         GevA==
X-Gm-Message-State: AOAM530VkowmjNIhEmk4FG57s1pREBWQYb9Aw20ntBsqbEI+xWGVwK6Y
        TUMN/ohg8C9dgyDebXwv7OSIc3fxk1zWkZWL
X-Google-Smtp-Source: ABdhPJzRByF66A4BSINBX5iVs8nBcZqNdrZ7mZgwx23OUF+TjKT+gN+fxNUfxlwF0dexd6eOGTxMCgHz5JLrJA8G
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a5d:6a0b:: with SMTP id
 m11mr5863665wru.190.1605305815704; Fri, 13 Nov 2020 14:16:55 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:15:45 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <6182fdbdc372e9e4888cc7b73c47f85d21d1827f.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 17/42] kasan, arm64: rename kasan_init_tags and mark as __init
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

Rename kasan_init_tags() to kasan_init_sw_tags() as the upcoming hardware
tag-based KASAN mode will have its own initialization routine.
Also similarly to kasan_init() mark kasan_init_tags() as __init.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
Change-Id: I99aa2f7115d38a34ed85b329dadab6c7d6952416
---
 arch/arm64/kernel/setup.c  | 2 +-
 arch/arm64/mm/kasan_init.c | 2 +-
 include/linux/kasan.h      | 4 ++--
 mm/kasan/sw_tags.c         | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index c28a9ec76b11..75e511211eb4 100644
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
index 58567a672c5c..8b8babab852c 100644
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
index 9445cf4ccdc8..7317d5229b2b 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -35,7 +35,7 @@
 
 static DEFINE_PER_CPU(u32, prng_state);
 
-void kasan_init_tags(void)
+void __init kasan_init_sw_tags(void)
 {
 	int cpu;
 
-- 
2.29.2.299.gdc1121823c-goog

