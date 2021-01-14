Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B8E2F6B0E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbhANTet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbhANTes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:34:48 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87397C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:34:08 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id bf13so2789546edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=K3THHtce7/ygl6Gpfs3Di2sEUO2VBikWbOhVCkSY9ac=;
        b=vGVmZqHj/AbJ1AfEndnv5qhN+kxXpODExe7oS5E1yEmi9WEhI0SfOrlYPGX55Bl5S5
         IAj/+Mw7dd5aBsSYNH5jX2rqXbsXhFP6e6PPixAuxk0wrqZ8unG4KH7Cw/eVhGJTGviN
         lPkgslaukDbGTN/Gv7djiu445f3483hEM3Ad6vdiOVFB6a05Sit/uI9otkaqdljywR+C
         v6tF/BLbualYuwQqKuaZJ6I8BIhCsGVVmIFVwUEHBeIG26BFXuW0fwgIBrX43LYTrGWH
         yeDapqJs1tPTHyAjsYyRfn5TLAJLj6+r7IU3blDikAT/jQG8jRfHtzStwmTf/yeR+4iE
         mdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K3THHtce7/ygl6Gpfs3Di2sEUO2VBikWbOhVCkSY9ac=;
        b=S4nkI/aKkmwpOfC9Fy1bpNWUwqv7GyzPRsrQ/xa3c/NKgSjEGRY49M1PTTY1+rZw0i
         I5LkhodyiNgKfEDTIgfck34i3FGQi+wHShsLiIT2b8skrJCGgJrFnCPEuwleF+wMXALJ
         ZCSnq65usROpMxPk2lUF8nTXAJXtknsznnVnnWtnj8VZyP2wUpey5zsCeWiiSn2ZAsYl
         KtVZScr2HKw5izB3YjjB2XdXEYJHpmf2ydS71FY5QNrbeyr2L6H9cwp2fHg0C/wqCrvX
         y4D9CbWZJ1uEWliuCT3vCaXfQVuut97OWPOFL6a3NEX1Nj33vANEgBvZHoyjamQATByq
         PmTA==
X-Gm-Message-State: AOAM5320vLG4tXeHZy6ZF6GTe+MHT3Y3fF22rzVM/Xg4OFFjPmWaUW97
        EOK26NcPXmpzCHfGjklgAyCiTiUeAjkSjQeQ
X-Google-Smtp-Source: ABdhPJyemLAvJCZ5NV1PNi6ia9mIG5BPvNuaojX/Vqve5Fg8GAq9MsC5vRUJBJF4bO4tLtErmJICS+Uki60iFkJH
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a17:906:578e:: with SMTP id
 k14mr6448146ejq.90.1610652846821; Thu, 14 Jan 2021 11:34:06 -0800 (PST)
Date:   Thu, 14 Jan 2021 20:33:56 +0100
In-Reply-To: <cover.1610652791.git.andreyknvl@google.com>
Message-Id: <89cd4db80c3ee8c1975eb9171e99fcbc894eb1dd.1610652791.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610652791.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 1/2] kasan, mm: fix conflicts with init_on_alloc/free
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

