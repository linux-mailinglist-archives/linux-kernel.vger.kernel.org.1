Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3293295FCD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899767AbgJVNVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899607AbgJVNTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:19:50 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558B3C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:49 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id o25so1032278qtt.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ttDbGg8ckV2PZque6BU+M0wdmEgRXMhDQET60HhqsRw=;
        b=DNq7BoOIMFRWZI331hPIuN8vmCPTnZnXF+XeIjG3w9Hk2atPyCaUpdrcWQFtLMEsK6
         LNS+gBQZSNMj+AQNcPlzCyjpQD+9cvI78lR3QVEDsT5li5S1WII6cVWu5VIIQkUnwM4e
         +bQIJ4VljeoRS67xneeuZbD+h9ZhKdXuyYyYcBr8991D5MhajraRH9cLTqIYWls1s/Kv
         1rWH3LASWY26b9h93KZAno8D5Spvwl5ggv8QS0bjaP3ThZhgnUW9192aLQdwG4/DjTjJ
         w0gzTW48I1nyPkSPnDsSs55Y8p2ekSNdOpn+V1L+KMK2eeF1JEdYr18irubGQFKoUNLs
         p0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ttDbGg8ckV2PZque6BU+M0wdmEgRXMhDQET60HhqsRw=;
        b=D3f8tWyrj34BwRs+iZibN1ZDWQBT6132xgH7VVNQSp7G7B2MoUsrD1GyKkHuz6jwIP
         WIyRgwxCqxMlF2IRFe+BQrLb6M7sFagJJbWL7DG7U31YIdeUggY9iGHmiL+S+bMD3Xed
         hWOeZt6Crv6wx2QevPKeEKjQVhiheKPQVMxKcshsBBeMce1YFNt2rvF3uhQ5mHkaW3gs
         wNEwRW84sD0J0+YEdaQgktQIBH9P2FGrOrQXqmw3V7K7vtLSPvd1qlfKN2SoRByW8pL3
         57mbUvJ2Z94IbwhklwPL3Wlfsm1nRvybnJYanKS4461evd+YRQfGGJcu2V/CaPDzYV5T
         EvPg==
X-Gm-Message-State: AOAM531yuGuYoFuW8GbpMHXJOeTADVVlZEq5XSoUs5jyBmFks74ccP4q
        K3xQuUj1nEqqbeYwxrvUagvnlV1ur/efkuKq
X-Google-Smtp-Source: ABdhPJwJNOlcCNokD229g2j6kSc2H2jEf2rPOcfKu2ebxDvvoQ75tqz88rP7WbdvohZY0+9l7Lmu+TJ0jcXmoqbT
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4d46:: with SMTP id
 m6mr2314403qvm.60.1603372788362; Thu, 22 Oct 2020 06:19:48 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:19:02 +0200
In-Reply-To: <cover.1603372719.git.andreyknvl@google.com>
Message-Id: <56b19be34ee958103481bdfc501978556a168b42.1603372719.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH RFC v2 10/21] kasan: inline random_tag for HW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
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
for hardware tag-based mode to avoid uneeded function call.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/Iac5b2faf9a912900e16cca6834d621f5d4abf427
---
 mm/kasan/hw_tags.c |  5 -----
 mm/kasan/kasan.h   | 37 ++++++++++++++++++++-----------------
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index c3a0e83b5e7a..4c24bfcfeff9 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -36,11 +36,6 @@ void kasan_unpoison_memory(const void *address, size_t size)
 			  round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
 }
 
-u8 random_tag(void)
-{
-	return get_random_tag();
-}
-
 bool check_invalid_free(void *addr)
 {
 	u8 ptr_tag = get_tag(addr);
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 0ccbb3c4c519..94ba15c2f860 100644
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
@@ -273,6 +262,20 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 #define get_mem_tag(addr)			arch_get_mem_tag(addr)
 #define set_mem_tag_range(addr, size, tag)	arch_set_mem_tag_range((addr), (size), (tag))
 
+#ifdef CONFIG_KASAN_SW_TAGS
+u8 random_tag(void);
+#elif defined(CONFIG_KASAN_HW_TAGS)
+static inline u8 random_tag(void)
+{
+	return get_random_tag();
+}
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
2.29.0.rc1.297.gfa9743e501-goog

