Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16991B12A2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 19:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgDTRIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 13:08:47 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:55242 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgDTRIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:08:46 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jQZuW-0000iW-C8; Mon, 20 Apr 2020 11:08:44 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jQZuV-0000LB-BN; Mon, 20 Apr 2020 11:08:44 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     linux-kernel@vger.kernel.org
Cc:     Christof Meerwald <cmeerw@cmeerw.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <20200419201336.GI22017@edge.cmeerw.net>
Date:   Mon, 20 Apr 2020 12:05:38 -0500
In-Reply-To: <20200419201336.GI22017@edge.cmeerw.net> (Christof Meerwald's
        message of "Sun, 19 Apr 2020 22:13:36 +0200")
Message-ID: <87sggyytnh.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jQZuV-0000LB-BN;;;mid=<87sggyytnh.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+ZpZqqqjLt+ygusWJr5B44stKiUvd5wvA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,LotsOfNums_01,
        T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 649 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (1.6%), b_tie_ro: 9 (1.4%), parse: 1.03 (0.2%),
         extract_message_metadata: 16 (2.4%), get_uri_detail_list: 3.5 (0.5%),
        tests_pri_-1000: 14 (2.2%), tests_pri_-950: 1.21 (0.2%),
        tests_pri_-900: 0.94 (0.1%), tests_pri_-90: 157 (24.3%), check_bayes:
        156 (24.0%), b_tokenize: 12 (1.9%), b_tok_get_all: 59 (9.1%),
        b_comp_prob: 3.9 (0.6%), b_tok_touch_all: 76 (11.8%), b_finish: 0.91
        (0.1%), tests_pri_0: 437 (67.4%), check_dkim_signature: 0.72 (0.1%),
        check_dkim_adsp: 1.83 (0.3%), poll_dns_idle: 0.44 (0.1%),
        tests_pri_10: 1.90 (0.3%), tests_pri_500: 6 (1.0%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH] signal: Avoid corrupting si_pid and si_uid in do_notify_parent
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christof Meerwald <cmeerw@cmeerw.org> writes:
> Hi,
>
> this is probably related to commit
> 7a0cf094944e2540758b7f957eb6846d5126f535 (signal: Correct namespace
> fixups of si_pid and si_uid).
>
> With a 5.6.5 kernel I am seeing SIGCHLD signals that don't include a
> properly set si_pid field - this seems to happen for multi-threaded
> child processes.
>
> A simple test program (based on the sample from the signalfd man page):
>
> #include <sys/signalfd.h>
> #include <signal.h>
> #include <unistd.h>
> #include <spawn.h>
> #include <stdlib.h>
> #include <stdio.h>
>
> #define handle_error(msg) \
>     do { perror(msg); exit(EXIT_FAILURE); } while (0)
>
> int main(int argc, char *argv[])
> {
>   sigset_t mask;
>   int sfd;
>   struct signalfd_siginfo fdsi;
>   ssize_t s;
>
>   sigemptyset(&mask);
>   sigaddset(&mask, SIGCHLD);
>
>   if (sigprocmask(SIG_BLOCK, &mask, NULL) == -1)
>     handle_error("sigprocmask");
>
>   pid_t chldpid;
>   char *chldargv[] = { "./sfdclient", NULL };
>   posix_spawn(&chldpid, "./sfdclient", NULL, NULL, chldargv, NULL);
>
>   sfd = signalfd(-1, &mask, 0);
>   if (sfd == -1)
>     handle_error("signalfd");
>
>   for (;;) {
>     s = read(sfd, &fdsi, sizeof(struct signalfd_siginfo));
>     if (s != sizeof(struct signalfd_siginfo))
>       handle_error("read");
>
>     if (fdsi.ssi_signo == SIGCHLD) {
>       printf("Got SIGCHLD %d %d %d %d\n",
>           fdsi.ssi_status, fdsi.ssi_code,
>           fdsi.ssi_uid, fdsi.ssi_pid);
>       return 0;
>     } else {
>       printf("Read unexpected signal\n");
>     }
>   }
> }
>
>
> and a multi-threaded client to test with:
>
> #include <unistd.h>
> #include <pthread.h>
>
> void *f(void *arg)
> {
>   sleep(100);
> }
>
> int main()
> {
>   pthread_t t[8];
>
>   for (int i = 0; i != 8; ++i)
>   {
>     pthread_create(&t[i], NULL, f, NULL);
>   }
> }
>
> I tried to do a bit of debugging and what seems to be happening is
> that
>
>   /* From an ancestor pid namespace? */
>   if (!task_pid_nr_ns(current, task_active_pid_ns(t))) {
>
> fails inside task_pid_nr_ns because the check for "pid_alive" fails.
>
> This code seems to be called from do_notify_parent and there we
> actually have "tsk != current" (I am assuming both are threads of the
> current process?)

I instrumented the code with a warning and received the following backtrace:
> WARNING: CPU: 0 PID: 777 at kernel/pid.c:501 __task_pid_nr_ns.cold.6+0xc/0x15
> Modules linked in:
> CPU: 0 PID: 777 Comm: sfdclient Not tainted 5.7.0-rc1userns+ #2924
> Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> RIP: 0010:__task_pid_nr_ns.cold.6+0xc/0x15
> Code: ff 66 90 48 83 ec 08 89 7c 24 04 48 8d 7e 08 48 8d 74 24 04 e8 9a b6 44 00 48 83 c4 08 c3 48 c7 c7 59 9f ac 82 e8 c2 c4 04 00 <0f> 0b e9 3fd
> RSP: 0018:ffffc9000042fbf8 EFLAGS: 00010046
> RAX: 000000000000000c RBX: 0000000000000000 RCX: ffffc9000042faf4
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff81193d29
> RBP: ffffc9000042fc18 R08: 0000000000000000 R09: 0000000000000001
> R10: 000000100f938416 R11: 0000000000000309 R12: ffff8880b941c140
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880b941c140
> FS:  0000000000000000(0000) GS:ffff8880bca00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f2e8c0a32e0 CR3: 0000000002e10000 CR4: 00000000000006f0
> Call Trace:
>  send_signal+0x1c8/0x310
>  do_notify_parent+0x50f/0x550
>  release_task.part.21+0x4fd/0x620
>  do_exit+0x6f6/0xaf0
>  do_group_exit+0x42/0xb0
>  get_signal+0x13b/0xbb0
>  do_signal+0x2b/0x670
>  ? __audit_syscall_exit+0x24d/0x2b0
>  ? rcu_read_lock_sched_held+0x4d/0x60
>  ? kfree+0x24c/0x2b0
>  do_syscall_64+0x176/0x640
>  ? trace_hardirqs_off_thunk+0x1a/0x1c
>  entry_SYSCALL_64_after_hwframe+0x49/0xb3

The immediate problem is as Christof noticed that "pid_alive(current) == false".
This happens because do_notify_parent is called from the last thread to exit
in a process after that thread has been reaped.

The bigger issue is that do_notify_parent can be called from any
process that manages to wait on a thread of a multi-threaded process
from wait_task_zombie.  So any logic based upon current for
do_notify_parent is just nonsense, as current can be pretty much
anything.

So change do_notify_parent to call __send_signal directly.

Inspecting the code it appears this problem has existed since the pid
namespace support started handling this case in 2.6.30.  This fix only
backports to 7a0cf094944e ("signal: Correct namespace fixups of si_pid and si_uid")
where the problem logic was moved out of __send_signal and into send_signal.

Cc: stable@vger.kernel.org
Fixes: 6588c1e3ff01 ("signals: SI_USER: Masquerade si_pid when crossing pid ns boundary
Ref: 921cf9f63089 ("signals: protect cinit from unblocked SIG_DFL signals")
Link: https://lore.kernel.org/lkml/20200419201336.GI22017@edge.cmeerw.net/
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

Unless someone has an objection I will apply this one and send it to
Linus.

 kernel/signal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 9899c5f91ee1..a88a89422227 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1993,8 +1993,12 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 		if (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN)
 			sig = 0;
 	}
+	/*
+	 * Bypass send_signal as the si_pid and si_uid values have
+	 * been generated in the parent's namespaces.
+	 */
 	if (valid_signal(sig) && sig)
-		__group_send_sig_info(sig, &info, tsk->parent);
+		__send_signal(sig, &info, tsk->parent, PIDTYPE_TGID, false);
 	__wake_up_parent(tsk, tsk->parent);
 	spin_unlock_irqrestore(&psig->siglock, flags);
 
-- 
2.20.1

