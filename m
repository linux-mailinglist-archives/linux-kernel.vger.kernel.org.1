Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0406C2B2873
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgKMWUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgKMWUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:20:32 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CAFC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:32 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id y5so6645855qtb.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0OoqMffsjTTjhNupRd8vITAFnXjp5GgZqecD32hcplM=;
        b=FZDE1cHfOmQH1YZ0oOuJY3WlcugPrZbEyGzYQnbBkc0IT7XwtcLMCjRyRdH8ImmzbI
         2ocq7RBkVv0T7TZ/ItJjt3h3KQRB0IHBrbddDM9bFsr11+98UW1k9dmhda+JmYfs1Kp8
         fZAqGERt02DDohNi3YXRNdYrB7CB0UMeRAfIAdIIviGWokrAidrBjArp+x9WQD78/1RV
         35bpHCDJWfjRqal1SZ/i8ugrTnvHwj2sjFNoiFGL4Xy9cNl94xb6x2HYVUt2HgvwcT23
         p50qE9wOzHhGqUbIl548ljaTXZ3q8gYTvA5ewEWeMuVkGPQTSmioHFPjDZAF28MSR4aU
         ilgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0OoqMffsjTTjhNupRd8vITAFnXjp5GgZqecD32hcplM=;
        b=oc1dXxDb78yZrWvnjFAiV1333k6k9Syms7UCl27vUkhB1sSCDIwh0OMs3wbkQmzs1u
         jjVaMEvetzUxn9uCEwfSvaHcUX9bvD6sak2NH5rO14eDlW0v+XX06CZpAt817lhLLhww
         ZwkA+OvFH2/vcmtIijbGAvtaxFxNK6IkqBDIR2DFv9BG2ZxPHVUXJShl0XLsuaLWC4Dn
         8tswULvXi0WfLeZBXltaW6rBufUHXLK8gcbo1Cslj0GHEGA4ZbbCGsATXIF0Ihw1It4F
         pKjPfEDfDPUYoBddArpRC1LOz5x/h3FdZK0PIIJwQLXzStqwI25+0K/RiDqs6OrTURnG
         LM7Q==
X-Gm-Message-State: AOAM530Be3Coysbpi9Juo/xUrFuxrmVeckMuGlWPdu5x1dZljlIKcTuU
        2tOLUFe4BBOqpxMrae8/KMM/FipXoe+kjLhn
X-Google-Smtp-Source: ABdhPJzDRFa4RTm2nDemL1ACuZ/b+tyJABImv2YFhSvfbxTLtvqZK6x+uT+0itTrLD1GAF2tY8oJ/5dvraqEEPYP
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:b418:: with SMTP id
 u24mr4838113qve.4.1605306031906; Fri, 13 Nov 2020 14:20:31 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:19:57 +0100
In-Reply-To: <cover.1605305978.git.andreyknvl@google.com>
Message-Id: <4c2a23ccb3572459da7585a776d2d45f6e8b8580.1605305978.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v3 07/19] kasan: inline kasan_reset_tag for tag-based modes
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

Using kasan_reset_tag() currently results in a function call. As it's
called quite often from the allocator code, this leads to a noticeable
slowdown. Move it to include/linux/kasan.h and turn it into a static
inline function. Also remove the now unneeded reset_tag() internal KASAN
macro and use kasan_reset_tag() instead.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Link: https://linux-review.googlesource.com/id/I4d2061acfe91d480a75df00b07c22d8494ef14b5
---
 include/linux/kasan.h     | 5 ++++-
 mm/kasan/common.c         | 6 +++---
 mm/kasan/hw_tags.c        | 9 ++-------
 mm/kasan/kasan.h          | 4 ----
 mm/kasan/report.c         | 4 ++--
 mm/kasan/report_hw_tags.c | 2 +-
 mm/kasan/report_sw_tags.c | 4 ++--
 mm/kasan/shadow.c         | 4 ++--
 mm/kasan/sw_tags.c        | 9 ++-------
 9 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index f2109bf0c5f9..1594177f86bb 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -193,7 +193,10 @@ static inline void kasan_record_aux_stack(void *ptr) {}
 
 #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
 
-void *kasan_reset_tag(const void *addr);
+static inline void *kasan_reset_tag(const void *addr)
+{
+	return (void *)arch_kasan_reset_tag(addr);
+}
 
 bool kasan_report(unsigned long addr, size_t size,
 		bool is_write, unsigned long ip);
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index fabd843eff3d..1ac4f435c679 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -180,14 +180,14 @@ size_t kasan_metadata_size(struct kmem_cache *cache)
 struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
 					      const void *object)
 {
-	return (void *)reset_tag(object) + cache->kasan_info.alloc_meta_offset;
+	return kasan_reset_tag(object) + cache->kasan_info.alloc_meta_offset;
 }
 
 struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
 					    const void *object)
 {
 	BUILD_BUG_ON(sizeof(struct kasan_free_meta) > 32);
-	return (void *)reset_tag(object) + cache->kasan_info.free_meta_offset;
+	return kasan_reset_tag(object) + cache->kasan_info.free_meta_offset;
 }
 
 void kasan_poison_slab(struct page *page)
@@ -284,7 +284,7 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 
 	tag = get_tag(object);
 	tagged_object = object;
-	object = reset_tag(object);
+	object = kasan_reset_tag(object);
 
 	if (is_kfence_address(object))
 		return false;
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 68e77363e58b..a34476764f1d 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -31,18 +31,13 @@ void __init kasan_init_hw_tags(void)
 	pr_info("KernelAddressSanitizer initialized\n");
 }
 
