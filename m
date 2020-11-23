Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DEB2C15D1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgKWUIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730001AbgKWUIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:08:41 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C31C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:08:41 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id b9so6446105qvj.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MuLqLrZstENUkSlaOHjVDBkv2H0uielvFk/0yXzNfks=;
        b=mI2C/t823crreScNzdRgZQi3TeDilSA0GkV/JDBAFN/IIekz/Y9Qqdd5dJR28C4Ydt
         5F5BtjFMs2M4aTw6sQ0W6tw57/8F9Y8qX7Kzyf/N4p4HBmXTd6JLixzvcFb8MCiyd1yH
         CNjUXniVhoWbMPJzsU6eavHO6dYepuD9xLO7RFR3JsE7mSsrxbv4WG1+NqtxjSB/7Ll4
         qcbTINPk/b2rXH6VE3IanZ0sZeGZDe7nBct/s5NOgTVFQ88jGQoNnd95gfzNjW00a6F2
         oALQIApF1X5Y7tBGlCoteRO5ByvWiMu+PYiv3r37cM6MGYdyvlsyyI2gmlhQ80H3kJFa
         TxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MuLqLrZstENUkSlaOHjVDBkv2H0uielvFk/0yXzNfks=;
        b=ncQQvlj80ToxcsCjYfEojJ6mxlamSTaOA5ojwBUQE7V+W8FSyT/zzox2NP3EmJ37vF
         kD+M+jFFJt2r78K35HSyz0NmOwh+keK6MfLRbPkPsb/F9tSW60u8EU5XAz1/roRu3E75
         kC36Y/nhnmj/593GS6It6SbSDu85aev9BvIJj4cVnkrZeWg82Gm5Ifx0kdKF7AQiMJyl
         ONKdnGGDbhmoHJzROQGRFVHOajQjVXZ/G19EnYzWiZR4wspjREA6EmWbEUWCBoKCxdoI
         wKv2zWNNAFqhjQTUrbZXwFvtjul2tuTjerAnRneV37BxCLYLVxbsUJq52rfdP3Cx46y7
         5c+Q==
X-Gm-Message-State: AOAM533TFyM+oY7mH9iWGzG/FF+R9XG26SDiqlyMrrvNwQ1twlFL1Hug
        /YoTgE5MN8c56ljd7RgPhMppTX8a4PfLlxmZ
X-Google-Smtp-Source: ABdhPJz0X8UyN9JtsaBrFzVr5WuitUEQTupCBqosF80pa08THcndvs5eajhamN7dESxpSBwM5s2JqYCz2oO0Ilrs
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4051:: with SMTP id
 r17mr1061834qvp.39.1606162120173; Mon, 23 Nov 2020 12:08:40 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:07:33 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <8329391cfe14b5cffd3decf3b5c535b6ce21eef6.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 09/42] kasan: define KASAN_MEMORY_PER_SHADOW_PAGE
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

Define KASAN_MEMORY_PER_SHADOW_PAGE as (KASAN_GRANULE_SIZE << PAGE_SHIFT),
which is the same as (KASAN_GRANULE_SIZE * PAGE_SIZE) for software modes
that use shadow memory, and use it across KASAN code to simplify it.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
Change-Id: I0b627b24187d06c8b9bb2f1d04d94b3d06945e73
---
 mm/kasan/init.c   | 10 ++++------
 mm/kasan/kasan.h  |  2 ++
 mm/kasan/shadow.c | 16 +++++++---------
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index 1a71eaa8c5f9..bc0ad208b3a7 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -441,9 +441,8 @@ void kasan_remove_zero_shadow(void *start, unsigned long size)
 	addr = (unsigned long)kasan_mem_to_shadow(start);
 	end = addr + (size >> KASAN_SHADOW_SCALE_SHIFT);
 
