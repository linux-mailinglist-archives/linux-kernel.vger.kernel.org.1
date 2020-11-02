Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3E92A3554
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 21:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbgKBUoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 15:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgKBUny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:43:54 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D17C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 12:43:53 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 13so10715013wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 12:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N2dn8fgFe5fRxczNSmFQS7yw8JTISYS7N2i9J5NtZuc=;
        b=QDe9svMNReBcHzh2bCvPKSu/QFJXB2Da1D4w8n1UGX3qDCBdfJ8457hcPvaCE6xqGW
         p/7CL1/MoaR/a90xZw9q07qi4m1ZbBHX5FBs9SkH9opMih0rKfszGdK91Q7mI5ZVMMXg
         FyVwusLUbRlbIZ+uqgm+Opeen/TdZbhige8XanW0c7R3YSqAkDZ3G91Q9Xfr2J0sjh1U
         93jcBzaF3rq4sDpvHPGFpuYw9pEZrhZnNU6BJ6dEm682hnXbHFVt5shX0ogTW5E28w97
         M6FvWqLBCSg5yGD4GoXEEzmIcCg6f9MHwhcfmPaKV49THbYz8JNVuIArO1x+cmC9D6UP
         pvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N2dn8fgFe5fRxczNSmFQS7yw8JTISYS7N2i9J5NtZuc=;
        b=WmS9WHV9gt+0znhnXhPJaxun1zzchdI8ZnV7d7TteRo5H91CMqBMbCbEEUHIYzyX2g
         o8bDAj/aTQnxq0UQxwqVFiefQlClw+De7IAR/lvqgD7jSlZ03WzVyPq646ACOS9D2hH1
         zMpDEiX9lrpXZ4UDu3AHCHgYOY7aNSpP5YcUuV8UGwy0vaopTJ4mghDebq1SHY4vqCBx
         0trz9mCdpb1XhDQKZSGKaRM/E2Qy8lCqpM+xSUB1jh2KwG1MsX2t7uLwbAySnmnw3XDR
         HdFQSXt47bKSFl8ocAUmYWH9upy4mLDLTal0YE8C8yX+CJc05DutNjT0X86Z/oDRMTi6
         5dYg==
X-Gm-Message-State: AOAM530nepylZJdhJAuGoFjVKEIUVvAc9h/Ohn33SAScpD9F+z3VJyfR
        UzIEIQKqu8zlRQycVD1OVoBZg/+7qlgG0A==
X-Google-Smtp-Source: ABdhPJw8+3fvYFDi3rynz2JkkQCX3sLLczVqwfJ/Uai+aDj2g6EeGdsuCJUArn9o8YfGWhtzJULdkw==
X-Received: by 2002:a05:600c:219a:: with SMTP id e26mr20840243wme.168.1604349433481;
        Mon, 02 Nov 2020 12:37:13 -0800 (PST)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id h4sm23387742wrp.52.2020.11.02.12.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:37:12 -0800 (PST)
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
Subject: [PATCH 1/3] seccomp: Return from SECCOMP_IOCTL_NOTIF_RECV when children are gone
Date:   Mon,  2 Nov 2020 21:37:04 +0100
Message-Id: <20201102203706.827510-1-jannh@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, the seccomp notifier API is hard to use without combining
it with APIs like poll() or epoll(); if all target processes have gone
away, the polling APIs will raise an error indication on the file
descriptor, but SECCOMP_IOCTL_NOTIF_RECV will keep blocking indefinitely.

This usability problem was discovered when Michael Kerrisk wrote a
manpage for this API.

To fix it, get rid of the semaphore logic and let SECCOMP_IOCTL_NOTIF_RECV
behave as follows:

If O_NONBLOCK is set, SECCOMP_IOCTL_NOTIF_RECV always returns
immediately, no matter whether a notification is available or not.

If O_NONBLOCK is unset, SECCOMP_IOCTL_NOTIF_RECV blocks until either a
notification is delivered to userspace or all users of the filter have
gone away.

To avoid subtle breakage from eventloop-style code that doesn't set
O_NONBLOCK, set O_NONBLOCK by default - userspace can clear it if it
wants blocking behavior, and if blocking-style code forgets to do so,
that will be much more obvious than the breakage we'd get the other way
around.
This also means that UAPI breakage from this change should be limited to
blocking users of the API, of which, to my knowledge, there are none so far
(outside of in-tree sample and selftest code, which this patch adjusts - in
particular the code in samples/ has to change a bunch).

This should be backported because future userspace code might otherwise not
work properly on old kernels.

