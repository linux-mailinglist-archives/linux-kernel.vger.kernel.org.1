Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA591FBCB8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 19:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgFPRWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 13:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgFPRWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 13:22:36 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F536C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:22:35 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b7so1360631pju.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=Pp+JbfentYaueAJNALln06L3L7MPA9gUVjWOyonrj3I=;
        b=ZIhX5lYaKd35Wofc5tHAkw7NC8ItRkgqo7ZnbnhNae4eLHmOiEGKHBKr28VdjcglIE
         woLn4AXArHrT//X1u+ftrxO7Njc4fs8aUe3Vsyn63QtZXScQj2cz/dAnzDSpQpBXBvNC
         gTkpro9rM7J8fuJ8mLOmRX5GO9eILQ2QjbcCRfKzGBPrYjllCp/2y+0Xp2nOIWac1axQ
         +/zCCCcNvKp7i3pqVj3kG38ReL9xaEcA68OrIPrytyDX5UUKet7WvtDOH9LN0NbVvZKW
         zChN58XFYR4ynpxuuJ8nfRiszbC2L9mhdnX+QTTyv2EAWseD+3zcEEA4Vq/Z3VwxEpdr
         YnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=Pp+JbfentYaueAJNALln06L3L7MPA9gUVjWOyonrj3I=;
        b=SVtrmR25ysYbNyRFf8igpsKto7glyTL4OGzbep2kz6xIjvvJgeR750g9wWyTX12cob
         nCXQtAuFmkAN/2NK/bgzAGj8TK374a6+10bGOt5BY32ziwJktM96DNL/KSz2KkQr59qw
         6pcPDfiRGbk0ZOl2Ec4a2Fp+ISa8U1FUQ4lq2NSzV+4k18hq1H9hgS2icpIDdzhkHOCg
         B/TGDcbZIB1Cb+9Z7rbyaEpBEgJ+WkEDEYGpFTdLZZsHYKh5phNiVNFpKLDQU4pqqvbO
         sdUVs1G9KnBkrI7P+pLgWgeK5D2IX5oxBgf6xtuc+6ityerb4mRtx6OcKIgBRGbKH38u
         T9+A==
X-Gm-Message-State: AOAM530GFKtGsw8hWIx2XHwfsaqh1M5BtduXInBNhNh82lgHLR8QoDmp
        Vyd0krPOUERxA9fEOxYpacKH84hjfELMEg==
X-Google-Smtp-Source: ABdhPJyf0evRInpdV5nsBjKSNX6/kcK0leh3I/Miz/txWzPBjlje2m59EWX7FVh88Waw9eEOtsJeoQ==
X-Received: by 2002:a17:902:b106:: with SMTP id q6mr2885272plr.23.1592328154890;
        Tue, 16 Jun 2020 10:22:34 -0700 (PDT)
Received: from posk-x1c (c-73-202-129-89.hsd1.ca.comcast.net. [73.202.129.89])
        by smtp.gmail.com with ESMTPSA id a12sm3033521pjw.35.2020.06.16.10.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 10:22:34 -0700 (PDT)
Message-ID: <a58582da82f99d5e7d3c5f8d0dbc55ea85bed08d.camel@posk.io>
Subject: [RFC PATCH 3/3 v2] selftests/futex: add futex_swap selftest
From:   Peter Oskolkov <posk@posk.io>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Oskolkov <posk@google.com>, avagin@google.com,
        "pjt@google.com" <pjt@google.com>, Ben Segall <bsegall@google.com>
Date:   Tue, 16 Jun 2020 10:22:33 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 7b091e46de4f9227b5a943e6d78283564e8c1c72 Mon Sep 17 00:00:00 2001
From: Peter Oskolkov <posk@google.com>
Date: Tue, 2 Jun 2020 13:01:17 -0700
Subject: [RFC PATCH 3/3 v2] selftests/futex: add futex_swap selftest

This is the final RFC patch in FUTEX_SWAP patchset. It
adds a test/benchmark to validate behavior and
compare performance of a new FUTEX_SWAP futex operation.

Detailed API design and behavior considerations are provided
in the commit messages of the previous two patches.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   1 +
 .../selftests/futex/functional/futex_swap.c   | 209 ++++++++++++++++++
 .../selftests/futex/include/futextest.h       |  19 ++
 4 files changed, 230 insertions(+)
 create mode 100644 tools/testing/selftests/futex/functional/futex_swap.c

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
index 0efcd494daab..d661ef0946cc 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -2,6 +2,7 @@
 futex_requeue_pi
 futex_requeue_pi_mismatched_ops
 futex_requeue_pi_signal_restart
