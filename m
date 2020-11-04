Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CEB2A6330
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbgKDLSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbgKDLSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:18:05 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C42C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 03:18:05 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id x20so18996831ilj.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 03:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iF1cUg5h/7gkYs9+RSMlEiGTk1xRMBUVa5E16/9tdGI=;
        b=NSzQYu2n2rYZwevRhiR6BoT/G9YK0IG747OVJRDKWHLqkBSN3E2WcvRX+ciE5KbrRC
         BILn09AlZPjrVlA5WkwOtlGfjl8zyWOXeBQoN8HCerqxYVkBxGKdEKk8h4PgRBtrOFSd
         BIyz1pEtfJc+4y9CeOsR6BwioXSDh3qzIscDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iF1cUg5h/7gkYs9+RSMlEiGTk1xRMBUVa5E16/9tdGI=;
        b=NrhxCOEwSvIdsa9xRihOmjJOA/cqCMZqAXRjgiBdqJDURfxcr4LEF5YneZm+uf2ig1
         CgiTreLai5Mrvx34bI/KfoUnSH9kx0tsP1sXf0E0AEzOETVVeR2OpeePcJhxRR8OnS4b
         sMYZNHhJxQaMFq3yel9prwCrQH+CJCqIcZCKLR7qDGosrkpzmcd1t/zqJ+gZPYzd1QTc
         tzRbPuXJMlvTHEogPX8gyjv+D/xL2sltcefOZXu0IZXAzpIlTgBfQyjmxaM1XlE9uXaf
         tfNPm0xqoIT+HCiPu3ywpKPdv699j07N3PGyLZuXisGHEOtOoQsOLr3tgsi+EplWanWq
         OX5Q==
X-Gm-Message-State: AOAM532HpNyOB4dQfoTMWJvjz4GS6vmM3JdNmiGbHywqdnETO7FaoGRN
        H6RHU/HAgWq5hwa59qyTKEfMIg==
X-Google-Smtp-Source: ABdhPJy3+LZ7R4+XJ5fuYSh6HaLDtWG2Gty6nK66v4a4+PVskd1ChAM65TCgx9Z5aEJ16oWarmHN0Q==
X-Received: by 2002:a92:de43:: with SMTP id e3mr16110057ilr.62.1604488684139;
        Wed, 04 Nov 2020 03:18:04 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id q23sm1040618iob.19.2020.11.04.03.18.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Nov 2020 03:18:03 -0800 (PST)
Date:   Wed, 4 Nov 2020 11:18:02 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.pizza>,
        Christian Brauner <christian.brauner@canonical.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <giuseppe@scrivano.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH 1/3] seccomp: Return from SECCOMP_IOCTL_NOTIF_RECV when
 children are gone
