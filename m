Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBAB2F4FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbhAMQXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727759AbhAMQXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:23:12 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4675C0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:22:11 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id r11so1174516wrs.23
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=L1Lauf2F6M7nowmjOy2kFR6Fh9wMsHUDYRnyLelpHLk=;
        b=YLqNMyj7CQklsJS87J6H8yeUQkZgOfU7G3lS/Mpds9lAgxLAaIIilaTdab465iE4pV
         r4K5VWiNZ6YehcB6XsRpj+i/5JzIesafSzAu/f7aS6i2pFhb0vHtPV2Qvj5aPFEZl0SB
         KtQAWfnJUt++5AVjgai6aKkkafwuPu7tpacheJvcvpdcfsKrgAarJyxxXOaUFBpVniKL
         pjEJ2AXkZrecOmZs0mVXnGG9ux9jN0M6HmUiY5VOs71uv2Sh3hiNtIXBTomvwUbsRth/
         6Muo7xLqiJfcoGSSHtdnRUivaKaHGpeyJ2nVAP1bS+4VqSMpEH8WUxL656p9rwUeG8QZ
         jKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L1Lauf2F6M7nowmjOy2kFR6Fh9wMsHUDYRnyLelpHLk=;
        b=HwxS55SdVJVgKSsAcO0So+qa2PIUGaZH0a58p0QZLu1YnplOOIrEjC91xKjvFjKfjZ
         dCg7YbGdXvxA/fRWX6ckt9fA8uBqQ4z9ZuAEoDz4S4otwmsd+yRVkOLAkD2TcLoIgTGw
         5D9eQaJQ9b2PFP4z+2qZG3zAKL+0FKqW7UqBkZvmnhEpgz8r9vQS5zqYlDOOA5BON7n2
         s3XUjPOrRoc3MCvCRaGc4JLWhjlfWbQ/km+syuEc5ROqKT+cSojcBbH8CivtqUc8ofPX
         Jlg402e2qU0B+BZuokm/25MMbbAbRna2xEi9lq627li/RLHR5Lu8kiBZpU7Px/k6WGI/
         nuhg==
X-Gm-Message-State: AOAM531Ywb1PnwyKZmtNsH1E1wpuaJlCK1YpjHwh1lB0gMmgaXFLmYiZ
        xqEUi+1YvK4wscEiJWtvUydiq6FgrDJUXDGW
X-Google-Smtp-Source: ABdhPJwuVUXUbA1bjgSkMWKa0K4gmDv1FuNW+RgWp1wk2T7Y5zN8m0zyfj5oYjho00jOolHgCjqK85kdGQ5YbXgt
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c044:: with SMTP id
 u4mr20900wmc.1.1610554929901; Wed, 13 Jan 2021 08:22:09 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:21:37 +0100
In-Reply-To: <cover.1610554432.git.andreyknvl@google.com>
Message-Id: <0dfffb5c0b13f1a150223863490638e8f462f635.1610554432.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 10/14] kasan: fix memory corruption in kasan_bitops_tags test
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
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
index a1a35d75ee1e..63252d1fd58c 100644
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