+futex_swap
 futex_wait_private_mapped_file
 futex_wait_timeout
 futex_wait_uninitialized_heap
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 23207829ec75..6992fac38b15 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -13,6 +13,7 @@ TEST_GEN_FILES := \
 	futex_requeue_pi \
 	futex_requeue_pi_signal_restart \
 	futex_requeue_pi_mismatched_ops \
+	futex_swap \
 	futex_wait_uninitialized_heap \
 	futex_wait_private_mapped_file

diff --git a/tools/testing/selftests/futex/functional/futex_swap.c b/tools/testing/selftests/futex/functional/futex_swap.c
new file mode 100644
index 000000000000..9034d04372d3
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex_swap.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <errno.h>
+#include <getopt.h>
+#include <pthread.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include "atomic.h"
+#include "futextest.h"
+
+/* The futex the main thread waits on. */
+futex_t futex_main = FUTEX_INITIALIZER;
+/* The futex the other thread wats on. */
+futex_t futex_other = FUTEX_INITIALIZER;
+
+/* The number of iterations to run (>1 => run benchmarks. */
+static int cfg_iterations = 1;
+
+/* If != 0, print diagnostic messages. */
+static int cfg_verbose;
+
+/* If == 0, do not use validation_counter. Useful for benchmarking. */
+static int cfg_validate = 1;
+
+/* How to swap threads. */
+#define SWAP_WAKE_WAIT 1
+#define SWAP_SWAP 2
+
+/* Futex values. */
+#define FUTEX_WAITING 0
+#define FUTEX_WAKEUP 1
+
+/* An atomic counter used to validate proper swapping. */
+static atomic_t validation_counter;
+
+void futex_swap_op(int mode, futex_t *futex_this, futex_t *futex_that)
+{
+	int ret;
+
+	switch (mode) {
+	case SWAP_WAKE_WAIT:
+		futex_set(futex_this, FUTEX_WAITING);
+		futex_set(futex_that, FUTEX_WAKEUP);
+		futex_wake(futex_that, 1, FUTEX_PRIVATE_FLAG);
+		futex_wait(futex_this, FUTEX_WAITING, NULL, FUTEX_PRIVATE_FLAG);
+		if (*futex_this != FUTEX_WAKEUP) {
+			fprintf(stderr, "unexpected futex_this value on wakeup\n");
+			exit(1);
+		}
+		break;
+
+	case SWAP_SWAP:
+		futex_set(futex_this, FUTEX_WAITING);
+		futex_set(futex_that, FUTEX_WAKEUP);
+		ret = futex_swap(futex_this, FUTEX_WAITING, NULL,
+				 futex_that, FUTEX_PRIVATE_FLAG);
+		if (ret < 0 && errno == ENOSYS) {
+			/* futex_swap not implemented */
+			perror("futex_swap");
+			exit(1);
+		}
+		if (*futex_this != FUTEX_WAKEUP) {
+			fprintf(stderr, "unexpected futex_this value on wakeup\n");
+			exit(1);
+		}
+		break;
+
+	default:
+		fprintf(stderr, "unknown mode in %s\n", __func__);
+		exit(1);
+	}
+}
+
+void *other_thread(void *arg)
+{
+	int mode = *((int *)arg);
+	int counter;
+
+	if (cfg_verbose)
+		printf("%s started\n", __func__);
+
+	futex_wait(&futex_other, 0, NULL, FUTEX_PRIVATE_FLAG);
+
+	for (counter = 0; counter < cfg_iterations; ++counter) {
+		if (cfg_validate) {
+			int prev = 2 * counter + 1;
+
+			if (prev != atomic_cmpxchg(&validation_counter, prev,
+						   prev + 1)) {
+				fprintf(stderr, "swap validation failed\n");
+				exit(1);
+			}
+		}
+		futex_swap_op(mode, &futex_other, &futex_main);
+	}
+
+	if (cfg_verbose)
+		printf("%s finished: %d iteration(s)\n", __func__, counter);
+
+	return NULL;
+}
+
+void run_test(int mode)
+{
+	struct timespec start, stop;
+	int ret, counter;
+	pthread_t thread;
+	uint64_t duration;
+
+	futex_set(&futex_other, FUTEX_WAITING);
+	atomic_set(&validation_counter, 0);
+	ret = pthread_create(&thread, NULL, &other_thread, &mode);
+	if (ret) {
+		perror("pthread_create");
+		exit(1);
+	}
+
+	ret = clock_gettime(CLOCK_MONOTONIC, &start);
+	if (ret) {
+		perror("clock_gettime");
+		exit(1);
+	}
+
+	for (counter = 0; counter < cfg_iterations; ++counter) {
+		if (cfg_validate) {
+			int prev = 2 * counter;
+
+			if (prev != atomic_cmpxchg(&validation_counter, prev,
+						   prev + 1)) {
+				fprintf(stderr, "swap validation failed\n");
+				exit(1);
+			}
+		}
+		futex_swap_op(mode, &futex_main, &futex_other);
+	}
+	if (cfg_validate && validation_counter.val != 2 * cfg_iterations) {
+		fprintf(stderr, "final swap validation failed\n");
+		exit(1);
+	}
+
+	ret = clock_gettime(CLOCK_MONOTONIC, &stop);
+	if (ret) {
+		perror("clock_gettime");
+		exit(1);
+	}
+
+	duration = (stop.tv_sec - start.tv_sec) * 1000000000LL +
+	stop.tv_nsec - start.tv_nsec;
+	if (cfg_verbose || cfg_iterations > 1) {
+		printf("completed %d swap and back iterations in %lu ns: %lu ns per swap\n",
+			cfg_iterations, duration,
+			duration / (cfg_iterations * 2));
+	}
+
+	/* The remote thread is blocked; send it the final wake. */
+	futex_set(&futex_other, FUTEX_WAKEUP);
+	futex_wake(&futex_other, 1, FUTEX_PRIVATE_FLAG);
+	if (pthread_join(thread, NULL)) {
+		perror("pthread_join");
+		exit(1);
+	}
+}
+
+void usage(char *prog)
+{
+	printf("Usage: %s\n", prog);
+	printf("  -h    Display this help message\n");
+	printf("  -i N  Use N iterations to benchmark\n");
+	printf("  -n    Do not validate swapping correctness\n");
+	printf("  -v    Print diagnostic messages\n");
+}
+
+int main(int argc, char *argv[])
+{
+	int c;
+
+	while ((c = getopt(argc, argv, "hi:nv")) != -1) {
+		switch (c) {
+		case 'h':
+			usage(basename(argv[0]));
+			exit(0);
+		case 'i':
+			cfg_iterations = atoi(optarg);
+			break;
+		case 'n':
+			cfg_validate = 0;
+			break;
+		case 'v':
+			cfg_verbose = 1;
+			break;
+		default:
+			usage(basename(argv[0]));
+			exit(1);
+		}
+	}
+
+	printf("\n\n------- running SWAP_WAKE_WAIT -----------\n\n");
+	run_test(SWAP_WAKE_WAIT);
+	printf("PASS\n");
+
+	printf("\n\n------- running SWAP_SWAP -----------\n\n");
+	run_test(SWAP_SWAP);
+	printf("PASS\n");
+
+	return 0;
+}
diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testing/selftests/futex/include/futextest.h
index ddbcfc9b7bac..4d6a0a18445a 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -38,6 +38,9 @@ typedef volatile u_int32_t futex_t;
 #ifndef FUTEX_CMP_REQUEUE_PI
 #define FUTEX_CMP_REQUEUE_PI		12
 #endif
