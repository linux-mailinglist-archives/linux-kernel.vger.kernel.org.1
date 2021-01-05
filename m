Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94F12EB29B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbhAES3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbhAES33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:29:29 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0642C0617A3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:28:26 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id t16so369756qvk.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=iBAofrYhtWdvm45KaDvHp4GorxFru4go+vxs4/2NiTo=;
        b=KhhzCW5Es0nmSwmYkGHPGV3OGnAcoZc7jwfMbTCbCegBDHXqF5DT8rkvlPE1yIST+o
         YEVKKkxEvMOk/SLecNzaD6NXqilvTc8a2f2w2cFRB94lDfJSW043ea4L+TWP+h4PTPcm
         XZaV27X5QjrMJ3W86t6eGFjgcjoIXsOMabPka26suv2tXMMEa4sSd6qp4ZRWu/8rMri4
         radLuY707IJUKEWW2iqRvaEB7j0HgxYLHeWZNGvjBPJ4uKDVQ+C3xGF9GGZ5kGPg+0LY
         fJd9knwm/PQxFTpoq7S/RzOqqxhlzr1ECWNzghOssFSwsr0qcptOTpJnyq4jJAAo5ke6
         bfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iBAofrYhtWdvm45KaDvHp4GorxFru4go+vxs4/2NiTo=;
        b=onG+OBvBnXV9AK6EhQ+SHIh2EA072FzBIhHiEbhwoE3O0s55598ovKuDUwV+gmC8PD
         WiYLkk81tj6Hm5yGrRsNG115Km2TL8vQsDdP4KRSwh9O9VtJT89H10BzcmYIWDBdRd3e
         jiULUsFW7W2DdzPTgzcJmy0nj5tlLFa4ONMdc+2upm515p4lWRdlBpJiJ5JtXfxDfQZG
         AwKqTCFbyJOHoeEJ7b1Uk5Ri/nnwmn+ArllIoSg9PltjgoPMsMEmXQ7LwAuhj/T9C9qN
         kIcsbQACdPq8J6D60SzXYitJUNk348pi2iK9zoQMjRC9mHDWoDqHvbQy1XJuSbryUbVc
         8Q8Q==
X-Gm-Message-State: AOAM531ne6PtK6ItmFNhoJu+oOm3vz8Yu0kDiWpfSr29+quMo/2VpYAy
        /HopKoAnlKj+CI7XpTbIJpdzBFI8SV1yW6qt
X-Google-Smtp-Source: ABdhPJz9ZeKojsIaFk7oiCjyflKtBkBDpOWYVQ94sBgXV9c8H5cDJw47Fn8opToDG7AunMFDOU1CSaq1S5pOZ82S
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:e90a:: with SMTP id
 a10mr863092qvo.38.1609871305814; Tue, 05 Jan 2021 10:28:25 -0800 (PST)
Date:   Tue,  5 Jan 2021 19:27:53 +0100
In-Reply-To: <cover.1609871239.git.andreyknvl@google.com>
Message-Id: <0c51a7266ea851797dc9816405fc40d860a48db1.1609871239.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH 09/11] kasan: fix memory corruption in kasan_bitops_tags test
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/I67f51d1ee48f0a8d0fe2658c2a39e4879fe0832a
---
 lib/test_kasan.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index b67da7f6e17f..3ea52da52714 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -771,17 +771,17 @@ static void kasan_bitops_tags(struct kunit *test)
 
 	/* This test is specifically crafted for the tag-based mode. */
 	if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
-		kunit_info(test, "skipping, CONFIG_KASAN_SW_TAGS required");
+		kunit_info(test, "skipping, CONFIG_KASAN_SW/HW_TAGS required");
 		return;
 	}
 
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
2.29.2.729.g45daf8777d-goog

