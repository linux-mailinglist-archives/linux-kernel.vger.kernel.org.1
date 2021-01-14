Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2635A2F6B31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbhANTh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbhANTh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:37:59 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA5DC061794
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:36:56 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id v7so3032774wra.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=BYOOBCCudRU7Lchp5NpxZrw19s2hqbj4Q5eYKa3nns4=;
        b=rTUv5m0zNhD34FCcwlpq09FOQVY979bNJORsUf6OmzgaoTAOFMWsj6uKVvVPryAncc
         Y6OhafJM04uWVc9pjJQKH5NCt3DkQiMm85OpEihWPA8JcD25gC3aeR9kvA9Y7WWCW9ie
         EmLUYPTYMJpoVS5omyVpvjA8KTO6StvqomYrsX+za0mQvc8oQwUxEjeGb11XkDrHA5Ee
         Szowzviwu7DMZ/YWR074GrBN8wKOLaOqezsuVaixBa1pbB8unyc+XyrVbX7S7Hr4U0Jt
         MYp20quJAyjR5U7eAr6/jrLyH1zjC5WXJT5NxhYC5GL61NwjGH+LqPS61lk6rSQ+HQeG
         bkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BYOOBCCudRU7Lchp5NpxZrw19s2hqbj4Q5eYKa3nns4=;
        b=XDUE0VsxZ8WQ1SH81jePBhMEGQ2ColeB53fy1kCq/8wq3dV7G93SuAGE/mqQr9oa/i
         j9FCI5pwvzFofsmV0jrCbzEg8foU07dzsUz5T7yzdIOYmmWs2h/xubwb5ObvP9OSRU5g
         V9hBykg6pix5+11TFsx93Q1ZielYSh3W2Jtm4+aX7EqHH5zUEM5noJcZk5C3qPqxmesB
         WWafMA0a7DDKsInTfM2W31YVgY0xBWJ8mEOa83Vcc0GVLblN51Q9VjhGYQHv3mFDyt21
         rDzkErjTl4YqwKYAbiBuoirK5JO7zhfAwqGT2wRfBBmUlteJS7xonnpIU0DZ2o4ofaVb
         TPKQ==
X-Gm-Message-State: AOAM530e+NC3UhyX7MMIx9mOu1ooSwS4VomJQvwW5luemdhU7n3DxCtc
        C72DLaVEurhbIWLBGjpd3d02NFaMEQ9CAFZp
X-Google-Smtp-Source: ABdhPJyYO2MlxfR/Y4/edLSR5eTxNluzpB8ZY4biV8IiJKVDxm5JrKLOUsXrzNZQUnUIvM0PtVPM014fSmcVbUqw
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:2905:: with SMTP id
 i5mr5291713wmd.28.1610653015397; Thu, 14 Jan 2021 11:36:55 -0800 (PST)
Date:   Thu, 14 Jan 2021 20:36:25 +0100
In-Reply-To: <cover.1610652890.git.andreyknvl@google.com>
Message-Id: <62a4d6dba701ad4747d836fb08c20fdfffc701f8.1610652890.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610652890.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v3 09/15] kasan: adapt kmalloc_uaf2 test to HW_TAGS mode
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

