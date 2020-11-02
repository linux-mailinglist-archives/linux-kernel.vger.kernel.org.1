Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD05B2A354D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 21:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgKBUjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 15:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgKBUhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:37:17 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C306C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 12:37:17 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id w14so16096946wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 12:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JBSfbnkhy+SsCVKkabq4UeCi4FqgMT/EvHEBqUnCapA=;
        b=Kg4bwx/sQs8JYty7zroxHEawKP1El2jW02Um3Sfv9bGyiGWG8YbN9CauDSqN5FkhxY
         nhfpd+zruvLLRbEPcL6eYE16YI5q1dGfTb8p1dHixaGUrTNx8NR4C5RQrtygIs0kpL5d
         TqFgf+jE49EEQMH+1T8yyprghAwa+hpZhPTZULo8hggpvsf5e6JFwOPcDfkQ3O2k23D2
         J2CQ8MjkQ2y+DPHvHcSOPlwpwvPDaeS6+7Vwa3Vct2GED6P2s5+pY1BdpDM1K4yrK5X6
         Pt0PfSR/b2AJ1/YGGQZEXgQGqBiABrOsFe8grGoPRZ2NyOEEbz2zldRwuyM0BRGLJaAG
         1lGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBSfbnkhy+SsCVKkabq4UeCi4FqgMT/EvHEBqUnCapA=;
        b=NV4bvEqRnSG1Mx57pI+f7dtm/kPdUHzLYtZQxuBBQW2yu4o9F4lLKgMZ1RMO72KnFW
         gDz/6Rngkx9wNMOZpPUOvQU2EB2DWxUK0uncFI4QcMhC8sc77gUgC4giV71zb6EzAigY
         BolX/ZZLaICNpjk/Pc0wdBcJLzrqoOo7BVjem4d8JDIHOYZMUTkYJW04mKodnsrqPjgh
         xreJ3rjwJUyQHEY1XzMTBF27WDpPhV0AhbtdCM5bX+HcFZDnU5iBEWnWjPiHj3yPkhGF
         nBkmIH209JdlXhSaGBwuAaXyplFpkAmotAZ+HkS5Drnu9gqx8lNjmckoO0biEAdcCPzm
         DGBw==
X-Gm-Message-State: AOAM5308UKJNx+34P88sLglZuJFdwqwAhNgJcm62h6UiEaHGsf+hhQ3s
        vQUG2RGx3naoihaHR2TkzMIRdA==
X-Google-Smtp-Source: ABdhPJyoNAtXjaC3Q8PAYFP3AKOrj9IA4iQDVef24ZBSQtp1ky5buQ3/i3Q7qSEGrKZhi7HSLdveOQ==
X-Received: by 2002:adf:f3d2:: with SMTP id g18mr22110924wrp.367.1604349436086;
        Mon, 02 Nov 2020 12:37:16 -0800 (PST)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id d2sm23823258wrq.34.2020.11.02.12.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:37:15 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.pizza>,
        Christian Brauner <christian.brauner@canonical.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Giuseppe Scrivano <giuseppe@scrivano.org>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 3/3] selftests/seccomp: Test NOTIF_RECV empty/dead errors
Date:   Mon,  2 Nov 2020 21:37:06 +0100
Message-Id: <20201102203706.827510-3-jannh@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201102203706.827510-1-jannh@google.com>
References: <20201102203706.827510-1-jannh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test that SECCOMP_IOCTL_NOTIF_RECV on a seccomp fd with zero users returns
-ENOTCONN, both in blocking and in non-blocking mode.
Also test that SECCOMP_IOCTL_NOTIF_RECV on a seccomp fd with no active
notifications returns -ENOENT in non-blocking mode.

Signed-off-by: Jann Horn <jannh@google.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 127 ++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/=
selftests/seccomp/seccomp_bpf.c
index 5318f9cb1aec..8214c431ad4b 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -28,6 +28,7 @@
 #include <linux/prctl.h>
 #include <linux/ptrace.h>
 #include <linux/seccomp.h>
+#include <linux/futex.h>
 #include <pthread.h>
 #include <semaphore.h>
 #include <signal.h>
@@ -315,6 +316,35 @@ static int __filecmp(pid_t pid1, pid_t pid2, int fd1, =
int fd2)
 	}						\
 	_ret; })
