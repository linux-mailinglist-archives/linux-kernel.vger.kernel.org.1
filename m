Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB032F4F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbhAMQHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbhAMQHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:07:11 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8011BC0617A2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:06:19 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id b11so1676916qtj.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JSaOZgBM+NKre49h7oSv83dotWqimUT6GB75MwXSDhM=;
        b=q3+44RYzwDW2KBmAa5b83zc1Abrj2QZfehoP7qY7oGT0eZo5R9EJqCiMpIEIw2k+fm
         IEq0tLcOe2723UR3OnwRkkeKalFoC103M+t0fnDfz9EKn3OMpJXni+CA8KPObq4KQQ3g
         Ts7JZKq5I1fXuLMOfXH1mykleFqzbljMRslsKgVO8YhquYalREjAQvmH+KJO7dS30kNr
         Uoqp3pz7L1OoWVgcw6YDTxTJe3o2VySPdWR2mD0hqYCmnGWuJlkNcFrEBu8tol6n09oe
         J17QQpc4P14hJhSD8QJ51foapyH2h6GlD3Ve9PlgQ+zh976KZOiZ44oos3rw5Pg+z7zJ
         rJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JSaOZgBM+NKre49h7oSv83dotWqimUT6GB75MwXSDhM=;
        b=epozv+zM6HJgvzab0waoj9a4yfEC0vioE8tyAar8EFLH/b0tuy7l5OaF8H58TUjWzN
         j4LuYww8Z5sHa/EfY9SjX3Efmkw9Bqf5z2Yi5P8fKwHaHhEwZCh100u2a6ME40fKbnXw
         CkunVsNHgTB7bZKDTXyXpkdwuvIoZGXLOxWlgslTill5IEFmSB1IxaOWRdWXXbWfcV8s
         dRMYT2Bezl8SFJMxAD0v3wguHClVUYXKp6lNCPp2YomtiZIbmLPenarJDDt3tFvBXlix
         WMwEkP7DZh+oSFU7t4KW7gGRLxMDecemmkYarFcpkxjAD/anQ6MnfWCB4mRuoJRbQtAt
         KVCA==
X-Gm-Message-State: AOAM530fwsqNdeDuChjgpMBnD9XErBBoplW7bbLcwnXDH1qriYM/pKx5
        70qd6DB9B8aZYOrgL46gkgxjroVeKw==
X-Google-Smtp-Source: ABdhPJzlwLJN4M8AgNFwWv+Dfbf5nMUwZ62lruDb+C3zsMCn74vy6Zy+SmKfVQADbPCDKMdLYh9hl8j40Q==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:ad4:4c50:: with SMTP id cs16mr3080778qvb.33.1610553978623;
 Wed, 13 Jan 2021 08:06:18 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:05:57 +0100
In-Reply-To: <20210113160557.1801480-1-elver@google.com>
Message-Id: <20210113160557.1801480-2-elver@google.com>
Mime-Version: 1.0
References: <20210113160557.1801480-1-elver@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 2/2] kcsan: Switch to KUNIT_CASE_PARAM for parameterized tests
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     dvyukov@google.com, boqun.feng@gmail.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since KUnit now support parameterized tests via KUNIT_CASE_PARAM, update
KCSAN's test to switch to it for parameterized tests. This simplifies
parameterized tests and gets rid of the "parameters in case name"
workaround (hack).

At the same time, we can increase the maximum number of threads used,
because on systems with too few CPUs, KUnit allows us to now stop at the
maximum useful threads and not unnecessarily execute redundant test
cases with (the same) limited threads as had been the case before.

Cc: David Gow <davidgow@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/kcsan_test.c | 116 ++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 62 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index f16f632eb416..b71751fc9f4f 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -13,6 +13,8 @@
  * Author: Marco Elver <elver@google.com>
  */
 
+#define pr_fmt(fmt) "kcsan_test: " fmt
+
 #include <kunit/test.h>
 #include <linux/jiffies.h>
 #include <linux/kcsan-checks.h>
@@ -951,22 +953,53 @@ static void test_atomic_builtins(struct kunit *test)
 }
 
 /*
- * Each test case is run with different numbers of threads. Until KUnit supports
- * passing arguments for each test case, we encode #threads in the test case
- * name (read by get_num_threads()). [The '-' was chosen as a stylistic
- * preference to separate test name and #threads.]
+ * Generate thread counts for all test cases. Values generated are in interval
+ * [2, 5] followed by exponentially increasing thread counts from 8 to 32.
  *
  * The thread counts are chosen to cover potentially interesting boundaries and
- * corner cases (range 2-5), and then stress the system with larger counts.
+ * corner cases (2 to 5), and then stress the system with larger counts.
  */
