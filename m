Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74EC2F82BB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbhAORm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbhAORm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:42:58 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F487C06179C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:42:01 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id i82so8715944qke.19
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=K3THHtce7/ygl6Gpfs3Di2sEUO2VBikWbOhVCkSY9ac=;
        b=YxIbv2JZ/qV4zGXdFigX3S8ljfnrUEhn14Ys1aZ1tTUXEm8VYqpXbLen8V6PWdmX0a
         E1KPMLYLHXQTaNCWXtiwbrArQV7LeWFbU+EG84BCpcJgteiL6c+tG3fLF7sDwGzDfG3S
         r5hrWL8TSW7EFVfolYDnRo5v1syNLMimHqANOlQXZgKEVy9hu3vUcNELux9OWdB15Sox
         pEZaa+p/BXkx7IMyA0XmUFOGfe4MSjUg/7LDoHyIqRjQppiMSyORcYeBWw08mDINHECt
         mKMRs/P6jP83P3rj2rhk01YJ0AVD+WaIOHBRq+aF0M4Glu+TVEtCF0AwjpAyhvn6MJNs
         kr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K3THHtce7/ygl6Gpfs3Di2sEUO2VBikWbOhVCkSY9ac=;
        b=mO8xMbAi5NsMjrI0UPKK3eRfb0u+mbkYX+oxU1uMjOhA0KeRvBX52ZlTBBsqe8I+yb
         RvORpteTMFXUuugxc41Z74D2CzyUYhPBhjnkO3j5iJLTA12KfLskBrb4NYglIWmZtgJo
         1nyTB74ovyFOigPONktUJnm6Sl3ujT9oUh8pptaZfUiEKG4XBD6aKC3O5ttPYMysGqA1
         Hi7DRLKH774ahJfBuy65v3rqtQ1MVeAEtnUe6STRznaCdx2b8LQgUtw4Z8y+aFgZ1Ykb
         ZVumAN2s06IQ4+T0IwJ/11IIkxgIUnJMkXEKferj7lYTOrWL5aNMpJkauzt1id25zMVw
         RuNw==
X-Gm-Message-State: AOAM530+MkQEZ6uU526z97zvoQNOWxkTR/Xuh2Fu9ZbN1jN+gdMnlqXT
        NPUmw8vbmqQu5ZyFt74NP60kKnFeb+msONLl
X-Google-Smtp-Source: ABdhPJyo0C2bPxvDzikWja0CkQYEzL9V2i5cKHIqhrS1fyoan+b+6pCwJnsUWRVvUkKXYAqE+QHiD+IlNohOm2Al
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:c583:: with SMTP id
 a3mr12947974qvj.15.1610732520689; Fri, 15 Jan 2021 09:42:00 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:41:52 +0100
In-Reply-To: <cover.1610731872.git.andreyknvl@google.com>
Message-Id: <093428b5d2ca8b507f4a79f92f9929b35f7fada7.1610731872.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610731872.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v3 1/2] kasan, mm: fix conflicts with init_on_alloc/free
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few places where SLUB accesses object's data or metadata were missed in
a previous patch. This leads to false positives with hardware tag-based
KASAN when bulk allocations are used with init_on_alloc/free.

Fix the false-positives by resetting pointer tags during these accesses.

(The kasan_reset_tag call is removed from slab_alloc_node, as it's added
 into maybe_wipe_obj_freeptr.)

Link: https://linux-review.googlesource.com/id/I50dd32838a666e173fe06c3c5c766f2c36aae901
Fixes: aa1ef4d7b3f67 ("kasan, mm: reset tags when accessing metadata")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
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

