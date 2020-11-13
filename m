Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C6E2B2877
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgKMWW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgKMWUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:20:25 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED2EC0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:23 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id a130so5872591wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mI/2rW8u6CFpBd7nyudEpTk9pqQDS3YjqZmg/d3PQMM=;
        b=NbjGOqNwl3sICIUuy2Dx6Xzsk+mkCs6fm3XUGKRsfG3RlwtzwJeMtGqzhnOtjIOoiT
         Rot4BuMouS9KdzhIncvVUDcdcTBFMKkaN6qwjznaCmoM7krl5OFJ6ix+0sWy8GuPLay+
         e2mJaLuz2BFxMMdHZ8SVcxa4QWYAge/CciV1HtckmdeKroa7ui8YIubpomJfLEoJ1dEc
         GBNCFWI8S9GHN0gntUUsZaqfFg/Mpc6BhsEB7G2dkF8gCf7kEbANocv7Q+U3YZWQavL/
         CxUEXJS9haZSNAG33cDsoNwaEc22R7xi0HycIMDSfOILK2oAZVPrHH2nAhLqdyaCGBkG
         gbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mI/2rW8u6CFpBd7nyudEpTk9pqQDS3YjqZmg/d3PQMM=;
        b=qBwakSUB/zRQSBCx5UR08cFLXFVmLq6p0OpDngdmhT2bKgj1llKc+5jVB2a+zbuTsL
         3K8AvxpEi098gmjYgorfhMEYrzp34g+DukG2V86T/dUkj3eQnG8yc+dgKvWFkbY0SL/k
         YGVPE73mTc0RUHBi4cZ8XygIrn2EvACP9NgcmYX+fQq/7zMtqPzzgphBYBLgz5RLfpVY
         Uor9WtunIBvoylXzfrGrL7jwypPXXN42XWH3QLHrlA3mW24//txUIX5JpiVNE4KAVdRw
         DluFsCmcrWdWusE56lBcggqUURCdaeHmfzf1DeCyJ7Rgo6hz7gZwI1mI6VvJSp6qCjLj
         V+Lw==
X-Gm-Message-State: AOAM531yWzaxyklYcJZFqb8SXBSjdZYRGQk7YwN8lMb9K67AHzEuKaA6
        k/RLuI5OYjRlx1i2qtkrDqIZsyMbDGSjGY4t
X-Google-Smtp-Source: ABdhPJxYtR4bh2WHC0w/07Gb/OQVXh3sZOJbZ2iTC6HhuummnwnQy7wvSSFekrmaH6T8oUMdO+1HYMOCfV40XpEX
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:f04b:: with SMTP id
 t11mr5710125wro.147.1605306022529; Fri, 13 Nov 2020 14:20:22 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:19:53 +0100
In-Reply-To: <cover.1605305978.git.andreyknvl@google.com>
Message-Id: <31f5366d3245f5405185a0b4057b305613ce60ee.1605305978.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v3 03/19] kasan: introduce set_alloc_info
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

Add set_alloc_info() helper and move kasan_set_track() into it. This will
simplify the code for one of the upcoming changes.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Link: https://linux-review.googlesource.com/id/I0316193cbb4ecc9b87b7c2eee0dd79f8ec908c1a
---
 mm/kasan/common.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 8197399b0a1f..0a420f1dbc54 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -327,6 +327,11 @@ bool kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
 	return __kasan_slab_free(cache, object, ip, true);
 }
 
+static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
+{
+	kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
+}
+
 static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 				size_t size, gfp_t flags, bool keep_tag)
 {
@@ -357,7 +362,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 		     KASAN_KMALLOC_REDZONE);
 
 	if (cache->flags & SLAB_KASAN)
-		kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
+		set_alloc_info(cache, (void *)object, flags);
 
 	return set_tag(object, tag);
 }
-- 
2.29.2.299.gdc1121823c-goog

