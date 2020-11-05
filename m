Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D092A7386
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387718AbgKEADR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733029AbgKEADQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:03:16 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7BBC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 16:03:14 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id w1so99839wrr.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 16:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KFrv2CeYC66xd7QOOp7G/eCqjg0M9rtzwQxn1AQSEo8=;
        b=QLuAbvZHFP2W58yhtR9vhBr55r8Hyf3S4Rs3PezTxrfLFhxyd7JT09PKnYS8oSsPPq
         gdRKQvVLLsai3OEzz4dyfxqzwtdGBwLP/JIK3nrPx65ohFOxXi8w41i17w7g8HswL0pM
         QsnWuFYb+DhqJ6xTCmfTf5pevVgWDcXouuFmLtrqO1Pnya8cbLcz2uUW+4+tBIDfCvWR
         NIBMGmdmtEOwmByJGW5M96WjPsZbCZh7VmiInUy7NkcWeP7l8Bovd9DsLTRHc6Tgd9yI
         lZqfbycXbtZhTw1t+934rBC373gyowgCXZJ0eV1iEKb+i/tEaSfzGY1H5Xkynl1uQ7FS
         4S7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KFrv2CeYC66xd7QOOp7G/eCqjg0M9rtzwQxn1AQSEo8=;
        b=Mp2ZoikesSuyzzEcScKiBU+vTDotSmCn5C6WO33Jmse62skNymynRHb1Z5t4N4xqmN
         R2W5lJ3aaz2VwaH8FSFhS/hmGyb1CaBCp88aBhSn+WkLr2rZUrYTeuNBq323Wx9ZxnuD
         MluAYJ2gYpPqvHcDFNGy/dySDczETiQgCkMXyidm9eVZOdw1zF5w0NM5/VGGZEGH9w8s
         +ziEjeE/cEV5GjhbHW8qCamc0WZ0LT/EEMJUBQrIqVASDMfo6hw7KfpllK03JaDrxUGA
         09+u9QXWGON3Gp9EBZWUDVnyXrJ9fSfYS9ursqNQzsORD9Q2VrsCDh0ueWqoxf7HF7DA
         7XcQ==
X-Gm-Message-State: AOAM532JKgKkPcblNpNw/T3YFamqy2V9YaCXXinaFC1sfh7kAFg5sGzi
        VUEZAjyDws6Ly/LiTHfXNcnxRxbORdpF1xLT
X-Google-Smtp-Source: ABdhPJwQ27fD7Fc3ZNzuubZFZKWZfrYiXQ310vGkklvY3Ifyj2TvUAmaupP6a4qWeV/wlXVXw6iDgvs3qJM0Dpq1
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:9d02:: with SMTP id
 g2mr24703wme.110.1604534593196; Wed, 04 Nov 2020 16:03:13 -0800 (PST)
Date:   Thu,  5 Nov 2020 01:02:26 +0100
In-Reply-To: <cover.1604534322.git.andreyknvl@google.com>
Message-Id: <d4149b16fe2fd29e57a0bb8d997354676f76a183.1604534322.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604534322.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 16/20] kasan: simplify assign_tag and set_tag calls
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
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
2.29.1.341.ge80a0c044ae-goog

