Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC5E1BF76C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 13:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgD3L7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 07:59:46 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:50538 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgD3L7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:59:45 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jU7qy-0001l8-Tv; Thu, 30 Apr 2020 05:59:44 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jU7qy-0007Wn-5m; Thu, 30 Apr 2020 05:59:44 -0600
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
Date:   Thu, 30 Apr 2020 06:56:28 -0500
In-Reply-To: <87h7x142an.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 30 Apr 2020 06:54:08 -0500")
Message-ID: <875zdh426r.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jU7qy-0007Wn-5m;;;mid=<875zdh426r.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19HLsccwhFJXOlRwNOyYmx/CctvQuMRiKU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_TooManySym_02,XMGappySubj_01,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;LKML <linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 312 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (3.3%), b_tie_ro: 9 (2.9%), parse: 0.93 (0.3%),
         extract_message_metadata: 11 (3.6%), get_uri_detail_list: 1.22 (0.4%),
         tests_pri_-1000: 13 (4.2%), tests_pri_-950: 1.36 (0.4%),
        tests_pri_-900: 1.03 (0.3%), tests_pri_-90: 62 (19.7%), check_bayes:
        60 (19.2%), b_tokenize: 6 (1.9%), b_tok_get_all: 5.0 (1.6%),
        b_comp_prob: 1.70 (0.5%), b_tok_touch_all: 44 (14.2%), b_finish: 0.91
        (0.3%), tests_pri_0: 200 (63.9%), check_dkim_signature: 0.58 (0.2%),
        check_dkim_adsp: 2.8 (0.9%), poll_dns_idle: 1.09 (0.3%), tests_pri_10:
        2.2 (0.7%), tests_pri_500: 8 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v1 2/3] posix-cpu-timers: Replace cpu_timer_pid_type with clock_pid_type
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Taking a clock and returning a pid_type is a more general and
a superset of taking a timer and returning a pid_type.

Perform this generalization so that future changes may use
this code on clocks as well as timers.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/time/posix-cpu-timers.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 91996dd089a4..42f673974d71 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -113,14 +113,14 @@ static inline int validate_clock_permissions(const clockid_t clock)
 	return ret;
 }
 
-static inline enum pid_type cpu_timer_pid_type(struct k_itimer *timer)
+static inline enum pid_type clock_pid_type(const clockid_t clock)
 {
-	return CPUCLOCK_PERTHREAD(timer->it_clock) ? PIDTYPE_PID : PIDTYPE_TGID;
+	return CPUCLOCK_PERTHREAD(clock) ? PIDTYPE_PID : PIDTYPE_TGID;
 }
 
 static inline struct task_struct *cpu_timer_task_rcu(struct k_itimer *timer)
 {
-	return pid_task(timer->it.cpu.pid, cpu_timer_pid_type(timer));
+	return pid_task(timer->it.cpu.pid, clock_pid_type(timer->it_clock));
 }
 
 /*
@@ -403,7 +403,7 @@ static int posix_cpu_timer_create(struct k_itimer *new_timer)
 
 	new_timer->kclock = &clock_posix_cpu;
 	timerqueue_init(&new_timer->it.cpu.node);
-	new_timer->it.cpu.pid = get_task_pid(p, cpu_timer_pid_type(new_timer));
+	new_timer->it.cpu.pid = get_task_pid(p, clock_pid_type(new_timer->it_clock));
 	rcu_read_unlock();
 	return 0;
 }
-- 
2.25.0

