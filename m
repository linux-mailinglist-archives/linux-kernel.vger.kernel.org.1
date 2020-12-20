Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415292DF607
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 17:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgLTQEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 11:04:46 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56981 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgLTQEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 11:04:45 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kr1Bf-0007KT-AP; Sun, 20 Dec 2020 16:03:59 +0000
Date:   Sun, 20 Dec 2020 17:03:57 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Rae Kim <rae.kim@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Leesoo Ahn <dev@ooseel.net>,
        linux-kernel@vger.kernel.org, Leesoo Ahn <lsahn@ooseel.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Collingbourne <pcc@google.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: Re: [PATCH] signal: Don't init struct kernel_siginfo fields to zero
 again
Message-ID: <20201220160357.r4cybiw3vyq7yxtg@wittgenstein>
References: <20201220074555.12655-1-lsahn@ooseel.net>
 <20201220142134.GB16470@redhat.com>
 <20201220154305.ixlm4mwesyfexq57@rae.kim>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201220154305.ixlm4mwesyfexq57@rae.kim>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 12:43:05AM +0900, Rae Kim wrote:
> 
> It looks like compiler optimization is smart enough to know that
> assigning zero is unnecessary after clear_siginfo() which is memset()
> under the hood. At least in my x86_64 machine, w/ or w/o this patch,
> there is no difference in final compiled machine code. (I've compared
> "objdump -d" results for "__send_signal()", "do_tkill()", and
> "collect_signal()")
> 
> Wouldn't it be nicer to have more information for both human and
> compiler since it doesn't generate extra machine code?

I don't have a strong preference. But the name clear_siginfo() is pretty
obvious imho. Say a new field "foo" were added to siginfo. We would
almost certainly reject a patch that would add an extra info->foo = 0
into all places where siginfo is initialized as being unnecessary unless
there was severe potential for confusion which I don't think is the case
here when removing this in favor of just relying on clear_siginfo(). But
as I said I don't have a strong opinion. I've picked this up but I'm
happy to drop it if other maintainers agree with you.

Christian

