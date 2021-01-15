Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233D12F8315
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387408AbhAORy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733220AbhAORy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:54:26 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F8BC06179C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:53:25 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id 189so8760348qko.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ifrv61nnbwuahZCEiwjCwkZVX2MKhkqH/HoLspc9PnM=;
        b=vTETwvGiJABOZThdLEGDvx2ivUu23KL2qBe85GQ2khevnt+UiLKbHEZFfUnOq4GNLk
         qEQRZu2Rryy9Th2CbAjsJV5MPhk4d4wXovKLQW0Ge60/tF8f7gxVwDEynPo0GSJ8UzXS
         76BSdfwWrmYxJc+ReiL5WAUkT6fy0dbh2URGuNq7lMXRza3iXqgLubGYMjGcju2p7GKG
         3EKGiT0/Y8Xy02Qkh/YyLa9r+ewB6SHgkKeRMAuUDbP8hCjB+8ndVXAjVh1YZ9ttC9IB
         ArlvDDJZeldDhBey7DK9pNJdB/cBxSOaj0KonS02EAleUp5JjHggEc+tsnlgOb/DAqVb
         MPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ifrv61nnbwuahZCEiwjCwkZVX2MKhkqH/HoLspc9PnM=;
        b=WeA95tjaTpcUyBvg6nx+qGhRk+8MeSMhK2+SAMOVYJx5/2wzqcAb97fSzl25BGdNop
         7zGWcXAgcLEDb8A9zEE38EEYg8cY/v6Bjdi+HREJvH02DysntR018CKmMfFlWbpjIG6D
         MKDo9d+KySfzIC3Bxn/29hL0PmHltQKJRbnQAuM2w9E+nTpIDrP813YGVQrQ0/NYKJ2n
         CLPh3e9yjvXuj8Q0vITGOlZYwSA9dvQrm+ZL/BhwMVMb4+yBp1e1jaKg8Nls+7dy6x83
         +hSfCuN+q0Xcxt4V9s5KbVpZw3RXVIlckAmhG5XmoQBfLhoTdw4IDyo8F7V3UH8U4SLC
         MURA==
X-Gm-Message-State: AOAM530G4XaKjm0tqfyUt+tylS4XFzhwcGE4sYZDnje3CMQ5+fPElWZA
        Ykt5H2JVlwa+bcfL2FjDqHgwqyazO7ZkVkos
X-Google-Smtp-Source: ABdhPJzBfQb6zE2y+OXiTp9u55l4FMz8PVljaEAfFdsjjaKCaC+5vFZX/LRjW8sQEZKI2STL25NXVivPrT2w5LX2
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4c44:: with SMTP id
 cs4mr13129570qvb.25.1610733204089; Fri, 15 Jan 2021 09:53:24 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:52:47 +0100
In-Reply-To: <cover.1610733117.git.andreyknvl@google.com>
Message-Id: <7d452ce4ae35bb1988d2c9244dfea56cf2cc9315.1610733117.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610733117.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v4 10/15] kasan: fix memory corruption in kasan_bitops_tags test
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

