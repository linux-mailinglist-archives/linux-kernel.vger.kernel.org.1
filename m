Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406FF2F6B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbhANTh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbhANThz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:37:55 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AAFC061793
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:36:53 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id k12so5305634qth.23
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IeCg6Q6ax6zf9VJ+vRzVtCBhXruC0quH/SAPFfzsvs4=;
        b=eTZNHRFwfoCF3Fl7H/HMfcHuwyTyfhV52ed+NJ58jBt3yxDyJcqD2BMacpWkq7y2RZ
         JeMFiKc4vkrxluqmQgLoLhGnVgH3jbfS/EhKMYIHxbRS8cwqVyRwoB4MlN56VxGqSjkn
         N5XaSiResQQqO6HC6l1fUhmVps7XNA6phTQeeMo2VWh3I9Kjb5T3oNEaK2hAV6UsBwoB
         rre26sZU5XJxzHLWKInioZ9+zByEt+QVei87qGtDX7XfdwMBxay5paiLav7OJnHNR/Qx
         YLPTjaN23CuZ90WIjmOX+wro+H5XZuSkLOpwxxmJaTcrJlOXiXWf25ozjg7ke+q0RhHP
         AhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IeCg6Q6ax6zf9VJ+vRzVtCBhXruC0quH/SAPFfzsvs4=;
        b=iwwe7myZHlszvus5EeR6ipiW74uuqPz9d77ShoV9S3xjeP8vp4Sey1UZgyKHKrJSgR
         zKadMJ9UaZWFvLnYn6EzPf9ZQnAzQQPExEQ1lQgzDuIsLQ+mbhe5T2WoH4mBjcafk5cE
         yOpunDfZBx1K5ovfOjkK7lhykDEhA3XFGeiVodVqmAxsrIvhChqaeNmImeNEqD2hTGH7
         G1G+gGPn+hlJK7VBsJlqKTSImk7OsMU8cAwYY3nOBVVEMELZ6uEy77lk9B/JOSMXBv56
         XaXZkd6N/B7X+lj7OtR0L8REHiiIHtwen0cMt535AqZDh4ALxcn/U2jeGO+Wy7TtjO+/
         aS2g==
X-Gm-Message-State: AOAM5305EjVm9ONJQAoIRyoCS3HFvmRaXvqKGjdxLSyl9lZUO1A1dQ+h
        m//8hM591+WPfLCyBRHt1Ng9Ss4wNjVFeTOW
X-Google-Smtp-Source: ABdhPJxfE6NK6yqr9G1+T+44ye3s9ZpD3mdA+ec+MYX3OXmVMzoUVOm3cRqC6z06PsWVassdHCODx3/XP0e2Q/xE
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:f08b:: with SMTP id
 g11mr8742547qvk.7.1610653012977; Thu, 14 Jan 2021 11:36:52 -0800 (PST)
Date:   Thu, 14 Jan 2021 20:36:24 +0100
In-Reply-To: <cover.1610652890.git.andreyknvl@google.com>
Message-Id: <73283ddcceed173966041f9ce1734f50ea3e9a41.1610652890.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610652890.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v3 08/15] kasan: add compiler barriers to KUNIT_EXPECT_KASAN_FAIL
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

