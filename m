Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB0328EDB9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 09:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgJOH3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 03:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgJOH3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 03:29:34 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9A7C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 00:29:34 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g29so1374236pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 00:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DLVJKgUO/JnOzG/Hk5eOhYbLf7sANpbcqmOxXBZhXEw=;
        b=N/8v4YfQfHlbitG+ZV10KZfCn2yoo1Ms3TmaZUKZCk1LhnhS4ZPOS2xVmgI75VdM3A
         v2bm58OUWDA9P5MGF8u8uzHW3DPlsnrx83+oJHkmCeprp6XoJk2nzgnF7I2X52rW8viC
         9QP10lZUplQ8HJwraMyf4vweDZmSc82xSJJOmdFDIL4GrXFD8cynWA8o/g8yzQM9AcBb
         vhYAQMz2SNdaDEQJc6eo70awjvKKnpjP8BV1Ki5fRBPL0fcAXkzoLS9a1GfmD7EE9izT
         Gw0GzZvYpL8v2cPKbdv6FMsQjopuvuwXlfJecrTZTK8H6Kz6Wp7naBNNvKndsayBx52k
         luAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DLVJKgUO/JnOzG/Hk5eOhYbLf7sANpbcqmOxXBZhXEw=;
        b=NI/XrvE7MZkgbHkp9UTNVCZ1TRjpycX2Sjh1q6cf6/Vet7+UOE43lz4B96iyk7zym2
         roigfUaHQLJH+umMLHhayZC8gIG1vxdblDPy+IRs94DCoeJoseiuuTM2tCIDdgu/4oMN
         XDMCiNp2if0+TFjoxLrrx0tp06zsZie4pk7ywSYX/wGVmli1q8syNgY0Fkk/nNh5/hCz
         2QPQclBLX+vL6c1R1W+vqb3NtkaF3AsfHeDVnCRyD9X3dnTphj0mdt0OV/4TKg9SoYyV
         brPmbJE+37J4HhFIWyAFpqYamDBmnJKsoLabCxm+nylPcomX1wnpRLMsl2TMIj9hHt/o
         GDVA==
X-Gm-Message-State: AOAM532ZqUMgB9Ua14GZtCakR8l9s6zzxwB6kaUlzVqztrelUczjoE97
        GLYjMe6QhAwFzy4wZYvhNyg=
X-Google-Smtp-Source: ABdhPJyy/GSNWe1kw99Dt6khIvNrLrcTGZRbol2TCGR2Lz6HXnVBcRwLZfbTJBOGnpjuTZZNcVdyxg==
X-Received: by 2002:a62:7609:0:b029:152:b31e:6aed with SMTP id r9-20020a6276090000b0290152b31e6aedmr3074672pfc.10.1602746973623;
        Thu, 15 Oct 2020 00:29:33 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id u7sm2039426pfn.37.2020.10.15.00.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 00:29:33 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 2/2] selftests/timens: Add a test for futex()
Date:   Thu, 15 Oct 2020 00:29:09 -0700
Message-Id: <20201015072909.271426-2-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20201015072909.271426-1-avagin@gmail.com>
References: <20201015072909.271426-1-avagin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Output on success:
 $ ./futex
 1..1
 ok 1 futex
 # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 tools/testing/selftests/timens/Makefile |   2 +-
 tools/testing/selftests/timens/futex.c  | 107 ++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 1 deletion(-)
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
index 000000000000..173760d3fce6
--- /dev/null
+++ b/tools/testing/selftests/timens/futex.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <linux/unistd.h>
+#include <linux/futex.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdint.h>
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
+static int run_test(void)
+{
+	struct timespec timeout, end;
+	int val = 0;
+
+	clock_gettime(CLOCK_MONOTONIC, &timeout);
+	timeout.tv_nsec += NSEC_PER_SEC / 10; // 100ms
+	if (timeout.tv_nsec > NSEC_PER_SEC) {
+		timeout.tv_sec++;
+		timeout.tv_nsec -= NSEC_PER_SEC;
+	}
+
+	if (syscall(__NR_futex, &val, FUTEX_WAIT_BITSET, 0,
+		    &timeout, 0, FUTEX_BITSET_MATCH_ANY) >= 0) {
+		ksft_test_result_fail("futex didn't return ETIMEDOUT");
+		return 1;
+	}
+
+	if (errno != ETIMEDOUT) {
+		ksft_test_result_fail("futex didn't return ETIMEDOUT: %s",
+							strerror(errno));
+		return 1;
+	}
+
+	clock_gettime(CLOCK_MONOTONIC, &end);
+
+	if (end.tv_sec < timeout.tv_sec ||
+	    (end.tv_sec == timeout.tv_sec && end.tv_nsec < timeout.tv_sec)) {
+		ksft_test_result_fail("futex slept less than 100ms");
+		return 1;
+	}
+
+
+	ksft_test_result_pass("futex\n");
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
+	check_supported_timers();
+
+	ksft_set_plan(1);
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
+		if (run_test())
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

