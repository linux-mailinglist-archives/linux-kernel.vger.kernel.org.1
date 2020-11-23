Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950722C1650
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387472AbgKWUPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387443AbgKWUPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:15:30 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFF5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:15:30 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id d2so151357wmd.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wBmPP01T6X6nVOaGKZckDZFO93MqGK09sbRfPDSt1eI=;
        b=vHo5ItmTL3kbBhJu4MbDo8AfqRmB73n2TJFE0EqgqSt8qZmzJAeQdQC3sKEnalkGXn
         ktkjkHf9SVCy/+8sUzxYEdo0V1Yxbry2LrkenRFFOepM6GqptfBvA4C8IpThBl75KpHt
         WmRnIy0r+5UovGNDlKo4z+gvVIVR67Jp4iFay2QP1lhbg/zzFlL1xN2Ts1992NPJccMO
         yPvLvTrrP9WRIgX3u5V106kkWnv9b5I21z82z2a8Odxi1fZjp6KzOWRTuiHa4PYjNJv+
         Qx8DTqkNyJ8snArdIUqRdgkNEsIT5BmKTanM6v/2K7vU+vIIBXO28XYu1M994wDmikAX
         UWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wBmPP01T6X6nVOaGKZckDZFO93MqGK09sbRfPDSt1eI=;
        b=Pnz3SmU4mqIc19Yg36ZcRPf4uIOMQgxSOU2c/1XP/MwiGsBucomhM18BKxJeiOgtJV
         eek4pw4yn3YEehyfdkB2dkVoPVyyB0SRTzmkDeN1uVPREnSVzHC92GkUByakRpNFOy4D
         epr52PguqNtgaldk3H6uvUdY6dDRCCAApJMg1/Df79hFEN25r5UNYcpjBVaJFQk67oR6
         C6G4RTs9zH0UFORaXt3smU4j1pr2GxveoT8yJqnllGDc7+E4xulXs2ZocUDWyD0b8ayz
         Q8+vpNBV9yw5O0c7dAGUTjy5Z24qCuBYYz7VYX8N9hcxaRPEFYAU3ETlkDouAwPNosbZ
         t7Mg==
X-Gm-Message-State: AOAM5312kGkXGWpxUaBqnh1h34SWaQglWSiKIfrGDcclOkrODpbAeAeO
        LUd+WGDfInj6YgrTvNMOncn+8NuejU0sQBbL
X-Google-Smtp-Source: ABdhPJyHaYhL2h/mGk2m6LiBmTS7pItR3APYX+HCQrNLLJYOQY2bd3/ofHLz5IVsdCsxUJXf29WoeTZZqqWHQsZj
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:810c:: with SMTP id
 c12mr609306wmd.96.1606162529119; Mon, 23 Nov 2020 12:15:29 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:14:45 +0100
In-Reply-To: <cover.1606162397.git.andreyknvl@google.com>
Message-Id: <121eeab245f98555862b289d2ba9269c868fbbcf.1606162397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606162397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v4 15/19] kasan: simplify assign_tag and set_tag calls
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
2.29.2.454.gaff20da3a2-goog

