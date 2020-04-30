Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309401BF76A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 13:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgD3L7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 07:59:13 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:50454 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgD3L7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:59:12 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jU7qR-0001jj-Tt; Thu, 30 Apr 2020 05:59:11 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jU7qR-000741-05; Thu, 30 Apr 2020 05:59:11 -0600
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
Date:   Thu, 30 Apr 2020 06:55:54 -0500
In-Reply-To: <87h7x142an.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 30 Apr 2020 06:54:08 -0500")
Message-ID: <87bln9427p.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jU7qR-000741-05;;;mid=<87bln9427p.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19n9Eti+w+LK2E89w42H49+N0x3I54SVB0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_TooManySym_02,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;LKML <linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 371 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (3.2%), b_tie_ro: 10 (2.8%), parse: 1.44
        (0.4%), extract_message_metadata: 13 (3.6%), get_uri_detail_list: 2.4
        (0.6%), tests_pri_-1000: 13 (3.4%), tests_pri_-950: 1.24 (0.3%),
        tests_pri_-900: 0.97 (0.3%), tests_pri_-90: 76 (20.4%), check_bayes:
        74 (19.9%), b_tokenize: 8 (2.1%), b_tok_get_all: 6 (1.6%),
        b_comp_prob: 1.97 (0.5%), b_tok_touch_all: 55 (14.9%), b_finish: 0.84
        (0.2%), tests_pri_0: 241 (65.0%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 2.4 (0.6%), poll_dns_idle: 0.80 (0.2%), tests_pri_10:
        2.6 (0.7%), tests_pri_500: 7 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v1 1/3] posix-cpu-timers: Extend rcu_read_lock removing task_struct references
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Now that the code stores of pid references it is no longer necessary
or desirable to take a reference on task_struct in __get_task_for_clock.

Instead extend the scope of rcu_read_lock and remove the reference
counting on struct task_struct entirely.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/time/posix-cpu-timers.c | 43 ++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index b7f972fb115e..91996dd089a4 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -81,36 +81,36 @@ static struct task_struct *lookup_task(const pid_t pid, bool thread,
 }
 
 static struct task_struct *__get_task_for_clock(const clockid_t clock,
-						bool getref, bool gettime)
+						bool gettime)
 {
 	const bool thread = !!CPUCLOCK_PERTHREAD(clock);
 	const pid_t pid = CPUCLOCK_PID(clock);
-	struct task_struct *p;
 
 	if (CPUCLOCK_WHICH(clock) >= CPUCLOCK_MAX)
 		return NULL;
 
-	rcu_read_lock();
-	p = lookup_task(pid, thread, gettime);
-	if (p && getref)
-		get_task_struct(p);
-	rcu_read_unlock();
-	return p;
+	return lookup_task(pid, thread, gettime);
 }
 
 static inline struct task_struct *get_task_for_clock(const clockid_t clock)
 {
-	return __get_task_for_clock(clock, true, false);
+	return __get_task_for_clock(clock, false);
 }
 
 static inline struct task_struct *get_task_for_clock_get(const clockid_t clock)
 {
-	return __get_task_for_clock(clock, true, true);
+	return __get_task_for_clock(clock, true);
 }
 
 static inline int validate_clock_permissions(const clockid_t clock)
 {
-	return __get_task_for_clock(clock, false, false) ? 0 : -EINVAL;
+	int ret;
+
+	rcu_read_lock();
+	ret = __get_task_for_clock(clock, false) ? 0 : -EINVAL;
+	rcu_read_unlock();
+
+	return ret;
 }
 
 static inline enum pid_type cpu_timer_pid_type(struct k_itimer *timer)
@@ -368,15 +368,18 @@ static int posix_cpu_clock_get(const clockid_t clock, struct timespec64 *tp)
 	struct task_struct *tsk;
 	u64 t;
 
+	rcu_read_lock();
 	tsk = get_task_for_clock_get(clock);
-	if (!tsk)
+	if (!tsk) {
+		rcu_read_unlock();
 		return -EINVAL;
+	}
 
 	if (CPUCLOCK_PERTHREAD(clock))
 		t = cpu_clock_sample(clkid, tsk);
 	else
 		t = cpu_clock_sample_group(clkid, tsk, false);
-	put_task_struct(tsk);
+	rcu_read_unlock();
 
 	*tp = ns_to_timespec64(t);
 	return 0;
@@ -389,19 +392,19 @@ static int posix_cpu_clock_get(const clockid_t clock, struct timespec64 *tp)
  */
 static int posix_cpu_timer_create(struct k_itimer *new_timer)
 {
-	struct task_struct *p = get_task_for_clock(new_timer->it_clock);
+	struct task_struct *p;
 
-	if (!p)
+	rcu_read_lock();
+	p = get_task_for_clock(new_timer->it_clock);
+	if (!p) {
+		rcu_read_unlock();
 		return -EINVAL;
+	}
 
 	new_timer->kclock = &clock_posix_cpu;
 	timerqueue_init(&new_timer->it.cpu.node);
 	new_timer->it.cpu.pid = get_task_pid(p, cpu_timer_pid_type(new_timer));
-	/*
-	 * get_task_for_clock() took a reference on @p. Drop it as the timer
-	 * holds a reference on the pid of @p.
-	 */
-	put_task_struct(p);
+	rcu_read_unlock();
 	return 0;
 }
 
-- 
2.25.0

