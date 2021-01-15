Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DAC2F8319
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbhAORys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733061AbhAORyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:54:23 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C560AC06179B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:53:22 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id d26so1489605qto.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=BYOOBCCudRU7Lchp5NpxZrw19s2hqbj4Q5eYKa3nns4=;
        b=oOLTb6iXGw4hR7fdl1kwHC5xGAza1F2tagz3FB0QzJWJZ+QDQztqyFMI5YtXoJnkKe
         Y8bnNIHQQI6h6YZB8c5JWJITMJwTcCVPccnXBUAH6v53fuzil8/YZQvPlWRIfbIJkX3k
         QhAZskFpCa+ydA7ejU09Rldhgnq+lomoiasoPI+wLLennUluX7zlgEMOvZlu3aSu/uya
         REciLVBKZ8HB9mefgBiy1+ygnJg5QEKOGO6TqXqwlYLg9xnZFQb6ydAdwrbnQTcVow6C
         lv0wjw4582nq09tW4GEKePRBzsLb1hpFJGbAuym5d3D1p8/Qq+uq1wl9ctzgSvCa1YwV
         Mf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BYOOBCCudRU7Lchp5NpxZrw19s2hqbj4Q5eYKa3nns4=;
        b=f3PJD5u93Q6zKwnTWH8d5beMkWCl60SUpF77dqdAXDTcreeyxXDXm+xIsyjVwOswvM
         XdAzhyTNuvBMzDTJgLwroi73LAIwH4ORzt3M/RNQt/oTC+uTn3Hnd5Ygil9UxVWeBMDX
         uAK2AfYoQyWCCCZqaP0HXZsx26+dHviDoxz3DkP1ZWUtxhRAOP93sb1veYMNggAqOvSB
         pLDNBhCAj9TZs7DvAxyPAYpbHSb/Rkvj0f3uhAEMOLipzReZIr3I+Y0G7XuWUPwh/S+L
         6WNh47/a46ZViLLPKnSbHmrJOF5FlxNJXhgIYOplKAACzOhMl+qnhCilDSpT900qzHPU
         L3Fw==
X-Gm-Message-State: AOAM5326OYmvoWIZ838aUbfTmRaBI6no+lNP4no3QX3tGVJH3kYkNf3t
        BTiN76zCcj4GBmkFwE41YzkuxzaN5cUknnH4
X-Google-Smtp-Source: ABdhPJzKh8C6qw7cdRynOQL3HqGoll2W7wn9Iq+M7R+ck7opki/cSqyWyZcMuFOd2GLp4ocvgj4w963nEuh9ZJCs
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:5188:: with SMTP id
 b8mr13230051qvp.55.1610733201718; Fri, 15 Jan 2021 09:53:21 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:52:46 +0100
In-Reply-To: <cover.1610733117.git.andreyknvl@google.com>
Message-Id: <9cd5cf2f633dcbf55cab801cd26845d2b075cec7.1610733117.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610733117.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v4 09/15] kasan: adapt kmalloc_uaf2 test to HW_TAGS mode
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

In the kmalloc_uaf2() test, the pointers to the two allocated memory
blocks might happen to be the same, and the test will fail. With the
software tag-based mode, the probability of the that is 1/254, so it's
hard to observe the failure. For the hardware tag-based mode though,
the probablity is 1/14, which is quite noticable.

Allow up to 16 attempts at generating different tags for the tag-based
modes.

Link: https://linux-review.googlesource.com/id/Ibfa458ef2804ff465d8eb07434a300bf36388d55
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 2419e36e117b..0cda4a1ff394 100644
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

