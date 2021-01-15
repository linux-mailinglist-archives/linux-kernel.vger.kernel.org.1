Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762622F8318
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbhAORyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbhAORyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:54:36 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F53C0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:53:35 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id q18so4470667wrc.20
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KKvTna9pOG94VdqPVmZRxWtkege1Cyuqg2hRO1ClK+0=;
        b=ed3FebypFmJx/L1iuiWNaLMG07hyk3w2HThAWfe4DA6P0l6iiWWdLglY+RugS8O3x2
         8wi5BH/PlnIMZ7Za8gNVHK59XI0kibCPJPsviTht+qATHJv+zUQaQAOo4AMD6J+aPFtx
         yT/cXmmvlg3q4J4t4N8foKtC82zZnW55Z9nKA0gh4TuEjuwv1C+94wUT5NhDamdRO0kJ
         yxabOTkDgEjUXjdBoGIDsRBVJNzXwSDA5vTrytu6Lb7+7VfDbXJeAQIgn8QFGWywwIzt
         tqV9KJl4xrtHmGlFext79AI3i47CDDdRBBENU5OfB7CZGAc363k/tr6ZNqAgeQ3MMZ3F
         qDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KKvTna9pOG94VdqPVmZRxWtkege1Cyuqg2hRO1ClK+0=;
        b=U3RDD6hBpPKJIo1ayP3BJ0qh2k0xSLWcZOhtC1Iu1x03CPvpYY1d1XkdG+OwLdkaL2
         CGhX63pbWCVKXWsw5oFPvj5jowWjIBJX8gyAJNFumIVwS5U0eG+To0nbIi0Y5Fvz3jQ3
         54yQgdyNqfzFDv8Z/OrsBVncLBWRgXO3LJtPk3Mi2zI1RzJtSPodtj/1ZuM0CR45G25j
         qNBDdN9W6ajkA0OVnCTqC1DJAHMtUn2EHWSM2Jf0Y5mGz/hHk4sSAm2nVbI+iQO2QB0r
         Q9Ewa6VQVNqot0PvdUiWWOCi/N5qsIN2LgkCxdi1BzxviUgV5QrzK/71ZcqdNABXXB3z
         yV6g==
X-Gm-Message-State: AOAM530uDM/+GpwTxUO4OpzP1OuZfMKPqZem9enps8mcIPUPJ95CLWx6
        4G3JfCO/POYP/cqzmJ00D3ACmNCJbFgVgvS+
X-Google-Smtp-Source: ABdhPJyVftmTjOwG8sQ/qHZqkBUIVpPntUaupbXGD/60w3ULfDb6BFCbT5DhRAHKYT1DG0qLEs4DoB2QgTHuIzaj
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6000:11c1:: with SMTP id
 i1mr14588719wrx.16.1610733213887; Fri, 15 Jan 2021 09:53:33 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:52:51 +0100
In-Reply-To: <cover.1610733117.git.andreyknvl@google.com>
Message-Id: <418122ebe4600771ac81e9ca6eab6740cf8dcfa1.1610733117.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610733117.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v4 14/15] kasan: add a test for kmem_cache_alloc/free_bulk
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

Add a test for kmem_cache_alloc/free_bulk to make sure there are no
false-positives when these functions are used.

Link: https://linux-review.googlesource.com/id/I2a8bf797aecf81baeac61380c567308f319e263d
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index ab22a653762e..4ba7461210fd 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -479,10 +479,11 @@ static void kmem_cache_oob(struct kunit *test)
 {
 	char *p;
 	size_t size = 200;
-	struct kmem_cache *cache = kmem_cache_create("test_cache",
-						size, 0,
-						0, NULL);
+	struct kmem_cache *cache;
+
+	cache = kmem_cache_create("test_cache", size, 0, 0, NULL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
+
 	p = kmem_cache_alloc(cache, GFP_KERNEL);
 	if (!p) {
 		kunit_err(test, "Allocation failed: %s\n", __func__);
@@ -491,11 +492,12 @@ static void kmem_cache_oob(struct kunit *test)
 	}
 
 	KUNIT_EXPECT_KASAN_FAIL(test, *p = p[size + OOB_TAG_OFF]);
+
 	kmem_cache_free(cache, p);
 	kmem_cache_destroy(cache);
 }
 
-static void memcg_accounted_kmem_cache(struct kunit *test)
+static void kmem_cache_accounted(struct kunit *test)
 {
 	int i;
 	char *p;
@@ -522,6 +524,31 @@ static void memcg_accounted_kmem_cache(struct kunit *test)
 	kmem_cache_destroy(cache);
 }
 
+static void kmem_cache_bulk(struct kunit *test)
+{
+	struct kmem_cache *cache;
+	size_t size = 200;
+	char *p[10];
+	bool ret;
+	int i;
+
+	cache = kmem_cache_create("test_cache", size, 0, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
+
+	ret = kmem_cache_alloc_bulk(cache, GFP_KERNEL, ARRAY_SIZE(p), (void **)&p);
+	if (!ret) {
+		kunit_err(test, "Allocation failed: %s\n", __func__);
+		kmem_cache_destroy(cache);
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(p); i++)
+		p[i][0] = p[i][size - 1] = 42;
+
+	kmem_cache_free_bulk(cache, ARRAY_SIZE(p), (void **)&p);
+	kmem_cache_destroy(cache);
+}
+
 static char global_array[10];
 
 static void kasan_global_oob(struct kunit *test)
@@ -961,7 +988,8 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kfree_via_page),
 	KUNIT_CASE(kfree_via_phys),
 	KUNIT_CASE(kmem_cache_oob),
-	KUNIT_CASE(memcg_accounted_kmem_cache),
+	KUNIT_CASE(kmem_cache_accounted),
+	KUNIT_CASE(kmem_cache_bulk),
 	KUNIT_CASE(kasan_global_oob),
 	KUNIT_CASE(kasan_stack_oob),
 	KUNIT_CASE(kasan_alloca_oob_left),
-- 
2.30.0.284.gd98b1dd5eaa7-goog

