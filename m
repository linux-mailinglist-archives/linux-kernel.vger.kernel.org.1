Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6A9295FC6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899489AbgJVNUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899672AbgJVNT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:19:56 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D05C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:56 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id g184so1010952qke.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ZoFNxYTX2w5xrKhT+4kOLYASUdfUPOoAnADKxtZ91BU=;
        b=hyg/yHWHvwShqvDVWk+p9jRaj1k1vbYvbMkQiwt/KYz+fgLWUl5RZZxkLQGBjmXyTg
         4Mpc350rxmj8NEmdVWFhN7K3IA0gBvxNU4krBGMa40Pe5tYLMpxQp9rTdZcI2IVNAq8X
         X6BGbZ198yO5M4c9WFkFQB1vRxo/zQKgMMnJ71TSXhFNz3csA5eIcnR7mgxlYqKdbvfO
         F6V3nrozw4kqQp8r3Mhim3FV/62Y22qIA0J/BOk+a8s/8mqn9yOWPdIKUBViFZUM5jRy
         Z4a7ho525wIUCVayqHieRmS5aR43zx68e2mZ9l/J1sD2671q8FvP0uYhAMnEpSGEGE0q
         iIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZoFNxYTX2w5xrKhT+4kOLYASUdfUPOoAnADKxtZ91BU=;
        b=sZ43204hqpGnfn7Yv/jEEweTrneWP6tLO3Qpl0j6529UJdTJusl5mUxhz4zcFC5Nxc
         NM5WwxZwak2Pvw/1LFrr2puafC112c15XwKxlEIjbAzHTpNiJJ6h4xoKlALzxvJqWfky
         ObBbeo7bySke3GhydFc0lscdetIJbWjEp7hlqGQR2CLw+U3h1qpEwsWZ8AA3jb+n8T5U
         6si/ovMPgU4Xqss4T7qwkeEXLpiPSBQY7wXx1mb0IH8e60V8OdVOZ9r3ZTQKXywxs/DW
         8th1sIHeEssFe958NQbj+lw06JyZmy/a4Dczl41U+0k1Uilki+QMtwrHgmp6xnMhhFB6
         c9Yg==
X-Gm-Message-State: AOAM531Sm+zBCmZ7X98N4QvrK7Mb4poPIIDwyoKnlUZLhShcoADiiXAc
        6/tV+N5diBqCpamioeNbGwwHvzFAJzgZnYJO
X-Google-Smtp-Source: ABdhPJz/upwD11o6KftRnmUWcVjQhuj/aMMh5idv43GrvZzPuF9FjjUI7+5zI2FNbmCB5582zV2P7+i0EuR2ktv5
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:1267:: with SMTP id
 r7mr2283039qvv.50.1603372795643; Thu, 22 Oct 2020 06:19:55 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:19:05 +0200
In-Reply-To: <cover.1603372719.git.andreyknvl@google.com>
Message-Id: <ae2caac58051ea4182c0278a1c1e4a945c3a1529.1603372719.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH RFC v2 13/21] arm64: kasan: Add cpu_supports_tags helper
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
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

Add an arm64 helper called cpu_supports_mte() that exposes information
about whether the CPU supports memory tagging and that can be called
during early boot (unlike system_supports_mte()).

Use that helper to implement a generic cpu_supports_tags() helper, that
will be used by hardware tag-based KASAN.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/Ib4b56a42c57c6293df29a0cdfee334c3ca7bdab4
---
 arch/arm64/include/asm/memory.h    |  1 +
 arch/arm64/include/asm/mte-kasan.h |  6 ++++++
 arch/arm64/kernel/mte.c            | 20 ++++++++++++++++++++
 mm/kasan/kasan.h                   |  4 ++++
 4 files changed, 31 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b5d6b824c21c..f496abfcf7f5 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -232,6 +232,7 @@ static inline const void *__tag_set(const void *addr, u8 tag)
 }
 
 #ifdef CONFIG_KASAN_HW_TAGS
+#define arch_cpu_supports_tags()		cpu_supports_mte()
 #define arch_init_tags(max_tag)			mte_init_tags(max_tag)
 #define arch_get_random_tag()			mte_get_random_tag()
 #define arch_get_mem_tag(addr)			mte_get_mem_tag(addr)
diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
index a4c61b926d4a..4c3f2c6b4fe6 100644
--- a/arch/arm64/include/asm/mte-kasan.h
+++ b/arch/arm64/include/asm/mte-kasan.h
@@ -9,6 +9,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/init.h>
 #include <linux/types.h>
 
 /*
@@ -30,6 +31,7 @@ u8 mte_get_random_tag(void);
 void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
 
 void mte_init_tags(u64 max_tag);
+bool __init cpu_supports_mte(void);
 
 #else /* CONFIG_ARM64_MTE */
 
@@ -54,6 +56,10 @@ static inline void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
 static inline void mte_init_tags(u64 max_tag)
 {
 }
+static inline bool cpu_supports_mte(void)
+{
+	return false;
+}
 
 #endif /* CONFIG_ARM64_MTE */
 
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index ca8206b7f9a6..8fcd17408515 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -134,6 +134,26 @@ void mte_init_tags(u64 max_tag)
 	gcr_kernel_excl = ~incl & SYS_GCR_EL1_EXCL_MASK;
 }
 
+/*
+ * This function can be used during early boot to determine whether the CPU
+ * supports MTE. The alternative that must be used after boot is completed is
+ * system_supports_mte(), but it only works after the cpufeature framework
+ * learns about MTE.
+ */
+bool __init cpu_supports_mte(void)
+{
+	u64 pfr1;
+	u32 val;
+
+	if (!IS_ENABLED(CONFIG_ARM64_MTE))
+		return false;
+
+	pfr1 = read_cpuid(ID_AA64PFR1_EL1);
+	val = cpuid_feature_extract_unsigned_field(pfr1, ID_AA64PFR1_MTE_SHIFT);
+
+	return val >= ID_AA64PFR1_MTE;
+}
+
 static void update_sctlr_el1_tcf0(u64 tcf0)
 {
 	/* ISB required for the kernel uaccess routines */
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index da08b2533d73..f7ae0c23f023 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -240,6 +240,9 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 #define set_tag(addr, tag)	((void *)arch_kasan_set_tag((addr), (tag)))
 #define get_tag(addr)		arch_kasan_get_tag(addr)
 
+#ifndef arch_cpu_supports_tags
+#define arch_cpu_supports_tags() (false)
+#endif
 #ifndef arch_init_tags
 #define arch_init_tags(max_tag)
 #endif
@@ -253,6 +256,7 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 #define arch_set_mem_tag_range(addr, size, tag) ((void *)(addr))
 #endif
 
+#define cpu_supports_tags()			arch_cpu_supports_tags()
 #define init_tags(max_tag)			arch_init_tags(max_tag)
 #define get_random_tag()			arch_get_random_tag()
 #define get_mem_tag(addr)			arch_get_mem_tag(addr)
-- 
2.29.0.rc1.297.gfa9743e501-goog

