Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABBA2C15D6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgKWUIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730196AbgKWUIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:08:47 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE7FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:08:47 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id dp12so13784854qvb.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VsAI4kIskvc7OgbGXOlaJf5U20hpa/63jMpnaocWLWM=;
        b=lgtA4NzRKL/sS7cId/OtSk8bpsKjz14BloPlYcl+E2erZjK92bXsA4p8a37FOE46k6
         Zu2Mkr+TVz0sub5GN8es0wA2jSJpZKBjIyQGVbEq5lGruBJThs+asHBSMhEK+pipkSZq
         KtzRRfVyYJL1zFc1GtIZI3Ze4Fqlo7wHN/qS/h/mn88ZzkIm5pgf415vAnBEZLflSx0+
         tpYAzbuveP5T6zeGoIEtqVfguTeqU5eTBcrDaKoUgMEFdl4/p0u2wxRnAkzPlpsfxxu4
         uTMFqHXQyPRhTfOgud0hIITTPSbxXxkeyUSdnBa0yJHwDqVVa/RLBhopPo3S14gqLiHM
         GJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VsAI4kIskvc7OgbGXOlaJf5U20hpa/63jMpnaocWLWM=;
        b=iDojtZpdFy4t/1qWi+82qJkDz0h4lBLOiK/JRK2qP0OrLj2bW42slJmqyEq5S3PNuk
         12LvfJ+JMndNrZErDp1ZuoKU6xmMHWMvGvJbloSA5EqP1Q88cegBERTdneHMOtH66sXo
         lCEpLh+8hQ+xWgR7kmobbrjujAck33N7HbcLNALZTagNo9KtGgW/B3DRYshbrhmmOEms
         fgUtVVPiJuXFU4DEQbzxDURvIvpaD+qW2EszKMrbSkEcF0HC4SCcI3zP2NBtuD6LQ7/I
         XZU6dK4d5gTmMTIt0B5GS6JtEnjKgkwxpITAHUNnMFdMtWqAG39ixVeWfQ60XVt7aoQZ
         PF9A==
X-Gm-Message-State: AOAM531QG8azK3SnsnC7sDGcURu6AFxjU0uVLJi6UDVAfQaM1FRpNJyZ
        K7O0rsZvxLUa8wAkEY0Jo5IS3DynP0Jm3g9b
X-Google-Smtp-Source: ABdhPJzQ44VzGDQGjD82W9CmwEaWld7rLNdT6Y1+lJuUYaoCWdvd/M8e9RFhUQ1m43P7Ba8CtJwX2RPN19SUuUND
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:eac4:: with SMTP id
 y4mr1106877qvp.19.1606162126939; Mon, 23 Nov 2020 12:08:46 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:07:36 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <d01534a4b977f97d87515dc590e6348e1406de81.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 12/42] kasan: hide invalid free check implementation
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
2.29.2.454.gaff20da3a2-goog