+#ifndef FUTEX_SWAP
+#define FUTEX_SWAP			13
+#endif
 #ifndef FUTEX_WAIT_REQUEUE_PI_PRIVATE
 #define FUTEX_WAIT_REQUEUE_PI_PRIVATE	(FUTEX_WAIT_REQUEUE_PI | \
 					 FUTEX_PRIVATE_FLAG)
@@ -46,6 +49,9 @@ typedef volatile u_int32_t futex_t;
 #define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
 					 FUTEX_PRIVATE_FLAG)
 #endif
+#ifndef FUTEX_SWAP_PRIVATE
+#define FUTEX_SWAP_PRIVATE		(FUTEX_WAIT_WAKE | FUTEX_PRIVATE_FLAG)
+#endif

 /**
  * futex() - SYS_futex syscall wrapper
@@ -204,6 +210,19 @@ futex_cmp_requeue_pi(futex_t *uaddr, futex_t val, futex_t *uaddr2, int nr_wake,
 		     val, opflags);
 }

+/**
+ * futex_swap() - block on uaddr and wake one task blocked on uaddr2.
+ * @uaddr:	futex to block the current task on
+ * @timeout:	relative timeout for the current task block
+ * @uaddr2:	futex to wake tasks at (can be the same as uaddr)
+ */
+static inline int
+futex_swap(futex_t *uaddr, futex_t val, struct timespec *timeout,
+	   futex_t *uaddr2, int opflags)
+{
+	return futex(uaddr, FUTEX_SWAP, val, timeout, uaddr2, 0, opflags);
+}
+
 /**
  * futex_cmpxchg() - atomic compare and exchange
  * @uaddr:	The address of the futex to be modified
--
2.25.1


