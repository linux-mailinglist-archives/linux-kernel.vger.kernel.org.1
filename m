Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35501228111
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 15:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgGUNiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 09:38:01 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:35670 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgGUNiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:38:01 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jxsT1-0008VP-GH; Tue, 21 Jul 2020 07:37:59 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jxsSz-00010q-Fy; Tue, 21 Jul 2020 07:37:59 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christoph Hellwig <hch@lst.de>
Cc:     akpm@linux-foundation.org, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org
References: <20200721130449.5008-1-hch@lst.de>
Date:   Tue, 21 Jul 2020 08:35:00 -0500
In-Reply-To: <20200721130449.5008-1-hch@lst.de> (Christoph Hellwig's message
        of "Tue, 21 Jul 2020 15:04:49 +0200")
Message-ID: <87eep5ng8r.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jxsSz-00010q-Fy;;;mid=<87eep5ng8r.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/2DM0dlThUoCuTHrfp3jCy5tEe/n0ohBk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa03 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Christoph Hellwig <hch@lst.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1627 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 4.3 (0.3%), b_tie_ro: 2.9 (0.2%), parse: 1.14
        (0.1%), extract_message_metadata: 15 (0.9%), get_uri_detail_list: 2.8
        (0.2%), tests_pri_-1000: 11 (0.7%), tests_pri_-950: 0.96 (0.1%),
        tests_pri_-900: 0.81 (0.1%), tests_pri_-90: 104 (6.4%), check_bayes:
        103 (6.3%), b_tokenize: 7 (0.4%), b_tok_get_all: 7 (0.4%),
        b_comp_prob: 1.68 (0.1%), b_tok_touch_all: 84 (5.2%), b_finish: 0.72
        (0.0%), tests_pri_0: 264 (16.2%), check_dkim_signature: 0.40 (0.0%),
        check_dkim_adsp: 3.2 (0.2%), poll_dns_idle: 1209 (74.3%),
        tests_pri_10: 2.2 (0.1%), tests_pri_500: 1220 (75.0%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH] kernel: add a kernel_wait helper
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> Add a helper that waits for a pid and stores the status in the passed
> in kernel pointer.  Use it to fix the usage of kernel_wait4 in
> call_usermodehelper_exec_sync that only happens to work due to the
> implicit set_fs(KERNEL_DS) for kernel threads.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/sched/task.h |  1 +
>  kernel/exit.c              | 16 ++++++++++++++++
>  kernel/umh.c               | 29 ++++-------------------------
>  3 files changed, 21 insertions(+), 25 deletions(-)
>
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 38359071236ad7..a80007df396e95 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -102,6 +102,7 @@ struct task_struct *fork_idle(int);
>  struct mm_struct *copy_init_mm(void);
>  extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
>  extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
> +int kernel_wait(pid_t pid, int *stat);
>  
>  extern void free_task(struct task_struct *tsk);
>  
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 727150f2810338..fd598846df0b17 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1626,6 +1626,22 @@ long kernel_wait4(pid_t upid, int __user *stat_addr, int options,
>  	return ret;
>  }
>  
> +int kernel_wait(pid_t pid, int *stat)
> +{
> +	struct wait_opts wo = {
> +		.wo_type	= PIDTYPE_PID,
> +		.wo_pid		= find_get_pid(pid),
> +		.wo_flags	= WEXITED,
> +	};
> +	int ret;
> +
> +	ret = do_wait(&wo);
> +	if (ret > 0 && wo.wo_stat)
> +		*stat = wo.wo_stat;
> +	put_pid(wo.wo_pid);
> +	return ret;
> +}
> +
>  SYSCALL_DEFINE4(wait4, pid_t, upid, int __user *, stat_addr,
>  		int, options, struct rusage __user *, ru)
>  {
> diff --git a/kernel/umh.c b/kernel/umh.c
> index 79f139a7ca03c6..733430921f47d7 100644
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -130,37 +130,16 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
>  {
>  	pid_t pid;
>  
> -	/* If SIGCLD is ignored kernel_wait4 won't populate the status. */
> +	/* If SIGCLD is ignored do_wait won't populate the status. */
>  	kernel_sigaction(SIGCHLD, SIG_DFL);
>  	pid = kernel_thread(call_usermodehelper_exec_async, sub_info, SIGCHLD);
> -	if (pid < 0) {
> +	if (pid < 0)
>  		sub_info->retval = pid;
> -	} else {
> -		int ret = -ECHILD;
> -		/*
> -		 * Normally it is bogus to call wait4() from in-kernel because
> -		 * wait4() wants to write the exit code to a userspace address.
> -		 * But call_usermodehelper_exec_sync() always runs as kernel
> -		 * thread (workqueue) and put_user() to a kernel address works
> -		 * OK for kernel threads, due to their having an mm_segment_t
> -		 * which spans the entire address space.
> -		 *
> -		 * Thus the __user pointer cast is valid here.
> -		 */
> -		kernel_wait4(pid, (int __user *)&ret, 0, NULL);
> -
> -		/*
> -		 * If ret is 0, either call_usermodehelper_exec_async failed and
> -		 * the real error code is already in sub_info->retval or
> -		 * sub_info->retval is 0 anyway, so don't mess with it then.
> -		 */
> -		if (ret)
> -			sub_info->retval = ret;
> -	}
> +	else
> +		kernel_wait(pid, &sub_info->retval);
>  
>  	/* Restore default kernel sig handler */
>  	kernel_sigaction(SIGCHLD, SIG_IGN);
> -
>  	umh_complete(sub_info);
>  }