> 
> On Sun, Dec 20, 2020 at 03:21:35PM +0100, Oleg Nesterov wrote:
> > On 12/20, Leesoo Ahn wrote:
> > >
> > > clear_siginfo() is responsible for clearing struct kernel_siginfo object.
> > > It's obvious that manually initializing those fields is needless as
> > > a commit[1] explains why the function introduced and its guarantee that
> > > all bits in the struct are cleared after it.
> > >
> > > [1]: commit 8c5dbf2ae00b ("signal: Introduce clear_siginfo")
> > >
> > > Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
> > 
> > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > 
> > 
> > > ---
> > >  kernel/signal.c | 21 ---------------------
> > >  1 file changed, 21 deletions(-)
> > > 
> > > diff --git a/kernel/signal.c b/kernel/signal.c
> > > index 5736c55aaa1a..8f49fa3ade33 100644
> > > --- a/kernel/signal.c
> > > +++ b/kernel/signal.c
> > > @@ -603,10 +603,7 @@ static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *i
> > >  		 */
> > >  		clear_siginfo(info);
> > >  		info->si_signo = sig;
> > > -		info->si_errno = 0;
> > >  		info->si_code = SI_USER;
> > > -		info->si_pid = 0;
> > > -		info->si_uid = 0;
> > >  	}
> > >  }
> > >  
> > > @@ -1120,7 +1117,6 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
> > >  		case (unsigned long) SEND_SIG_NOINFO:
> > >  			clear_siginfo(&q->info);
> > >  			q->info.si_signo = sig;
> > > -			q->info.si_errno = 0;
> > >  			q->info.si_code = SI_USER;
> > >  			q->info.si_pid = task_tgid_nr_ns(current,
> > >  							task_active_pid_ns(t));
> > > @@ -1133,10 +1129,7 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
> > >  		case (unsigned long) SEND_SIG_PRIV:
> > >  			clear_siginfo(&q->info);
> > >  			q->info.si_signo = sig;
> > > -			q->info.si_errno = 0;
> > >  			q->info.si_code = SI_KERNEL;
> > > -			q->info.si_pid = 0;
> > > -			q->info.si_uid = 0;
> > >  			break;
> > >  		default:
> > >  			copy_siginfo(&q->info, info);
> > > @@ -1623,10 +1616,7 @@ void force_sig(int sig)
> > >  
> > >  	clear_siginfo(&info);
> > >  	info.si_signo = sig;
> > > -	info.si_errno = 0;
> > >  	info.si_code = SI_KERNEL;
> > > -	info.si_pid = 0;
> > > -	info.si_uid = 0;
> > >  	force_sig_info(&info);
> > >  }
> > >  EXPORT_SYMBOL(force_sig);
> > > @@ -1659,7 +1649,6 @@ int force_sig_fault_to_task(int sig, int code, void __user *addr
> > >  
> > >  	clear_siginfo(&info);
> > >  	info.si_signo = sig;
> > > -	info.si_errno = 0;
> > >  	info.si_code  = code;
> > >  	info.si_addr  = addr;
> > >  #ifdef __ARCH_SI_TRAPNO
> > > @@ -1691,7 +1680,6 @@ int send_sig_fault(int sig, int code, void __user *addr
> > >  
> > >  	clear_siginfo(&info);
> > >  	info.si_signo = sig;
> > > -	info.si_errno = 0;
> > >  	info.si_code  = code;
> > >  	info.si_addr  = addr;
> > >  #ifdef __ARCH_SI_TRAPNO
> > > @@ -1712,7 +1700,6 @@ int force_sig_mceerr(int code, void __user *addr, short lsb)
> > >  	WARN_ON((code != BUS_MCEERR_AO) && (code != BUS_MCEERR_AR));
> > >  	clear_siginfo(&info);
> > >  	info.si_signo = SIGBUS;
> > > -	info.si_errno = 0;
> > >  	info.si_code = code;
> > >  	info.si_addr = addr;
> > >  	info.si_addr_lsb = lsb;
> > > @@ -1726,7 +1713,6 @@ int send_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *
> > >  	WARN_ON((code != BUS_MCEERR_AO) && (code != BUS_MCEERR_AR));
> > >  	clear_siginfo(&info);
> > >  	info.si_signo = SIGBUS;
> > > -	info.si_errno = 0;
> > >  	info.si_code = code;
> > >  	info.si_addr = addr;
> > >  	info.si_addr_lsb = lsb;
> > > @@ -1740,7 +1726,6 @@ int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper)
> > >  
> > >  	clear_siginfo(&info);
> > >  	info.si_signo = SIGSEGV;
> > > -	info.si_errno = 0;
> > >  	info.si_code  = SEGV_BNDERR;
> > >  	info.si_addr  = addr;
> > >  	info.si_lower = lower;
> > > @@ -1755,7 +1740,6 @@ int force_sig_pkuerr(void __user *addr, u32 pkey)
> > >  
> > >  	clear_siginfo(&info);
> > >  	info.si_signo = SIGSEGV;
> > > -	info.si_errno = 0;
> > >  	info.si_code  = SEGV_PKUERR;
> > >  	info.si_addr  = addr;
> > >  	info.si_pkey  = pkey;
> > > @@ -1934,7 +1918,6 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
> > >  
> > >  	clear_siginfo(&info);
> > >  	info.si_signo = sig;
> > > -	info.si_errno = 0;
> > >  	/*
> > >  	 * We are under tasklist_lock here so our parent is tied to
> > >  	 * us and cannot change.
> > > @@ -2033,7 +2016,6 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
> > >  
> > >  	clear_siginfo(&info);
> > >  	info.si_signo = SIGCHLD;
> > > -	info.si_errno = 0;
> > >  	/*
> > >  	 * see comment in do_notify_parent() about the following 4 lines
> > >  	 */
> > > @@ -2506,7 +2488,6 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info)
> > >  	if (signr != info->si_signo) {
> > >  		clear_siginfo(info);
> > >  		info->si_signo = signr;
> > > -		info->si_errno = 0;
> > >  		info->si_code = SI_USER;
> > >  		rcu_read_lock();
> > >  		info->si_pid = task_pid_vnr(current->parent);
> > > @@ -3660,7 +3641,6 @@ static inline void prepare_kill_siginfo(int sig, struct kernel_siginfo *info)
> > >  {
> > >  	clear_siginfo(info);
> > >  	info->si_signo = sig;
> > > -	info->si_errno = 0;
> > >  	info->si_code = SI_USER;
> > >  	info->si_pid = task_tgid_vnr(current);
> > >  	info->si_uid = from_kuid_munged(current_user_ns(), current_uid());
> > > @@ -3833,7 +3813,6 @@ static int do_tkill(pid_t tgid, pid_t pid, int sig)
> > >  
> > >  	clear_siginfo(&info);
> > >  	info.si_signo = sig;
> > > -	info.si_errno = 0;
> > >  	info.si_code = SI_TKILL;
> > >  	info.si_pid = task_tgid_vnr(current);
> > >  	info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
> > > -- 
> > > 2.26.2
> > > 
> > 
