Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19862DDBF3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 00:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbgLQXk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 18:40:56 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:60984 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbgLQXk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 18:40:56 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kq2sY-0044T9-4e; Thu, 17 Dec 2020 16:40:14 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kq2sX-0005I7-4C; Thu, 17 Dec 2020 16:40:13 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simon.marchi@efficios.com>,
        linux-kernel@vger.kernel.org
References: <20201217142931.GA8865@redhat.com>
Date:   Thu, 17 Dec 2020 17:39:25 -0600
In-Reply-To: <20201217142931.GA8865@redhat.com> (Oleg Nesterov's message of
        "Thu, 17 Dec 2020 15:29:31 +0100")
Message-ID: <875z50roia.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kq2sX-0005I7-4C;;;mid=<875z50roia.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18qbH29e3tFi1eaHW9H8LdYmZDAzgCjEVU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 556 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 4.2 (0.7%), b_tie_ro: 2.9 (0.5%), parse: 1.30
        (0.2%), extract_message_metadata: 12 (2.2%), get_uri_detail_list: 4.2
        (0.8%), tests_pri_-1000: 11 (1.9%), tests_pri_-950: 1.05 (0.2%),
        tests_pri_-900: 0.79 (0.1%), tests_pri_-90: 102 (18.3%), check_bayes:
        100 (18.0%), b_tokenize: 10 (1.7%), b_tok_get_all: 10 (1.8%),
        b_comp_prob: 2.5 (0.5%), b_tok_touch_all: 75 (13.4%), b_finish: 0.77
        (0.1%), tests_pri_0: 412 (74.0%), check_dkim_signature: 0.71 (0.1%),
        check_dkim_adsp: 3.7 (0.7%), poll_dns_idle: 1.65 (0.3%), tests_pri_10:
        2.6 (0.5%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH] ptrace: make ptrace() fail if the tracee changed its pid unexpectedly
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> Suppose we have 2 threads, the group-leader L and a sub-theread T,
> both parked in ptrace_stop(). Debugger tries to resume both threads
> and does
>
> 	ptrace(PTRACE_CONT, T);
> 	ptrace(PTRACE_CONT, L);
>
> If the sub-thread T execs in between, the 2nd PTRACE_CONT doesn not
> resume the old leader L, it resumes the post-exec thread T which was
> actually now stopped in PTHREAD_EVENT_EXEC. In this case the
> PTHREAD_EVENT_EXEC event is lost, and the tracer can't know that the
> tracee changed its pid.

The change seems sensible.  I don't expect this is common but it looks
painful to deal with if it happens.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

I am wondering if this should be expanded to all ptrace types for
consistency.  Or maybe we should set a flag to make this happen for
all ptrace events.

It just seems really odd to only worry about missing this event.
I admit this a threaded PTRACE_EVENT_EXEC is the only event we are
likely to miss but still.

Do you by any chance have any debugger/strace test cases?

I would think that would be the way to test to see if this breaks
anything.  I think I remember strace having a good test suite.