=20
+static void store_and_wake(int *ptr, int value)
+{
+	__atomic_store(ptr, &value, __ATOMIC_RELEASE);
+	if (syscall(__NR_futex, ptr, FUTEX_WAKE, INT_MAX, NULL, NULL, 0) =3D=3D -=
1) {
+		perror("FUTEX_WAKE failed unexpectedly");
+		exit(EXIT_FAILURE);
+	}
+}
+
+static int wait_and_load(int *ptr, int placeholder)
+{
+	int futex_ret;
+	int value;
+
+retry:
+	futex_ret =3D syscall(__NR_futex, ptr, FUTEX_WAIT, placeholder, NULL,
+			    NULL, 0);
+	if (futex_ret =3D=3D -1 && errno !=3D EAGAIN) {
+		if (errno =3D=3D EINTR)
+			goto retry;
+		perror("FUTEX_WAIT failed unexpectedly");
+		exit(EXIT_FAILURE);
+	}
+	value =3D __atomic_load_n(ptr, __ATOMIC_ACQUIRE);
+	if (value =3D=3D placeholder)
+		goto retry;
+	return value;
+}
+
 TEST(kcmp)
 {
 	int ret;
@@ -4160,6 +4190,103 @@ TEST(user_notification_addfd_rlimit)
 	close(memfd);
 }
=20
+TEST(user_notification_recv_dead)
+{
+	pid_t pid;
+	int status;
+	struct __clone_args args =3D {
+		.flags =3D CLONE_FILES,
+		.exit_signal =3D SIGCHLD,
+	};
+	struct seccomp_notif notif =3D {};
+	struct shared_data {
+		int notif_fd;
+	} *shared_data;
+
+	shared_data =3D mmap(NULL, sizeof(struct shared_data),
+			   PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_SHARED,
+			   -1, 0);
+	ASSERT_NE(NULL, shared_data);
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	pid =3D sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid =3D=3D 0) {
+		shared_data->notif_fd =3D user_notif_syscall(
+				__NR_mknodat, SECCOMP_FILTER_FLAG_NEW_LISTENER);
+		if (shared_data->notif_fd < 0)
+			_exit(EXIT_FAILURE);
+
+		_exit(EXIT_SUCCESS);
+	}
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	/* non-blocking recv */
+	EXPECT_EQ(-1, ioctl(shared_data->notif_fd, SECCOMP_IOCTL_NOTIF_RECV, &not=
if));
+	EXPECT_EQ(ENOTCONN, errno);
+
+	/* blocking recv */
+	set_blocking(shared_data->notif_fd);
+	EXPECT_EQ(-1, ioctl(shared_data->notif_fd, SECCOMP_IOCTL_NOTIF_RECV, &not=
if));
+	EXPECT_EQ(ENOTCONN, errno);
+}
+
+TEST(user_notification_recv_nonblock)
+{
+	pid_t pid;
+	struct __clone_args args =3D {
+		.flags =3D CLONE_FILES,
+		.exit_signal =3D SIGCHLD,
+	};
+	struct seccomp_notif notif =3D {};
+	struct shared_data {
+		int notif_fd;
+	} *shared_data;
+
+	shared_data =3D mmap(NULL, sizeof(struct shared_data),
+			   PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_SHARED,
+			   -1, 0);
+	ASSERT_NE(NULL, shared_data);
+	shared_data->notif_fd =3D -1;
+
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	pid =3D sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid =3D=3D 0) {
+		int fd;
+
+		fd =3D user_notif_syscall(__NR_mknodat,
+					SECCOMP_FILTER_FLAG_NEW_LISTENER);
+		if (fd < 0) {
+			store_and_wake(&shared_data->notif_fd, -2);
+			_exit(EXIT_FAILURE);
+		}
+		store_and_wake(&shared_data->notif_fd, fd);
+
+		while (1)
+			pause();
+	}
+
+	wait_and_load(&shared_data->notif_fd, -1);
+
+	/* non-blocking recv */
+	EXPECT_EQ(-1, ioctl(shared_data->notif_fd, SECCOMP_IOCTL_NOTIF_RECV,
+			    &notif));
+	EXPECT_EQ(ENOENT, errno);
+
+	kill(pid, SIGKILL);
+}
+
 /*
  * TODO:
  * - expand NNP testing
--=20
2.29.1.341.ge80a0c044ae-goog

