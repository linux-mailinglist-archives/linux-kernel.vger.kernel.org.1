Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7952A7130
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbgKDXT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732694AbgKDXTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:19:53 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F32C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:19:51 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id w3so42741wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ojj9e6SeGShn+CqBq2chujClVFvSwMkEAD8uQAmerxw=;
        b=KrghbXMM9I87gk5nyKwP68q9D7JmfiGJWPyvcuRP5JhQi4zKJv4x/OQdNK899VZfqz
         Fl3FdIrNm1+pH2z8nU+0yU3a/m6zzFixZuFzq6Ywp5d02Hxu0YgaCRAnpHe0fyQB5FWy
         Y/c14XQNtkxh2iATLUSfgdZbaMz+vZbXVmuVrnh2nnpAp0+1STVxyz2Sh98bhr7b1BQK
         eQjjVuaipiQJIrrByCMPsXUnMpNmFY7tjmF5Na/ENvCa0ba0B6jimHGctfbj5rZWXnd/
         xf/7tvFqBWanQqEH6Ns0LXEVcMlySnqa2XGWIs5Ifyr1zCKgYpbS7BOFRlscFme4BgmJ
         gsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ojj9e6SeGShn+CqBq2chujClVFvSwMkEAD8uQAmerxw=;
        b=gX+AgDbsE1fQxbc29pvouq/OtVv5Fh75Az/xlz7Mc3EBC7wKTSqHOxBnlKdh5B8Mre
         xVovRaOnlU0DgBpW0rhdfixpMRCkXAyzzzsUUC+8GxZT+k4E8pxyYs003J74t/eFYZ5u
         VtUI/BOtqnOWMr0x5BCyUnSu1PdRjUJaKjO0HBwYLchWLjDNPGCM1CJHWw5Yhbm1v5Ru
         LVAsivNI0pYvVx5/kmElpB+WSIx6B4b2RqYUjuOp/iIWB+bIvgHAbiRFskpnAkgL9G2U
         sh2jaWtoaT1ti0YWk6sl9Weupfg0yUAWNcW0jrFlNstW+zRnvYVGEelup2qb/g9eo7tX
         ccxQ==
X-Gm-Message-State: AOAM533PBwLEPJXGcV0LBj0RkRRWnqWa/yh4kxYcCErZG1OkjsScBjn5
        E7dvzW6WThK4V0xmtzggyp7AO4OJ7TH1ZHPD
X-Google-Smtp-Source: ABdhPJz4Hbrh3Ua4QZ0IndrRDGnYifiicCuVPdjCPO/4LNGbo3KP+1XW2gBoZ6BhFx5g1YdGjEGB1Urre7hAN5qv
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:e903:: with SMTP id
 q3mr97119wmc.42.1604531990350; Wed, 04 Nov 2020 15:19:50 -0800 (PST)
Date:   Thu,  5 Nov 2020 00:18:33 +0100
In-Reply-To: <cover.1604531793.git.andreyknvl@google.com>
Message-Id: <f931d074bccbdf96ad91a34392d009fece081f59.1604531793.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v8 18/43] kasan, arm64: rename kasan_init_tags and mark as __init
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
index 8d3d3c21340d..32b9d283e0a0 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -189,7 +189,7 @@ static inline void kasan_record_aux_stack(void *ptr) {}
 
 #ifdef CONFIG_KASAN_SW_TAGS
 
-void kasan_init_tags(void);
+void __init kasan_init_sw_tags(void);
 
 void *kasan_reset_tag(const void *addr);
 
@@ -198,7 +198,7 @@ bool kasan_report(unsigned long addr, size_t size,
 
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
2.29.1.341.ge80a0c044ae-goog

