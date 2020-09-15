Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372A826AF95
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgIOVah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgIOVQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:16:48 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86E0C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:16:47 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id 99so3183134qva.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=PJMOcA8gqYHqxhIXShAJ08j6C1UfzhHyZzvegxBV4p8=;
        b=Pyez5vKz+XLZ00ncbPcRUbrzjMjQrhm4FyXOKO0rf6GibdPjrahX4Dav2SHfv1yhRT
         i+YdOyuFp7w811xTJhmS8U5yzQA1RiOozM52MmAJYzwigWzxwukAtwabIZ62PQJwet4m
         /NLPTWYJlfPY/5F5DXaspPdyP2BsnQFdE52otIMmNbLJjT3/4dh4I9oIm/YejEYaie4R
         nQA5dszVd+YZ9oX2VErcwOMwi7vDvgwqbTCzlnbwzfKO3rdq1z/f2yzTupMx23vej94N
         lhtF+yoHeVLagt1I4Lqle8dAvBLPSY0uLRmZZt1Vyktpmw8FDsmMASdlOKNxxj4GWDjU
         RfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PJMOcA8gqYHqxhIXShAJ08j6C1UfzhHyZzvegxBV4p8=;
        b=htqDJ5qcc7R/H8G8btGnnsd0Q4GyJvDV+U3zV3lugDPDql8GBz8MkyyCMNMOR7dO17
         FjbIaJoPcfnXBGLJZu13zIQ0JzH5rSD/2IEp0r+UWHTDri37J5alBn/2XCw8/sqlYZVF
         2yJDJJS93eJZAcrmKfzC20P1pxHHH5wEonYtQRI9Ms+XFdJHeMnNMhND+mAz2ZU9vmRR
         /oekTE4g7wa23DkOpTIp/PRYd6vEVcv4t/wV/bqEawzJHkF1tA0zEMVYY+PhXYDP0FZw
         cqIC7KeO7Nf+WUuhI9oE6fvTfmmHLSF0A/W4x5xe7FwY3A0YESK8MUgKXGdLkgg0wzzX
         Q6Iw==
X-Gm-Message-State: AOAM533iDGoPgHZQjo5LZVlufIIqxakNoeNbrb/L4EEDcm+h4+GzDC5Q
        zCfVuk6Pz6clnawwZwUtN8g2R0BoPlcm+fi+
X-Google-Smtp-Source: ABdhPJyhaTd4yQYZ8onO2P+Zy+eqzSStAHDt5/e2wfJn4SyvBNEh8CRe7qqQKWFJB8cy29L9yd907X0cOOY8mKev
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:5743:: with SMTP id
 q3mr19874682qvx.6.1600204607062; Tue, 15 Sep 2020 14:16:47 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:15:52 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <29aaa1e9ab63d03891f8fae268a5f71582db5778.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 10/37] kasan: hide invalid free check implementation
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

For software KASAN modes the check is based on the value in the shadow
memory. Hardware tag-based KASAN won't be using shadow, so hide the
implementation of the check in check_invalid_free().

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Change-Id: I5fae9531c9fc948eb4d4e0c589744032fc5a0789
---
 mm/kasan/common.c  | 19 +------------------
 mm/kasan/generic.c |  7 +++++++
 mm/kasan/kasan.h   |  2 ++
 mm/kasan/tags.c    | 12 ++++++++++++
 4 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 43a927e70067..a2321d35390e 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -277,25 +277,9 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
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
@@ -314,8 +298,7 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 	if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
 		return false;
 
-	shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(object));
-	if (shadow_invalid(tag, shadow_byte)) {
+	if (check_invalid_free(tagged_object)) {
 		kasan_report_invalid_free(tagged_object, ip);
 		return true;
 	}
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index f6d68aa9872f..73f4d786ad5d 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -192,6 +192,13 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
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
index c31e2c739301..cf6a135860f2 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -163,6 +163,8 @@ void kasan_poison_memory(const void *address, size_t size, u8 value);
 bool check_memory_region(unsigned long addr, size_t size, bool write,
 				unsigned long ret_ip);
 
+bool check_invalid_free(void *addr);
+
 void *find_first_bad_addr(void *addr, size_t size);
 const char *get_bug_type(struct kasan_access_info *info);
 
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 4d5a1fe8251f..feb42c1763b8 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -126,6 +126,18 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
 	return true;
 }
 
+bool check_invalid_free(void *addr)
+{
+	u8 tag = get_tag(addr);
+	u8 shadow_byte = READ_ONCE(*(u8 *)kasan_mem_to_shadow(reset_tag(addr)));
+
+	if (shadow_byte == KASAN_TAG_INVALID)
+		return true;
+	if (tag != KASAN_TAG_KERNEL && tag != shadow_byte)
+		return true;
+	return false;
+}
+
 #define DEFINE_HWASAN_LOAD_STORE(size)					\
 	void __hwasan_load##size##_noabort(unsigned long addr)		\
 	{								\
-- 
2.28.0.618.gf4bc123cb7-goog

