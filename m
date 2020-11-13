Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14862B286C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgKMWV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgKMWUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:20:53 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFB5C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:53 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id 67so4702300wra.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=FjDCd3uZs5tZgyebUG073A1B5l2RXwE8lidjbcRsCvs=;
        b=gVybcLoFQUNnqi8BvDXIuLxWzyBvmJ9r8YgiuYhT5Vu2C/zCCrI7te3RDmVOXAIc8d
         jWdwWo5LeuXbMT+aa3nFbTr7pi1D7mqVCTn1+Kr06wbwlyMlEdafbkwCQf+Np9kgAEwq
         G18BCLYbfNs//MAyXfJCvA4BZPSNOgVNjaxII/tGOSP3J7KzzOpraccZJslROAokEP/w
         gbpLxCXcb8AwsSYVXkVGO1YkPuVk07OlX1Ri3z5eDOhzP2nxBArhzqAoDZvUib0T7cA6
         sxJ2VEfODnX22F93ftmfkG7ItpS54IPEpfsGlbzriQ4c07kVaMvIWMlMtIo0OfVbEEEc
         TDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FjDCd3uZs5tZgyebUG073A1B5l2RXwE8lidjbcRsCvs=;
        b=WlpAtxrHUFriM6K+k0FNXiZ3WQFJb7V8h9AZFlNeD7Dfp5Zal4K45emcsPNapVppVL
         4d8gi2evQeX+vujOyBvHDXv68iOrZHZfWne8Iu38/kVWIUUYZ+kwhWsjOw+20K69ELPt
         CawS5/OCI0uaDreJm2leNFVdMB0+fkPYQgKA0yY7a1vTckGX272shhqduNi9dGK4XRIg
         5Banvh6UK/T8Q4npvEHVw5HvRKVmBY8QxGxEYYvoIy0Ek+R6HFtORELCyzma+1KHkJII
         zviyfq1k/fEiYQqJp1LbVdwcJHOPC7RqkFIiOD8rYUNUkXaLODqyg8hWwAX/TYrB3jeF
         11Ug==
X-Gm-Message-State: AOAM531WaNjMaFN39NBop3Tt27MIr4fvuldjY6m4KoAs3w88uj2HAqMx
        4vR4pbf/+M7jJni3QGxiXq3EmwaEulUWZYKR
X-Google-Smtp-Source: ABdhPJyhSXjfAMNZDyab6PZ2QpxILyu3jBNhWgi25Hcu7VUSLE8KCaS2ijL7XZdOMCTm1EGjb1TAJwfcjEDFzQlL
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:e74d:: with SMTP id
 c13mr6274338wrn.277.1605306051483; Fri, 13 Nov 2020 14:20:51 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:20:05 +0100
In-Reply-To: <cover.1605305978.git.andreyknvl@google.com>
Message-Id: <ec3e1c18c41e0bb8428f21440a1962c322cfe1af.1605305978.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v3 15/19] kasan: simplify assign_tag and set_tag calls
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

set_tag() already ignores the tag for the generic mode, so just call it
as is. Add a check for the generic mode to assign_tag(), and simplify its
call in ____kasan_kmalloc().

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Link: https://linux-review.googlesource.com/id/I18905ca78fb4a3d60e1a34a4ca00247272480438
---
 mm/kasan/common.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 1a88e4005181..821678a58ac6 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -234,6 +234,9 @@ void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
 static u8 assign_tag(struct kmem_cache *cache, const void *object,
 			bool init, bool keep_tag)
 {
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
+		return 0xff;
+
 	/*
 	 * 1. When an object is kmalloc()'ed, two hooks are called:
 	 *    kasan_slab_alloc() and kasan_kmalloc(). We assign the
@@ -276,8 +279,8 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
 		__memset(alloc_meta, 0, sizeof(*alloc_meta));
 	}
 
-	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
-		object = set_tag(object, assign_tag(cache, object, true, false));
+	/* Tag is ignored in set_tag() without CONFIG_KASAN_SW/HW_TAGS */
+	object = set_tag(object, assign_tag(cache, object, true, false));
 
 	return (void *)object;
 }
@@ -364,7 +367,7 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
 {
 	unsigned long redzone_start;
 	unsigned long redzone_end;
-	u8 tag = 0xff;
+	u8 tag;
 
 	if (gfpflags_allow_blocking(flags))
 		quarantine_reduce();
@@ -379,9 +382,7 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
 				KASAN_GRANULE_SIZE);
 	redzone_end = round_up((unsigned long)object + cache->object_size,
 				KASAN_GRANULE_SIZE);
-
-	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
-		tag = assign_tag(cache, object, false, keep_tag);
+	tag = assign_tag(cache, object, false, keep_tag);
 
 	/* Tag is ignored in set_tag without CONFIG_KASAN_SW/HW_TAGS */
 	unpoison_range(set_tag(object, tag), size);
-- 
2.29.2.299.gdc1121823c-goog

