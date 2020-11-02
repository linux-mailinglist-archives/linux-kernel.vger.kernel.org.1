Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173752A2F4D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgKBQHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgKBQFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:05:22 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A593BC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:05:20 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id e3so6616895wrn.19
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JrbTjwkrdKqcTf3OBQQXqXKZQLwLc5XAsTu4uoIDNkU=;
        b=BSLt9OKaearay+FGWxrm4o7h2bkHk/gdUbGPcfYRGHQdZUj8sw/1erDb+9+jujTLw0
         Ug225r6/pntadIDfVbDTace6LXDbzEzYtWFc9wcVlA+lolJ0moGKw3h0zScXyFynl9CB
         BQp4ViTMUAR7sTv9TbxNtHPnaqAT9H3yUKkYK08j0+ZXg5Ar/OwpIWVEdsJE5FxizL4S
         WS2h9maD5lysR8dijjWXKPQLDA59x7DKG1WXtqkgetf/O6iCGhGmLmer1316cHGTushF
         CNq7JLufAyz95XwjMEHNNtSYSt2k+XIy1UfP8Key0nYicM3iGFpuQnzO/Rtd0FJq+vYk
         nlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JrbTjwkrdKqcTf3OBQQXqXKZQLwLc5XAsTu4uoIDNkU=;
        b=J/4mrP3slk+Hm1m2tEFb4jlZL8ZjZuiqZiQaxjFnf0vPTJL4ij/Odx1XsH6dgusvRb
         pX5TV55eoL8pJBr5O5kwfYmoTF+CRaS/97MxSue28XY6wq5GJV0U4AZuz4sPMekNz4EJ
         VK6A9HZ08fV8TQ9auC4p0NiEmxrhEsp9tI5rJ2bdoRJD1/7DYosLApQ8GR0Tebwt6Q0h
         56668bd4J7NWLymINE5mPAUHO11ZTCbXEglsTXNM2deQ6gTBQeH0jqK4H0OVA/sBi/Lp
         xXMlwmfGVjBCxRPRoZlsrs5JYEtgcoGTWHQBUtVvFdzp1TOYGT/IhdU16RL4LGUUxoLy
         Jc+A==
X-Gm-Message-State: AOAM531ErtKafETXyGG0wIJlTWn22Pu5Lw+5FeQByqT0cS+1udtWmN3N
        Dv+ovvQzFVIlhbDMet4vo4jBCJOgZOU8xTrE
X-Google-Smtp-Source: ABdhPJyOvs6s9ctpkM6Ce8d6mYTqLAZR/nAOMWlFghuqE5Zo1zLXZqWjNGBUbKu6n2PsowbXwY5h/PzVQRvYgQue
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a5d:6a85:: with SMTP id
 s5mr21657731wru.90.1604333119324; Mon, 02 Nov 2020 08:05:19 -0800 (PST)
Date:   Mon,  2 Nov 2020 17:04:02 +0100
In-Reply-To: <cover.1604333009.git.andreyknvl@google.com>
Message-Id: <499c0824a10e32c7dbb29c2f28e9a76c771c0da0.1604333009.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 22/41] kasan: hide invalid free check implementation
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
index d8f54efb2899..04df1481a033 100644
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
2.29.1.341.ge80a0c044ae-goog