-#define KCSAN_KUNIT_CASE(test_name)                                            \
-	{ .run_case = test_name, .name = #test_name "-02" },                   \
-	{ .run_case = test_name, .name = #test_name "-03" },                   \
-	{ .run_case = test_name, .name = #test_name "-04" },                   \
-	{ .run_case = test_name, .name = #test_name "-05" },                   \
-	{ .run_case = test_name, .name = #test_name "-08" },                   \
-	{ .run_case = test_name, .name = #test_name "-16" }
+static const void *nthreads_gen_params(const void *prev, char *desc)
+{
+	long nthreads = (long)prev;
+
+	if (nthreads < 0 || nthreads >= 32)
+		nthreads = 0; /* stop */
+	else if (!nthreads)
+		nthreads = 2; /* initial value */
+	else if (nthreads < 5)
+		nthreads++;
+	else if (nthreads == 5)
+		nthreads = 8;
+	else
+		nthreads *= 2;
 
+	if (!IS_ENABLED(CONFIG_PREEMPT) || !IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER)) {
+		/*
+		 * Without any preemption, keep 2 CPUs free for other tasks, one
+		 * of which is the main test case function checking for
+		 * completion or failure.
+		 */
+		const long min_unused_cpus = IS_ENABLED(CONFIG_PREEMPT_NONE) ? 2 : 0;
+		const long min_required_cpus = 2 + min_unused_cpus;
+
+		if (num_online_cpus() < min_required_cpus) {
+			pr_err_once("Too few online CPUs (%u < %d) for test\n",
+				    num_online_cpus(), min_required_cpus);
+			nthreads = 0;
+		} else if (nthreads >= num_online_cpus() - min_unused_cpus) {
+			/* Use negative value to indicate last param. */
+			nthreads = -(num_online_cpus() - min_unused_cpus);
+			pr_warn_once("Limiting number of threads to %ld (only %d online CPUs)\n",
+				     -nthreads, num_online_cpus());
+		}
+	}
+
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "threads=%ld", abs(nthreads));
+	return (void *)nthreads;
+}
+
+#define KCSAN_KUNIT_CASE(test_name) KUNIT_CASE_PARAM(test_name, nthreads_gen_params)
 static struct kunit_case kcsan_test_cases[] = {
 	KCSAN_KUNIT_CASE(test_basic),
 	KCSAN_KUNIT_CASE(test_concurrent_races),
@@ -996,24 +1029,6 @@ static struct kunit_case kcsan_test_cases[] = {
 
 /* ===== End test cases ===== */
 
-/* Get number of threads encoded in test name. */
-static bool __no_kcsan
-get_num_threads(const char *test, int *nthreads)
-{
-	int len = strlen(test);
-
-	if (WARN_ON(len < 3))
-		return false;
-
-	*nthreads = test[len - 1] - '0';
-	*nthreads += (test[len - 2] - '0') * 10;
-
-	if (WARN_ON(*nthreads < 0))
-		return false;
-
-	return true;
-}
-
 /* Concurrent accesses from interrupts. */
 __no_kcsan
 static void access_thread_timer(struct timer_list *timer)
@@ -1076,9 +1091,6 @@ static int test_init(struct kunit *test)
 	if (!torture_init_begin((char *)test->name, 1))
 		return -EBUSY;
 
-	if (!get_num_threads(test->name, &nthreads))
-		goto err;
-
 	if (WARN_ON(threads))
 		goto err;
 
@@ -1087,38 +1099,18 @@ static int test_init(struct kunit *test)
 			goto err;
 	}
 
-	if (!IS_ENABLED(CONFIG_PREEMPT) || !IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER)) {
-		/*
-		 * Without any preemption, keep 2 CPUs free for other tasks, one
-		 * of which is the main test case function checking for
-		 * completion or failure.
-		 */
-		const int min_unused_cpus = IS_ENABLED(CONFIG_PREEMPT_NONE) ? 2 : 0;
-		const int min_required_cpus = 2 + min_unused_cpus;
+	nthreads = abs((long)test->param_value);
+	if (WARN_ON(!nthreads))
+		goto err;
 
-		if (num_online_cpus() < min_required_cpus) {
-			pr_err("%s: too few online CPUs (%u < %d) for test",
-			       test->name, num_online_cpus(), min_required_cpus);
-			goto err;
-		} else if (nthreads > num_online_cpus() - min_unused_cpus) {
-			nthreads = num_online_cpus() - min_unused_cpus;
-			pr_warn("%s: limiting number of threads to %d\n",
-				test->name, nthreads);
-		}
-	}
+	threads = kcalloc(nthreads + 1, sizeof(struct task_struct *), GFP_KERNEL);
+	if (WARN_ON(!threads))
+		goto err;
 
-	if (nthreads) {
-		threads = kcalloc(nthreads + 1, sizeof(struct task_struct *),
-				  GFP_KERNEL);
-		if (WARN_ON(!threads))
+	threads[nthreads] = NULL;
+	for (i = 0; i < nthreads; ++i) {
+		if (torture_create_kthread(access_thread, NULL, threads[i]))
 			goto err;
-
-		threads[nthreads] = NULL;
-		for (i = 0; i < nthreads; ++i) {
-			if (torture_create_kthread(access_thread, NULL,
-						   threads[i]))
-				goto err;
-		}
 	}
 
 	torture_init_end();
-- 
2.30.0.284.gd98b1dd5eaa7-goog

