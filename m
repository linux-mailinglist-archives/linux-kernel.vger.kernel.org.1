Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97CA2A737A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387448AbgKEACz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgKEACx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:02:53 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D295AC0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 16:02:52 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id t64so44922qkd.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 16:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/zD7WZPyOqitLWvnpsu4/VKPhFmibJDXB/9ojacn4YU=;
        b=DwhOeulf583kaNb7jVHS5Ju0oa1dB7TrWi/R74xwn9ypCjTjRyYu4S8mpn18QDz9h6
         pT0vF/yvBwh0+yLH/hwX3jrJc3VBDxn//Ereo6E9UElkpvh2qx9EdDD8loDgsfhHC8zh
         /H81ILLovNBrBT7gnCrmEGE3Hhz43hkPqoNJgdV+2pOGCS1BFKJ7i13Zp1VZHe6XFaIp
         jn4gXLXl+JEcEF3ImyfvsKrHHAE1zL5Sklo2KONJoFsQ6K4WK/fRubaG3V2m+OzSf0fK
         4EUGukjbRkVVQM+qlOKiwuaeSn3pwok6hhAoIzm5rWvkIQ7+3EagaNQNqGwDm+x+1tJZ
         6coQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/zD7WZPyOqitLWvnpsu4/VKPhFmibJDXB/9ojacn4YU=;
        b=Fq8BEn3RAUxHJHrHhs0tdtbF8CE2CHu2ZsiEdWis6AYiwk/yH2cj5qPXngXqwx5UHx
         WkI3Klf9z9yYJT5OoFqzM54uS1tX7XG9GCqbnEesd1+glGEbbbQztkb1DUfvWIN8o5O7
         ppzvwv513QR5lIubD/Zfe4db+8S0PiLU5lGlbOcl7Cr8LXeWwmNSBbZ+ENqA6KX1YC26
         K1u0WCl9oJ7fLJIzh1AJFA0BXvDHYcWCnI2hfhtEFuNLXNBwgzHH1qtbGYguul2sYiKj
         NIlmPjxPOaAetqI2qeadaPgeqwuC5XmD/bDXgwBAwGfwVDHl9XBfUIJmXgvVwmvmVDe8
         xg2Q==
X-Gm-Message-State: AOAM530KWG2BnHHdfa5MayvKgNfBiAh/jUwR6I5L3lzl/ScwDd037aiS
        W3P70+i0XLgKMJwMtML1wNr/1000f3mF+fUR
X-Google-Smtp-Source: ABdhPJx8UCj7hDKh8Iv5Gz2Yjdfp1h/FlWdPy/wN7f+g1RtFnkwPWjZFqkJyR10HO5jKvmjyPuN4iXlFK++lmqPj
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:45ca:: with SMTP id
 v10mr546432qvt.36.1604534571983; Wed, 04 Nov 2020 16:02:51 -0800 (PST)
Date:   Thu,  5 Nov 2020 01:02:17 +0100
In-Reply-To: <cover.1604534322.git.andreyknvl@google.com>
Message-Id: <a34436af3e3383001fa6232834bd6d46687bda22.1604534322.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604534322.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 07/20] kasan: inline kasan_reset_tag for tag-based modes
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

Using kasan_reset_tag() currently results in a function call. As it's
called quite often from the allocator code, this leads to a noticeable
slowdown. Move it to include/linux/kasan.h and turn it into a static
inline function. Also remove the now unneeded reset_tag() internal KASAN
macro and use kasan_reset_tag() instead.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
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
index 2c37a39b76ed..0211a4ec5d87 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -191,7 +191,10 @@ static inline void kasan_record_aux_stack(void *ptr) {}
 
 #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
 
-void *kasan_reset_tag(const void *addr);
+static inline void *kasan_reset_tag(const void *addr)
+{
+	return (void *)arch_kasan_reset_tag(addr);
+}
 
 bool kasan_report(unsigned long addr, size_t size,
 		bool is_write, unsigned long ip);
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 9008fc6b0810..a266b90636a1 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -174,14 +174,14 @@ size_t kasan_metadata_size(struct kmem_cache *cache)
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
@@ -278,7 +278,7 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 
 	tag = get_tag(object);
 	tagged_object = object;
-	object = reset_tag(object);
+	object = kasan_reset_tag(object);
 
 	if (unlikely(nearest_obj(cache, virt_to_head_page(object), object) !=
 	    object)) {
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index d858aeb7387f..fe8e6c8e6319 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -26,20 +26,15 @@ void kasan_init_hw_tags(void)
 		pr_info("KernelAddressSanitizer initialized\n");
 }
 
-void *kasan_reset_tag(const void *addr)
-{
-	return reset_tag(addr);
-}
-
 void kasan_poison_memory(const void *address, size_t size, u8 value)
 {
-	hw_set_mem_tag_range(reset_tag(address),
+	hw_set_mem_tag_range(kasan_reset_tag(address),
 			round_up(size, KASAN_GRANULE_SIZE), value);
 }
 
 void kasan_unpoison_memory(const void *address, size_t size)
 {
-	hw_set_mem_tag_range(reset_tag(address),
+	hw_set_mem_tag_range(kasan_reset_tag(address),
 			round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
 }
 
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 5513b4685007..e9c7d061fbe5 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -246,15 +246,11 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
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
index 0cac53a57c14..25ca66c99e48 100644
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
index 616ac64c4a21..8e4fa9157a0b 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -81,7 +81,7 @@ void kasan_poison_memory(const void *address, size_t size, u8 value)
 	 * some of the callers (e.g. kasan_poison_object_data) pass tagged
 	 * addresses to this function.
 	 */
-	address = reset_tag(address);
+	address = kasan_reset_tag(address);
 
 	shadow_start = kasan_mem_to_shadow(address);
 	shadow_end = kasan_mem_to_shadow(address + size);
@@ -98,7 +98,7 @@ void kasan_unpoison_memory(const void *address, size_t size)
 	 * some of the callers (e.g. kasan_unpoison_object_data) pass tagged
 	 * addresses to this function.
 	 */
-	address = reset_tag(address);
+	address = kasan_reset_tag(address);
 
 	kasan_poison_memory(address, size, tag);
 
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index 3bffb489b144..d1af6f6c6d12 100644
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
2.29.1.341.ge80a0c044ae-goog

