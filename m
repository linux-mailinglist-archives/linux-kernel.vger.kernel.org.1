Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E7F28F647
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 18:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389039AbgJOQAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 12:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388854AbgJOQAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 12:00:42 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966BFC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 09:00:42 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h6so2183184pgk.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E7If3CcxJhS5frbnHPy/zaEOBlvLbQxQgs14QvEgn5Y=;
        b=Y9HHjSYot3RJocD+KHNr4FQ9aKui3cM7pIoHAGLNZnZvLIwnjRHCN+qX4CHpT/K6nY
         PNJtL2XXUanPlViUD22AQKcFaFfqFfEF8g4563HT9aUfLt0J1q1sL/qn182pFmxRBX74
         LarcZXFsoI3knAwnuki8dwck96UNghhpzim5TdvToNpXl+ITvPnfINMIXGy/txQwXvU5
         BNxUeSH0VmlXi6ooaUlTXjulElpubS6nF2RS2k0kiTssE6HgSe68yju/FAC24wqyAuiU
         4EFpoyjDH/Do2X7YHTiPltKry3MeC0LWSMyj2qgz6YPQm4QvHZFmIKkOVf6FLnRGkoqG
         EbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E7If3CcxJhS5frbnHPy/zaEOBlvLbQxQgs14QvEgn5Y=;
        b=thsbWceXNhLTlpefwQU3okaUa/32hrddZt9cmHmSSRLBOCroe6ZDndcA+8Qk9AeGLG
         SNxg8vhdqyeTVHPyC1XcbFZzM6gy+Re5FAwq5kAjFmjFTEngP69qwtrreYknr1jMwiQZ
         hGoxRLsvu+NOfz12EeIdKLL8lny58IzUhluH41geTSfbiTkaHYMyez9T8AQvW1oVuRGa
         W06lS2Y/CzEaB9PC4Y0ZAfA+eOQiIT6qG7ZcMOKaorKknmf4+qanypwS0X4cG8/Hp38D
         Yh9RhaZBaKgtyOTXbi0K+oRsD1maOFKX3bgRlZ2g0i8HCaLMEJG2ngIGN2fdwsjMOC6a
         DAOg==
X-Gm-Message-State: AOAM533gMjFMYVhSpw6A7tRDCkMobvOTosrTi/szmY3qKaFCQxxTdMNr
        yyXBMBLbS2GK5QzaxkJcwgw=
X-Google-Smtp-Source: ABdhPJx1jG6jplT4Jv5s6x/Cb78iSSu+KB3ZBCW3aP4NXSLVZNe4IfeCuZeFxtRr+GYGfn53OKKLuw==
X-Received: by 2002:a63:531d:: with SMTP id h29mr3531264pgb.301.1602777641930;
        Thu, 15 Oct 2020 09:00:41 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id q24sm3664414pgb.12.2020.10.15.09.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 09:00:41 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 2/2 v2] selftests/timens: Add a test for futex()
Date:   Thu, 15 Oct 2020 09:00:20 -0700
Message-Id: <20201015160020.293748-2-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20201015160020.293748-1-avagin@gmail.com>
References: <20201015160020.293748-1-avagin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Output on success:
 1..2
 ok 1 futex with the 0 clockid
 ok 2 futex with the 1 clockid
 # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
v2: extend the test to check FUTEX_CLOCK_REALTIME

 tools/testing/selftests/timens/Makefile |   2 +-
 tools/testing/selftests/timens/futex.c  | 110 ++++++++++++++++++++++++
 2 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/futex.c

diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index b4fd9a934654..3a5936cc10ab 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs exec
+TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs exec futex
 TEST_GEN_PROGS_EXTENDED := gettime_perf
 
 CFLAGS := -Wall -Werror -pthread
diff --git a/tools/testing/selftests/timens/futex.c b/tools/testing/selftests/timens/futex.c
new file mode 100644
index 000000000000..6b2b9264e851
--- /dev/null
+++ b/tools/testing/selftests/timens/futex.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <linux/unistd.h>
+#include <linux/futex.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "log.h"
+#include "timens.h"
+
+#define NSEC_PER_SEC 1000000000ULL
+
+static int run_test(int clockid)
+{
+	int futex_op = FUTEX_WAIT_BITSET;
+	struct timespec timeout, end;
+	int val = 0;
+
+	if (clockid == CLOCK_REALTIME)
+		futex_op |= FUTEX_CLOCK_REALTIME;
+
+	clock_gettime(clockid, &timeout);
+	timeout.tv_nsec += NSEC_PER_SEC / 10; // 100ms
+	if (timeout.tv_nsec > NSEC_PER_SEC) {
+		timeout.tv_sec++;
+		timeout.tv_nsec -= NSEC_PER_SEC;
+	}
+
+	if (syscall(__NR_futex, &val, futex_op, 0,
+		    &timeout, 0, FUTEX_BITSET_MATCH_ANY) >= 0) {
+		ksft_test_result_fail("futex didn't return ETIMEDOUT\n");
+		return 1;
+	}
+
+	if (errno != ETIMEDOUT) {
+		ksft_test_result_fail("futex didn't return ETIMEDOUT: %s\n",
+							strerror(errno));
+		return 1;
+	}
+
+	clock_gettime(clockid, &end);
+
+	if (end.tv_sec < timeout.tv_sec ||
+	    (end.tv_sec == timeout.tv_sec && end.tv_nsec < timeout.tv_nsec)) {
+		ksft_test_result_fail("futex slept less than 100ms\n");
+		return 1;
+	}
+
+
+	ksft_test_result_pass("futex with the %d clockid\n", clockid);
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int status, len, fd;
+	char buf[4096];
+	pid_t pid;
+	struct timespec mtime_now;
+
+	nscheck();
+
+	ksft_set_plan(2);
+
+	clock_gettime(CLOCK_MONOTONIC, &mtime_now);
+
+	if (unshare_timens())
+		return 1;
+
+	len = snprintf(buf, sizeof(buf), "%d %d 0",
+			CLOCK_MONOTONIC, 70 * 24 * 3600);
+	fd = open("/proc/self/timens_offsets", O_WRONLY);
+	if (fd < 0)
+		return pr_perror("/proc/self/timens_offsets");
+
+	if (write(fd, buf, len) != len)
+		return pr_perror("/proc/self/timens_offsets");
+
+	close(fd);
+
+	pid = fork();
+	if (pid < 0)
+		return pr_perror("Unable to fork");
+	if (pid == 0) {
+		int ret = 0;
+
+		ret |= run_test(CLOCK_REALTIME);
+		ret |= run_test(CLOCK_MONOTONIC);
+		if (ret)
+			ksft_exit_fail();
+		ksft_exit_pass();
+		return 0;
+	}
+
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Unable to wait the child process");
+
+	if (WIFEXITED(status))
+		return WEXITSTATUS(status);
+
+	return 1;
+}
-- 
2.26.2

