Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815D62AE2BF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbgKJWLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732253AbgKJWLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:11:32 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE087C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:30 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id f9so185227qkg.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ku1ALkNUvDBR4qencFY/mbgiU7WPy6T95MRyq/FIMxg=;
        b=SBjXenKgaF0/vO5e2Kd0m5S+aRB5B9YK7fZ5L1lS7hLCn/V1tX4KZEa9dFzE8O7B/M
         my0RwMTZgEggcPYxAsWhsNle7sePuuq0OS2Iy805eM5tiBtjRaJ3a84IvGoz5VUYx9rd
         b1VBB68RQIsrz/BhQt//I1mA1l5VbR14Mbxo3FXPkCKRpnB0e30SMGTf3bGR5AHVXJKp
         jk44yJi5BdFTMnKgnSG8FHytycRzGUXZUgLcbn8+QO3qix2TU4dbW4VnRO0JsvBPDx60
         5vXcpxMjODNfmmnA5GE3C+iXofl48Nf+yYjWMl1jTSpoxCxqRvloGgj/TQ+0837h/NfW
         4y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ku1ALkNUvDBR4qencFY/mbgiU7WPy6T95MRyq/FIMxg=;
        b=ReuBzty7oyLXpmyI4zhwas6TIcWywlRbOfjreXnaVZPQ2irpkFaps0GR++IdKiGh5Q
         NBZ7R/oAlOIchiyOKpkbF3bOXiZil7083JjJcyeOHeIt3qAuMyvaRMt0GpH/QMFtamev
         6MA0EojuQ2FlSau2oAX0cX5cxzPOP3LE6Z6sqBEoPrdtKFLJjpJnA0OApz3IF9BXUeDf
         zsnwvEsNlxj2ChwIGff2IVv3YzHdEMJQ9YsgX50kYDIE9KjdvZGjfSxF6msKDqcofQJv
         AHG1NXT/kGaFlV6pMagbrAQRjKx7fA9RN1CPqq6+O9C57uZ0TYy+/x3NhX5ys+bPuAgL
         AIGA==
X-Gm-Message-State: AOAM5326VeMbhOYCOCemZ9shMOWscHeKOH80w+Ky5Uzyzo6maO86IMW5
        gArE661yGDKPPLeJQaPZlm3rPqE/3FJh09UV
X-Google-Smtp-Source: ABdhPJyzW+qSOT8eZ2xH6+egen3C/J9A2i75tgpqQOqPZmnnClHZadzNjlQ5QFZonRar8JQEWhvDBFOvaBul6wNq
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:10c4:: with SMTP id
 r4mr21419097qvs.62.1605046290015; Tue, 10 Nov 2020 14:11:30 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:10:07 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <85aba371903b749412fac34e44e54c89e5ddae30.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 10/44] kasan: define KASAN_GRANULE_PAGE
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
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

Define KASAN_GRANULE_PAGE as (KASAN_GRANULE_SIZE << PAGE_SHIFT), which is
the same as (KASAN_GRANULE_SIZE * PAGE_SIZE), and use it across KASAN code
to simplify it.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: I0b627b24187d06c8b9bb2f1d04d94b3d06945e73
---
 mm/kasan/init.c   | 10 ++++------
 mm/kasan/kasan.h  |  1 +
 mm/kasan/shadow.c | 16 +++++++---------
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index 1a71eaa8c5f9..26b2663b3a42 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -441,9 +441,8 @@ void kasan_remove_zero_shadow(void *start, unsigned long size)
 	addr = (unsigned long)kasan_mem_to_shadow(start);
 	end = addr + (size >> KASAN_SHADOW_SCALE_SHIFT);
 
-	if (WARN_ON((unsigned long)start %
-			(KASAN_GRANULE_SIZE * PAGE_SIZE)) ||
-	    WARN_ON(size % (KASAN_GRANULE_SIZE * PAGE_SIZE)))
+	if (WARN_ON((unsigned long)start % KASAN_GRANULE_PAGE) ||
+	    WARN_ON(size % KASAN_GRANULE_PAGE))
 		return;
 
 	for (; addr < end; addr = next) {
@@ -476,9 +475,8 @@ int kasan_add_zero_shadow(void *start, unsigned long size)
 	shadow_start = kasan_mem_to_shadow(start);
 	shadow_end = shadow_start + (size >> KASAN_SHADOW_SCALE_SHIFT);
 
-	if (WARN_ON((unsigned long)start %
-			(KASAN_GRANULE_SIZE * PAGE_SIZE)) ||
-	    WARN_ON(size % (KASAN_GRANULE_SIZE * PAGE_SIZE)))
+	if (WARN_ON((unsigned long)start % KASAN_GRANULE_PAGE) ||
+	    WARN_ON(size % KASAN_GRANULE_PAGE))
 		return -EINVAL;
 
 	ret = kasan_populate_early_shadow(shadow_start, shadow_end);
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index c31e2c739301..1865bb92d47a 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -7,6 +7,7 @@
 
 #define KASAN_GRANULE_SIZE	(1UL << KASAN_SHADOW_SCALE_SHIFT)
 #define KASAN_GRANULE_MASK	(KASAN_GRANULE_SIZE - 1)
+#define KASAN_GRANULE_PAGE	(KASAN_GRANULE_SIZE << PAGE_SHIFT)
 
 #define KASAN_TAG_KERNEL	0xFF /* native kernel pointers tag */
 #define KASAN_TAG_INVALID	0xFE /* inaccessible memory tag */
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index ca0cc4c31454..1fadd4930d54 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -161,7 +161,7 @@ static int __meminit kasan_mem_notifier(struct notifier_block *nb,
 	shadow_end = shadow_start + shadow_size;
 
 	if (WARN_ON(mem_data->nr_pages % KASAN_GRANULE_SIZE) ||
-		WARN_ON(start_kaddr % (KASAN_GRANULE_SIZE << PAGE_SHIFT)))
+		WARN_ON(start_kaddr % KASAN_GRANULE_PAGE))
 		return NOTIFY_BAD;
 
 	switch (action) {
@@ -432,22 +432,20 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 	unsigned long region_start, region_end;
 	unsigned long size;
 
-	region_start = ALIGN(start, PAGE_SIZE * KASAN_GRANULE_SIZE);
-	region_end = ALIGN_DOWN(end, PAGE_SIZE * KASAN_GRANULE_SIZE);
+	region_start = ALIGN(start, KASAN_GRANULE_PAGE);
+	region_end = ALIGN_DOWN(end, KASAN_GRANULE_PAGE);
 
-	free_region_start = ALIGN(free_region_start,
-				  PAGE_SIZE * KASAN_GRANULE_SIZE);
+	free_region_start = ALIGN(free_region_start, KASAN_GRANULE_PAGE);
 
 	if (start != region_start &&
 	    free_region_start < region_start)
-		region_start -= PAGE_SIZE * KASAN_GRANULE_SIZE;
+		region_start -= KASAN_GRANULE_PAGE;
 
-	free_region_end = ALIGN_DOWN(free_region_end,
-				     PAGE_SIZE * KASAN_GRANULE_SIZE);
+	free_region_end = ALIGN_DOWN(free_region_end, KASAN_GRANULE_PAGE);
 
 	if (end != region_end &&
 	    free_region_end > region_end)
-		region_end += PAGE_SIZE * KASAN_GRANULE_SIZE;
+		region_end += KASAN_GRANULE_PAGE;
 
 	shadow_start = kasan_mem_to_shadow((void *)region_start);
 	shadow_end = kasan_mem_to_shadow((void *)region_end);
-- 
2.29.2.222.g5d2a92d10f8-goog

