Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C582F4F72
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbhAMQET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbhAMQES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:04:18 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E241DC061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:03:37 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id l3so1772663qvr.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=S1gB0mX83HDDRDaVYmLzCgZEsoFxFZ697ly4fdy8+Ks=;
        b=onsW+t/YsYPW7Svrw7yWD2kvrRWEmrDqD+BcstXXpVYE27xuAbQnuH366baXFUJt7P
         q2byhvdnZS2pHRQEfzr8dVbYqGDMqWhQdCNgsLaH5LgIYs+rBzpKTp8X1s5UfXlW31fo
         e/LF6hRisIMf3tNYOwJcmN8ctzKnUVwtEIRdZdB2mCsOgt7eokJxnt8i1AF4kDp+r/Jn
         eMgyMsESgMNLluf6Q0Z8B4w9PFFgPGXC/zypWRSttrijEeUX1QAA6paSYDx1Ux9nv/MR
         oGsZEZ5ILg/XHhL4Wc9leIItNY5bZTBM2ML71iw/WcHGEoCcZ6vk7T14I7OM8Z3hQDyB
         fI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S1gB0mX83HDDRDaVYmLzCgZEsoFxFZ697ly4fdy8+Ks=;
        b=EhBiwmSnxcXilpm/Q0KbNKrfzJk/LeVJ2SccurjaEPwYXcBmdVBIQM/zOqXLXU5fKe
         zrgYeh27Swut6aA8qSBQ+dk0yYlFxRgodB7lWBHKb8i2r6wJNZMTjUm9tRvc+QyKM8Xw
         Is9EU3wJ6QNuGbuFKLCIr8nxLasYEn+eZK5JS/QANACBGawZ5q7rT/lJZA6kyhEbqNgy
         v6ZjFRA0gNsZwCrG3QOz3miwhvrsa3nr6AABOBvZvHJkcVwCaJUUcmNxopJFOrQLxb9g
         0EmEUFjbJYdY1762pC3EbVBYjguVydCgE9OcA2AoerWHpdw0HXfTX2jC6ox00ee+PoRW
         d72w==
X-Gm-Message-State: AOAM533uVPSqw4XK1vne3ZDqUDFi2eS5F5n05xdfyTRI3gtyShtCeG4c
        E67VMdO/0sdnICgb14Rz6LMs+7Xo3jE3O5zL
X-Google-Smtp-Source: ABdhPJztlyDnxqW+tCluo1zQcHISh9MRheAbpgrcjhVfg6uiLIQBqjzru7wLvoT5T/oLsbWRseVQ28oyUeghjYDF
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a25:ac1f:: with SMTP id
 w31mr4193358ybi.87.1610553817007; Wed, 13 Jan 2021 08:03:37 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:03:29 +0100
In-Reply-To: <cover.1610553773.git.andreyknvl@google.com>
Message-Id: <7fbac00e4d155cf529517a165a48351dcf3c3156.1610553774.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610553773.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 1/2] kasan, mm: fix conflicts with init_on_alloc/free
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
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

A few places where SLUB accesses object's data or metadata were missed in
a previous patch. This leads to false positives with hardware tag-based
KASAN when bulk allocations are used with init_on_alloc/free.

Fix the false-positives by resetting pointer tags during these accesses.

Link: https://linux-review.googlesource.com/id/I50dd32838a666e173fe06c3c5c766f2c36aae901
Fixes: aa1ef4d7b3f67 ("kasan, mm: reset tags when accessing metadata")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slub.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index dc5b42e700b8..75fb097d990d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2791,7 +2791,8 @@ static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
 						   void *obj)
 {
 	if (unlikely(slab_want_init_on_free(s)) && obj)
-		memset((void *)((char *)obj + s->offset), 0, sizeof(void *));
+		memset((void *)((char *)kasan_reset_tag(obj) + s->offset),
+			0, sizeof(void *));
 }
 
 /*
@@ -2883,7 +2884,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 		stat(s, ALLOC_FASTPATH);
 	}
 
-	maybe_wipe_obj_freeptr(s, kasan_reset_tag(object));
+	maybe_wipe_obj_freeptr(s, object);
 
 	if (unlikely(slab_want_init_on_alloc(gfpflags, s)) && object)
 		memset(kasan_reset_tag(object), 0, s->object_size);
@@ -3329,7 +3330,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 		int j;
 
 		for (j = 0; j < i; j++)
-			memset(p[j], 0, s->object_size);
+			memset(kasan_reset_tag(p[j]), 0, s->object_size);
 	}
 
 	/* memcg and kmem_cache debug support */
-- 
2.30.0.284.gd98b1dd5eaa7-goog