Cc: stable@vger.kernel.org
Reported-by: Michael Kerrisk <mtk.manpages@gmail.com>
Signed-off-by: Jann Horn <jannh@google.com>
---
 kernel/seccomp.c                              | 62 +++++++++++++------
 samples/seccomp/user-trap.c                   | 16 +++++
 tools/testing/selftests/seccomp/seccomp_bpf.c | 21 +++++++
 3 files changed, 79 insertions(+), 20 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 8ad7a293255a..b3730740515f 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -43,6 +43,7 @@
 #include <linux/uaccess.h>
 #include <linux/anon_inodes.h>
 #include <linux/lockdep.h>
+#include <linux/freezer.h>
=20
 /*
  * When SECCOMP_IOCTL_NOTIF_ID_VALID was first introduced, it had the
@@ -138,7 +139,6 @@ struct seccomp_kaddfd {
  * @notifications: A list of struct seccomp_knotif elements.
  */
 struct notification {
-	struct semaphore request;
 	u64 next_id;
 	struct list_head notifications;
 };
@@ -863,7 +863,6 @@ static int seccomp_do_user_notification(int this_syscal=
l,
 	list_add(&n.list, &match->notif->notifications);
 	INIT_LIST_HEAD(&n.addfd);
=20
-	up(&match->notif->request);
 	wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
 	mutex_unlock(&match->notify_lock);
=20
@@ -1179,9 +1178,10 @@ find_notification(struct seccomp_filter *filter, u64=
 id)
=20
=20
 static long seccomp_notify_recv(struct seccomp_filter *filter,
-				void __user *buf)
+				void __user *buf, bool blocking)
 {
 	struct seccomp_knotif *knotif =3D NULL, *cur;
+	DEFINE_WAIT(wait);
 	struct seccomp_notif unotif;
 	ssize_t ret;
=20
@@ -1194,11 +1194,9 @@ static long seccomp_notify_recv(struct seccomp_filte=
r *filter,
=20
 	memset(&unotif, 0, sizeof(unotif));
=20
-	ret =3D down_interruptible(&filter->notif->request);
-	if (ret < 0)
-		return ret;
-
 	mutex_lock(&filter->notify_lock);
+
+retry:
 	list_for_each_entry(cur, &filter->notif->notifications, list) {
 		if (cur->state =3D=3D SECCOMP_NOTIFY_INIT) {
 			knotif =3D cur;
@@ -1206,14 +1204,40 @@ static long seccomp_notify_recv(struct seccomp_filt=
er *filter,
 		}
 	}
=20
-	/*
-	 * If we didn't find a notification, it could be that the task was
-	 * interrupted by a fatal signal between the time we were woken and
-	 * when we were able to acquire the rw lock.
-	 */
 	if (!knotif) {
-		ret =3D -ENOENT;
-		goto out;
+		if (!blocking) {
+			if (refcount_read(&filter->users) =3D=3D 0)
+				ret =3D -ENOTCONN;
+			else
+				ret =3D -ENOENT;
+			goto out;
+		}
+
+		/* This has to happen before checking &filter->users. */
+		prepare_to_wait(&filter->wqh, &wait, TASK_INTERRUPTIBLE);
+
+		/*
+		 * If all users of the filter are gone, throw an error
+		 * instead of pointlessly continuing to block.
+		 */
+		if (refcount_read(&filter->users) =3D=3D 0) {
+			finish_wait(&filter->wqh, &wait);
+			ret =3D -ENOTCONN;
+			goto out;
+		}
+
+		/* No notifications - wait for one... */
+		mutex_unlock(&filter->notify_lock);
+		freezable_schedule();
+		finish_wait(&filter->wqh, &wait);
+
+		/* ... and retry */
+		mutex_lock(&filter->notify_lock);
+		if (signal_pending(current)) {
+			ret =3D -EINTR;
+			goto out;
+		}
+		goto retry;
 	}
=20
 	unotif.id =3D knotif->id;
@@ -1237,10 +1261,8 @@ static long seccomp_notify_recv(struct seccomp_filte=
r *filter,
 		 */
 		mutex_lock(&filter->notify_lock);
 		knotif =3D find_notification(filter, unotif.id);
-		if (knotif) {
+		if (knotif)
 			knotif->state =3D SECCOMP_NOTIFY_INIT;
-			up(&filter->notif->request);
-		}
 		mutex_unlock(&filter->notify_lock);
 	}
=20
@@ -1416,11 +1438,12 @@ static long seccomp_notify_ioctl(struct file *file,=
 unsigned int cmd,
 {
 	struct seccomp_filter *filter =3D file->private_data;
 	void __user *buf =3D (void __user *)arg;
+	bool blocking =3D !(file->f_flags & O_NONBLOCK);
=20
 	/* Fixed-size ioctls */
 	switch (cmd) {
 	case SECCOMP_IOCTL_NOTIF_RECV:
-		return seccomp_notify_recv(filter, buf);
+		return seccomp_notify_recv(filter, buf, blocking);
 	case SECCOMP_IOCTL_NOTIF_SEND:
 		return seccomp_notify_send(filter, buf);
 	case SECCOMP_IOCTL_NOTIF_ID_VALID_WRONG_DIR:
@@ -1483,12 +1506,11 @@ static struct file *init_listener(struct seccomp_fi=
lter *filter)
 	if (!filter->notif)
 		goto out;
=20
-	sema_init(&filter->notif->request, 0);
 	filter->notif->next_id =3D get_random_u64();
 	INIT_LIST_HEAD(&filter->notif->notifications);
=20
 	ret =3D anon_inode_getfile("seccomp notify", &seccomp_notify_ops,
-				 filter, O_RDWR);
+				 filter, O_RDWR|O_NONBLOCK);
 	if (IS_ERR(ret))
 		goto out_notif;
=20
diff --git a/samples/seccomp/user-trap.c b/samples/seccomp/user-trap.c
index 20291ec6489f..b9e666f15998 100644
--- a/samples/seccomp/user-trap.c
+++ b/samples/seccomp/user-trap.c
@@ -198,6 +198,17 @@ static int handle_req(struct seccomp_notif *req,
 	return ret;
 }
=20
+static void set_blocking(int fd)
+{
+	int file_status_flags =3D fcntl(fd, F_GETFL);
+
+	file_status_flags &=3D ~O_NONBLOCK;
+	if (fcntl(fd, F_SETFL, file_status_flags)) {
+		perror("F_SETFL");
+		exit(1);
+	}
+}
+
 int main(void)
 {
 	int sk_pair[2], ret =3D 1, status, listener;
@@ -274,6 +285,8 @@ int main(void)
 	if (listener < 0)
 		goto out_kill;
=20
+	set_blocking(listener);
+
 	/*
 	 * Fork a task to handle the requests. This isn't strictly necessary,
 	 * but it makes the particular writing of this sample easier, since we
@@ -307,6 +320,9 @@ int main(void)
 		while (1) {
 			memset(req, 0, sizes.seccomp_notif);
 			if (ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, req)) {
+				if (errno =3D=3D ENOTCONN)
+					exit(0);
+
 				perror("ioctl recv");
 				goto out_resp;
 			}
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/=
selftests/seccomp/seccomp_bpf.c
index 4a180439ee9e..5318f9cb1aec 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -295,6 +295,13 @@ static int __filecmp(pid_t pid1, pid_t pid2, int fd1, =
int fd2)
 #endif
 }
=20
+#define set_blocking(fd) ({					\
+	int file_status_flags;					\
+	file_status_flags =3D fcntl(fd, F_GETFL);			\
+	file_status_flags &=3D ~O_NONBLOCK;			\
+	ASSERT_EQ(fcntl(fd, F_SETFL, file_status_flags), 0);	\
+})
+
 /* Have TH_LOG report actual location filecmp() is used. */
 #define filecmp(pid1, pid2, fd1, fd2)	({		\
 	int _ret;					\
@@ -3422,6 +3429,8 @@ TEST(user_notification_kill_in_middle)
 				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
=20
+	set_blocking(listener);
+
 	/*
 	 * Check that nothing bad happens when we kill the task in the middle
 	 * of a syscall.
@@ -3476,6 +3485,8 @@ TEST(user_notification_signal)
 				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
=20
+	set_blocking(listener);
+
 	pid =3D fork();
 	ASSERT_GE(pid, 0);
=20
@@ -3583,6 +3594,8 @@ TEST(user_notification_child_pid_ns)
 				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
=20
+	set_blocking(listener);
+
 	pid =3D fork();
 	ASSERT_GE(pid, 0);
=20
@@ -3623,6 +3636,8 @@ TEST(user_notification_sibling_pid_ns)
 				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
=20
+	set_blocking(listener);
+
 	pid =3D fork();
 	ASSERT_GE(pid, 0);
=20
@@ -3691,6 +3706,8 @@ TEST(user_notification_fault_recv)
 				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
=20
+	set_blocking(listener);
+
 	pid =3D fork();
 	ASSERT_GE(pid, 0);
=20
@@ -3972,6 +3989,8 @@ TEST(user_notification_addfd)
 				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
=20
+	set_blocking(listener);
+
 	pid =3D fork();
 	ASSERT_GE(pid, 0);
=20
@@ -4099,6 +4118,8 @@ TEST(user_notification_addfd_rlimit)
 				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
=20
+	set_blocking(listener);
+
 	pid =3D fork();
 	ASSERT_GE(pid, 0);
=20

base-commit: 4525c8781ec0701ce824e8bd379ae1b129e26568
--=20
2.29.1.341.ge80a0c044ae-goog

