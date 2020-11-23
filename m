Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F61D2C15FD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbgKWUKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731841AbgKWUKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:10:09 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6402DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:10:08 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id c131so162693wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hF9TK0RyS1YTrryY1Q/xCWNy21LxBIwj2x5LKL9MrUU=;
        b=WN2+Wdix/39+GFO9+0U6Q3dLj/ysrOAB1p9FGiVD/Ghgi6qjBcCZYZqUt1XQye4BLd
         HS0FAWeOM2DPN8/3LTxv9pKmW9JIBCpzG1YEnO9AsmRjblQmaNL8cpxl+vsh62hHfqFM
         e9ZxtHclwXU20zFb61QYrEkql+MDYiINm1KqV/k18Z9jPeHCIvqc4J+KfrGwjwxibzfo
         Gzk/Wb3nVVJJ6bZoaYgggWwUEdBqUU25+zvcFPUlQIo6uQ2eUiiepA06j0eYV+O5eEut
         QNmrqV5BGdTFufPqqb8AdnDR05t+JCYL9PwjQaeoY7Kgd+SmkioJTgEi9AXyJLkwd46Z
         DZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hF9TK0RyS1YTrryY1Q/xCWNy21LxBIwj2x5LKL9MrUU=;
        b=UgJ+BWHhc1S3h/itPeCT/GwU/GmDu3ZcmYs5mR4gT+tg3hhCxTqY1XwvdeR61qvHtg
         xEMdrAZSlrIcQxn8jn/im4JlsS2xik9LXs8Z2nSE9+s5vQdIvl82q2ub5cJKiMZQiDRp
         QxLs8KbsX7deCGqVAQmF8FS3s3j3rbfHe31F8d9VCSOEgCM5P5A4Rburt6ysukKnSkOP
         JqquKWj3YoTt2hdmVfXAZEJFgz4yvyYrV/u/LWKRfy6k3U9ysGvcEefLKYy7TNB250YP
         g8cGwc++WBqys/r4J5gRab/8z32rvAjxyBSLuSwb1868zFov+c18m5fUY+pNeOXruKxy
         egpg==
X-Gm-Message-State: AOAM530BQ+QGkN1b4HN4N319LcrmHtdQn/QRwqWUsZOwJLOQQPn6Mm3T
        fBH1Zm+mxzHcxaZ76PZULvptaw2P4RwYh9CG
X-Google-Smtp-Source: ABdhPJy3aGsj5bSuKdabZhsMP/+HzZedjMK1Cq2aizzINVoUPxqX3shRLy/rcVKPoad7EW5PlA6r3fb2idgNxqoH
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:791a:: with SMTP id
 l26mr202416wme.1.1606162206684; Mon, 23 Nov 2020 12:10:06 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:08:06 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <b51a165426e906e7ec8a68d806ef3f8cd92581a6.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 42/42] kselftest/arm64: Check GCR_EL1 after context switch
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
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

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

This test is specific to MTE and verifies that the GCR_EL1 register
is context switched correctly.

It spawns 1024 processes and each process spawns 5 threads. Each thread
writes a random setting of GCR_EL1 through the prctl() system call and
reads it back verifying that it is the same. If the values are not the
same it reports a failure.

Note: The test has been extended to verify that even SYNC and ASYNC mode
setting is preserved correctly over context switching.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
Change-Id: Ia917684a2b8e5f29e705ca5cbf360b010df6f61e
---
 tools/testing/selftests/arm64/mte/Makefile    |   2 +-
 .../arm64/mte/check_gcr_el1_cswitch.c         | 155 ++++++++++++++++++
 2 files changed, 156 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c

diff --git a/tools/testing/selftests/arm64/mte/Makefile b/tools/testing/selftests/arm64/mte/Makefile
index 2480226dfe57..0b3af552632a 100644
--- a/tools/testing/selftests/arm64/mte/Makefile
+++ b/tools/testing/selftests/arm64/mte/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (C) 2020 ARM Limited
 
-CFLAGS += -std=gnu99 -I.
+CFLAGS += -std=gnu99 -I. -lpthread
 SRCS := $(filter-out mte_common_util.c,$(wildcard *.c))
 PROGS := $(patsubst %.c,%,$(SRCS))
 
