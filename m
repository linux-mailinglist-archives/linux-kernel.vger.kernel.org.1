Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880542B2860
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgKMWT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgKMWQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:16:38 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FA2C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:16:36 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id e22so6598324qte.22
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DCS5SBsJzS3y9SMPHdgCSO0YkPjeiiQV5TNLKbwTzYQ=;
        b=A+gL+E2KeJ9HQO4cq4UhWfqC794iu/ltyUvvNlfOr4MK5NyHq8o7D08sb7lpilgiRK
         zLWIdlyesGqEj9Nwn8dRalvrYejfDUCUy7ej2CbkifyAjXXAtqdt2qdtfz9xMJUFuQ63
         MLSDSm1yzLqnp1HxFPsKnaMUukU1HanjjFxdJXzzOcasbB7kih1pPBcQvOy5+wtrw69s
         z85oC7E9q2PSekbJvxuUqwTM6LVn3Dll46UeVpMnpYTjLqPfqN0gQbWuITZW5LTOnhzC
         3qs6l+IscAhY48sYNgluWqDPcgftL/8gapaPKx/hXYcWImWvumL8YjdI6jvQD4Lhfl4D
         L/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DCS5SBsJzS3y9SMPHdgCSO0YkPjeiiQV5TNLKbwTzYQ=;
        b=ub31EGBhjpKnJ7egsx91z94soh4Kl5/bamLpMDTQblUIHnTi9Ivn/JdRkwRwzfxA/Y
         3WY7t9DV6RWPcpoTYXJ1pcpi55K9i5d792DrBtN7x4FiF+EyVkh5ob7MNlDOJn7HJCYr
         PipKLjC4CHFrGJabaLCEiXo3px4YFKubV8azniyXgOhoxWGo8mr+cXBCa4lo/wsXvmY9
         GWvhJrq487BCdVDCC6ADaIsL26B+AJ3VfdI2SJuncD1/YLYi5nHUsyqBqtLslxXcdp2l
         Oqb/h9jO7Ilt7A9e8NPNkLwxLXQMR0UR3X8eiguHPSsi3P4VA7om6C6ZzIIlfPjkv4lI
         xZ9w==
X-Gm-Message-State: AOAM531l08fV6BZqXtmLzF3Q6az6ZgmzFxhTouVL+xjHXRViwPvxwUlC
        KkgYBcC28Um2mneNHHYhhSnw+pT7jfYzn8l+
X-Google-Smtp-Source: ABdhPJwr5xSs18pknkpDmkZ8LBejueZfckFn/wzDjcT+sWM1tVdM7TocURSMMBdZoDN5V5vtDZluCN8k4QOZLoIi
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4e13:: with SMTP id
 dl19mr4516709qvb.24.1605305796028; Fri, 13 Nov 2020 14:16:36 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:15:37 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <19601c2110760228adf7594385db4508f62a5721.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 09/42] kasan: define KASAN_MEMORY_PER_SHADOW_PAGE
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
2.29.2.299.gdc1121823c-goog

