Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D9B280B08
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387467AbgJAXLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387428AbgJAXLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:11:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3FEC0613E3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:11:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x1so571843ybi.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=h4ahnVj97FiAecn9nKUYbRmxkWBQXwitOEnqIvzOE3A=;
        b=GDXGGeur056ZObUaZBmT76EMq9vjJuiu3SLxevMJL7Lp9DO9eTxRtzoxyRfG4QsI4g
         FTSoquPNprCxJ5tEPav9+29lVNMiKv+ED6zwBI5ZyeObUUurg/K6XfMzd5TpuL2MprLG
         OHv0qb2ET4SbBbwoe9erVW8AUXVKHbn3pnBHLpRuzB96Nh7iI1LaJXQ2EOi4ob5f6DN/
         oyrd2r0fXzERb9JyXVhMQjvYXbSr8KH9+TJbQqcZ+Yf3tYmiQjcQGaQSS7BXDVA9Lx87
         xNFdDgKLBuFqX+jcl/jCd30I9P+kS3r8PQTNtLTheInk03Z10jc5Z1yFNG3n9FzAe1Sb
         fsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h4ahnVj97FiAecn9nKUYbRmxkWBQXwitOEnqIvzOE3A=;
        b=lhm8rD1n3HfxGcs748MXIaFPcuO14ySnkko7ms7WCfvzdfGniq6FrPUWB9x46nlqy9
         OwroP4ndCuvDxHLNmLVp83SHTLW/IvYkxfTZQZoRkwFZLopMIJi6T8Si5ihwiRvbHq1b
         p4+vuYxJpCRduzlMAB2QLMC54UrrAqzHwFAirPlUCibkio5CPw/4TVQ6+B7U4Z2zYbG3
         QVv7OzNdRB7JKCesLdHjwmt8h1a4HlUJd1GCX3u6og7k3rQoOrLW4ViTTZ6UjwAV5xPq
         nb3W1qmfpVRH0WGFALtrM+owpchRlDP5oyhE3pWDK9JR+aNz5F9WYb/WpyKm1JHVYV3v
         qaHQ==
X-Gm-Message-State: AOAM530X0ofUPuAB/SBhw4y0mQKsomoeqCG4C6yeqHr9gSLaoxJikd2Y
        WA6kP/WKnDz+IcT955tZP6dZm1J6N6GYO0pC
X-Google-Smtp-Source: ABdhPJwkNGH52s8XSvjvTX8weCXeT0pf8IIyzdrWWXuqKPbupAsQ1VOtSXtRtIH9cdygTMyKKEHAwBMTWSEB8Qkm
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a5b:f03:: with SMTP id
 x3mr14383469ybr.137.1601593865465; Thu, 01 Oct 2020 16:11:05 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:10 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <559c0a35aa6de0a7a2e915c73da260e35bad5809.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 09/39] kasan: define KASAN_GRANULE_PAGE
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
2.28.0.709.gb0816b6eb0-goog

