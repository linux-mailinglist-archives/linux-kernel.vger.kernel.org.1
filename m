Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555D62A3548
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 21:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbgKBUhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 15:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgKBUhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:37:16 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C139C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 12:37:16 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id b3so10207808wrx.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 12:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P6bwcjJ2XDoLMn5CYKNmMHk7XIKE6/VWTbsWHP9UClo=;
        b=aKaoXciH+Pz6gDWihGavAzN/ujpZoxLKjMpbk0qtQE+WdgaClA6/PW02jsZ/IyQiba
         Qwl/n98Sl4nt9BE97wkuciYtsEMvuWuJK2OEzq1W35DoabrGO/rBpCR/Jp0EX5mkl9JH
         2O1AQH2Oov0eCzctSKszffNczo8gdzVQdzgL9UmbOfbMNeUjeGwWvN4ccdxXR6VkuYPn
         tnLYbGCy2RU8DfX/3qehxfdA/dh+HtTki/1vQZ1PmQN1/dknqPHwyCpp9D27NkzIykxN
         zmWJ0GgBtHOudGW4uZVMDrXk2wrCh3zdhSU5xc5Sc2r8bqtVqMXVEb/aD/JVFzFuBsjr
         hlog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P6bwcjJ2XDoLMn5CYKNmMHk7XIKE6/VWTbsWHP9UClo=;
        b=JkhVvFQSu0o8Tf+jqb/M55ukwkewQUE7qTyOu/4+KH7hsskfnGYgxMlgdfJQFg009E
         1ZzuDOVgP58Q5RZqDvXhqpviOS7vl9wgnH75F23qIIPwKu3xDv9loUIYwQNln/BgW9JG
         EmRR6NaVQ31MoUVIjJaRjUnrtpvqry3jD3R9cx2XGkXJck6aA49OwGmX+9e8SljLYjGe
         +0jYBYKCOOqNlF9L5BMKNMRqCYl76v/bdQe2tTOxsu5BXShVihj8LqGj8p0/bA3+g2/7
         dZBF9SC+BJBI3JQzMVjIVjuLlP4e/qFgHywYHyMSZk+AVDogKy9a+7ym8U/k27982sWG
         bQzQ==
X-Gm-Message-State: AOAM5331AtlvcBPD9I5OQbg5eQIl8ww0Xwik3lnA52L5ADeewl9XFVgj
        Pu16xAUE2FSWT7VI5MoY/h0j6w==
X-Google-Smtp-Source: ABdhPJzXx/XOiYBSftriqL4NwZCBFmoS3l5uwsKoMYq4A2Lbr3Q9wAPU2NS/WPIdFxi6SjgyUI707A==
X-Received: by 2002:a05:6000:118c:: with SMTP id g12mr22889111wrx.246.1604349434817;
        Mon, 02 Nov 2020 12:37:14 -0800 (PST)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id 9sm672797wmk.5.2020.11.02.12.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:37:14 -0800 (PST)
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
Subject: [PATCH 2/3] samples: seccomp: simplify user-trap sample
Date:   Mon,  2 Nov 2020 21:37:05 +0100
Message-Id: <20201102203706.827510-2-jannh@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201102203706.827510-1-jannh@google.com>
References: <20201102203706.827510-1-jannh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the blocking unotify API returns when all users of the filter are
gone, get rid of the helper task that kills the blocked task.

Note that since seccomp only tracks whether tasks are completely gone, not
whether they have exited, we need to handle SIGCHLD while blocked on
SECCOMP_IOCTL_NOTIF_RECV. Alternatively we could also set SIGCHLD to
SIG_IGN and let the kernel autoreap exiting children.

Signed-off-by: Jann Horn <jannh@google.com>
---
 samples/seccomp/user-trap.c | 163 +++++++++++++++++++-----------------
 1 file changed, 87 insertions(+), 76 deletions(-)

diff --git a/samples/seccomp/user-trap.c b/samples/seccomp/user-trap.c
index b9e666f15998..92d0f9ba58b6 100644
--- a/samples/seccomp/user-trap.c
+++ b/samples/seccomp/user-trap.c
@@ -15,6 +15,7 @@
 #include <sys/syscall.h>
 #include <sys/user.h>
 #include <sys/ioctl.h>
+#include <sys/prctl.h>
 #include <sys/ptrace.h>
 #include <sys/mount.h>
 #include <linux/limits.h>
@@ -198,6 +199,21 @@ static int handle_req(struct seccomp_notif *req,
 	return ret;
 }
