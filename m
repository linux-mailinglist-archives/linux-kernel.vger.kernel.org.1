Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF87D2F6B35
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbhANTiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbhANTiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:38:03 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC143C06179A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:37:07 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id v1so5467903qvb.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mpVlk1+Mq66Mf4g3XdhCLFVXRKuPdNXXWU/IOGoVVBY=;
        b=l3zgn02fnCG02/GorQOuHum5hC7LgdsREdZg3KtQjsCdJpLVHBSEXZpZE+iWL9Unw7
         F9Uroqs0bYp4/RbfxoOOkgqbmSXgTtrgphGuEFTA93qSMKgiloOwLBZQs3QpTF7Nmp2g
         sKCerQ7G12PWMi2HkcrkCiLDhaneDzSGSgHrDLAJ1TscgLv5lLHgrVzXCufFbPcT2nZE
         voBucxeaWnqMUdm8c2zPGQYLK8EfM+ixWGByvozQNXQuiByq2LFuypPugMvpqP7atzdr
         jpZvfhU856Qc1ZjCfbnDdn2FbCx5WJ/G05kPvVtwq3GO1lpCNinWTgcm4Ms026UlnJgQ
         tCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mpVlk1+Mq66Mf4g3XdhCLFVXRKuPdNXXWU/IOGoVVBY=;
        b=eLjxARDpWXLPiv3THK+gJ5mi+owy9h2qmPlN0GVApfzYEefTP/1h7+97jScLA6q/xC
         qhQ23tN3tj4uYJO6G/OjQ40VCMM7P+yDtHMJfYNWFB01GVGMOoSxCGyEMUsLyUOgH8rg
         A7nqEBAwwNYXs/+VtbkW6VGf9tAFD/YMX86KzzXjwNs46cMx3n0GN/ySe1liXdcMq/5v
         r2tt3ftlUmjNQbOZlOfzA14lBY99cudCl0IgE/tnPaNUDmk7LsFJaKBBPe0yfnlEvOsA
         Tf4l9gRPuxGvKD85Bx4ZYKQQfX6xNnyYKsNdqOIgMIKc2V2loc70oSjzwZ6xqiu3nvdM
         NM9A==
X-Gm-Message-State: AOAM531sNIbSYTIk2/iFWKv84Mw9bqgcGJv74M6LQHUr5S0a0JnehTnL
        A6mkgDHl++jsDqsU0PKBEV31XxaNJLFtJPRm
X-Google-Smtp-Source: ABdhPJyGquTeLUlZdqo6VBCEwifJl8lXrre/ob8oN7AAyol/9rBOwLOtlLOHPIxvikPOYLtv2pJ5MGos33xGzZJe
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:b2f:: with SMTP id
 w15mr8831064qvj.8.1610653026992; Thu, 14 Jan 2021 11:37:06 -0800 (PST)
Date:   Thu, 14 Jan 2021 20:36:30 +0100
In-Reply-To: <cover.1610652890.git.andreyknvl@google.com>
Message-Id: <b75320408b90f18e369a464c446b6969c2afb06c.1610652890.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610652890.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v3 14/15] kasan: add a test for kmem_cache_alloc/free_bulk
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
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index ab22a653762e..a96376aa7293 100644
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
+	cache = kmem_cache_create("test_cache",	size, 0, 0, NULL);
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