> This patch makes ptrace() fail in this case until debugger does wait()
> and consumes PTHREAD_EVENT_EXEC which reports old_pid. This affects all
> ptrace requests except the "asynchronous" PTRACE_INTERRUPT/KILL.
>
> The patch doesn't add the new PTRACE_ option to not complicate the API,
> and I _hope_ this won't cause any noticeable regression:
>
> 	- If debugger uses PTRACE_O_TRACEEXEC and the thread did an exec
> 	  and the tracer does a ptrace request without having consumed
> 	  the exec event, it's 100% sure that the thread the ptracer
> 	  thinks it is targeting does not exist anymore, or isn't the
> 	  same as the one it thinks it is targeting.
>
> 	- To some degree this patch adds nothing new. In the scenario
> 	  above ptrace(L) can fail with -ESRCH if it is called after the
> 	  execing sub-thread wakes the leader up and before it "steals"
> 	  the leader's pid.
>
> Test-case:
>
> 	#include <stdio.h>
> 	#include <unistd.h>
> 	#include <signal.h>
> 	#include <sys/ptrace.h>
> 	#include <sys/wait.h>
> 	#include <errno.h>
> 	#include <pthread.h>
> 	#include <assert.h>
>
> 	void *tf(void *arg)
> 	{
> 		execve("/usr/bin/true", NULL, NULL);
> 		assert(0);
>
> 		return NULL;
> 	}
>
> 	int main(void)
> 	{
> 		int leader = fork();
> 		if (!leader) {
> 			kill(getpid(), SIGSTOP);
>
> 			pthread_t th;
> 			pthread_create(&th, NULL, tf, NULL);
> 			for (;;)
> 				pause();
>
> 			return 0;
> 		}
>
> 		waitpid(leader, NULL, WSTOPPED);
>
> 		ptrace(PTRACE_SEIZE, leader, 0,
> 				PTRACE_O_TRACECLONE | PTRACE_O_TRACEEXEC);
> 		waitpid(leader, NULL, 0);
>
> 		ptrace(PTRACE_CONT, leader, 0,0);
> 		waitpid(leader, NULL, 0);
>
> 		int status, thread = waitpid(-1, &status, 0);
> 		assert(thread > 0 && thread != leader);
> 		assert(status == 0x80137f);
>
> 		ptrace(PTRACE_CONT, thread, 0,0);
> 		/*
> 		 * waitid() because waitpid(leader, &status, WNOWAIT) does not
> 		 * report status. Why ????
> 		 *
> 		 * Why WEXITED? because we have another kernel problem connected
> 		 * to mt-exec.
> 		 */
> 		siginfo_t info;
> 		assert(waitid(P_PID, leader, &info, WSTOPPED|WEXITED|WNOWAIT) == 0);
> 		assert(info.si_pid == leader && info.si_status == 0x0405);
>
> 		/* OK, it sleeps in ptrace(PTRACE_EVENT_EXEC == 0x04) */
> 		assert(ptrace(PTRACE_CONT, leader, 0,0) == -1);
> 		assert(errno == ESRCH);
>
> 		assert(leader == waitpid(leader, &status, WNOHANG));
> 		assert(status == 0x04057f);
>
> 		assert(ptrace(PTRACE_CONT, leader, 0,0) == 0);
>
> 		return 0;
> 	}
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/ptrace.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 43d6179508d6..1037251ae4a5 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -169,6 +169,27 @@ void __ptrace_unlink(struct task_struct *child)
>  	spin_unlock(&child->sighand->siglock);
>  }
>  
> +static bool looks_like_a_spurious_pid(struct task_struct *task)
> +{
> +	int pid;
> +
> +	if (task->exit_code != ((PTRACE_EVENT_EXEC << 8) | SIGTRAP))
> +		return false;
> +
> +	rcu_read_lock();
> +	pid = task_pid_nr_ns(task, task_active_pid_ns(task->parent));
> +	rcu_read_unlock();
> +
> +	if (pid == task->ptrace_message)
> +		return false;
> +	/*
> +	 * The tracee changed its pid but the PTRACE_EVENT_EXEC event
> +	 * was not wait()'ed, most probably debugger targets the old
> +	 * leader which was destroyed in de_thread().
> +	 */
> +	return true;
> +}
> +
>  /* Ensure that nothing can wake it up, even SIGKILL */
>  static bool ptrace_freeze_traced(struct task_struct *task)
>  {
> @@ -179,7 +200,8 @@ static bool ptrace_freeze_traced(struct task_struct *task)
>  		return ret;
>  
>  	spin_lock_irq(&task->sighand->siglock);
> -	if (task_is_traced(task) && !__fatal_signal_pending(task)) {
> +	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
> +	    !__fatal_signal_pending(task)) {
>  		task->state = __TASK_TRACED;
>  		ret = true;
>  	}

Eric