=20
+static pid_t worker;
+static int worker_status;
+
+static void sigchld_handler(int sig, siginfo_t *info, void *ctx)
+{
+	if (info->si_pid !=3D worker) {
+		fprintf(stderr, "SIGCHLD from unknown process\n");
+		return;
+	}
+	if (waitpid(worker, &worker_status, 0) !=3D worker) {
+		perror("waitpid");
+		exit(1);
+	}
+}
+
 static void set_blocking(int fd)
 {
 	int file_status_flags =3D fcntl(fd, F_GETFL);
@@ -211,14 +227,26 @@ static void set_blocking(int fd)
=20
 int main(void)
 {
-	int sk_pair[2], ret =3D 1, status, listener;
-	pid_t worker =3D 0 , tracer =3D 0;
+	int sk_pair[2], ret =3D 1, listener;
+	struct seccomp_notif *req;
+	struct seccomp_notif_resp *resp;
+	struct seccomp_notif_sizes sizes;
+	pid_t parent =3D getpid();
=20
 	if (socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair) < 0) {
 		perror("socketpair");
 		return 1;
 	}
=20
+	struct sigaction sigchld_act =3D {
+		.sa_sigaction =3D sigchld_handler,
+		.sa_flags =3D SA_SIGINFO
+	};
+	if (sigaction(SIGCHLD, &sigchld_act, NULL)) {
+		perror("sigaction");
+		return 1;
+	}
+
 	worker =3D fork();
 	if (worker < 0) {
 		perror("fork");
@@ -226,6 +254,14 @@ int main(void)
 	}
=20
 	if (worker =3D=3D 0) {
+		/* quit if the parent dies */
+		if (prctl(PR_SET_PDEATHSIG, SIGKILL)) {
+			perror("PR_SET_PDEATHSIG");
+			exit(1);
+		}
+		if (getppid() !=3D parent)
+			exit(1);
+
 		listener =3D user_trap_syscall(__NR_mount,
 					     SECCOMP_FILTER_FLAG_NEW_LISTENER);
 		if (listener < 0) {
@@ -283,87 +319,69 @@ int main(void)
 	 */
 	listener =3D recv_fd(sk_pair[0]);
 	if (listener < 0)
-		goto out_kill;
+		goto close_pair;
=20
 	set_blocking(listener);
=20
-	/*
-	 * Fork a task to handle the requests. This isn't strictly necessary,
-	 * but it makes the particular writing of this sample easier, since we
-	 * can just wait ofr the tracee to exit and kill the tracer.
-	 */
-	tracer =3D fork();
-	if (tracer < 0) {
-		perror("fork");
-		goto out_kill;
+	if (seccomp(SECCOMP_GET_NOTIF_SIZES, 0, &sizes) < 0) {
+		perror("seccomp(GET_NOTIF_SIZES)");
+		goto out_close;
 	}
=20
-	if (tracer =3D=3D 0) {
-		struct seccomp_notif *req;
-		struct seccomp_notif_resp *resp;
-		struct seccomp_notif_sizes sizes;
+	req =3D malloc(sizes.seccomp_notif);
+	if (!req)
+		goto out_close;
+
+	resp =3D malloc(sizes.seccomp_notif_resp);
+	if (!resp)
+		goto out_req;
+	memset(resp, 0, sizes.seccomp_notif_resp);
+
+	while (1) {
+		memset(req, 0, sizes.seccomp_notif);
+		if (ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, req)) {
+			if (errno =3D=3D ENOTCONN) {
+				/* The child process went away. */
+				break;
+			} else if (errno =3D=3D EINTR) {
+				continue;
+			}
=20
-		if (seccomp(SECCOMP_GET_NOTIF_SIZES, 0, &sizes) < 0) {
-			perror("seccomp(GET_NOTIF_SIZES)");
-			goto out_close;
+			perror("ioctl recv");
+			goto out_resp;
 		}
=20
-		req =3D malloc(sizes.seccomp_notif);
-		if (!req)
-			goto out_close;
-
-		resp =3D malloc(sizes.seccomp_notif_resp);
-		if (!resp)
-			goto out_req;
-		memset(resp, 0, sizes.seccomp_notif_resp);
+		if (handle_req(req, resp, listener) < 0)
+			goto out_resp;
=20
-		while (1) {
-			memset(req, 0, sizes.seccomp_notif);
-			if (ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, req)) {
-				if (errno =3D=3D ENOTCONN)
-					exit(0);
-
-				perror("ioctl recv");
-				goto out_resp;
-			}
-
-			if (handle_req(req, resp, listener) < 0)
-				goto out_resp;
-
-			/*
-			 * ENOENT here means that the task may have gotten a
-			 * signal and restarted the syscall. It's up to the
-			 * handler to decide what to do in this case, but for
-			 * the sample code, we just ignore it. Probably
-			 * something better should happen, like undoing the
-			 * mount, or keeping track of the args to make sure we
-			 * don't do it again.
-			 */
-			if (ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, resp) < 0 &&
-			    errno !=3D ENOENT) {
-				perror("ioctl send");
-				goto out_resp;
-			}
+		/*
+		 * ENOENT here means that the task may have gotten a
+		 * signal and restarted the syscall. It's up to the
+		 * handler to decide what to do in this case, but for
+		 * the sample code, we just ignore it. Probably
+		 * something better should happen, like undoing the
+		 * mount, or keeping track of the args to make sure we
+		 * don't do it again.
+		 */
+		if (ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, resp) < 0 &&
+		    errno !=3D ENOENT) {
+			perror("ioctl send");
+			goto out_resp;
 		}
+	}
+	ret =3D 0;
+
 out_resp:
-		free(resp);
+	free(resp);
 out_req:
-		free(req);
+	free(req);
 out_close:
-		close(listener);
-		exit(1);
-	}
-
 	close(listener);
=20
-	if (waitpid(worker, &status, 0) !=3D worker) {
-		perror("waitpid");
-		goto out_kill;
-	}
-
 	if (umount2("/tmp/foo", MNT_DETACH) < 0 && errno !=3D EINVAL) {
 		perror("umount2");
-		goto out_kill;
+		ret =3D 1;
+		goto close_pair;
 	}
=20
 	if (remove("/tmp/foo") < 0 && errno !=3D ENOENT) {
@@ -371,19 +389,12 @@ int main(void)
 		exit(1);
 	}
=20
-	if (!WIFEXITED(status) || WEXITSTATUS(status)) {
+	if (!WIFEXITED(worker_status) || WEXITSTATUS(worker_status)) {
 		fprintf(stderr, "worker exited nonzero\n");
-		goto out_kill;
+		ret =3D 1;
+		goto close_pair;
 	}
=20
-	ret =3D 0;
-
-out_kill:
-	if (tracer > 0)
-		kill(tracer, SIGKILL);
-	if (worker > 0)
-		kill(worker, SIGKILL);
-
 close_pair:
 	close(sk_pair[0]);
 	close(sk_pair[1]);
--=20
2.29.1.341.ge80a0c044ae-goog

