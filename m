Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C20F2FC313
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbhASWMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730197AbhASWJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 17:09:18 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AE0C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 14:08:16 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 15so13844175pgx.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 14:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fzr5ZmyqkA8PO0rKR84r5wnTkX6dyXCN2TjKwSkTcCQ=;
        b=YqqYzbHq8KUuNlsVV8uwX4a0tFYj85lWPFI48TJfZyr4Zmv8WL6MT/v2KFm08aiB9+
         ZaTTebjTlB2CZ7O5HN7YO5bGtEn1DxCepQOl/lNmRZpgk6m1ih3VeaKfoayD7MJJ8n/r
         K+g7jYDBP1uGGTPuNf8MyfTVMGCmZCzq8PjbR9oWO0zuYzaUzAhsGVU/FxPVqXvc3DM2
         +Z47rau7jLXrmUUlLYytzT6XhCYmi0OtLKewHxHaep4pXTsQhO0SxnkVtN4NVe91EBYW
         zsbHh7VrR9DP7Oy1hbTc8p/GCDqkUNhsO4d1PPeTzZE5M5ogY46bQrcQcS1ZJMvt7T8b
         /hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fzr5ZmyqkA8PO0rKR84r5wnTkX6dyXCN2TjKwSkTcCQ=;
        b=oJV/elqSjXs8e+kbmjE6SJhHB4TubBUCdGa8oYZHVspChBoCuCgzv6n1X9XDKpqM73
         5LOGTdTqQMp6QlyPVijf38xgiTOSlrPhX2C2k+NiH08kVnybZxhLzUmDURmGrX2VpVS+
         /gQH4GbUIP+erfflDWVHLUBZOd3mwEsOc5ZurtZC0sDjV1CA54RVVOaybcn7EQX5oYSt
         TICG45M78RCdzguvBIqIpJ+aHa4yizvmrInvjwWu/qsXV9ufnxJzeIBAzhCAgM/BIe6/
         ot1Soa0usseQgBn7UmozyzYE5xxffG5vfUaWgH/Iqnf9UAt7aHCsFPRyZFB3b7Hde75K
         X58w==
X-Gm-Message-State: AOAM530cUutyu8Ob+EkNyiThhFRP61A1xoJnXVnE8M+RiCHsLbSxafog
        WW90ISmP041KEDmLB6dGMJU=
X-Google-Smtp-Source: ABdhPJy28WqsBvPwRH+gTwECasNDKDCvTk+9y/hhs1zMjQCiho52tcSsFNcJidbKFqaA0/ZV4wJE9w==
X-Received: by 2002:a63:fb54:: with SMTP id w20mr6211413pgj.419.1611094096174;
        Tue, 19 Jan 2021 14:08:16 -0800 (PST)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id 72sm95196pfw.170.2021.01.19.14.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 14:08:15 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 3/3] selftest/arm64/ptrace: add a test for NT_ARM_PRSTATUS
Date:   Tue, 19 Jan 2021 14:06:37 -0800
Message-Id: <20210119220637.494476-4-avagin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210119220637.494476-1-avagin@gmail.com>
References: <20210119220637.494476-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test output:
 TAP version 13
 1..1
 # selftests: arm64/ptrace: ptrace_syscall_regs_test
 # 1..3
 # ok 1 NT_PRSTATUS: x7 0
 # ok 2 NT_ARM_PRSTATUS: x7 686920776f726c64
 # ok 3 The child exited with code 0.
 # # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
 ok 1 selftests: arm64/ptrace: ptrace_syscall_regs_test

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 tools/testing/selftests/arm64/Makefile        |   2 +-
 tools/testing/selftests/arm64/ptrace/Makefile |   6 +
 .../arm64/ptrace/ptrace_syscall_regs_test.c   | 147 ++++++++++++++++++
 3 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/ptrace/Makefile
 create mode 100644 tools/testing/selftests/arm64/ptrace/ptrace_syscall_regs_test.c

diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
index 2c9d012797a7..704770a60ece 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -4,7 +4,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),aarch64 arm64))
-ARM64_SUBTARGETS ?= tags signal pauth fp mte
+ARM64_SUBTARGETS ?= tags signal pauth fp mte ptrace
 else
 ARM64_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/arm64/ptrace/Makefile b/tools/testing/selftests/arm64/ptrace/Makefile
