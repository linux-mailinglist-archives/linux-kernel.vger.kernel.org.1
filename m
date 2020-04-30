Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C231BF78B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 14:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgD3MAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 08:00:19 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50602 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgD3MAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:00:16 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jU7rR-0003bc-RL; Thu, 30 Apr 2020 06:00:13 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jU7rQ-0007cJ-UZ; Thu, 30 Apr 2020 06:00:13 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
        <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
        <20200424173927.GB26802@redhat.com>
        <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
        <875zdmmj4y.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
        <878sihgfzh.fsf@x220.int.ebiederm.org>
        <CAHk-=wjSM9mgsDuX=ZTy2L+S7wGrxZMcBn054As_Jyv8FQvcvQ@mail.gmail.com>
        <87sggnajpv.fsf_-_@x220.int.ebiederm.org>
        <20200428180540.GB29960@redhat.com>
        <87mu6v70in.fsf_-_@x220.int.ebiederm.org>
        <87h7x142an.fsf_-_@x220.int.ebiederm.org>
Date:   Thu, 30 Apr 2020 06:56:56 -0500
In-Reply-To: <87h7x142an.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 30 Apr 2020 06:54:08 -0500")
Message-ID: <87zhat2nlj.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jU7rQ-0007cJ-UZ;;;mid=<87zhat2nlj.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19DC2tmmJ4gPb2uABqQu802b6RlTlRfzTE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMGappySubj_01,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;LKML <linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 520 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 10 (1.9%), b_tie_ro: 9 (1.7%), parse: 1.16 (0.2%),
         extract_message_metadata: 14 (2.6%), get_uri_detail_list: 3.6 (0.7%),
        tests_pri_-1000: 14 (2.7%), tests_pri_-950: 1.35 (0.3%),
        tests_pri_-900: 1.10 (0.2%), tests_pri_-90: 73 (14.1%), check_bayes:
        72 (13.8%), b_tokenize: 13 (2.5%), b_tok_get_all: 11 (2.1%),
        b_comp_prob: 3.1 (0.6%), b_tok_touch_all: 41 (7.9%), b_finish: 0.90
        (0.2%), tests_pri_0: 392 (75.5%), check_dkim_signature: 0.73 (0.1%),
        check_dkim_adsp: 2.3 (0.4%), poll_dns_idle: 0.63 (0.1%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v1 3/3] posix-cpu-timers: Replace __get_task_for_clock with pid_for_clock
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Now that the codes store references to pids instead of referendes to
tasks.  Looking up a task for a clock instead of looking up a struct
pid makes the code more difficult to verify it is correct than
necessary.

In posix_cpu_timers_create get_task_pid can race with release_task for
threads and return a NULL pid.  As put_pid and cpu_timer_task_rcu
handle NULL pids just fine the code works without problems but it is
an extra case to consider and keep in mind while verifying and
modifying the code.

There are races with de_thread to consider that only don't apply
because thread clocks are only allowed for threads in the same
thread_group.

So instead of leaving a burden for people making modification to the
code in the future return a rcu protected struct pid for the clock
instead.

The logic for __get_task_for_pid and lookup_task has been folded into
the new function pid_for_clock with the only change being the logic
has been modified from working on a task to working on a pid that
will be returned.

In posix_cpu_clock_get instead of calling pid_for_clock checking the
result and then calling pid_task to get the task.  The result of
pid_for_clock is fed directly into pid_task.  This is safe because
pid_task handles NULL pids.  As such an extra error check was
unnecessary.

Instead of hiding the flag that enables the special clock_gettime
handling, I have made the 3 callers just pass the flag in themselves.
That is less code and seems just as simple to work with as the
wrapper functions.

Historically the clock_gettime special case of allowing a process
clock to be found by the thread id did not even exist [33ab0fec3352]
but Thomas Gleixner reports that he has found code that uses that
functionality [55e8c8eb2c7b].

Link: https://lkml.kernel.org/r/87zhaxqkwa.fsf@nanos.tec.linutronix.de/
Ref: 33ab0fec3352 ("posix-timers: Consolidate posix_cpu_clock_get()")
Ref: 55e8c8eb2c7b ("posix-cpu-timers: Store a reference to a pid not a task")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/time/posix-cpu-timers.c | 75 ++++++++++++++--------------------
 1 file changed, 30 insertions(+), 45 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 42f673974d71..165117996ea0 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -47,59 +47,44 @@ void update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new)
 /*
  * Functions for validating access to tasks.
  */