-	if (WARN_ON((unsigned long)start %
-			(KASAN_GRANULE_SIZE * PAGE_SIZE)) ||
-	    WARN_ON(size % (KASAN_GRANULE_SIZE * PAGE_SIZE)))
+	if (WARN_ON((unsigned long)start % KASAN_MEMORY_PER_SHADOW_PAGE) ||
+	    WARN_ON(size % KASAN_MEMORY_PER_SHADOW_PAGE))
 		return;
 
 	for (; addr < end; addr = next) {
@@ -476,9 +475,8 @@ int kasan_add_zero_shadow(void *start, unsigned long size)
 	shadow_start = kasan_mem_to_shadow(start);
 	shadow_end = shadow_start + (size >> KASAN_SHADOW_SCALE_SHIFT);
 
-	if (WARN_ON((unsigned long)start %
-			(KASAN_GRANULE_SIZE * PAGE_SIZE)) ||
-	    WARN_ON(size % (KASAN_GRANULE_SIZE * PAGE_SIZE)))
+	if (WARN_ON((unsigned long)start % KASAN_MEMORY_PER_SHADOW_PAGE) ||
+	    WARN_ON(size % KASAN_MEMORY_PER_SHADOW_PAGE))
 		return -EINVAL;
 
 	ret = kasan_populate_early_shadow(shadow_start, shadow_end);
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 53b095f56f28..eec88bf28c64 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -8,6 +8,8 @@
 #define KASAN_GRANULE_SIZE	(1UL << KASAN_SHADOW_SCALE_SHIFT)
 #define KASAN_GRANULE_MASK	(KASAN_GRANULE_SIZE - 1)
 
+#define KASAN_MEMORY_PER_SHADOW_PAGE	(KASAN_GRANULE_SIZE << PAGE_SHIFT)
+
 #define KASAN_TAG_KERNEL	0xFF /* native kernel pointers tag */
 #define KASAN_TAG_INVALID	0xFE /* inaccessible memory tag */
 #define KASAN_TAG_MAX		0xFD /* maximum value for random tags */
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 4264bfbdca1a..80522d2c447b 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -174,7 +174,7 @@ static int __meminit kasan_mem_notifier(struct notifier_block *nb,
 	shadow_end = shadow_start + shadow_size;
 
 	if (WARN_ON(mem_data->nr_pages % KASAN_GRANULE_SIZE) ||
-		WARN_ON(start_kaddr % (KASAN_GRANULE_SIZE << PAGE_SHIFT)))
+		WARN_ON(start_kaddr % KASAN_MEMORY_PER_SHADOW_PAGE))
 		return NOTIFY_BAD;
 
 	switch (action) {
@@ -445,22 +445,20 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 	unsigned long region_start, region_end;
 	unsigned long size;
 
-	region_start = ALIGN(start, PAGE_SIZE * KASAN_GRANULE_SIZE);
-	region_end = ALIGN_DOWN(end, PAGE_SIZE * KASAN_GRANULE_SIZE);
+	region_start = ALIGN(start, KASAN_MEMORY_PER_SHADOW_PAGE);
+	region_end = ALIGN_DOWN(end, KASAN_MEMORY_PER_SHADOW_PAGE);
 
-	free_region_start = ALIGN(free_region_start,
-				  PAGE_SIZE * KASAN_GRANULE_SIZE);
+	free_region_start = ALIGN(free_region_start, KASAN_MEMORY_PER_SHADOW_PAGE);
 
 	if (start != region_start &&
 	    free_region_start < region_start)
-		region_start -= PAGE_SIZE * KASAN_GRANULE_SIZE;
+		region_start -= KASAN_MEMORY_PER_SHADOW_PAGE;
 
-	free_region_end = ALIGN_DOWN(free_region_end,
-				     PAGE_SIZE * KASAN_GRANULE_SIZE);
+	free_region_end = ALIGN_DOWN(free_region_end, KASAN_MEMORY_PER_SHADOW_PAGE);
 
 	if (end != region_end &&
 	    free_region_end > region_end)
-		region_end += PAGE_SIZE * KASAN_GRANULE_SIZE;
+		region_end += KASAN_MEMORY_PER_SHADOW_PAGE;
 
 	shadow_start = kasan_mem_to_shadow((void *)region_start);
 	shadow_end = kasan_mem_to_shadow((void *)region_end);
-- 
2.29.2.454.gaff20da3a2-goog

