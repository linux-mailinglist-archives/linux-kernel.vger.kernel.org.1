Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DB0298211
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 15:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416616AbgJYOZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 10:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416580AbgJYOZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 10:25:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6886DC0613D0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 07:25:46 -0700 (PDT)
Date:   Sun, 25 Oct 2020 14:25:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603635944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GOzHnYI/aQz1W7IzAACCEEv1Mwd8FuZYhbts7b3WEQw=;
        b=GwOT1amTe2s36KxOgQzCkrMCUMryShpxSYPcFq4yQ8wWEToGRqdFai6sZ0cspHpNuJaxuY
        +NBb4RJeFHoqQLo9fPkRhV6aic7oQv+RGrAb01T5mcF7Dr+5P2Ie0DAEQEEPA7aaegM1DS
        KFYcPezHHcopTwDe3nxssM0J7qZRIerQ1OslTV8xxKZ7y/grGY83oEm99guG9SN3py6uqD
        F8OHemkN3lA7B930thRuEhYDClGLaE//zjj1q49/KUcN2lbq+ZLcZou9tsNab5zNfOUYov
        HXu0wthUxythZnYQtSkeXrxxqmvJTyw5zUPnllnPAnbMKV+sp76E2zKmt/Zo4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603635944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GOzHnYI/aQz1W7IzAACCEEv1Mwd8FuZYhbts7b3WEQw=;
        b=Ce7keJWx2eDpmCA8xIEYHOUPHmtZC+FDLi1g8RV2xqLt11uCXcVIyydACmdFyZURBRP59H
        HoHj/R2j/LrYF3BA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for 5.10-rc1
References: <160363590465.1234.11586095980767794789.tglx@nanos>
Message-ID: <160363590826.1234.17293019096180328200.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-10-25

up to:  a4fd8414659b: selftests/timens: Add a test for futex()


A time namespace fix and a matching selftest. The futex absolute timeouts
which are based on CLOCK_MONOTONIC require time namespace corrected. This
was missed in the original time namesapce support.

Thanks,

	tglx

------------------>
Andrei Vagin (2):
      futex: Adjust absolute futex timeouts with per time namespace offset
      selftests/timens: Add a test for futex()


 kernel/futex.c                          |   5 ++
 tools/testing/selftests/timens/Makefile |   2 +-
 tools/testing/selftests/timens/futex.c  | 110 ++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/futex.c

diff --git a/kernel/futex.c b/kernel/futex.c
index 680854dcf156..be68ac0d49ad 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -39,6 +39,7 @@
 #include <linux/freezer.h>
 #include <linux/memblock.h>
 #include <linux/fault-inject.h>
+#include <linux/time_namespace.h>
 
 #include <asm/futex.h>
 
@@ -3797,6 +3798,8 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 		t = timespec64_to_ktime(ts);
 		if (cmd == FUTEX_WAIT)
 			t = ktime_add_safe(ktime_get(), t);
+		else if (!(op & FUTEX_CLOCK_REALTIME))
+			t = timens_ktime_to_host(CLOCK_MONOTONIC, t);
 		tp = &t;
 	}
 	/*
@@ -3989,6 +3992,8 @@ SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
 		t = timespec64_to_ktime(ts);
 		if (cmd == FUTEX_WAIT)
 			t = ktime_add_safe(ktime_get(), t);
+		else if (!(op & FUTEX_CLOCK_REALTIME))
+			t = timens_ktime_to_host(CLOCK_MONOTONIC, t);
 		tp = &t;
 	}
 	if (cmd == FUTEX_REQUEUE || cmd == FUTEX_CMP_REQUEUE ||
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

