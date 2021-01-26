Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B61C304FD9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhA0DbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:31:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51968 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbhAZVQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:16:41 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611695754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMahlZb5x+SfoahAvlTjhgBXvdODWPSZSyWSs7nWzYY=;
        b=4LewWy5aLg+xLcQ80a3PBEwWoqZT8WGw2MjWK5oDL2kpSbyQp3wBXo/Og3mI1iLl0M/B7r
        ZWYsPPKbIa81XtmyC82pdwlNf0tJcn5hIlMEsBqaYeW1Iqbg+eY+W5DXu/DYynNwwgjkvy
        GgH+5WBty5NZzke4hsrXrevFR8/kKZKR3M4lTrdxYZ4VPJaha+pMAKBenwzDK5MYa4FmdO
        kY5U+H4zn+1Nj/uiLV1wbQfURInqxm3fG+YjVNlYqrH+qd+Skd0hPtFYAkcbY/cEBDX5SS
        Uf1+WNgSxUvKiZHihJ4SaZO9PWI5sgVLp5ENY9coCBYekx8WAaPyQ6vvzTbCsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611695754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMahlZb5x+SfoahAvlTjhgBXvdODWPSZSyWSs7nWzYY=;
        b=lYw2arILovsgEqDfcaqrfoZEkQaRJjskAsb7kCUqEaLocPeMzXJbZrOVrmHTkREBeTn1TE
        WKqdwmP1LDaCMbCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk-rework 06/12] printk: use atomic64_t for devkmsg_user.seq
Date:   Tue, 26 Jan 2021 22:21:45 +0106
Message-Id: <20210126211551.26536-7-john.ogness@linutronix.de>
In-Reply-To: <20210126211551.26536-1-john.ogness@linutronix.de>
References: <20210126211551.26536-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@user->seq is indirectly protected by @logbuf_lock. Once @logbuf_lock
is removed, @user->seq will be no longer safe from an atomicity point
of view.

In preparation for the removal of @logbuf_lock, change it to
atomic64_t to provide this safety.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d41fd3306f4e..fe3df16315c0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -657,7 +657,7 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 
 /* /dev/kmsg - userspace message inject/listen interface */
 struct devkmsg_user {
-	u64 seq;
+	atomic64_t seq;
 	struct ratelimit_state rs;
 	struct mutex lock;
 	char buf[CONSOLE_EXT_LOG_MAX];
@@ -759,7 +759,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		return ret;
 
 	logbuf_lock_irq();
-	if (!prb_read_valid(prb, user->seq, r)) {
+	if (!prb_read_valid(prb, atomic64_read(&user->seq), r)) {
 		if (file->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
 			logbuf_unlock_irq();
@@ -768,15 +768,15 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 
 		logbuf_unlock_irq();
 		ret = wait_event_interruptible(log_wait,
-					prb_read_valid(prb, user->seq, r));
+				prb_read_valid(prb, atomic64_read(&user->seq), r));
 		if (ret)
 			goto out;
 		logbuf_lock_irq();
 	}
 
-	if (user->seq < prb_first_valid_seq(prb)) {
+	if (atomic64_read(&user->seq) < prb_first_valid_seq(prb)) {
 		/* our last seen message is gone, return error and reset */
-		user->seq = prb_first_valid_seq(prb);
+		atomic64_set(&user->seq, prb_first_valid_seq(prb));
 		ret = -EPIPE;
 		logbuf_unlock_irq();
 		goto out;
@@ -787,7 +787,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 				  &r->text_buf[0], r->info->text_len,
 				  &r->info->dev_info);
 
-	user->seq = r->info->seq + 1;
+	atomic64_set(&user->seq, r->info->seq + 1);
 	logbuf_unlock_irq();
 
 	if (len > count) {
@@ -827,7 +827,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 	switch (whence) {
 	case SEEK_SET:
 		/* the first record */
-		user->seq = prb_first_valid_seq(prb);
+		atomic64_set(&user->seq, prb_first_valid_seq(prb));
 		break;
 	case SEEK_DATA:
 		/*
@@ -835,11 +835,11 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 		 * like issued by 'dmesg -c'. Reading /dev/kmsg itself
 		 * changes no global state, and does not clear anything.
 		 */
-		user->seq = latched_seq_read_nolock(&clear_seq);
+		atomic64_set(&user->seq, latched_seq_read_nolock(&clear_seq));
 		break;
 	case SEEK_END:
 		/* after the last record */
-		user->seq = prb_next_seq(prb);
+		atomic64_set(&user->seq, prb_next_seq(prb));
 		break;
 	default:
 		ret = -EINVAL;
@@ -859,9 +859,9 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
 	poll_wait(file, &log_wait, wait);
 
 	logbuf_lock_irq();
-	if (prb_read_valid(prb, user->seq, NULL)) {
+	if (prb_read_valid(prb, atomic64_read(&user->seq), NULL)) {
 		/* return error when data has vanished underneath us */
-		if (user->seq < prb_first_valid_seq(prb))
+		if (atomic64_read(&user->seq) < prb_first_valid_seq(prb))
 			ret = EPOLLIN|EPOLLRDNORM|EPOLLERR|EPOLLPRI;
 		else
 			ret = EPOLLIN|EPOLLRDNORM;
@@ -900,7 +900,7 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 			&user->text_buf[0], sizeof(user->text_buf));
 
 	logbuf_lock_irq();
-	user->seq = prb_first_valid_seq(prb);
+	atomic64_set(&user->seq, prb_first_valid_seq(prb));
 	logbuf_unlock_irq();
 
 	file->private_data = user;
-- 
2.20.1

