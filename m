Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB222DF455
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 08:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgLTHr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 02:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgLTHrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 02:47:25 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29FEC0617B0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 23:46:35 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id hk16so4642834pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 23:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yTLp5hz4WsxOygALRyyjW4SA7sh5mwlptgN11SGq+Ko=;
        b=eTPiXsWLpf6guZSocpOMEs3SR/LZkpVtjA/kQWcOyySATXp5S/9WOeEu0wSkz+b1AT
         EpdoYbNLwNuxTPjw2OgoJGkDEQGlJ3qZE1kUZ27gFHwS40JcrYSp+EXeVqZPJP4+5hRH
         rgtkfF6hWpT0/4cb6im3Thw6rSZIuoOYyytBFXOGdq7S0o4MT1tC7s3OdUMeQG7f0e4q
         UH49IsP1Vz7XdUYqDxUZ7urSxOmWL5jjNwqHNWmn8y6DqUyrp3NO43VQb3uAuInLk3pz
         DBTTA46651xVwR8SFH9MATSgor3n5wgmG2C0FvVkmStLs0tsboa8V/B7UP/mJ+IfU3la
         /ImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=yTLp5hz4WsxOygALRyyjW4SA7sh5mwlptgN11SGq+Ko=;
        b=lkgAYp/ZEzTTwfwFqzIkC/4Bwi31teZHYe5oRf2QKRBAQm0+AaEGfrFdP/t4Payyq+
         P4bS68xH9Rss6jYPftHCHZx7AelbxBJM+0g3S4tUl0LWYKs7sxCecbDjlUKBMZFLMxlP
         cdrNGxLl4dZLndytq5R6AlafOjou4VvLtXh6QrlnhqhEkCid9blGF6eUsNM+1KXM/4G5
         9KiYJEBLimltEnfjDuVf/8kwCh0k3nwnZbKXevQB56pJOTy9p/T4TKqVIqZBvhH00NRP
         781QaBAwzIre6nI9lclcQ8yOEILw8D8QFpgxpbcYMqUMO0XKAGTz7dzPgb9A8ldtVwyN
         vQKw==
X-Gm-Message-State: AOAM532fP4pMCUZjvj6E8c0C/H1TLpsNXKjoEHnIwbXTJi5IcpHsz7/4
        pFhLGqTI+PM8rM81LIDUgycCcJHYVAELrHYm
X-Google-Smtp-Source: ABdhPJybEroUosmtCfj5jPT5WIMJVLRBSbO0dRTa/q7mHPasMg1cgTJ8oAz0nyrZFZljvtb6jvwP/A==
X-Received: by 2002:a17:90b:3687:: with SMTP id mj7mr11922766pjb.76.1608450394273;
        Sat, 19 Dec 2020 23:46:34 -0800 (PST)
Received: from localhost.localdomain ([49.236.93.237])
        by smtp.gmail.com with ESMTPSA id h36sm13174810pgb.28.2020.12.19.23.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 23:46:33 -0800 (PST)
Sender: Leesoo Ahn <yisooan.dev@gmail.com>
From:   Leesoo Ahn <dev@ooseel.net>
X-Google-Original-From: Leesoo Ahn <lsahn@ooseel.net>
To:     linux-kernel@vger.kernel.org
Cc:     Leesoo Ahn <lsahn@ooseel.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Peter Collingbourne <pcc@google.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH] signal: Don't init struct kernel_siginfo fields to zero again
Date:   Sun, 20 Dec 2020 16:45:54 +0900
Message-Id: <20201220074555.12655-1-lsahn@ooseel.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear_siginfo() is responsible for clearing struct kernel_siginfo object.
It's obvious that manually initializing those fields is needless as
a commit[1] explains why the function introduced and its guarantee that
all bits in the struct are cleared after it.

[1]: commit 8c5dbf2ae00b ("signal: Introduce clear_siginfo")

Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
---
 kernel/signal.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 5736c55aaa1a..8f49fa3ade33 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -603,10 +603,7 @@ static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *i
 		 */
 		clear_siginfo(info);
 		info->si_signo = sig;
-		info->si_errno = 0;
 		info->si_code = SI_USER;
-		info->si_pid = 0;
-		info->si_uid = 0;
 	}
 }
 
@@ -1120,7 +1117,6 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 		case (unsigned long) SEND_SIG_NOINFO:
 			clear_siginfo(&q->info);
 			q->info.si_signo = sig;
-			q->info.si_errno = 0;
 			q->info.si_code = SI_USER;
 			q->info.si_pid = task_tgid_nr_ns(current,
 							task_active_pid_ns(t));
