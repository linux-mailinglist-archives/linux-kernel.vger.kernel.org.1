Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606692A737B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387505AbgKEAC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387466AbgKEAC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:02:56 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3BCC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 16:02:55 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id y1so2215wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 16:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mRk4x8ffqejU12g7nFdHunjF+UNrFXF8Jgp9G1eFhMI=;
        b=cMYeDNAIEtLr1J3RVSdvrmgQMONBQrVYYerYkXCetvmGBA2xUeYAgNtkEzxajLT3CI
         Bh1DopQkey4TaU1/5/i1N7npPVtiA/6+48OP7fv9WSaHFiK0vGvalq1IIyODIovLziQ6
         zMS4w9QJ63hGFrVjV3+FF8tTat/0fKVwSKWNijqQLrijIlcvDOkez4BWmkgXGFA9J0aB
         6Z7OHg1UfOyKJi6jTLQEvCR+dVhIDQbvKXe/QHUgcqVkfITeCc8cvOBbeOhVboFi7Xqz
         K+At9OBj/xD9fE95zOkrKIEfvez3xnemsuQTm53Fi0esSdQzKOjhX1YcdHiNvLB6WEkw
         qHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mRk4x8ffqejU12g7nFdHunjF+UNrFXF8Jgp9G1eFhMI=;
        b=FxkIRf2LaQHcVkVr9G2D3ZHrdtHw+u4+scnlem9KPPyQSa44LeruhOxds8b7j35aqZ
         DJ34LIwfo/XfrIDGMSjN1uxnHVG16SFLROOPXC+OGujVlbwN5ELbzyqD/kamKS3tpSDi
         nAAtjKlC+CC1fd3haDEGJisMrnyJAzi/DdgLoV9ZqRyEE+x0AN4pX8hj0++wlD9qQ6RV
         U93rqjkPD6HPiaeFJA1x82mzhwyT+BW7V2D+aXNwjxfojumqsCQyRYI/gDVEBvd+tEu8
         pUAFrNrlvaUwYg3RmHiEbnjpw31kDNoQFF+sx/pematnv6S1PBafiBjYCOCa6z2V0WoZ
         GVlQ==
X-Gm-Message-State: AOAM531pKmr1MPMflB/kCBV+X6mFsMBnKoAm1Ap926HvCWlUCyX7uFp6
        h+MhpVuHEt0gOkOYZ5iHvb2i1CRFqDwbH8zV
X-Google-Smtp-Source: ABdhPJxaB9bS1n4FopLulDs5jJOJUms2oIgnCPMGCHt0rWTOkeMjdf4qr41+n+qwT4dQ3uLhsi4LP6SGG6zkwG0L
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6000:36f:: with SMTP id
 f15mr532689wrf.78.1604534574449; Wed, 04 Nov 2020 16:02:54 -0800 (PST)
Date:   Thu,  5 Nov 2020 01:02:18 +0100
In-Reply-To: <cover.1604534322.git.andreyknvl@google.com>
Message-Id: <f51b7247367b92e9ae78e12696c63dc58dbda83d.1604534322.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604534322.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 08/20] kasan: inline random_tag for HW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
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
index fe8e6c8e6319..d5824530fd15 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -38,11 +38,6 @@ void kasan_unpoison_memory(const void *address, size_t size)
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
index e9c7d061fbe5..d7a03eab5814 100644
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
@@ -275,6 +264,17 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 
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
2.29.1.341.ge80a0c044ae-goog

