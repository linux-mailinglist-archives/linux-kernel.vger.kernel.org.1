Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312C7295FD2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899757AbgJVNU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899702AbgJVNUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:20:14 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE729C0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:20:13 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id s25so583641wmj.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xOXxdsX9wfgVlPASo24fEeH7IiHQsViadxCdQzhZ1/Y=;
        b=HfX7ercL+cFW/KClhFoz+6kZbu2i+/58U1zQot0xkcWJUF4lNlzTPutId70SOfd2su
         jTfaHHJ/k1+6vcydfwijYQY45vVXk4hQxn0bovGm+FuCTzRWCzYeHfO5c+0PaBsWEAs9
         SkSvJy/yjNmODf8+50lkI136iZ6TU/E+cKDQ2rkS5Evb8rPm80APJnXIvGMRkPuFRDXJ
         MxmPdEPchFR3620tU25OHllWIx19ppDbTTIYyRq9ZyvHnxi3SPOuQLihNQInuBF5+BW9
         Lhm+va8L6VezXpICA36BvVmlZaQeLJCdYjNnF5WhHdYgVS3mujiiSLiBvdM8+39/CCs1
         s+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xOXxdsX9wfgVlPASo24fEeH7IiHQsViadxCdQzhZ1/Y=;
        b=MFBXDS3ZHt6o1+w4tBVsj4ZuUcRhtPPEvKkrjnbpZZK9rIN47Kxsi/Ym5n1fLnE2YN
         4sf76MODLMGQRP7qtdEHAHzsTOGdb1wwkYRUfES1W0SRTGejlDN/nmshqmj1bsQCrImK
         7JY1cIPgpICJqyWnUYn9+w73tqYPdld5MUONSvw2rv8KNxEppnPZTZOVAkS94fP44b9t
         V+7HmFAxSZRkO0GUqnDzESgWKKwEd3hHUBVzdHhigNzToJYWCprChPenwn1MdoFgcbY3
         zkhA9mf5zS7y4AG1ovdPnSUCPMc8AvFuT+SDTPY0F1vxuZnG/d9VvlvozoqODqRY4kdc
         P+Qw==
X-Gm-Message-State: AOAM532Q+JEqT9AfpqUoVi+ZcWc2cN6YuGxzDIE7c7xsK7KOUy9lDksV
        PDE/sUeb/lxaU9xmm9rESL0NkKPs4ChBOnxA
X-Google-Smtp-Source: ABdhPJxmmX9viwK28cT2Ay5EHxingwtZYKgXsdkjeLwZhFRedSASX0UK4zU6EaIwvfeoe8I2Gxb7B7c+TXE5SqrB
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:3503:: with SMTP id
 c3mr2468528wma.43.1603372812346; Thu, 22 Oct 2020 06:20:12 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:19:12 +0200
In-Reply-To: <cover.1603372719.git.andreyknvl@google.com>
Message-Id: <6e866efaa7620162a9824914186ce54b29c17788.1603372719.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH RFC v2 20/21] kasan: simplify assign_tag and set_tag calls
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
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
Link: https://linux-review.googlesource.com/id/I18905ca78fb4a3d60e1a34a4ca00247272480438
---
 mm/kasan/common.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 983383ebe32a..3cd56861eb11 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -235,6 +235,9 @@ void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
 static u8 assign_tag(struct kmem_cache *cache, const void *object,
 			bool init, bool keep_tag)
 {
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
+		return 0xff;
+
 	/*
 	 * 1. When an object is kmalloc()'ed, two hooks are called:
 	 *    kasan_slab_alloc() and kasan_kmalloc(). We assign the
@@ -277,8 +280,8 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
 		__memset(alloc_meta, 0, sizeof(*alloc_meta));
 	}
 
-	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
-		object = set_tag(object, assign_tag(cache, object, true, false));
+	/* Tag is ignored in set_tag() without CONFIG_KASAN_SW/HW_TAGS */
+	object = set_tag(object, assign_tag(cache, object, true, false));
 
 	return (void *)object;
 }
@@ -360,9 +363,7 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
 				KASAN_GRANULE_SIZE);
 	redzone_end = round_up((unsigned long)object + cache->object_size,
 				KASAN_GRANULE_SIZE);
-
-	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
-		tag = assign_tag(cache, object, false, keep_tag);
+	tag = assign_tag(cache, object, false, keep_tag);
 
 	/*
 	 * Don't unpoison the object when keeping the tag. Tag is kept for:
-- 
2.29.0.rc1.297.gfa9743e501-goog

