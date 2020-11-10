Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2D32AE342
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732784AbgKJWVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732614AbgKJWVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:21:09 -0500
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C47C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:21:08 -0800 (PST)
Received: by mail-ej1-x649.google.com with SMTP id o27so33230eji.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=UUb16eez1SBPDEo4INNWK7vyjFOxlmk1eUi1izfNnGk=;
        b=QP7TuVPxCEiWmmHgnEKJnNoGay3AQqR5W+nqoq/mV5uvCvY6CbJgGKtXz82KEG4kId
         KNMjnlvqyunp1Kqhwt3peDe0Vg4O+DQxvkw+MnRVzCq5Nvf0Ou/xBeqbAPV2XSIrqswu
         9aKboBYNZGPP5klIdn8CMN07pjj/wj34ufercro9wLmyR/w6wCqGr66F7ztDXO4P9Y5P
         QoahP92EwMw+TLRC0EtcxvwFqReTRl6Xn1duRONdFajcKPyltvk3QlSDJFIhoKFiJo9K
         an+ewDBQH6xWC/JrFoJ/Z1WbXQtbEDByyh/6FVx/JJ1FMmIHAZ+hzFOiqtvuORTqVwpA
         AXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UUb16eez1SBPDEo4INNWK7vyjFOxlmk1eUi1izfNnGk=;
        b=HjDW45/nV1evxv41FdYj1JcRV7dUQ9rxNKz4/xsrJSGb4B9xWq0v6M9WGeD/9Qq7gR
         FHVpKL0NH7C7RMMcz+b2rLiN9meYkrx661wGjBxG3pczXAPYRd+IhFPQGqUyfALgrA+W
         4z/VaJlD0L4J7ZiVqr9kcN+TMhtpTvcPqg3CWsvExTzN0GtAt5x4Zy9+xAvQ1ZsQvC1L
         zEJmBqhrac5/a5nT9wKzoMpUJCLuen2OZTFnVgAn8XUWe6K2uQkWRRFg865mI2wR6RB6
         pPigywLs5R8Oes4GnLLhjvsYyJCubgrG51S6JgSwdzrFm7Q0vegVe5HHfDXoMFm6trZ7
         ZLog==
X-Gm-Message-State: AOAM531B5TR6g8smq58yQ0Dg6JG/aFK1IS2mLiGMWDYeB9LIPqQqV+OA
        gGDdYk0i7zoJ9gHmJt2afIadDeinFeObmf0i
X-Google-Smtp-Source: ABdhPJy1APWb8IPIno5fyCxmFvAiY4V9ib3nnVEVsGk5gNukRVXnCQVuL8cF06lZdJfE+QXxRpZDFZp+aOWcujy4
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a17:906:b043:: with SMTP id
 bj3mr21951070ejb.543.1605046867367; Tue, 10 Nov 2020 14:21:07 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:20:20 +0100
In-Reply-To: <cover.1605046662.git.andreyknvl@google.com>
Message-Id: <eae2f21f9e412b508783f72c687cb0b76c151440.1605046662.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v2 16/20] kasan: simplify assign_tag and set_tag calls
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
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

set_tag() already ignores the tag for the generic mode, so just call it
as is. Add a check for the generic mode to assign_tag(), and simplify its
call in ____kasan_kmalloc().

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://linux-review.googlesource.com/id/I18905ca78fb4a3d60e1a34a4ca00247272480438
---
 mm/kasan/common.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 69ab880abacc..40ff3ce07a76 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -238,6 +238,9 @@ void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
 static u8 assign_tag(struct kmem_cache *cache, const void *object,
 			bool init, bool keep_tag)
 {
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
+		return 0xff;
+
 	/*
 	 * 1. When an object is kmalloc()'ed, two hooks are called:
 	 *    kasan_slab_alloc() and kasan_kmalloc(). We assign the
@@ -280,8 +283,8 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
 		__memset(alloc_meta, 0, sizeof(*alloc_meta));
 	}
 
-	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
-		object = set_tag(object, assign_tag(cache, object, true, false));
+	/* Tag is ignored in set_tag() without CONFIG_KASAN_SW/HW_TAGS */
+	object = set_tag(object, assign_tag(cache, object, true, false));
 
 	return (void *)object;
 }
@@ -362,9 +365,7 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
 				KASAN_GRANULE_SIZE);
 	redzone_end = round_up((unsigned long)object + cache->object_size,
 				KASAN_GRANULE_SIZE);
-
-	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
-		tag = assign_tag(cache, object, false, keep_tag);
+	tag = assign_tag(cache, object, false, keep_tag);
 
 	/* Tag is ignored in set_tag without CONFIG_KASAN_SW/HW_TAGS */
 	kasan_unpoison_memory(set_tag(object, tag), size);
-- 
2.29.2.222.g5d2a92d10f8-goog

