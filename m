Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5CD2EB29A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbhAES3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbhAES33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:29:29 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6CDC0617A2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:28:24 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id k126so522933qkf.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KRXpzoAkHqv6MlP+Q/fGJx09RWdmlAlIVzxtUVuwpVM=;
        b=Fb3Q6nCT57b+4oec7OslcxN7gAFtRYQJmn5KExlMD4IEMm/aMW+oydy50jC6i5Fi3I
         ozZK5SylYmuAGCpYHep2PY3CQIMgXQyCS1mNWz9BwzWk0h+zMnMBr8jfu/p58hR8voeQ
         Ox5qAB7CTTFDHlWYDh0sSWQjQlZcEUcI8dH0dQ/CMbIk6Vy32+JURCXcIr2jckjFJh+T
         DhGfUfCVDtASvkaZsJVSE+CJExCAjNej+oEOmZTzKwkYai4t5e6Cpz7OZK0EKqG241b/
         V8DEmXfKegA/XsMJ6HE3j+YTV7XG3Zj0DNmo9rA3kz8kLKwyCoe1BGAFntOuNaAR6HVq
         wl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KRXpzoAkHqv6MlP+Q/fGJx09RWdmlAlIVzxtUVuwpVM=;
        b=KTO95/Ce8a090si73JwdGIvSJVTDW9rSET0Z2wxHuEjK0IAkk4Mi5GY1+1kXZvUxXH
         VTCOZluDwN/yjDIH1dHlN5DuOoNU9YP+z4yfdNQttY4T4dXdi6+vF1JG7u8v7zNbUR8h
         alxjn5HKEXmYAq5QCdfku9jLgv5W0u6mRz3aRso4H0D9ViT0tnvkW0LYqT21EfBkauAp
         RnbNXO5Fj+Iax5SCQVQezKExWhzwa3JTyGz4GjsEZBBZ34tCjy5EoBSt2/sUFYY5MbZw
         7P+atJFuID4BtfRLE4wI4lX+rh9xPhKOItp1j+WYmRSyqEDCCZ/zIjsDoz3M8qGBcix2
         K8RQ==
X-Gm-Message-State: AOAM530GNrTfkevtYfeuzfUCoTj3+6Wgy7TEooDgukWU4/rCl+XZtzBj
        m6UaKzBuqVm2PZ3QgO1JNQVNgCFWOi9DlIJO
X-Google-Smtp-Source: ABdhPJxT90gB7YILrKMHoRfd8xi56D/8zCgNctAzqvpw1JEB+6Jc2/mpZafdl3bgFb9he5+PwmsqWLivJbSsh8PS
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:b38b:: with SMTP id
 t11mr470993qve.58.1609871303254; Tue, 05 Jan 2021 10:28:23 -0800 (PST)
Date:   Tue,  5 Jan 2021 19:27:52 +0100
In-Reply-To: <cover.1609871239.git.andreyknvl@google.com>
Message-Id: <9a4f47fe8717b4b249591b307cdd1f26c46dcb82.1609871239.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH 08/11] kasan: adopt kmalloc_uaf2 test to HW_TAGS mode
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

In the kmalloc_uaf2() test, the pointers to the two allocated memory
blocks might be the same, and the test will fail. With the software
tag-based mode, the probability of the that happening is 1/254, so it's
hard to observe the failure. For the hardware tag-based mode though,
the probablity is 1/14, which is quite noticable.

Allow up to 4 attempts at generating different tags for the tag-based
modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/Ibfa458ef2804ff465d8eb07434a300bf36388d55
---
 lib/test_kasan.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index b5077a47b95a..b67da7f6e17f 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -375,7 +375,9 @@ static void kmalloc_uaf2(struct kunit *test)
 {
 	char *ptr1, *ptr2;
 	size_t size = 43;
+	int counter = 0;
 
+again:
 	ptr1 = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
 
@@ -384,6 +386,13 @@ static void kmalloc_uaf2(struct kunit *test)
 	ptr2 = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
 
+	/*
+	 * For tag-based KASAN ptr1 and ptr2 tags might happen to be the same.
+	 * Allow up to 4 attempts at generating different tags.
+	 */
+	if (!IS_ENABLED(CONFIG_KASAN_GENERIC) && ptr1 == ptr2 && counter++ < 4)
+		goto again;
+
 	KUNIT_EXPECT_KASAN_FAIL(test, ptr1[40] = 'x');
 	KUNIT_EXPECT_PTR_NE(test, ptr1, ptr2);
 
-- 
2.29.2.729.g45daf8777d-goog

