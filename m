Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0FD2B286B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgKMWVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgKMWUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:20:50 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9CFC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:49 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id m17so5484185qtu.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=WUG0j444ZBT4A3BTzNH/LM6507YxULafwrr/Sriwg0c=;
        b=feWIg6qUi7heyfOTSzsy2DpmrO1Qia8xbqIt8JmH5daMnreAv2krFvZcHiqDVKaKv2
         1bTiAzutYZP/XiwiZ9rIvAKvtPkQ7Mc6tpkK9c/r6TsmzWPVn8WIrC7+uJ4GTVzK1zmW
         TARqSwftqGvkqjdh+M4+ZJqYCDPFDqsDB9jR8vkc90/AV5vWJuhIxDotwDlEkh3jH5qe
         ZmaI6Rzzwp10/w7Ry/ZUbxCMitP2uLv4cyOpLyoScAlq9lSOFBT/gO1S6XhYs7/32ijH
         6yjUGd/6BuFXadoaZ8NaAhKvRf9nKcM6diCCz9JjlSN3ZDQG/jWv6oy7qyJYGVlmyAkl
         JszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WUG0j444ZBT4A3BTzNH/LM6507YxULafwrr/Sriwg0c=;
        b=i8N6zvxNZSippQSY3VFEfl5x8+5PpuBom/mgGelHVZwyhT+GaESsEeeOVZMBZy1QZ1
         gp9ntTBR/rJ2VipwQ5EG5bJ6VyNPjqElJ+r5t5u3Y01iqTKQKEXaLXyN5gAuCYwoSmZu
         IkHQGd2u6cYtl6bDbhqTbA7wmlAbSZ0POAeT7cii+inb8NGjwkr4PfaDpJYDbs0i7iyX
         v+5Ose3LqvlUv5q/t1+6ZxDWhilzbq5Akym2bK6MvDZrC0ZFPwEf+VLX7W9aWL0nOXQy
         wAbrsPnoYsU4iy+faNyui9hgWnPpd/CZuMtCRXUuAwZU7J/r/IqmEEYQafJo94PZ2D2o
         kmiA==
X-Gm-Message-State: AOAM531ENDgCzSbTbkYU4/gIj8eo/9uDeiAYOMcKkMIL9uZhnm2/mOUm
        UNRWF+QfeZYls7FPDxkZcF+hKZA1ss/l0gqP
X-Google-Smtp-Source: ABdhPJyDbEDKFY3EfcHLc7j3mQfHgxDyZ09bJBO/2bzJnR89c+WsxkzTNbHHqzArwf4wHZ9mwaSRm4uyurfObZ/0
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:d43:: with SMTP id
 3mr4767045qvr.38.1605306048874; Fri, 13 Nov 2020 14:20:48 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:20:04 +0100
In-Reply-To: <cover.1605305978.git.andreyknvl@google.com>
Message-Id: <38ed98141f58eb53eb23100caac212b1c1f3bc9f.1605305978.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v3 14/19] kasan: don't round_up too much
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

For hardware tag-based mode kasan_poison_memory() already rounds up the
size. Do the same for software modes and remove round_up() from the common
code.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Link: https://linux-review.googlesource.com/id/Ib397128fac6eba874008662b4964d65352db4aa4
---
 mm/kasan/common.c | 8 ++------
 mm/kasan/shadow.c | 1 +
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 1205faac90bd..1a88e4005181 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -214,9 +214,7 @@ void __kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
 
 void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
 {
-	poison_range(object,
-			round_up(cache->object_size, KASAN_GRANULE_SIZE),
-			KASAN_KMALLOC_REDZONE);
+	poison_range(object, cache->object_size, KASAN_KMALLOC_REDZONE);
 }
 
 /*
@@ -289,7 +287,6 @@ static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 {
 	u8 tag;
 	void *tagged_object;
-	unsigned long rounded_up_size;
 
 	tag = get_tag(object);
 	tagged_object = object;
@@ -313,8 +310,7 @@ static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 		return true;
 	}
 
-	rounded_up_size = round_up(cache->object_size, KASAN_GRANULE_SIZE);
-	poison_range(object, rounded_up_size, KASAN_KMALLOC_FREE);
+	poison_range(object, cache->object_size, KASAN_KMALLOC_FREE);
 
 	if (!kasan_stack_collection_enabled())
 		return false;
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 37153bd1c126..e9efe88f7679 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -83,6 +83,7 @@ void poison_range(const void *address, size_t size, u8 value)
 	 * addresses to this function.
 	 */
 	address = kasan_reset_tag(address);
+	size = round_up(size, KASAN_GRANULE_SIZE);
 
 	/* Skip KFENCE memory if called explicitly outside of sl*b. */
 	if (is_kfence_address(address))
-- 
2.29.2.299.gdc1121823c-goog

