Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C2B2B2812
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgKMWQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgKMWQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:16:44 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14287C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:16:44 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id i39so6655706qtb.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KBw2xb89iGf5nkQBhVPMBrv+WXUlpFCEGVTeqj9IKE8=;
        b=kEaoU6imARJ9PUMGylo3WxrvNJwhz4ehol5ihwX1PAJZetS+MYeRsmLL73YYgZJPSj
         Y1to6lX3L3cZywbseOl5yJksMji3kaOqt5ZEvniI49snje8Yn7/BqWcjwSRkOyDMStR9
         u0UH19eQdTaD7lyammRYs91tUiy1mx+SlweE8yjpHaXB+D4rIyALl/bOswEGdcXyo4ir
         /uotDXbwDUcN93YlnCwaj+NWLIPhIcE20bCRcldSJoQRvhxBZXVdNMjev6tvLfvsE1c/
         OWDZy5n0UnAhwdiLLnq7YQCs5rB7gMRE0EToE+ZffqJCxIS7vKMt/zoshLvu8CU2Kpy0
         fnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KBw2xb89iGf5nkQBhVPMBrv+WXUlpFCEGVTeqj9IKE8=;
        b=jdNU9VPq6FYEa6iR2MKk58SqtqRyjvTZAsbIg8FRd8Hce309kqQ3Z6hv2qhHXDQXyZ
         jMTtX8iG+596tn/x5xibHc3lWFaIbldTHz1ldYKGikDuUW19BNB+utWtIs5/lNBLRuIX
         k3M8ukqbBeYvLYGUkekV9KxUWKC+gl6OpnNLIkKgaB9oF8dXg2pYMkGRgnrSrgpXbqZg
         zLRlUo31H65I20nDjJmyQhjkQpKdsch2sekgPWSw6+0Ob9zJB/bYa6BY4HlgyHfLhJ9K
         1gJ59qeWZMyGa8EfmLhlUh75DQoN06KF2AvqWmWZU74fVffg1pJ7m/Zgi9inGLsW3rsX
         FPFA==
X-Gm-Message-State: AOAM530mCniSrLY1oFw8hondr2znLQ2XirV5sUw+04eku2gSlen5n7Lb
        mobvL2mnNJLIh6bUhqyXfK987CURNNkiWi4b
X-Google-Smtp-Source: ABdhPJz28oDTu0JrMVUyvh42LUnx0OaovzkH2m5z3QnEQ90fl2RtrA3qpCClpjEC/kSPUPZ0vfdSYddbzI61o9DW
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:54cd:: with SMTP id
 j13mr4460435qvx.8.1605305803272; Fri, 13 Nov 2020 14:16:43 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:15:40 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <6b1a801b2132bf11e19c4421b2b079d242b152f3.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 12/42] kasan: hide invalid free check implementation
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
Reviewed-by: Alexander Potapenko <glider@google.com>
---
Change-Id: I5fae9531c9fc948eb4d4e0c589744032fc5a0789
---
 mm/kasan/common.c  | 19 +------------------
 mm/kasan/generic.c |  7 +++++++
 mm/kasan/kasan.h   |  2 ++
 mm/kasan/sw_tags.c |  9 +++++++++
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index b3ebee6fcfca..ae55570b4d32 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -278,25 +278,9 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
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
@@ -318,8 +302,7 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 	if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
 		return false;
 
-	shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(object));
-	if (shadow_invalid(tag, shadow_byte)) {
+	if (check_invalid_free(tagged_object)) {
 		kasan_report_invalid_free(tagged_object, ip);
 		return true;
 	}
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 754217c258a8..67642acafe92 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -188,6 +188,13 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
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
index eec88bf28c64..e5b5f60bc963 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -166,6 +166,8 @@ void unpoison_range(const void *address, size_t size);
 bool check_memory_region(unsigned long addr, size_t size, bool write,
 				unsigned long ret_ip);
 
+bool check_invalid_free(void *addr);
+
 void *find_first_bad_addr(void *addr, size_t size);
 const char *get_bug_type(struct kasan_access_info *info);
 
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index c0b3f327812b..64540109c461 100644
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
2.29.2.299.gdc1121823c-goog