diff --git a/tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c b/tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c
new file mode 100644
index 000000000000..de5066aca097
--- /dev/null
+++ b/tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2020 ARM Limited
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <pthread.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <time.h>
+#include <unistd.h>
+#include <sys/auxv.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#include "kselftest.h"
+#include "mte_common_util.h"
+
+#define PR_SET_TAGGED_ADDR_CTRL 55
+#define PR_GET_TAGGED_ADDR_CTRL 56
+# define PR_TAGGED_ADDR_ENABLE  (1UL << 0)
+# define PR_MTE_TCF_SHIFT	1
+# define PR_MTE_TCF_NONE	(0UL << PR_MTE_TCF_SHIFT)
+# define PR_MTE_TCF_SYNC	(1UL << PR_MTE_TCF_SHIFT)
+# define PR_MTE_TCF_ASYNC	(2UL << PR_MTE_TCF_SHIFT)
+# define PR_MTE_TCF_MASK	(3UL << PR_MTE_TCF_SHIFT)
+# define PR_MTE_TAG_SHIFT	3
+# define PR_MTE_TAG_MASK	(0xffffUL << PR_MTE_TAG_SHIFT)
+
+#include "mte_def.h"
+
+#define NUM_ITERATIONS		1024
+#define MAX_THREADS		5
+#define THREAD_ITERATIONS	1000
+
+void *execute_thread(void *x)
+{
+	pid_t pid = *((pid_t *)x);
+	pid_t tid = gettid();
+	uint64_t prctl_tag_mask;
+	uint64_t prctl_set;
+	uint64_t prctl_get;
+	uint64_t prctl_tcf;
+
+	srand(time(NULL) ^ (pid << 16) ^ (tid << 16));
+
+	prctl_tag_mask = rand() & 0xffff;
+
+	if (prctl_tag_mask % 2)
+		prctl_tcf = PR_MTE_TCF_SYNC;
+	else
+		prctl_tcf = PR_MTE_TCF_ASYNC;
+
+	prctl_set = PR_TAGGED_ADDR_ENABLE | prctl_tcf | (prctl_tag_mask << PR_MTE_TAG_SHIFT);
+
+	for (int j = 0; j < THREAD_ITERATIONS; j++) {
+		if (prctl(PR_SET_TAGGED_ADDR_CTRL, prctl_set, 0, 0, 0)) {
+			perror("prctl() failed");
+			goto fail;
+		}
+
+		prctl_get = prctl(PR_GET_TAGGED_ADDR_CTRL, 0, 0, 0, 0);
+
+		if (prctl_set != prctl_get) {
+			ksft_print_msg("Error: prctl_set: 0x%lx != prctl_get: 0x%lx\n",
+						prctl_set, prctl_get);
+			goto fail;
+		}
+	}
+
+	return (void *)KSFT_PASS;
+
+fail:
+	return (void *)KSFT_FAIL;
+}
+
+int execute_test(pid_t pid)
+{
+	pthread_t thread_id[MAX_THREADS];
+	int thread_data[MAX_THREADS];
+
+	for (int i = 0; i < MAX_THREADS; i++)
+		pthread_create(&thread_id[i], NULL,
+			       execute_thread, (void *)&pid);
+
+	for (int i = 0; i < MAX_THREADS; i++)
+		pthread_join(thread_id[i], (void *)&thread_data[i]);
+
+	for (int i = 0; i < MAX_THREADS; i++)
+		if (thread_data[i] == KSFT_FAIL)
+			return KSFT_FAIL;
+
+	return KSFT_PASS;
+}
+
+int mte_gcr_fork_test(void)
+{
+	pid_t pid;
+	int results[NUM_ITERATIONS];
+	pid_t cpid;
+	int res;
+
+	for (int i = 0; i < NUM_ITERATIONS; i++) {
+		pid = fork();
+
+		if (pid < 0)
+			return KSFT_FAIL;
+
+		if (pid == 0) {
+			cpid = getpid();
+
+			res = execute_test(cpid);
+
+			exit(res);
+		}
+	}
+
+	for (int i = 0; i < NUM_ITERATIONS; i++) {
+		wait(&res);
+
+		if (WIFEXITED(res))
+			results[i] = WEXITSTATUS(res);
+		else
+			--i;
+	}
+
+	for (int i = 0; i < NUM_ITERATIONS; i++)
+		if (results[i] == KSFT_FAIL)
+			return KSFT_FAIL;
+
+	return KSFT_PASS;
+}
+
+int main(int argc, char *argv[])
+{
+	int err;
+
+	err = mte_default_setup();
+	if (err)
+		return err;
+
+	ksft_set_plan(1);
+
+	evaluate_test(mte_gcr_fork_test(),
+		"Verify that GCR_EL1 is set correctly on context switch\n");
+
+	mte_restore_setup();
+	ksft_print_cnts();
+
+	return ksft_get_fail_cnt() == 0 ? KSFT_PASS : KSFT_FAIL;
+}
+
-- 
2.29.2.454.gaff20da3a2-goog

