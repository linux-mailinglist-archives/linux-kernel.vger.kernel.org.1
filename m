Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098502DFFF6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgLUShc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:37:32 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:50908 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgLUShb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:37:31 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1krQ37-00C2Jc-Ax; Mon, 21 Dec 2020 11:36:49 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1krQ36-0004iN-7W; Mon, 21 Dec 2020 11:36:49 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Leesoo Ahn <dev@ooseel.net>
Cc:     linux-kernel@vger.kernel.org, Leesoo Ahn <lsahn@ooseel.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Peter Collingbourne <pcc@google.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>
References: <20201220074555.12655-1-lsahn@ooseel.net>
Date:   Mon, 21 Dec 2020 12:36:07 -0600
In-Reply-To: <20201220074555.12655-1-lsahn@ooseel.net> (Leesoo Ahn's message
        of "Sun, 20 Dec 2020 16:45:54 +0900")
Message-ID: <87czz3qa5k.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1krQ36-0004iN-7W;;;mid=<87czz3qa5k.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+utS313e8S6Cx/5DSUz1JC8zXdjXs1Kho=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Leesoo Ahn <dev@ooseel.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 721 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.3 (0.6%), b_tie_ro: 2.9 (0.4%), parse: 1.30
        (0.2%), extract_message_metadata: 13 (1.8%), get_uri_detail_list: 4.3
        (0.6%), tests_pri_-1000: 4.6 (0.6%), tests_pri_-950: 1.66 (0.2%),
        tests_pri_-900: 1.32 (0.2%), tests_pri_-90: 276 (38.3%), check_bayes:
        268 (37.1%), b_tokenize: 12 (1.6%), b_tok_get_all: 10 (1.4%),
        b_comp_prob: 2.4 (0.3%), b_tok_touch_all: 240 (33.3%), b_finish: 0.72
        (0.1%), tests_pri_0: 408 (56.5%), check_dkim_signature: 0.45 (0.1%),
        check_dkim_adsp: 2.1 (0.3%), poll_dns_idle: 0.80 (0.1%), tests_pri_10:
        1.76 (0.2%), tests_pri_500: 6 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal: Don't init struct kernel_siginfo fields to zero again
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leesoo Ahn <dev@ooseel.net> writes:

> clear_siginfo() is responsible for clearing struct kernel_siginfo object.
> It's obvious that manually initializing those fields is needless as
> a commit[1] explains why the function introduced and its guarantee that
> all bits in the struct are cleared after it.

The fields that are explicitly set to zero are fields that must be zero.
Not fields whose value should default to zero.

Given how difficult it is to keep track of which fields are relevant
in struct siginfo.  I prefer the explicit approach that currently
exists.  Especially as the compiler appears smart enough to optimize
through this.

Mostly I am being touchy and conservative because getting all of these
fields set properly took me several kernel development cycles, and
before that there were bugs in setting those fields that persisted for
decades.

I think the current form allows someone to glance at the entry and see
that a field like si_errno is present and set to 0.  With you your
suggested change someone needs to walk through the definition of the
union and see which union member is being invoked to see which fields
are present, to see if si_errno even exists, before it is possible
to see that si_errno is 0.

So unless there is a reason more compelling than a few less lines of
code let's keep it this way for now.

Eric


> [1]: commit 8c5dbf2ae00b ("signal: Introduce clear_siginfo")
>
> Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
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
