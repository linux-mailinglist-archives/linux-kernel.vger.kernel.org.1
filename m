Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CC12F4FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbhAMQXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbhAMQXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:23:12 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F69C0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:22:08 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id u9so1720779qkk.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AYU8RiBMDoH8LqbcE5Bsl4HVhMUvTlIJH5ygAkCw1uo=;
        b=sK8w4/7+bFlRogPbbwsMzQZGIyJaLfruaGQq1NyTZoKuRV8kkSuJYSTajYObeb5BhB
         j5B0aO7AYdjA/X7h/55sqn/8eJ3L98sNWt0usa6ZKYeOu2Bu8A8yH7kyedWNIqOTdyrK
         7CS2smIDxfMMUEU7+r5sUDMO6AU5v0dCsYRHfTm3snA0bdsu5Ihim6C+QorZWPCWRicw
         Qj0JSwE5rlQKQmMPulAWV7Qb3+JbCq4sEEKb5k2sIlwQpL768ladXTwg9PV88ssTPbGC
         ghBTXXxjBAM5WcVjFFrHK6/Ml9RcY1l1gksA/BDruf31RYSvG4PiPSYoNNlzTZKxcYQA
         r4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AYU8RiBMDoH8LqbcE5Bsl4HVhMUvTlIJH5ygAkCw1uo=;
        b=q75sucSlySryZYeAkaFIeWgFz922YRBHvwEV5AHu8D3wRKPv/dJ25by3wiL4mNEq1A
         Z7u1RJTGbCxNHWZUIiYNgOF73OKEjU3K/m+EjczloINjcvjElieiRFDqTB+8lHfn9/rE
         9b7mfEVRhu1qxTwO3Tvj3sjBrJ9UBYPPVzs0vG0zMzjcDg6uVi3D9c9NnTreCojXc25x
         GLowqAloy6n+elgFEtSN15NckATuozTymx4B7SYH86UVmExwXxzG35q/pziDecJYrY3E
         zUEMOdFy44M77DgdqNbuVqdX+gqWonY042aOIrkb4QKWhVFijZ09JIAwQbVuu7jUdYY7
         BE4Q==
X-Gm-Message-State: AOAM533NSiDMmjkKApZihncfJi+XQjFjoAeiExirxzsx2gJGEEWCqytR
        61ybu5BbaYpfqXAlBX8AwoUOLGDa9UmSzNw7
X-Google-Smtp-Source: ABdhPJzAk8lbAA2oeZ/5LkBz1EFW7U5GssDQ0xOiO1RZBV9k+c3FKD7ufLGB+DknkADCLYH+T0s3FGzAptjFgwj6
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:fe91:: with SMTP id
 d17mr3133660qvs.50.1610554927401; Wed, 13 Jan 2021 08:22:07 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:21:36 +0100
In-Reply-To: <cover.1610554432.git.andreyknvl@google.com>
Message-Id: <1b884616c85091d6d173f7c1a8647d25424f1e7e.1610554432.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 09/14] kasan: adapt kmalloc_uaf2 test to HW_TAGS mode
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

In the kmalloc_uaf2() test, the pointers to the two allocated memory
blocks might happen to be the same, and the test will fail. With the
software tag-based mode, the probability of the that is 1/254, so it's
hard to observe the failure. For the hardware tag-based mode though,
the probablity is 1/14, which is quite noticable.

Allow up to 16 attempts at generating different tags for the tag-based
modes.

Link: https://linux-review.googlesource.com/id/Ibfa458ef2804ff465d8eb07434a300bf36388d55
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 283feda9882a..a1a35d75ee1e 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -382,7 +382,9 @@ static void kmalloc_uaf2(struct kunit *test)
 {
 	char *ptr1, *ptr2;
 	size_t size = 43;
+	int counter = 0;
 
+again:
 	ptr1 = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
 
@@ -391,6 +393,15 @@ static void kmalloc_uaf2(struct kunit *test)
 	ptr2 = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
 
+	/*
+	 * For tag-based KASAN ptr1 and ptr2 tags might happen to be the same.
+	 * Allow up to 16 attempts at generating different tags.
+	 */
+	if (!IS_ENABLED(CONFIG_KASAN_GENERIC) && ptr1 == ptr2 && counter++ < 16) {
+		kfree(ptr2);
+		goto again;
+	}
+
 	KUNIT_EXPECT_KASAN_FAIL(test, ptr1[40] = 'x');
 	KUNIT_EXPECT_PTR_NE(test, ptr1, ptr2);
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

