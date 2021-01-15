Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B97E2F831A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387636AbhAORyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733059AbhAORyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:54:23 -0500
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA4AC06179A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:53:21 -0800 (PST)
Received: by mail-lj1-x24a.google.com with SMTP id z8so3379512lji.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ncx/ADq8yORoljqCdVSCBm5uc5T6Epz7JI4WnQIQm9Y=;
        b=JyTBPemy3BOiuiPnGHThX969keSgEJXqagqLcGeIwrltiAduseqR9VsulSa+UB561H
         p9ca1sq4Tqxv6yqpKs/Hzbdl7HMOvCk9HD750NHtTPXCT38/tJ6mIPowusxMc4DrtZ74
         rvIa2RankgFhhQ2w0Ax4fJdf1SeCsWdYOYa+z8ZxOGppkDMvFKqaq8dLDsMPu4iu38m3
         HgS+q4AdwDawo9HtCCeE3OWWunv7dNe9QF4nZjILkmQ8tIIj2A8aq7zup/5kuZjNBsNH
         /RshVRfNEtOEPJ0GVqNhWT2HTHv5hhEF1YwOk3UtqlD2k98xBtxF64puSAW+GAopsKjP
         JQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ncx/ADq8yORoljqCdVSCBm5uc5T6Epz7JI4WnQIQm9Y=;
        b=C7+2vhleafN0bKfS+JspXfppdPTT9CdjcQXvyHwohd7KPFGsmvCgYg1SWxF99fGekb
         Zg/2MOC4/EWUfOqvn3cZpSd0xchUBPZA9SVAJ3nBeVhohjQNS0WdUv355YItMvE1aoMI
         QD9JcafLuVjwqFIXEmmyuqWfaSalNO6+O+8l1wL8bqdWrUVqcJJvWx459M17qXq4LJB5
         64QZDWH+JnDZ0Titqpn93jDnPOKhHaifXLLPJrFBbmqnQwD1Ryq3bUoJjTDSLwIFeiMy
         1vddkeiUFv344Ser0BkE+22SoaBD9xrS7tft7dTKyKZxh+uv+CFIuYLGYdsUEalEZyXo
         eYNQ==
X-Gm-Message-State: AOAM530F9KMvvB+VluHzjSjJlcR784vsf/NDpZObcKd0Xg3ZATHhtrzK
        a+POsEYQkun5DmFvoy5ijJcL+MIrO7z9RexP
X-Google-Smtp-Source: ABdhPJxkcEq3dTkx3/QICT5fD5ln+9/s4jmGD3uu27CAmlbv7p6OvUWn27f9nqaT6qfXvVOQ8P5WJRnaqf1ZJ63q
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a19:40d7:: with SMTP id
 n206mr5901814lfa.27.1610733198842; Fri, 15 Jan 2021 09:53:18 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:52:45 +0100
In-Reply-To: <cover.1610733117.git.andreyknvl@google.com>
Message-Id: <6f11596f367d8ae8f71d800351e9a5d91eda19f6.1610733117.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610733117.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v4 08/15] kasan: add compiler barriers to KUNIT_EXPECT_KASAN_FAIL
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

It might not be obvious to the compiler that the expression must be
executed between writing and reading to fail_data. In this case, the
compiler might reorder or optimize away some of the accesses, and
the tests will fail.

Add compiler barriers around the expression in KUNIT_EXPECT_KASAN_FAIL
and use READ/WRITE_ONCE() for accessing fail_data fields.

Link: https://linux-review.googlesource.com/id/I046079f48641a1d36fe627fc8827a9249102fd50
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c  | 17 ++++++++++++-----
 mm/kasan/report.c |  2 +-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index ef663bcf83e5..2419e36e117b 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -68,23 +68,30 @@ static void kasan_test_exit(struct kunit *test)
  * normally auto-disabled. When this happens, this test handler reenables
  * tag checking. As tag checking can be only disabled or enabled per CPU, this
  * handler disables migration (preemption).
+ *
+ * Since the compiler doesn't see that the expression can change the fail_data
+ * fields, it can reorder or optimize away the accesses to those fields.
+ * Use READ/WRITE_ONCE() for the accesses and compiler barriers around the
+ * expression to prevent that.
  */
 #define KUNIT_EXPECT_KASAN_FAIL(test, expression) do {		\
 	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS))			\
 		migrate_disable();				\
-	fail_data.report_expected = true;			\
-	fail_data.report_found = false;				\
+	WRITE_ONCE(fail_data.report_expected, true);		\
+	WRITE_ONCE(fail_data.report_found, false);		\
 	kunit_add_named_resource(test,				\
 				NULL,				\
 				NULL,				\
 				&resource,			\
 				"kasan_data", &fail_data);	\
+	barrier();						\
 	expression;						\
+	barrier();						\
 	KUNIT_EXPECT_EQ(test,					\
-			fail_data.report_expected,		\
-			fail_data.report_found);		\
+			READ_ONCE(fail_data.report_expected),	\
+			READ_ONCE(fail_data.report_found));	\
 	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {			\
-		if (fail_data.report_found)			\
+		if (READ_ONCE(fail_data.report_found))		\
 			hw_enable_tagging();			\
 		migrate_enable();				\
 	}							\
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index e93d7973792e..234f35a84f19 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -331,7 +331,7 @@ static void kasan_update_kunit_status(struct kunit *cur_test)
 	}
 
 	kasan_data = (struct kunit_kasan_expectation *)resource->data;
-	kasan_data->report_found = true;
+	WRITE_ONCE(kasan_data->report_found, true);
 	kunit_put_resource(resource);
 }
 #endif /* IS_ENABLED(CONFIG_KUNIT) */
-- 
2.30.0.284.gd98b1dd5eaa7-goog