-void *kasan_reset_tag(const void *addr)
-{
-	return reset_tag(addr);
-}
-
 void poison_range(const void *address, size_t size, u8 value)
 {
 	/* Skip KFENCE memory if called explicitly outside of sl*b. */
 	if (is_kfence_address(address))
 		return;
 
-	hw_set_mem_tag_range(reset_tag(address),
+	hw_set_mem_tag_range(kasan_reset_tag(address),
 			round_up(size, KASAN_GRANULE_SIZE), value);
 }
 
@@ -52,7 +47,7 @@ void unpoison_range(const void *address, size_t size)
 	if (is_kfence_address(address))
 		return;
 
-	hw_set_mem_tag_range(reset_tag(address),
+	hw_set_mem_tag_range(kasan_reset_tag(address),
 			round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
 }
 
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 0eab7e4cecb8..5e8cd2080369 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -248,15 +248,11 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 	return addr;
 }
 #endif
-#ifndef arch_kasan_reset_tag
-#define arch_kasan_reset_tag(addr)	((void *)(addr))
-#endif
 #ifndef arch_kasan_get_tag
 #define arch_kasan_get_tag(addr)	0
 #endif
 
 #define set_tag(addr, tag)	((void *)arch_kasan_set_tag((addr), (tag)))
-#define reset_tag(addr)		((void *)arch_kasan_reset_tag(addr))
 #define get_tag(addr)		arch_kasan_get_tag(addr)
 
 #ifdef CONFIG_KASAN_HW_TAGS
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index df16bef0d810..76a0e3ae2049 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -328,7 +328,7 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
 	unsigned long flags;
 	u8 tag = get_tag(object);
 
-	object = reset_tag(object);
+	object = kasan_reset_tag(object);
 
 #if IS_ENABLED(CONFIG_KUNIT)
 	if (current->kunit_test)
@@ -361,7 +361,7 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 	disable_trace_on_warning();
 
 	tagged_addr = (void *)addr;
-	untagged_addr = reset_tag(tagged_addr);
+	untagged_addr = kasan_reset_tag(tagged_addr);
 
 	info.access_addr = tagged_addr;
 	if (addr_has_metadata(untagged_addr))
diff --git a/mm/kasan/report_hw_tags.c b/mm/kasan/report_hw_tags.c
index da543eb832cd..57114f0e14d1 100644
--- a/mm/kasan/report_hw_tags.c
+++ b/mm/kasan/report_hw_tags.c
@@ -22,7 +22,7 @@ const char *get_bug_type(struct kasan_access_info *info)
 
 void *find_first_bad_addr(void *addr, size_t size)
 {
-	return reset_tag(addr);
+	return kasan_reset_tag(addr);
 }
 
 void metadata_fetch_row(char *buffer, void *row)
diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
index 317100fd95b9..7604b46239d4 100644
--- a/mm/kasan/report_sw_tags.c
+++ b/mm/kasan/report_sw_tags.c
@@ -41,7 +41,7 @@ const char *get_bug_type(struct kasan_access_info *info)
 	int i;
 
 	tag = get_tag(info->access_addr);
-	addr = reset_tag(info->access_addr);
+	addr = kasan_reset_tag(info->access_addr);
 	page = kasan_addr_to_page(addr);
 	if (page && PageSlab(page)) {
 		cache = page->slab_cache;
@@ -72,7 +72,7 @@ const char *get_bug_type(struct kasan_access_info *info)
 void *find_first_bad_addr(void *addr, size_t size)
 {
 	u8 tag = get_tag(addr);
-	void *p = reset_tag(addr);
+	void *p = kasan_reset_tag(addr);
 	void *end = p + size;
 
 	while (p < end && tag == *(u8 *)kasan_mem_to_shadow(p))
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index d8a122f887a0..37153bd1c126 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -82,7 +82,7 @@ void poison_range(const void *address, size_t size, u8 value)
 	 * some of the callers (e.g. kasan_poison_object_data) pass tagged
 	 * addresses to this function.
 	 */
-	address = reset_tag(address);
+	address = kasan_reset_tag(address);
 
 	/* Skip KFENCE memory if called explicitly outside of sl*b. */
 	if (is_kfence_address(address))
@@ -103,7 +103,7 @@ void unpoison_range(const void *address, size_t size)
 	 * some of the callers (e.g. kasan_unpoison_object_data) pass tagged
 	 * addresses to this function.
 	 */
-	address = reset_tag(address);
+	address = kasan_reset_tag(address);
 
 	/*
 	 * Skip KFENCE memory if called explicitly outside of sl*b. Also note
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index 6d7648cc3b98..e17de2619bbf 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -67,11 +67,6 @@ u8 random_tag(void)
 	return (u8)(state % (KASAN_TAG_MAX + 1));
 }
 
-void *kasan_reset_tag(const void *addr)
-{
-	return reset_tag(addr);
-}
-
 bool check_memory_region(unsigned long addr, size_t size, bool write,
 				unsigned long ret_ip)
 {
@@ -107,7 +102,7 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
 	if (tag == KASAN_TAG_KERNEL)
 		return true;
 
-	untagged_addr = reset_tag((const void *)addr);
+	untagged_addr = kasan_reset_tag((const void *)addr);
 	if (unlikely(untagged_addr <
 			kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
 		return !kasan_report(addr, size, write, ret_ip);
@@ -126,7 +121,7 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
 bool check_invalid_free(void *addr)
 {
 	u8 tag = get_tag(addr);
-	u8 shadow_byte = READ_ONCE(*(u8 *)kasan_mem_to_shadow(reset_tag(addr)));
+	u8 shadow_byte = READ_ONCE(*(u8 *)kasan_mem_to_shadow(kasan_reset_tag(addr)));
 
 	return (shadow_byte == KASAN_TAG_INVALID) ||
 		(tag != KASAN_TAG_KERNEL && tag != shadow_byte);
-- 
2.29.2.299.gdc1121823c-goog

