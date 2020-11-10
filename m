Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A762AE332
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbgKJWUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732327AbgKJWUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:20:49 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E745C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:20:49 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id 67so6236176wra.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/rSFl10DA/GX54GBDw6zGUYBErxFDPI5QaAJ7Zds8ak=;
        b=X/G1FHBpaTNPbceckVWXnlaQTlozNeiCpeU7tMmREOJimTXkmCTjt6rRjgNPSeQ0pw
         q73UVtucfzggJP2pLLg0d8XHXT0ngy/FLNTkV+unC3tseUSKbxmMqR1RfIvjsfMbA2Eq
         fniu1B6bL+1GI15kaPYNzXCk/yeIk98ad1Jm+d8i/5KDIlsK5BgcmP/efX5QPF1s8Si/
         6NXEIxz4MDViC1Q1XgbEBgCSkG1swl6ak5j3v5axkuBmgM9UBfbh1fuNYORk8kWZXP9Q
         iGwaOfp4qXX5szQspMdAW9gYIF9nebgteHML8xT3tOJCbTT3oOXCOGM54M/KBM4bacSy
         YBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/rSFl10DA/GX54GBDw6zGUYBErxFDPI5QaAJ7Zds8ak=;
        b=fpcslUsCQosIckLYeuNY/in61fKLnaJRxmNHxt0aT+FEDNXuNU2sRe7ToH2hhdZr/J
         NZ6Fqlh6+pfN+LjjG2uZLLbC3ol7pO+4Jg1BvfBigvBPLzT6XsAnkOspaE4mfbEFmEuX
         6dg2vUqI1bfh/OiHoQInm8qt5X/VARqPcKR2io0es86fCRPXSqQAvPArGXx73UpNHIZk
         cWVdsj/qPPyc77Vu+Vy+sfdTx++2G48kF5A2vn/lxyOWrlwl3JheBhMXP9ZdDfVZw7jE
         NK+jHod1JxQe+H7ozPo7tBDSGHZyzq4Gm4hh4L4oDepRgN1+YyrhQoOwIXJbMMhStmh9
         ScGA==
X-Gm-Message-State: AOAM530HDo/vzgw8nci9ASwU1DEn6FeEIh2DB8I9X6bNYGTc7K8PIUeq
        J+ZguXjXbJ4R79wfWciS8q1RRNCWNIYZHzrY
X-Google-Smtp-Source: ABdhPJyY/bBCadcyM/PRgjtzpu0TT6SQ1RzDsL0gjh3vrXFFiPqpWwP79w3xbEXBJdKIjt2rfzmw9gOcpXSqt2FT
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a5d:6692:: with SMTP id
 l18mr14959782wru.44.1605046848070; Tue, 10 Nov 2020 14:20:48 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:20:12 +0100
In-Reply-To: <cover.1605046662.git.andreyknvl@google.com>
Message-Id: <73399d4c0644266d61ad81eb391f5ee10c09e098.1605046662.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v2 08/20] kasan: inline random_tag for HW_TAGS
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

Using random_tag() currently results in a function call. Move its
definition to mm/kasan/kasan.h and turn it into a static inline function
for hardware tag-based mode to avoid uneeded function calls.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/Iac5b2faf9a912900e16cca6834d621f5d4abf427
---
 mm/kasan/hw_tags.c |  5 -----
 mm/kasan/kasan.h   | 34 +++++++++++++++++-----------------
 2 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 49ea5f5c5643..1476ac07666e 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -42,11 +42,6 @@ void kasan_unpoison_memory(const void *address, size_t size)
 			round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
 }
 
-u8 random_tag(void)
-{
-	return hw_get_random_tag();
-}
-
 bool check_invalid_free(void *addr)
 {
 	u8 ptr_tag = get_tag(addr);
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 8a5501ef2339..7498839a15d3 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -188,6 +188,12 @@ static inline bool addr_has_metadata(const void *addr)
 
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
+#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
+void print_tags(u8 addr_tag, const void *addr);
+#else
+static inline void print_tags(u8 addr_tag, const void *addr) { }
+#endif
+
 bool check_invalid_free(void *addr);
 
 void *find_first_bad_addr(void *addr, size_t size);
@@ -223,23 +229,6 @@ static inline void quarantine_reduce(void) { }
 static inline void quarantine_remove_cache(struct kmem_cache *cache) { }
 #endif
 
-#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
-
-void print_tags(u8 addr_tag, const void *addr);
-
-u8 random_tag(void);
-
-#else
-
-static inline void print_tags(u8 addr_tag, const void *addr) { }
-
-static inline u8 random_tag(void)
-{
-	return 0;
-}
-
-#endif
-
 #ifndef arch_kasan_set_tag
 static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 {
@@ -279,6 +268,17 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 
 #endif /* CONFIG_KASAN_HW_TAGS */
 
+#ifdef CONFIG_KASAN_SW_TAGS
+u8 random_tag(void);
+#elif defined(CONFIG_KASAN_HW_TAGS)
+#define random_tag() hw_get_random_tag()
+#else
+static inline u8 random_tag(void)
+{
+	return 0;
+}
+#endif
+
 /*
  * Exported functions for interfaces called from assembly or from generated
  * code. Declarations here to avoid warning about missing declarations.
-- 
2.29.2.222.g5d2a92d10f8-goog

