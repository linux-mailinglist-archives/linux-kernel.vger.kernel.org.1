Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC562C164A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbgKWUPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731725AbgKWUPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:15:13 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FB3C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:15:13 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id 7so14363836qtw.23
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=+ebVro8WhZiLU99JJsnZ41QIjsbf3l1QeUgTEZT5fwM=;
        b=nMsy4P1zBhnUlJ7LXW5vgMe9VAoz/CbtlFUKrJKF1+LyFx3nO8IGDWAzkq6sCI3cyX
         37cZ0AyhoIpiVPMTMdyIP8+n8+BQA57PTXiQxaqv1coMlGKSDmL5G0Bzu1IswwgHYRIF
         WL3uJIRxFuTlY8/s2i4hCvE/6Vy8uBi6lCrsVkIn8eAz6q3j1YzY9iX/JW8uCtCQyoOv
         2fgfUu3tA1ooA7GWCT/E5nVFskmr0ABKzjIcPB/jQauVJM9VZ8rbHjYRd8eAchmaVMRZ
         kRtz9MnoLJ+37V9QrBxh8/aA/B7kZ8Cwx1WSfgMSxOgxMX4E7RLZx4vULPLNgYjMi0p6
         nheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+ebVro8WhZiLU99JJsnZ41QIjsbf3l1QeUgTEZT5fwM=;
        b=TBOGdselV6e3/P+zA2wpFokxGSHivux0IT7hnDOYPYGvItmyHxlrsRjxTKnQ9nqmqB
         N+alxEQHXlTYqd3IsVc0KxvChVbBdmt2+R0KM4Y3j1Aq0jjQcmAPnZrwSwMNg+iRHvbH
         cojaPwfaEW9dmpfzdqp7ewGDO9pEgfxlNd977W6CUdqEzVAI4PHa4+fcVoyco6ol+Dg/
         DgQNl6fXiaABWPS3gTmJClhfG2XWfcYJrwXQYyVGgYQC4MWXg6FgN3xMKXP+JxUtqED4
         vBehkJFlWIn6hCfIGVGygaGu7g/QxeBJfplF3jaO9a6e2NYwgHCRCz49OqoaaKWQOWB9
         Xp1A==
X-Gm-Message-State: AOAM5302VVKgiBpPBAoGKxDN7GpihPs3UZ5r5y4IfTiKKcW/VhCpra3B
        L79LJj7PNoE9T1CqMhtFaHUG6VhT/2KiogLi
X-Google-Smtp-Source: ABdhPJz/EIT+p1GLjg2l1/jdNIDDxtLmLPSNqnUlEbXUIzj7/CSWJSG0+2TpsAC2+guYEI2P9bEmzgTPMtEAhQTQ
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:aab:: with SMTP id
 ew11mr1176833qvb.4.1606162512301; Mon, 23 Nov 2020 12:15:12 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:14:38 +0100
In-Reply-To: <cover.1606162397.git.andreyknvl@google.com>
Message-Id: <be438471690e351e1d792e6bb432e8c03ccb15d3.1606162397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606162397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v4 08/19] kasan: inline random_tag for HW_TAGS
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
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
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
2.29.2.454.gaff20da3a2-goog

