Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F832DF5A2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 15:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgLTOXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 09:23:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21610 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727489AbgLTOXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 09:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608474103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MDbwUf+8XstD8OivjaozAkwTO9Z6ZWRHeP6xHB5dtGU=;
        b=VrdcPmP1TtNr7vWPJmSNnj9M2deMy1VLXmRdyzyCATJpF+9ZO1n0w9v5eXcCe1VUmglg8Y
        VIst4UCorv7XC9RDlL+dVdK8dXiLPtx6NZscHlOkJP/uAtJUOBvtfeODILav+e64MNhdnE
        ayGqUhJXHsaSh1PJRLMhM2ise1kfDt4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-QteUgzOOPxa2LRiPmB4QGg-1; Sun, 20 Dec 2020 09:21:41 -0500
X-MC-Unique: QteUgzOOPxa2LRiPmB4QGg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89FA815720;
        Sun, 20 Dec 2020 14:21:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.9])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9958619715;
        Sun, 20 Dec 2020 14:21:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sun, 20 Dec 2020 15:21:39 +0100 (CET)
Date:   Sun, 20 Dec 2020 15:21:35 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Leesoo Ahn <dev@ooseel.net>
Cc:     linux-kernel@vger.kernel.org, Leesoo Ahn <lsahn@ooseel.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Collingbourne <pcc@google.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: Re: [PATCH] signal: Don't init struct kernel_siginfo fields to zero
 again
Message-ID: <20201220142134.GB16470@redhat.com>
References: <20201220074555.12655-1-lsahn@ooseel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201220074555.12655-1-lsahn@ooseel.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20, Leesoo Ahn wrote:
>
> clear_siginfo() is responsible for clearing struct kernel_siginfo object.
> It's obvious that manually initializing those fields is needless as
> a commit[1] explains why the function introduced and its guarantee that
> all bits in the struct are cleared after it.
>
> [1]: commit 8c5dbf2ae00b ("signal: Introduce clear_siginfo")
>
> Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>

Acked-by: Oleg Nesterov <oleg@redhat.com>


> ---
>  kernel/signal.c | 21 ---------------------
>  1 file changed, 21 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 5736c55aaa1a..8f49fa3ade33 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -603,10 +603,7 @@ static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *i
>  		 */
>  		clear_siginfo(info);
>  		info->si_signo = sig;
> -		info->si_errno = 0;
>  		info->si_code = SI_USER;
> -		info->si_pid = 0;
> -		info->si_uid = 0;
>  	}
>  }
>  
> @@ -1120,7 +1117,6 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
>  		case (unsigned long) SEND_SIG_NOINFO:
>  			clear_siginfo(&q->info);
>  			q->info.si_signo = sig;
> -			q->info.si_errno = 0;
>  			q->info.si_code = SI_USER;
>  			q->info.si_pid = task_tgid_nr_ns(current,
>  							task_active_pid_ns(t));
> @@ -1133,10 +1129,7 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
>  		case (unsigned long) SEND_SIG_PRIV:
>  			clear_siginfo(&q->info);
>  			q->info.si_signo = sig;
> -			q->info.si_errno = 0;
>  			q->info.si_code = SI_KERNEL;
> -			q->info.si_pid = 0;
> -			q->info.si_uid = 0;
>  			break;
>  		default:
>  			copy_siginfo(&q->info, info);
> @@ -1623,10 +1616,7 @@ void force_sig(int sig)
>  
>  	clear_siginfo(&info);
>  	info.si_signo = sig;
> -	info.si_errno = 0;
>  	info.si_code = SI_KERNEL;
> -	info.si_pid = 0;
> -	info.si_uid = 0;
>  	force_sig_info(&info);
>  }
>  EXPORT_SYMBOL(force_sig);
> @@ -1659,7 +1649,6 @@ int force_sig_fault_to_task(int sig, int code, void __user *addr
>  
>  	clear_siginfo(&info);
>  	info.si_signo = sig;
> -	info.si_errno = 0;
>  	info.si_code  = code;
>  	info.si_addr  = addr;
>  #ifdef __ARCH_SI_TRAPNO
> @@ -1691,7 +1680,6 @@ int send_sig_fault(int sig, int code, void __user *addr
>  
>  	clear_siginfo(&info);
>  	info.si_signo = sig;
> -	info.si_errno = 0;
>  	info.si_code  = code;
>  	info.si_addr  = addr;
>  #ifdef __ARCH_SI_TRAPNO
> @@ -1712,7 +1700,6 @@ int force_sig_mceerr(int code, void __user *addr, short lsb)
>  	WARN_ON((code != BUS_MCEERR_AO) && (code != BUS_MCEERR_AR));
>  	clear_siginfo(&info);
>  	info.si_signo = SIGBUS;
> -	info.si_errno = 0;
>  	info.si_code = code;
>  	info.si_addr = addr;
>  	info.si_addr_lsb = lsb;
> @@ -1726,7 +1713,6 @@ int send_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *
>  	WARN_ON((code != BUS_MCEERR_AO) && (code != BUS_MCEERR_AR));
>  	clear_siginfo(&info);
>  	info.si_signo = SIGBUS;
> -	info.si_errno = 0;
>  	info.si_code = code;
>  	info.si_addr = addr;
>  	info.si_addr_lsb = lsb;
> @@ -1740,7 +1726,6 @@ int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper)
>  
>  	clear_siginfo(&info);
>  	info.si_signo = SIGSEGV;
> -	info.si_errno = 0;
>  	info.si_code  = SEGV_BNDERR;
>  	info.si_addr  = addr;
>  	info.si_lower = lower;
> @@ -1755,7 +1740,6 @@ int force_sig_pkuerr(void __user *addr, u32 pkey)
>  
>  	clear_siginfo(&info);
>  	info.si_signo = SIGSEGV;
> -	info.si_errno = 0;
>  	info.si_code  = SEGV_PKUERR;
>  	info.si_addr  = addr;
>  	info.si_pkey  = pkey;
> @@ -1934,7 +1918,6 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  
>  	clear_siginfo(&info);
>  	info.si_signo = sig;
> -	info.si_errno = 0;
>  	/*
>  	 * We are under tasklist_lock here so our parent is tied to
>  	 * us and cannot change.
> @@ -2033,7 +2016,6 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
>  
>  	clear_siginfo(&info);
>  	info.si_signo = SIGCHLD;
> -	info.si_errno = 0;
>  	/*
>  	 * see comment in do_notify_parent() about the following 4 lines
>  	 */
> @@ -2506,7 +2488,6 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info)
>  	if (signr != info->si_signo) {
>  		clear_siginfo(info);
>  		info->si_signo = signr;
> -		info->si_errno = 0;
>  		info->si_code = SI_USER;
>  		rcu_read_lock();
>  		info->si_pid = task_pid_vnr(current->parent);
> @@ -3660,7 +3641,6 @@ static inline void prepare_kill_siginfo(int sig, struct kernel_siginfo *info)
>  {
>  	clear_siginfo(info);
>  	info->si_signo = sig;
> -	info->si_errno = 0;
>  	info->si_code = SI_USER;
>  	info->si_pid = task_tgid_vnr(current);
>  	info->si_uid = from_kuid_munged(current_user_ns(), current_uid());
> @@ -3833,7 +3813,6 @@ static int do_tkill(pid_t tgid, pid_t pid, int sig)
>  
>  	clear_siginfo(&info);
>  	info.si_signo = sig;
> -	info.si_errno = 0;
>  	info.si_code = SI_TKILL;
>  	info.si_pid = task_tgid_vnr(current);
>  	info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
> -- 
> 2.26.2
> 