Message-ID: <20201104111801.GA22109@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201102203706.827510-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102203706.827510-1-jannh@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 09:37:04PM +0100, Jann Horn wrote:
> At the moment, the seccomp notifier API is hard to use without combining
> it with APIs like poll() or epoll(); if all target processes have gone
> away, the polling APIs will raise an error indication on the file
> descriptor, but SECCOMP_IOCTL_NOTIF_RECV will keep blocking indefinitely.
> 
> This usability problem was discovered when Michael Kerrisk wrote a
> manpage for this API.
> 
> To fix it, get rid of the semaphore logic and let SECCOMP_IOCTL_NOTIF_RECV
> behave as follows:
> 
> If O_NONBLOCK is set, SECCOMP_IOCTL_NOTIF_RECV always returns
> immediately, no matter whether a notification is available or not.
> 
> If O_NONBLOCK is unset, SECCOMP_IOCTL_NOTIF_RECV blocks until either a
> notification is delivered to userspace or all users of the filter have
> gone away.
> 
> To avoid subtle breakage from eventloop-style code that doesn't set
> O_NONBLOCK, set O_NONBLOCK by default - userspace can clear it if it
> wants blocking behavior, and if blocking-style code forgets to do so,
> that will be much more obvious than the breakage we'd get the other way
> around.
> This also means that UAPI breakage from this change should be limited to
> blocking users of the API, of which, to my knowledge, there are none so far
> (outside of in-tree sample and selftest code, which this patch adjusts - in
> particular the code in samples/ has to change a bunch).
> 
> This should be backported because future userspace code might otherwise not
> work properly on old kernels.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Michael Kerrisk <mtk.manpages@gmail.com>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  kernel/seccomp.c                              | 62 +++++++++++++------
>  samples/seccomp/user-trap.c                   | 16 +++++
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 21 +++++++
>  3 files changed, 79 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 8ad7a293255a..b3730740515f 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -43,6 +43,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/anon_inodes.h>
>  #include <linux/lockdep.h>
> +#include <linux/freezer.h>
>  
>  /*
>   * When SECCOMP_IOCTL_NOTIF_ID_VALID was first introduced, it had the
> @@ -138,7 +139,6 @@ struct seccomp_kaddfd {
>   * @notifications: A list of struct seccomp_knotif elements.
>   */
>  struct notification {
> -	struct semaphore request;
>  	u64 next_id;
>  	struct list_head notifications;
>  };
> @@ -863,7 +863,6 @@ static int seccomp_do_user_notification(int this_syscall,
>  	list_add(&n.list, &match->notif->notifications);
>  	INIT_LIST_HEAD(&n.addfd);
>  
> -	up(&match->notif->request);
>  	wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
>  	mutex_unlock(&match->notify_lock);
>  
> @@ -1179,9 +1178,10 @@ find_notification(struct seccomp_filter *filter, u64 id)
>  
>  
>  static long seccomp_notify_recv(struct seccomp_filter *filter,
> -				void __user *buf)
> +				void __user *buf, bool blocking)
>  {
>  	struct seccomp_knotif *knotif = NULL, *cur;
> +	DEFINE_WAIT(wait);
>  	struct seccomp_notif unotif;
>  	ssize_t ret;
>  
> @@ -1194,11 +1194,9 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
>  
>  	memset(&unotif, 0, sizeof(unotif));
>  
> -	ret = down_interruptible(&filter->notif->request);
> -	if (ret < 0)
> -		return ret;
> -
>  	mutex_lock(&filter->notify_lock);
> +
> +retry:
>  	list_for_each_entry(cur, &filter->notif->notifications, list) {
>  		if (cur->state == SECCOMP_NOTIFY_INIT) {
>  			knotif = cur;
> @@ -1206,14 +1204,40 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
>  		}
>  	}
>  
> -	/*
> -	 * If we didn't find a notification, it could be that the task was
> -	 * interrupted by a fatal signal between the time we were woken and
> -	 * when we were able to acquire the rw lock.
> -	 */
>  	if (!knotif) {
> -		ret = -ENOENT;
> -		goto out;
> +		if (!blocking) {
> +			if (refcount_read(&filter->users) == 0)
> +				ret = -ENOTCONN;
> +			else
> +				ret = -ENOENT;
> +			goto out;
> +		}
> +
> +		/* This has to happen before checking &filter->users. */
> +		prepare_to_wait(&filter->wqh, &wait, TASK_INTERRUPTIBLE);

Isn't there a subtle race condition here, that if we are in blocking mode, and 
we get a notification here, we wont be woken up? since we enter the wait queue
after checking to see if there are pending notifications, and in that period
the wake_up_poll could have been called?

I very well might be missing something interesting about the semantics of
freezable_schedule.

shouldn't it read something like:

retry:
	mutex_lock(...);
	ret = prepare_to_wait_event(&filter->wqh, &wait, TASK_INTERRUPTIBLE);
	if (ret)
		goto out;
	list_for_each_entry(cur, &filter->notif->notifications, list) {
		if (cur->state == SECCOMP_NOTIFY_INIT) {
			knotif = cur;
			break;
		}
	}

	/* Maybe this should be before we iterate over the list of outstanding notifcations? */
	if (refcount_read(&filter->users) == 0) {
		ret = -ENOTCONN;
		goto out;
	}

	if (!knotif) {
		if (!blocking) {
			ret = -ENOENT;
			goto out;
		}
		mutex_unlock(...);
		freezable_schedule();
		goto retry;
	}


out:
	finish_wait(&filter->wqh, &wait);
	mutex_unlock(...);
> +
> +		/*
> +		 * If all users of the filter are gone, throw an error
> +		 * instead of pointlessly continuing to block.
> +		 */
> +		if (refcount_read(&filter->users) == 0) {
> +			finish_wait(&filter->wqh, &wait);
> +			ret = -ENOTCONN;
> +			goto out;
> +		}
> +
> +		/* No notifications - wait for one... */
> +		mutex_unlock(&filter->notify_lock);
> +		freezable_schedule();
> +		finish_wait(&filter->wqh, &wait);
> +
> +		/* ... and retry */
> +		mutex_lock(&filter->notify_lock);
> +		if (signal_pending(current)) {
> +			ret = -EINTR;
> +			goto out;
> +		}
> +		goto retry;
>  	}
>  
>  	unotif.id = knotif->id;
> @@ -1237,10 +1261,8 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
>  		 */
>  		mutex_lock(&filter->notify_lock);
>  		knotif = find_notification(filter, unotif.id);
> -		if (knotif) {
> +		if (knotif)
>  			knotif->state = SECCOMP_NOTIFY_INIT;
> -			up(&filter->notif->request);
> -		}
>  		mutex_unlock(&filter->notify_lock);
>  	}
>  
> @@ -1416,11 +1438,12 @@ static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
>  {
>  	struct seccomp_filter *filter = file->private_data;
>  	void __user *buf = (void __user *)arg;
> +	bool blocking = !(file->f_flags & O_NONBLOCK);
>  
>  	/* Fixed-size ioctls */
>  	switch (cmd) {
>  	case SECCOMP_IOCTL_NOTIF_RECV:
> -		return seccomp_notify_recv(filter, buf);
> +		return seccomp_notify_recv(filter, buf, blocking);
>  	case SECCOMP_IOCTL_NOTIF_SEND:
>  		return seccomp_notify_send(filter, buf);
>  	case SECCOMP_IOCTL_NOTIF_ID_VALID_WRONG_DIR:
> @@ -1483,12 +1506,11 @@ static struct file *init_listener(struct seccomp_filter *filter)
>  	if (!filter->notif)
>  		goto out;
>  
> -	sema_init(&filter->notif->request, 0);
>  	filter->notif->next_id = get_random_u64();
>  	INIT_LIST_HEAD(&filter->notif->notifications);
>  
>  	ret = anon_inode_getfile("seccomp notify", &seccomp_notify_ops,
> -				 filter, O_RDWR);
> +				 filter, O_RDWR|O_NONBLOCK);
>  	if (IS_ERR(ret))
>  		goto out_notif;
>  
> diff --git a/samples/seccomp/user-trap.c b/samples/seccomp/user-trap.c
> index 20291ec6489f..b9e666f15998 100644
> --- a/samples/seccomp/user-trap.c
> +++ b/samples/seccomp/user-trap.c
> @@ -198,6 +198,17 @@ static int handle_req(struct seccomp_notif *req,
>  	return ret;
>  }
>  
> +static void set_blocking(int fd)
> +{
> +	int file_status_flags = fcntl(fd, F_GETFL);
> +
> +	file_status_flags &= ~O_NONBLOCK;
> +	if (fcntl(fd, F_SETFL, file_status_flags)) {
> +		perror("F_SETFL");
> +		exit(1);
> +	}
> +}
> +
>  int main(void)
>  {
>  	int sk_pair[2], ret = 1, status, listener;
> @@ -274,6 +285,8 @@ int main(void)
>  	if (listener < 0)
>  		goto out_kill;
>  
> +	set_blocking(listener);
> +
>  	/*
>  	 * Fork a task to handle the requests. This isn't strictly necessary,
>  	 * but it makes the particular writing of this sample easier, since we
> @@ -307,6 +320,9 @@ int main(void)
>  		while (1) {
>  			memset(req, 0, sizes.seccomp_notif);
>  			if (ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, req)) {
> +				if (errno == ENOTCONN)
> +					exit(0);
> +
>  				perror("ioctl recv");
>  				goto out_resp;
>  			}
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 4a180439ee9e..5318f9cb1aec 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -295,6 +295,13 @@ static int __filecmp(pid_t pid1, pid_t pid2, int fd1, int fd2)
>  #endif
>  }
>  
> +#define set_blocking(fd) ({					\
> +	int file_status_flags;					\
> +	file_status_flags = fcntl(fd, F_GETFL);			\
> +	file_status_flags &= ~O_NONBLOCK;			\
> +	ASSERT_EQ(fcntl(fd, F_SETFL, file_status_flags), 0);	\
> +})
> +
>  /* Have TH_LOG report actual location filecmp() is used. */
>  #define filecmp(pid1, pid2, fd1, fd2)	({		\
>  	int _ret;					\
> @@ -3422,6 +3429,8 @@ TEST(user_notification_kill_in_middle)
>  				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
>  	ASSERT_GE(listener, 0);
>  
> +	set_blocking(listener);
> +
>  	/*
>  	 * Check that nothing bad happens when we kill the task in the middle
>  	 * of a syscall.
> @@ -3476,6 +3485,8 @@ TEST(user_notification_signal)
>  				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
>  	ASSERT_GE(listener, 0);
>  
> +	set_blocking(listener);
> +
>  	pid = fork();
>  	ASSERT_GE(pid, 0);
>  
> @@ -3583,6 +3594,8 @@ TEST(user_notification_child_pid_ns)
>  				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
>  	ASSERT_GE(listener, 0);
>  
> +	set_blocking(listener);
> +
>  	pid = fork();
>  	ASSERT_GE(pid, 0);
>  
> @@ -3623,6 +3636,8 @@ TEST(user_notification_sibling_pid_ns)
>  				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
>  	ASSERT_GE(listener, 0);
>  
> +	set_blocking(listener);
> +
>  	pid = fork();
>  	ASSERT_GE(pid, 0);
>  
> @@ -3691,6 +3706,8 @@ TEST(user_notification_fault_recv)
>  				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
>  	ASSERT_GE(listener, 0);
>  
> +	set_blocking(listener);
> +
>  	pid = fork();
>  	ASSERT_GE(pid, 0);
>  
> @@ -3972,6 +3989,8 @@ TEST(user_notification_addfd)
>  				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
>  	ASSERT_GE(listener, 0);
>  
> +	set_blocking(listener);
> +
>  	pid = fork();
>  	ASSERT_GE(pid, 0);
>  
> @@ -4099,6 +4118,8 @@ TEST(user_notification_addfd_rlimit)
>  				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
>  	ASSERT_GE(listener, 0);
>  
> +	set_blocking(listener);
> +
>  	pid = fork();
>  	ASSERT_GE(pid, 0);
>  
> 
> base-commit: 4525c8781ec0701ce824e8bd379ae1b129e26568
> -- 
> 2.29.1.341.ge80a0c044ae-goog
> 