@@ -1133,10 +1129,7 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 		case (unsigned long) SEND_SIG_PRIV:
 			clear_siginfo(&q->info);
 			q->info.si_signo = sig;
-			q->info.si_errno = 0;
 			q->info.si_code = SI_KERNEL;
-			q->info.si_pid = 0;
-			q->info.si_uid = 0;
 			break;
 		default:
 			copy_siginfo(&q->info, info);
@@ -1623,10 +1616,7 @@ void force_sig(int sig)
 
 	clear_siginfo(&info);
 	info.si_signo = sig;
-	info.si_errno = 0;
 	info.si_code = SI_KERNEL;
-	info.si_pid = 0;
-	info.si_uid = 0;
 	force_sig_info(&info);
 }
 EXPORT_SYMBOL(force_sig);
@@ -1659,7 +1649,6 @@ int force_sig_fault_to_task(int sig, int code, void __user *addr
 
 	clear_siginfo(&info);
 	info.si_signo = sig;
-	info.si_errno = 0;
 	info.si_code  = code;
 	info.si_addr  = addr;
 #ifdef __ARCH_SI_TRAPNO
@@ -1691,7 +1680,6 @@ int send_sig_fault(int sig, int code, void __user *addr
 
 	clear_siginfo(&info);
 	info.si_signo = sig;
-	info.si_errno = 0;
 	info.si_code  = code;
 	info.si_addr  = addr;
 #ifdef __ARCH_SI_TRAPNO
@@ -1712,7 +1700,6 @@ int force_sig_mceerr(int code, void __user *addr, short lsb)
 	WARN_ON((code != BUS_MCEERR_AO) && (code != BUS_MCEERR_AR));
 	clear_siginfo(&info);
 	info.si_signo = SIGBUS;
-	info.si_errno = 0;
 	info.si_code = code;
 	info.si_addr = addr;
 	info.si_addr_lsb = lsb;
@@ -1726,7 +1713,6 @@ int send_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *
 	WARN_ON((code != BUS_MCEERR_AO) && (code != BUS_MCEERR_AR));
 	clear_siginfo(&info);
 	info.si_signo = SIGBUS;
-	info.si_errno = 0;
 	info.si_code = code;
 	info.si_addr = addr;
 	info.si_addr_lsb = lsb;
@@ -1740,7 +1726,6 @@ int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper)
 
 	clear_siginfo(&info);
 	info.si_signo = SIGSEGV;
-	info.si_errno = 0;
 	info.si_code  = SEGV_BNDERR;
 	info.si_addr  = addr;
 	info.si_lower = lower;
@@ -1755,7 +1740,6 @@ int force_sig_pkuerr(void __user *addr, u32 pkey)
 
 	clear_siginfo(&info);
 	info.si_signo = SIGSEGV;
-	info.si_errno = 0;
 	info.si_code  = SEGV_PKUERR;
 	info.si_addr  = addr;
 	info.si_pkey  = pkey;
@@ -1934,7 +1918,6 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 
 	clear_siginfo(&info);
 	info.si_signo = sig;
-	info.si_errno = 0;
 	/*
 	 * We are under tasklist_lock here so our parent is tied to
 	 * us and cannot change.
@@ -2033,7 +2016,6 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
 
 	clear_siginfo(&info);
 	info.si_signo = SIGCHLD;
-	info.si_errno = 0;
 	/*
 	 * see comment in do_notify_parent() about the following 4 lines
 	 */
@@ -2506,7 +2488,6 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info)
 	if (signr != info->si_signo) {
 		clear_siginfo(info);
 		info->si_signo = signr;
-		info->si_errno = 0;
 		info->si_code = SI_USER;
 		rcu_read_lock();
 		info->si_pid = task_pid_vnr(current->parent);
@@ -3660,7 +3641,6 @@ static inline void prepare_kill_siginfo(int sig, struct kernel_siginfo *info)
 {
 	clear_siginfo(info);
 	info->si_signo = sig;
-	info->si_errno = 0;
 	info->si_code = SI_USER;
 	info->si_pid = task_tgid_vnr(current);
 	info->si_uid = from_kuid_munged(current_user_ns(), current_uid());
@@ -3833,7 +3813,6 @@ static int do_tkill(pid_t tgid, pid_t pid, int sig)
 
 	clear_siginfo(&info);
 	info.si_signo = sig;
-	info.si_errno = 0;
 	info.si_code = SI_TKILL;
 	info.si_pid = task_tgid_vnr(current);
 	info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
-- 
2.26.2