new file mode 100644
index 000000000000..ca906ce3a581
--- /dev/null
+++ b/tools/testing/selftests/arm64/ptrace/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS += -g -I../../../../../usr/include/
+TEST_GEN_PROGS := ptrace_syscall_regs_test
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/arm64/ptrace/ptrace_syscall_regs_test.c b/tools/testing/selftests/arm64/ptrace/ptrace_syscall_regs_test.c
new file mode 100644
index 000000000000..601378b7591d
--- /dev/null
+++ b/tools/testing/selftests/arm64/ptrace/ptrace_syscall_regs_test.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <errno.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/types.h>
+#include <sys/ptrace.h>
+#include <sys/user.h>
+#include <sys/wait.h>
+#include <sys/uio.h>
+#include <linux/elf.h>
+#include <linux/unistd.h>
+
+#include "../../kselftest.h"
+
+#define TEST_VAL 0x686920776f726c64UL
+
+#define pr_p(func, fmt, ...)	func(fmt ": %m", ##__VA_ARGS__)
+
+#define pr_err(fmt, ...)						\
+	({								\
+		ksft_test_result_error(fmt "\n", ##__VA_ARGS__);		\
+		-1;							\
+	})
+
+#define pr_fail(fmt, ...)					\
+	({							\
+		ksft_test_result_fail(fmt "\n", ##__VA_ARGS__);	\
+		-1;						\
+	})
+
+#define pr_perror(fmt, ...)	pr_p(pr_err, fmt, ##__VA_ARGS__)
+
+static long loop(void *val)
+{
+	register long x0 __asm__("x0");
+	register void *x1 __asm__("x1") = val;
+	register long x8 __asm__("x8") = 555;
+
+	__asm__ (
+		"again:\n"
+		"ldr x7, [x1, 0]\n"
+		"svc 0\n"
+		"str x7, [x1, 0]\n"
+			   : "=r"(x0)
+			   : "r"(x1), "r"(x8)
+			   :
+	);
+	return 0;
+}
+
+static int child(void)
+{
+	long  val = TEST_VAL;
+
+	loop(&val);
+	if (val != ~TEST_VAL) {
+		ksft_print_msg("Unexpected x7: %lx\n", val);
+		return 1;
+	}
+
+	return 0;
+}
+
+#ifndef PTRACE_SYSEMU
+#define PTRACE_SYSEMU 31
+#endif
+
+#ifndef NT_ARM_PRSTATUS
+#define NT_ARM_PRSTATUS 0x410
+#endif
+
+int main(int argc, void **argv)
+{
+	struct user_regs_struct regs = {};
+	struct iovec iov = {
+		.iov_base = &regs,
+		.iov_len = sizeof(struct user_regs_struct),
+	};
+	int status;
+	pid_t pid;
+
+	ksft_set_plan(3);
+
+	pid = fork();
+	if (pid == 0) {
+		kill(getpid(), SIGSTOP);
+		child();
+		_exit(0);
+	}
+	if (pid < 0)
+		return 1;
+
+	if (ptrace(PTRACE_ATTACH, pid, 0, 0))
+		return pr_perror("Can't attach to the child %d", pid);
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Can't wait for the child %d", pid);
+	/* skip SIGSTOP */
+	if (ptrace(PTRACE_CONT, pid, 0, 0))
+		return pr_perror("Can't resume the child %d", pid);
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Can't wait for the child %d", pid);
+
+	/* Resume the child to the next system call. */
+	if (ptrace(PTRACE_SYSEMU, pid, 0, 0))
+		return pr_perror("Can't resume the child %d", pid);
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Can't wait for the child %d", pid);
+	if (!WIFSTOPPED(status) || WSTOPSIG(status) != SIGTRAP)
+		return pr_err("Unexpected status: %d", status);
+
+	/* Check that x7 is zero in the case of NT_PRSTATUS. */
+	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
+		return pr_perror("Can't get child registers");
+	if (regs.regs[7] != 0)
+		return pr_fail("NT_PRSTATUS: unexpected x7: %lx", regs.regs[7]);
+	ksft_test_result_pass("NT_PRSTATUS: x7 %llx\n", regs.regs[7]);
+
+	/* Check that x7 isnt't clobbered in the case of NT_ARM_PRSTATUS. */
+	if (ptrace(PTRACE_GETREGSET, pid, NT_ARM_PRSTATUS, &iov))
+		return pr_perror("Can't get child registers");
+	if (regs.regs[7] != TEST_VAL)
+		return pr_fail("NT_ARM_PRSTATUS: unexpected x7: %lx", regs.regs[7]);
+	ksft_test_result_pass("NT_ARM_PRSTATUS: x7 %llx\n", regs.regs[7]);
+
+	/* Check that the child will see a new value of x7. */
+	regs.regs[0] = 0;
+	regs.regs[7] = ~TEST_VAL;
+	if (ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov))
+		return pr_perror("Can't set child registers");
+
+	if (ptrace(PTRACE_CONT, pid, 0, 0))
+		return pr_perror("Can't resume the child %d", pid);
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Can't wait for the child %d", pid);
+
+	if (status != 0)
+		return pr_fail("Child exited with code %d.", status);
+
+	ksft_test_result_pass("The child exited with code 0.\n");
+	ksft_exit_pass();
+	return 0;
+}
+
-- 
2.29.2

