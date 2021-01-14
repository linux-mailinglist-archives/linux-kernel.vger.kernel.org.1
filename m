Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D39E2F6B32
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbhANTiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbhANTh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:37:59 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B84C061795
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:36:58 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id h7so5305880qtn.21
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ifrv61nnbwuahZCEiwjCwkZVX2MKhkqH/HoLspc9PnM=;
        b=svvurHrHAcNYd/CQpQXSFQuHa9Ng8oBiXsZOqVosLsBBpuko4Af8P7jmQDjInyf/fM
         DVIWn495lGvWTbxs+rpvrFbIHurmf+B/mdK1L18doOeUSBrUSD0brU/9kX/U1vm9qhJp
         kAs3xT0lWdqqiAiB5sVUJRyWfszLq7mO6QKFsTd+Xr0wyHtJBEs1Q/EsEtKybR9gotZ8
         fjvT4ue9G6yBvYVXQR2ZABb8kp4QUr/3SMVaLi2E2Gy5DAeBAVyEav6RLmYpuLVm39iH
         eF8aJCJfYsIXVRHUQvFWd76xKwZHT8LIdDjWrMcFRwQSPDyVhguE8MAnZaOzY5p5g985
         PCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ifrv61nnbwuahZCEiwjCwkZVX2MKhkqH/HoLspc9PnM=;
        b=CwGQauauS+IGPhRmg28NDxuMej34unmPB7sfBXs3wgN7TpLJ7TzvNyKxWKOOKQ5fYT
         CVZbOlt1UGaEyVnMpmUXJvhwnil1gj/T++eHtBcK6SBlQLhskpdrOnlL+tZK119niPzQ
         08SDbepexCityEcypGoAK1xLOQr+ODu15b+rsNJz2D8BPMF04n+aLcwt7EKHJzPDSKMm
         o3UxdQehpxwRGWIeMeXV17o9h3gOHrYeYHJeIrXEp8yRGnVZDvRNF4AvK+KsMBiGkZX8
         GqE0TjufifJ0RI/sD5GZzHyIiL2+PvmUB+vN4zmg8rYumNyql6Gwza6sm/Uzw/wul+NX
         bPRw==
X-Gm-Message-State: AOAM533ynMjEryOGbGrPwTw2jgSEsIU1XqOrD2eEvi3vICmSeJToCFUu
        ajwpCzCnHNC6FzKKWKzZ5owqazy/NArn2Phi
X-Google-Smtp-Source: ABdhPJxsaB8DotGQxWble5pFmykfdTGG5ArjTFhmCqcwhqBIGlk7Tsyswg8ZcoX/blfWQVd4MH1EYIJAGkRqexxn
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4c44:: with SMTP id
 cs4mr8625788qvb.25.1610653017877; Thu, 14 Jan 2021 11:36:57 -0800 (PST)
Date:   Thu, 14 Jan 2021 20:36:26 +0100
In-Reply-To: <cover.1610652890.git.andreyknvl@google.com>
Message-Id: <5232775c82fe249ef3ec0a1e8470ec54eceb5002.1610652890.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610652890.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v3 10/15] kasan: fix memory corruption in kasan_bitops_tags test
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
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the hardware tag-based KASAN mode might not have a redzone that
comes after an allocated object (when kasan.mode=prod is enabled), the
kasan_bitops_tags() test ends up corrupting the next object in memory.

Change the test so it always accesses the redzone that lies within the
allocated object's boundaries.

Link: https://linux-review.googlesource.com/id/I67f51d1ee48f0a8d0fe2658c2a39e4879fe0832a
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 0cda4a1ff394..a06e7946f581 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -749,13 +749,13 @@ static void kasan_bitops_tags(struct kunit *test)
 	/* This test is specifically crafted for tag-based modes. */
 	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_GENERIC);
 
-	/* Allocation size will be rounded to up granule size, which is 16. */
-	bits = kzalloc(sizeof(*bits), GFP_KERNEL);
+	/* kmalloc-64 cache will be used and the last 16 bytes will be the redzone. */
+	bits = kzalloc(48, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bits);
 
-	/* Do the accesses past the 16 allocated bytes. */
-	kasan_bitops_modify(test, BITS_PER_LONG, &bits[1]);
-	kasan_bitops_test_and_modify(test, BITS_PER_LONG + BITS_PER_BYTE, &bits[1]);
+	/* Do the accesses past the 48 allocated bytes, but within the redone. */
+	kasan_bitops_modify(test, BITS_PER_LONG, (void *)bits + 48);
+	kasan_bitops_test_and_modify(test, BITS_PER_LONG + BITS_PER_BYTE, (void *)bits + 48);
 
 	kfree(bits);
 }
-- 
2.30.0.284.gd98b1dd5eaa7-goog

