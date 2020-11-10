Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A642AE346
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbgKJWU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732374AbgKJWUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:20:51 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467D5C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:20:51 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id j5so8487695qtj.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=WOMasW4WeK4i4aCbvBDhnou95P0GnHEsdPLivTBemP4=;
        b=HbmemqL7hGON1dZUtHAIO/Ny5Z5yXZ4JDxyVyJy817JkkYWiD/QtbND8oC8ab7jCnI
         5Wbp10QDuzYLJu6lNMQ/cilMKfhcOQKdxLo2b2RlUEr9KAST0GqOKpk56Qy0CPfK5YuM
         QKo9+lLsoO9x4ILXIt3sKjhcJ8pdIqjOatB0zmydqRDWzWGHfAAw6YSENtb7o5FoF2si
         lv2RAbcm26eD/cbihEmRP5cwTzv9aHIH9H1rKOeKMG6R8p0oNMZ/gBRAvVBPI42BEMDc
         psc8VI/Zf64SE7/LFloA+ZdjypcKgOsrKstJM34+FhTA1A+KoSlI7qAqvqmoxKnZxc2h
         Df1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WOMasW4WeK4i4aCbvBDhnou95P0GnHEsdPLivTBemP4=;
        b=p0OTVHLLkmaQUeF7aJW3te4IbE/8RGn3XmjyQ/VudvDANXtLu0ixPoOlyJmaZCcZy6
         Q0q5vqPit3UEZ0msGUOvhe9sBx3kagehjWoQEEBV2zuOVNu1jsnBVGsB251Q+bCOK00c
         gXMgpOQwSyQb/fU8mKY1sStPsv1j2V2lHj9CD8aD1r6evbQJ7q/T04YbhC+45AKaifNT
         4L7SQ0LBmrCo6ArUEcN1kQCyCWQq5lG0BABY0TguOezscEbgdB1eb/vMQ8m2ywr2G1EI
         35JngAvKDwg0wCwTREgWKX3EwKZHqjORPGUcBD0HMbuXp/HjaSRds4zBcTkmDPFsX21R
         4zSQ==
X-Gm-Message-State: AOAM5325nEb7t3YR9ADgm+qG8Xrj2lX6pufbZi5qhME7ZM969XHBzOtz
        z0WxJoQB34+E67xmLoNTQobn0ECWNxze08do
X-Google-Smtp-Source: ABdhPJxV3RzH8+DI2bYMl115wXV/xV/YUfiel/zd2PCNwgEqHTxxwM0dmmBMZ8TRZ+cgt1xGGP23OM9y5Oi9AE76
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:9e2f:: with SMTP id
 p47mr14534879qve.11.1605046850374; Tue, 10 Nov 2020 14:20:50 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:20:13 +0100
In-Reply-To: <cover.1605046662.git.andreyknvl@google.com>
Message-Id: <e14ac53d7c43b4381ad94665c63a154dffc04b6b.1605046662.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v2 09/20] kasan: inline kasan_poison_memory and check_invalid_free
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
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

Using kasan_poison_memory() or check_invalid_free() currently results in
function calls. Move their definitions to mm/kasan/kasan.h and turn them
into static inline functions for hardware tag-based mode to avoid
unneeded function calls.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://linux-review.googlesource.com/id/Ia9d8191024a12d1374675b3d27197f10193f50bb
---
 mm/kasan/hw_tags.c | 15 ---------------
 mm/kasan/kasan.h   | 28 ++++++++++++++++++++++++----
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 1476ac07666e..0303e49904b4 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -30,27 +30,12 @@ void kasan_init_hw_tags(void)
 	pr_info("KernelAddressSanitizer initialized\n");
 }
 
-void kasan_poison_memory(const void *address, size_t size, u8 value)
-{
-	hw_set_mem_tag_range(kasan_reset_tag(address),
-			round_up(size, KASAN_GRANULE_SIZE), value);
-}
-
 void kasan_unpoison_memory(const void *address, size_t size)
 {
 	hw_set_mem_tag_range(kasan_reset_tag(address),
 			round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
 }
 
-bool check_invalid_free(void *addr)
-{
-	u8 ptr_tag = get_tag(addr);
-	u8 mem_tag = hw_get_mem_tag(addr);
-
-	return (mem_tag == KASAN_TAG_INVALID) ||
-		(ptr_tag != KASAN_TAG_KERNEL && ptr_tag != mem_tag);
-}
-
 void kasan_set_free_info(struct kmem_cache *cache,
 				void *object, u8 tag)
 {
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 7498839a15d3..ab7314418604 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -153,8 +153,6 @@ struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
 struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
 						const void *object);
 
-void kasan_poison_memory(const void *address, size_t size, u8 value);
-
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
 static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
@@ -194,8 +192,6 @@ void print_tags(u8 addr_tag, const void *addr);
 static inline void print_tags(u8 addr_tag, const void *addr) { }
 #endif
 
-bool check_invalid_free(void *addr);
-
 void *find_first_bad_addr(void *addr, size_t size);
 const char *get_bug_type(struct kasan_access_info *info);
 void metadata_fetch_row(char *buffer, void *row);
@@ -279,6 +275,30 @@ static inline u8 random_tag(void)
 }
 #endif
 
+#ifdef CONFIG_KASAN_HW_TAGS
+
+static inline void kasan_poison_memory(const void *address, size_t size, u8 value)
+{
+	hw_set_mem_tag_range(kasan_reset_tag(address),
+			round_up(size, KASAN_GRANULE_SIZE), value);
+}
+
+static inline bool check_invalid_free(void *addr)
+{
+	u8 ptr_tag = get_tag(addr);
+	u8 mem_tag = hw_get_mem_tag(addr);
+
+	return (mem_tag == KASAN_TAG_INVALID) ||
+		(ptr_tag != KASAN_TAG_KERNEL && ptr_tag != mem_tag);
+}
+
+#else /* CONFIG_KASAN_HW_TAGS */
+
+void kasan_poison_memory(const void *address, size_t size, u8 value);
+bool check_invalid_free(void *addr);
+
+#endif /* CONFIG_KASAN_HW_TAGS */
+
 /*
  * Exported functions for interfaces called from assembly or from generated
  * code. Declarations here to avoid warning about missing declarations.
-- 
2.29.2.222.g5d2a92d10f8-goog

