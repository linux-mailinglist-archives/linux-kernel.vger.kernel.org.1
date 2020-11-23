Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C7D2C15DB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbgKWUJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbgKWUJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:09:01 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08479C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:00 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id t141so15458974qke.22
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=kG65aVx5WJn/kF7F81b/rehD2S5LbswJneuDpixnu58=;
        b=srZKa6aHLqZuKptDw843Gpf6CkZm8dA/hocN4dfToqMo5X8OsvEYKl5tsjHLPgc37E
         XQvyLPqtPSNkha6MG2VccqVuGwDifvfbiSE1EclosaEyCCQ8odpo+OqLN9C5v5tW9gbK
         FiKBSOio5UAaJlfqg1BJYSn5iw3kmq7U1OxZxW8Sq5ZtRywQEJcyMIryLXgPGMBXAP3j
         EuEklUtlEZx9luFg41dLWH7GskrwhaclbAo0T7ToeaKRMka02nwSDy/Mf99HCCPbsbaO
         9DLT9ytZlHaRWKUuKQAWv0BfaRWxFyZeD3Uw7OaCr3V4Eku5B89A/ztTOS35MeDKQOQ6
         EYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kG65aVx5WJn/kF7F81b/rehD2S5LbswJneuDpixnu58=;
        b=d0dybHWQBo+ElS5SdEV5SEJjteU9/YHMzIQSK3XYxqJYNgv2f9aLKeLxqdF6C3I5b8
         CeXLuUYiQA82u+9Y3maLlmS7ZYaYqP/6e0f36sKsLIDLF+EjvW43nrAEDOTFUaLjddtP
         4Lm/a1iiGd7FTwlSOAZ7Z0lWxgxjO5hEQ22aTUYVCwW0Zh2if78hzK9QvQ8p4lCRK3RK
         wi2AboPh4tNs4FLOjCcU+Zt056o92B9kohYnKGYqvoLb5NdeqSe+K8+K5OOEXZO5mRJA
         Dz1gkMJpe5shqeGdjc3e5u7g4MhdkOoLuTkRNbMIoSDIrvyACRVmtr+/tqEDOcPP3glg
         Z26w==
X-Gm-Message-State: AOAM531qGwv7wJPtLXk5cnuvLbFbnZIkgt5ED6w5ZRKL4jFrGfrxnSq0
        nqL2M1+Mce89I0O3YJgPmto2wDUglSnnRz57
X-Google-Smtp-Source: ABdhPJxCad00eZI+YxCwZo4nx7rt4QHv4Zb7t1cqFFmdL3aHDRdQ3jgyZllbuhtEoIpwCLdysHI2kBaa0x5rs/sX
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:5587:: with SMTP id
 e7mr1239239qvx.33.1606162139104; Mon, 23 Nov 2020 12:08:59 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:07:41 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <71e52af72a09f4b50c8042f16101c60e50649fbb.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 17/42] kasan, arm64: rename kasan_init_tags and mark as __init
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
index 1a57a76e1cc2..a950d5bc1ba5 100644
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
2.29.2.454.gaff20da3a2-goog