-static struct task_struct *lookup_task(const pid_t pid, bool thread,
-				       bool gettime)
+static struct pid *pid_for_clock(const clockid_t clock, bool gettime)
 {
-	struct task_struct *p;
+	const bool thread = !!CPUCLOCK_PERTHREAD(clock);
+	const pid_t upid = CPUCLOCK_PID(clock);
+	struct pid *pid;
+
+	if (CPUCLOCK_WHICH(clock) >= CPUCLOCK_MAX)
+		return NULL;
 
 	/*
 	 * If the encoded PID is 0, then the timer is targeted at current
 	 * or the process to which current belongs.
 	 */
-	if (!pid)
-		return thread ? current : current->group_leader;
+	if (upid == 0)
+		return thread ? task_pid(current) : task_tgid(current);
 
-	p = find_task_by_vpid(pid);
-	if (!p)
-		return p;
+	pid = find_vpid(upid);
+	if (!pid)
+		return NULL;
 
-	if (thread)
-		return same_thread_group(p, current) ? p : NULL;
+	if (thread) {
+		struct task_struct *tsk = pid_task(pid, PIDTYPE_PID);
+		return (tsk && same_thread_group(tsk, current)) ? pid : NULL;
+	}
 
 	/*
-	 * For clock_gettime(PROCESS) the task does not need to be
-	 * the actual group leader. task->signal gives
-	 * access to the group's clock.
+	 * For clock_gettime(PROCESS) allow finding the process by
+	 * with the pid of the current task.  The code needs the tgid
+	 * of the process so that pid_task(pid, PIDTYPE_TGID) can be
+	 * used to find the process.
 	 */
-	if (gettime && (p == current))
-		return p;
+	if (gettime && (pid == task_pid(current)))
+		return task_tgid(current);
 
 	/*
-	 * For processes require that p is group leader.
+	 * For processes require that pid identifies a process.
 	 */
-	return thread_group_leader(p) ? p : NULL;
-}
-
-static struct task_struct *__get_task_for_clock(const clockid_t clock,
-						bool gettime)
-{
-	const bool thread = !!CPUCLOCK_PERTHREAD(clock);
-	const pid_t pid = CPUCLOCK_PID(clock);
-
-	if (CPUCLOCK_WHICH(clock) >= CPUCLOCK_MAX)
-		return NULL;
-
-	return lookup_task(pid, thread, gettime);
-}
-
-static inline struct task_struct *get_task_for_clock(const clockid_t clock)
-{
-	return __get_task_for_clock(clock, false);
-}
-
-static inline struct task_struct *get_task_for_clock_get(const clockid_t clock)
-{
-	return __get_task_for_clock(clock, true);
+	return pid_has_task(pid, PIDTYPE_TGID) ? pid : NULL;
 }
 
 static inline int validate_clock_permissions(const clockid_t clock)
@@ -107,7 +92,7 @@ static inline int validate_clock_permissions(const clockid_t clock)
 	int ret;
 
 	rcu_read_lock();
-	ret = __get_task_for_clock(clock, false) ? 0 : -EINVAL;
+	ret = pid_for_clock(clock, false) ? 0 : -EINVAL;
 	rcu_read_unlock();
 
 	return ret;
@@ -369,7 +354,7 @@ static int posix_cpu_clock_get(const clockid_t clock, struct timespec64 *tp)
 	u64 t;
 
 	rcu_read_lock();
-	tsk = get_task_for_clock_get(clock);
+	tsk = pid_task(pid_for_clock(clock, true), clock_pid_type(clock));
 	if (!tsk) {
 		rcu_read_unlock();
 		return -EINVAL;
@@ -392,18 +377,18 @@ static int posix_cpu_clock_get(const clockid_t clock, struct timespec64 *tp)
  */
 static int posix_cpu_timer_create(struct k_itimer *new_timer)
 {
-	struct task_struct *p;
+	struct pid *pid;
 
 	rcu_read_lock();
-	p = get_task_for_clock(new_timer->it_clock);
-	if (!p) {
+	pid = pid_for_clock(new_timer->it_clock, false);
+	if (!pid) {
 		rcu_read_unlock();
 		return -EINVAL;
 	}
 
 	new_timer->kclock = &clock_posix_cpu;
 	timerqueue_init(&new_timer->it.cpu.node);
-	new_timer->it.cpu.pid = get_task_pid(p, clock_pid_type(new_timer->it_clock));
+	new_timer->it.cpu.pid = get_pid(pid);
 	rcu_read_unlock();
 	return 0;
 }
-- 
2.25.0

