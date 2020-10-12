Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F7228C30C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389427AbgJLUpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388859AbgJLUpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:45:43 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A74C0613D5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:43 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id w126so13584194qka.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=w5C2W2DY9SAvZH/qaocnCGPCQ8ZMERi9GQeckWB8bok=;
        b=Qb8mGGA59hLL96H9n4wZTwTCQmo2f1Y8s2N9qAyX44nKBmlSwKIJyA2fOpSDTEEY62
         1a7SmrGdLrxGFJGvQtaI0zf/crGciYHNobZdRWuQGZz3xjiEI0GEF0k5F0MDyi73Fn8g
         Sf2hHuxdnJ3GDLwDLG/hJ3+D1yOw6M2odk3mjtcKfqHY9WiuMoSQl2ClemQ8k/3j2vgr
         xxJ+VJR3q0dqRb35yh1fT9gOBc4PF8RXVwQvUFln48jiK7X2kEUCheygNRm3stKJMVXd
         XNemY7BWfdoM24VrlCBpqDjPGFgpVecwmO4v/eKVagK9h49SQkA/lZrtmxZkqe280vK2
         jBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w5C2W2DY9SAvZH/qaocnCGPCQ8ZMERi9GQeckWB8bok=;
        b=opVVCf02rJsNYk7b6bMZWlfiBM0p92na35kyrN8O4g09yrmzl4zbE38Dq/16DVRvjk
         rfisllqpMx2iDQw3a789w4IHTCaCV1090JI7gL/vvUZy7ErbHcb5VUtC2tUysXdpVK1X
         cq4IwSqQ20UK2eR46RxEi9oUfo9Lf69CKWeY+BFHASpotCHEbWW6eLx+GMhs529wDwpf
         8L5Mz04Iy57pVK1sdWSyHJE291fnn2cdl8plplmRNOQ3cbo/yGs+Vzn4USw6sYLXK+pL
         of4pylOfKtSOXZvHReoDHAdyshm9tMu2QALKpBAfXAdXBKyqW+ClO7RxLZ8z6w5UaU82
         UPkA==
X-Gm-Message-State: AOAM533OZi8CMy0EaE7eejAcomScBVqZ3n+Olvaw6OTmMxEYkmmltUjU
        LcAplJr7qKHUwkuzd9vq4iG2uBH0xW0tnsyN
X-Google-Smtp-Source: ABdhPJx0+G225vjwuSVOUfMcvs4JiztOy++XKHcZN1gNDyorfaVWZ/mhsXfgInQFZnY6Tnkq7csSN/Fy301L4VKV
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:146e:: with SMTP id
 c14mr26719107qvy.22.1602535542528; Mon, 12 Oct 2020 13:45:42 -0700 (PDT)
Date:   Mon, 12 Oct 2020 22:44:27 +0200
In-Reply-To: <cover.1602535397.git.andreyknvl@google.com>
Message-Id: <1d1755d107694267933ccf22045f9d4480a00593.1602535397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602535397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 21/40] kasan: hide invalid free check implementation
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

For software KASAN modes the check is based on the value in the shadow
memory. Hardware tag-based KASAN won't be using shadow, so hide the
implementation of the check in check_invalid_free().

Also simplify the code for software tag-based mode.

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: I5fae9531c9fc948eb4d4e0c589744032fc5a0789
---
 mm/kasan/common.c  | 19 +------------------
 mm/kasan/generic.c |  7 +++++++
 mm/kasan/kasan.h   |  2 ++
 mm/kasan/sw_tags.c |  9 +++++++++
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 123abfb760d4..543e6bf2168f 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -272,25 +272,9 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
 	return (void *)object;
 }
 
-static inline bool shadow_invalid(u8 tag, s8 shadow_byte)
-{
-	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
-		return shadow_byte < 0 ||
-			shadow_byte >= KASAN_GRANULE_SIZE;
-
-	/* else CONFIG_KASAN_SW_TAGS: */
-	if ((u8)shadow_byte == KASAN_TAG_INVALID)
-		return true;
-	if ((tag != KASAN_TAG_KERNEL) && (tag != (u8)shadow_byte))
-		return true;
-
-	return false;
-}
-
 static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 			      unsigned long ip, bool quarantine)
 {
-	s8 shadow_byte;
 	u8 tag;
 	void *tagged_object;
 	unsigned long rounded_up_size;
@@ -309,8 +293,7 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 	if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
 		return false;
 
-	shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(object));
-	if (shadow_invalid(tag, shadow_byte)) {
+	if (check_invalid_free(tagged_object)) {
 		kasan_report_invalid_free(tagged_object, ip);
 		return true;
 	}
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index ec4417156943..e1af3b6c53b8 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -187,6 +187,13 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
 	return check_memory_region_inline(addr, size, write, ret_ip);
 }
 
+bool check_invalid_free(void *addr)
+{
+	s8 shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(addr));
+
+	return shadow_byte < 0 || shadow_byte >= KASAN_GRANULE_SIZE;
+}
+
 void kasan_cache_shrink(struct kmem_cache *cache)
 {
 	quarantine_remove_cache(cache);
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index a2e71818d464..325bfd82bce4 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -164,6 +164,8 @@ void kasan_poison_memory(const void *address, size_t size, u8 value);
 bool check_memory_region(unsigned long addr, size_t size, bool write,
 				unsigned long ret_ip);
 
+bool check_invalid_free(void *addr);
+
 void *find_first_bad_addr(void *addr, size_t size);
 const char *get_bug_type(struct kasan_access_info *info);
 
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index 4bdd7dbd6647..b2638c2cd58a 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -121,6 +121,15 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
 	return true;
 }
 
+bool check_invalid_free(void *addr)
+{
+	u8 tag = get_tag(addr);
+	u8 shadow_byte = READ_ONCE(*(u8 *)kasan_mem_to_shadow(reset_tag(addr)));
+
+	return (shadow_byte == KASAN_TAG_INVALID) ||
+		(tag != KASAN_TAG_KERNEL && tag != shadow_byte);
+}
+
 #define DEFINE_HWASAN_LOAD_STORE(size)					\
 	void __hwasan_load##size##_noabort(unsigned long addr)		\
 	{								\
-- 
2.28.0.1011.ga647a8990f-goog

