Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320932B2864
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgKMWUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgKMWUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:20:35 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B950C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:35 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id w189so7579885qkd.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YBdsxMVQVE97UJPn5Dc1HSKikQDmHg1H37Pt2LLE+Kk=;
        b=avk+IvhMlEZbmk9DmjnRO5FW8NWySM86BGQFkLT/09JJyb3bg/256owXPaIQNTTw+l
         13Og2C+14ZkKV7O8e1B0R7/6G+IdEiu8xNf0Y8uh/3DJRzSSNnEbHhwBkpYwQvS4Dvr3
         87rjbB+pQNHS3eleUgWZo+hpMz8uLG8TSmLKVfdfrHwhXOD3+xXbYQHF+7sQdg+ofvKN
         XP/DdI5ItTdvz5zVDwfjd/70KW2JGXsaqs/30TYn9umM3DXz9coQj5/FW/3sKbfqEdyX
         naOOcCQpj6mgZY8q56dtr2CJTx5SWs2jxYitvM0NA/jGV7eyTVjJ78xvtPRr5MRutn/E
         /wWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YBdsxMVQVE97UJPn5Dc1HSKikQDmHg1H37Pt2LLE+Kk=;
        b=gjooM8TUWhc00VCaC9WGpBIumai9IrmLLk7qpvt9l2uZAM8HG4UZ2Z0ra+WEyzAIbT
         4mxMl7Wv56E0lSq8EEqQ08G4XgMLHMEjCi6x8ZM8nlLGsEuKbHSsMu+XWECoheg5H/Hr
         FqC2cpdrh4vNWK07QpfoNB/grBUqFgGTtC0gxO/umIWU5CwviHC5mmSLzTdHPwu7vaEa
         oy6gGViAK2OszYQ7MZ75JmOc6ea4cI5UOlWeFJj9zK9PLJlMsakhDqy5Xu4V2crD/GTs
         iDev/Lf7Vg7xwDMvo9CA30ISZ6MHJ9MujrZipwUtFQsUXaO2FmQAmbesH7feruxgHPlt
         rbng==
X-Gm-Message-State: AOAM530eO/MOLSEbEM2I83MpX/uPObkX43JWZsJg0CGpRoXLuMYJ3lmA
        4yckYWk9IZzCNkB+aF4jfm3B26lDoCZlRrGr
X-Google-Smtp-Source: ABdhPJwJbNc8LBA5L3yID4KPJo+8gcoSu+K34ENqO85OraM7oBvwXTkr8l2irPNsaon5CTeENcbj5cfem0w7nXTz
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:43ca:: with SMTP id
 o10mr4757439qvs.33.1605306034217; Fri, 13 Nov 2020 14:20:34 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:19:58 +0100
In-Reply-To: <cover.1605305978.git.andreyknvl@google.com>
Message-Id: <d42cdd23c59501ccc4ab91cf4e04dd134be57277.1605305978.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v3 08/19] kasan: inline random_tag for HW_TAGS
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

Using random_tag() currently results in a function call. Move its
definition to mm/kasan/kasan.h and turn it into a static inline function
for hardware tag-based mode to avoid uneeded function calls.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Link: https://linux-review.googlesource.com/id/Iac5b2faf9a912900e16cca6834d621f5d4abf427
---
 mm/kasan/hw_tags.c |  5 -----
 mm/kasan/kasan.h   | 31 ++++++++++++++-----------------
 2 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index a34476764f1d..3cdd87d189f6 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -51,11 +51,6 @@ void unpoison_range(const void *address, size_t size)
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
index 5e8cd2080369..7876a2547b7d 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -190,6 +190,12 @@ static inline bool addr_has_metadata(const void *addr)
 
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
+#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
+void print_tags(u8 addr_tag, const void *addr);
+#else
+static inline void print_tags(u8 addr_tag, const void *addr) { }
+#endif
+
 bool check_invalid_free(void *addr);
 
 void *find_first_bad_addr(void *addr, size_t size);
@@ -225,23 +231,6 @@ static inline void quarantine_reduce(void) { }
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
@@ -281,6 +270,14 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 
 #endif /* CONFIG_KASAN_HW_TAGS */
 
+#ifdef CONFIG_KASAN_SW_TAGS
+u8 random_tag(void);
+#elif defined(CONFIG_KASAN_HW_TAGS)
+static inline u8 random_tag(void) { return hw_get_random_tag(); }
+#else
+static inline u8 random_tag(void) { return 0; }
+#endif
+
 /*
  * Exported functions for interfaces called from assembly or from generated
  * code. Declarations here to avoid warning about missing declarations.
-- 
2.29.2.299.gdc1121823c-goog

