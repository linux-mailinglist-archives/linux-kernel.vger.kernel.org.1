Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED362F4FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbhAMQXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbhAMQXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:23:11 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1E0C0617A5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:22:06 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id k126so1716945qkf.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1ElsZsJrO3cOsYp/vFzZufoQKn9+sd3vP1RO0nASQZ0=;
        b=vLdGASrWREAy+wj9sfLUQB8j+yuVmoSbMdRaRJXHZRPSwkP8jB8knKlgUr+3AQR9Ve
         +r4vu4nQaMgAPKzfyhmAnJD0GwU6xEzluvKdeR9lktNoMnhyjqR2SbxVWzWiTKW3yd8A
         dxzNhIdB5+2+uFtg8x0VySNNDiMNMTODEvZz/GwlMWaIXxmHrfBNWrul1YExWcwZe8dq
         ErFPQ5XWd+oRZYvm3QY1ynahqe5O0lzPJ4CWD5ZbJ02KeB2Jlc94Cg++JguL9yPQXGhb
         Dnm7IxJww7M1CbKv0pids9Wc5g1KRkXybcD1YhSQUrQhlRSOZpo13kWx8rJLimwmCi4/
         gOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1ElsZsJrO3cOsYp/vFzZufoQKn9+sd3vP1RO0nASQZ0=;
        b=Ts3svAeKDJDlpxIdt26CFilp9foMqW7JrtIV9BDQNpUp0gAbq3ktvnCdbpXRwNsiMs
         UXCCwvI6h60j6XrHkBTdvU6wEkyBUNI+TtctiTU2c0nOBfvPUm66yClHov+MTmt9bVMY
         xUjQqY2omIuSpKra6WqGctXLEVzPhkpjjbDkgORvl8bb/0UlP5G9JO2bmMg0x7veE8kT
         /AyanUHWLx/Zh58D/WQSBp9CNq5lNjJ9pDDUI08ei659ruXYUdg78EglAh4Z9kWR8AQF
         ZE6bY/bxzWtOxu7dESMrMB8nEfCpXhckueEm3+TGDFMT2FRxEpLXRLBiCfnTH1NZ6iHK
         1mlg==
X-Gm-Message-State: AOAM531AcudR9vG40Ix2zQV9c0u71SPuWWHoAUs+Zv1dvuWXmySFAmFH
        nFaX2Hm57xAk1s9H9xW9HpO3DVNuFj3nDS4R
X-Google-Smtp-Source: ABdhPJzRVpbzs6eSZ4YpS+Iv4DdXN1T6DSp2/3sND1u+wQPzWYQWt3sUVkNPSbg16ucwUAEsnMF3mPkHaU9ACJ77
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:fd89:: with SMTP id
 p9mr3153133qvr.8.1610554925220; Wed, 13 Jan 2021 08:22:05 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:21:35 +0100
In-Reply-To: <cover.1610554432.git.andreyknvl@google.com>
Message-Id: <e75010281350ff3a4380006218f81e1233fa4e6b.1610554432.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 08/14] kasan: add compiler barriers to KUNIT_EXPECT_KASAN_FAIL
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

It might not be obvious to the compiler that the expression must be
executed between writing and reading to fail_data. In this case, the
compiler might reorder or optimize away some of the accesses, and
the tests will fail.

Add compiler barriers around the expression in KUNIT_EXPECT_KASAN_FAIL
and use READ/WRITE_ONCE() for accessing fail_data fields.

Link: https://linux-review.googlesource.com/id/I046079f48641a1d36fe627fc8827a9249102fd50
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c  | 17 ++++++++++++-----
 mm/kasan/report.c |  2 +-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 5c8aa3a5ce93..283feda9882a 100644
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

