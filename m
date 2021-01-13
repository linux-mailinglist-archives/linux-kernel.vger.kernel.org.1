Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9A52F4FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbhAMQX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbhAMQXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:23:17 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0573FC0617AB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:22:20 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id f18so1029433wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=F9RPqmmRw2Yulu4z1uWbEkv56znu+VxUo16IevqT5w0=;
        b=WhXPKI7ka1PLsjpj9a1T3weEwxQ9LvJWks0+YFb00OhSvQC/EH0LdHWIwXnhlAzsAC
         LiGbUHWbpgahZqXRXhrQVQuPUYfHZc9HKOs3NRhPQNt8GTc2UZqQ5c6uFISJqXUvEJqy
         ewAG16gjFqiAHwmLniCt16/Fkc4q1Whks66SxS3XPsBq3eUwEo48WFXK0ER50OKScjAe
         GAXL74wFdc8bC/Efq5Zvm/yvWLMZA80M0TWPT7adRxArIoTdLYAMvgI06/vzVoL1xDGS
         dYrwxb4FDvNk9jTHQDpWcL4z/s32aZv30dBKMM3f/pXjvn17HpyRCv9nphNKV3AqzPs1
         WXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F9RPqmmRw2Yulu4z1uWbEkv56znu+VxUo16IevqT5w0=;
        b=spbXlyd7mKs3lVWETWUDRULRXT8Hdje4TkU4vWNoaMqs94ktVKeC3Ivt9U5Sb2JZ60
         Y+elMOsIExasicn4W5UQ7qvGgCvcg/wg+T1+wY+J75ktmZH2U2qAJI45fNW47LjA3EIB
         hpWLS62tCGIsZdXCAWJaWAbiFl3q5sbDHkFAR+uF4sXEtdj2iAfy9UzyBQ93F1bf9156
         gdscGTqfSvTwmiaJFph6BN1nhotcE9x0ObLGw1/s2GfEcIlbTkySgGKCqQr6FxZIPKcb
         4PsdA29Iwy0oZdGicRHH1bjrDbLUfKkLWbDpy4vw7Dj2ygGe1YXQ8eyDvhprTvvzSKER
         KVdg==
X-Gm-Message-State: AOAM530EYQQ2KTg1GstlODwd8/V91Taj6WYiPCfkRLTY0dprKsSKdT+4
        QSv/CnpHH0H/pX4q5rpd3y10zh5xDGXQmdH2
X-Google-Smtp-Source: ABdhPJwUx1QOs+UqfzWHVhJ4l6FtbhFlt9a/4UJ2shESq0YyK1lhktj3AH0Y5/JRqWIf9rrtsCQ5ejOwFlyvUDY5
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:c308:: with SMTP id
 t8mr85582wmf.22.1610554938684; Wed, 13 Jan 2021 08:22:18 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:21:40 +0100
In-Reply-To: <cover.1610554432.git.andreyknvl@google.com>
Message-Id: <0e994d67a05cbf23b3c6186a862b5d22cad2ca7b.1610554432.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 13/14] kasan: add a test for kmem_cache_alloc/free_bulk
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

Add a test for kmem_cache_alloc/free_bulk to make sure there are now
false-positives when these functions are used.

Link: https://linux-review.googlesource.com/id/I2a8bf797aecf81baeac61380c567308f319e263d
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 5e3d054e5b8c..d9f9a93922d5 100644
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
+	cache = kmem_cache_create("test_cache",	size, 0, 0, NULL);
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
@@ -522,6 +524,32 @@ static void memcg_accounted_kmem_cache(struct kunit *test)
 	kmem_cache_destroy(cache);
 }
 
+static void kmem_cache_bulk(struct kunit *test)
+{
+	struct kmem_cache *cache;
+	size_t size = 200;
+	size_t p_size = 10;
+	char *p[10];
+	bool ret;
+	int i;
+
+	cache = kmem_cache_create("test_cache",	size, 0, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
+
+	ret = kmem_cache_alloc_bulk(cache, GFP_KERNEL, p_size, (void **)&p);
+	if (!ret) {
+		kunit_err(test, "Allocation failed: %s\n", __func__);
+		kmem_cache_destroy(cache);
+		return;
+	}
+
+	for (i = 0; i < p_size; i++)
+		p[i][0] = p[i][size - 1] = 42;
+
+	kmem_cache_free_bulk(cache, p_size, (void **)&p);
+	kmem_cache_destroy(cache);
+}
+
 static char global_array[10];
 
 static void kasan_global_oob(struct kunit *test)
@@ -961,7 +989,8 @@ static struct kunit_case kasan_kunit_test_cases[] = {
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

