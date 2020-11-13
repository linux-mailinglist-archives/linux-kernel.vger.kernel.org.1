Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA5C2B2867
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgKMWVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgKMWUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:20:41 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E88C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:40 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id h23so7582009qka.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MeFL8PhZCdNKf3Y6a938/A3o+3e79v6OLkm/7y5InEs=;
        b=a7iYcqhiOEzmoQJIygPhyPCEebvODyOmH8298XwMFZzhnPBc8slvcHMG5pc3xrTPwr
         eo3pI3jbeiA0ddVRw38Om6NCXa3ppgNdxUTV5JllWdXhzXa8f1tU3INCEQzxkABBvlBc
         vtnGSglODeaGY/C7wpVTNORwBeFKYAp1vYDzJa/o+IL6JH1hbPvjh9in06nqJiut5VyS
         6JrAOcbT8gr53bGUESlGwZGxkUrsI5Pl7Tmybny5kxg4WPgaJ/JzxHtj/bFIrxZgvugG
         Yw8nsDOV4uCmmz7n9MasLcCSQoxYvuI5QcL+o6R/KpNGKPwxb5KEoglhvBpsMtdv16WZ
         d7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MeFL8PhZCdNKf3Y6a938/A3o+3e79v6OLkm/7y5InEs=;
        b=DlbY77aP/CAY5vwDbLSo2z74O6YUTw0W5HYkzo9lNxzM8zAb7XOeiV3OvQcKLWJNkH
         0B/eTy6kagg7ypbGMb+8uwqKL8dma1R5ppvUu5qoVgM5NUmTvjxMvgnjA9O5Mzm702+r
         5A/PLrYGj1udQ/1oTp67EDtoUSSTOxm/qSOPAZ/tAG7Pj2kXY60BZ9rlfA1AgveS6g13
         8yH2xGKQ2IqOuG+OU+DLUC1aJ0xQLQgq/3VCuXdZevKV+xb5hpG9nQBnvmMlFOfqdMZk
         GyHpReaYywZ0eyUQ07AomQheMviRYtH/FeX407YFZTEDIugIHy+Z/JWV/hB4otJ2tEAg
         zEyw==
X-Gm-Message-State: AOAM531BsnVxe+0fNVbdM6s65du54M2eZIo6nY9HenPZ5qEtYK2KPI/Z
        v97PiWbj9xDxO/eifwFFdwNuoFo3jJTAYjj1
X-Google-Smtp-Source: ABdhPJxvwWRD6q+V00iGx8/Z5kxruSALO3/XNWuS6mhOxV+VJqQLBGqOmzGaQxVV5xj90d9/dy0xRas9NgWz59wT
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:b6c4:: with SMTP id
 h4mr4429589qve.35.1605306039132; Fri, 13 Nov 2020 14:20:39 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:20:00 +0100
In-Reply-To: <cover.1605305978.git.andreyknvl@google.com>
Message-Id: <cc8bea6e21d1cba10f4718fb58458f54fce0dab3.1605305978.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v3 10/19] kasan: inline (un)poison_range and check_invalid_free
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

Using (un)poison_range() or check_invalid_free() currently results in
function calls. Move their definitions to mm/kasan/kasan.h and turn them
into static inline functions for hardware tag-based mode to avoid
unneeded function calls.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/Ia9d8191024a12d1374675b3d27197f10193f50bb
---
 mm/kasan/hw_tags.c | 30 ------------------------------
 mm/kasan/kasan.h   | 45 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 3cdd87d189f6..863fed4edd3f 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -10,7 +10,6 @@
 
 #include <linux/kasan.h>
 #include <linux/kernel.h>
-#include <linux/kfence.h>
 #include <linux/memory.h>
 #include <linux/mm.h>
 #include <linux/string.h>
@@ -31,35 +30,6 @@ void __init kasan_init_hw_tags(void)
 	pr_info("KernelAddressSanitizer initialized\n");
 }
 
-void poison_range(const void *address, size_t size, u8 value)
-{
-	/* Skip KFENCE memory if called explicitly outside of sl*b. */
-	if (is_kfence_address(address))
-		return;
-
-	hw_set_mem_tag_range(kasan_reset_tag(address),
-			round_up(size, KASAN_GRANULE_SIZE), value);
-}
-
-void unpoison_range(const void *address, size_t size)
-{
-	/* Skip KFENCE memory if called explicitly outside of sl*b. */
-	if (is_kfence_address(address))
-		return;
-
-	hw_set_mem_tag_range(kasan_reset_tag(address),
-			round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
-}
-
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
index 7876a2547b7d..8aa83b7ad79e 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -3,6 +3,7 @@
 #define __MM_KASAN_KASAN_H
 
 #include <linux/kasan.h>
+#include <linux/kfence.h>
 #include <linux/stackdepot.h>
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
@@ -154,9 +155,6 @@ struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
 struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
 						const void *object);
 
-void poison_range(const void *address, size_t size, u8 value);
-void unpoison_range(const void *address, size_t size);
-
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
 static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
@@ -196,8 +194,6 @@ void print_tags(u8 addr_tag, const void *addr);
 static inline void print_tags(u8 addr_tag, const void *addr) { }
 #endif
 
-bool check_invalid_free(void *addr);
-
 void *find_first_bad_addr(void *addr, size_t size);
 const char *get_bug_type(struct kasan_access_info *info);
 void metadata_fetch_row(char *buffer, void *row);
@@ -278,6 +274,45 @@ static inline u8 random_tag(void) { return hw_get_random_tag(); }
 static inline u8 random_tag(void) { return 0; }
 #endif
 
+#ifdef CONFIG_KASAN_HW_TAGS
+
+static inline void poison_range(const void *address, size_t size, u8 value)
+{
+	/* Skip KFENCE memory if called explicitly outside of sl*b. */
+	if (is_kfence_address(address))
+		return;
+
+	hw_set_mem_tag_range(kasan_reset_tag(address),
+			round_up(size, KASAN_GRANULE_SIZE), value);
+}
+
+static inline void unpoison_range(const void *address, size_t size)
+{
+	/* Skip KFENCE memory if called explicitly outside of sl*b. */
+	if (is_kfence_address(address))
+		return;
+
+	hw_set_mem_tag_range(kasan_reset_tag(address),
+			round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
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
+void poison_range(const void *address, size_t size, u8 value);
+void unpoison_range(const void *address, size_t size);
+bool check_invalid_free(void *addr);
+
+#endif /* CONFIG_KASAN_HW_TAGS */
+
 /*
  * Exported functions for interfaces called from assembly or from generated
  * code. Declarations here to avoid warning about missing declarations.
-- 
2.29.2.299.gdc1121823c-goog

