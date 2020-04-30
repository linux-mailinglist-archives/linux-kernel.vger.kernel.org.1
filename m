Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58E11BF74A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 13:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgD3L52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 07:57:28 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:50136 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgD3L52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:57:28 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jU7ok-0001YZ-9E; Thu, 30 Apr 2020 05:57:26 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jU7oj-0006ms-9J; Thu, 30 Apr 2020 05:57:26 -0600
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
Date:   Thu, 30 Apr 2020 06:54:08 -0500
In-Reply-To: <87mu6v70in.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 28 Apr 2020 16:39:44 -0500")
Message-ID: <87h7x142an.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jU7oj-0006ms-9J;;;mid=<87h7x142an.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX192GiFafHOXLspxUPv1pRaacxDAcMcpddE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;LKML <linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 369 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.5 (1.2%), b_tie_ro: 3.0 (0.8%), parse: 1.08
        (0.3%), extract_message_metadata: 11 (2.9%), get_uri_detail_list: 1.10
        (0.3%), tests_pri_-1000: 11 (3.0%), tests_pri_-950: 0.99 (0.3%),
        tests_pri_-900: 0.80 (0.2%), tests_pri_-90: 171 (46.3%), check_bayes:
        169 (45.9%), b_tokenize: 4.1 (1.1%), b_tok_get_all: 119 (32.3%),
        b_comp_prob: 2.2 (0.6%), b_tok_touch_all: 41 (11.1%), b_finish: 0.76
        (0.2%), tests_pri_0: 158 (42.8%), check_dkim_signature: 0.38 (0.1%),
        check_dkim_adsp: 4.4 (1.2%), poll_dns_idle: 1.15 (0.3%), tests_pri_10:
        2.2 (0.6%), tests_pri_500: 6 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v1 0/3] posix-cpu-timers: Use pids not tasks in lookup
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The current posix-cpu-timer code uses pids when holding persistent
references in timers.  However the lookups from clockid_t still return
tasks that need to be converted into pids for use.

This results in usage being pid->task->pid and that can race with
release_task and de_thread.  This can lead to some not wrong but
surprising results.  Surprising enough that Oleg and I both thought
there were some bugs in the code for a while.

This set of changes modifies the code to just lookup, verify, and return
pids from the clockid_t lookups to remove those potentialy troublesome
races.

Eric W. Biederman (3):
      posix-cpu-timers: Extend rcu_read_lock removing task_struct references
      posix-cpu-timers: Replace cpu_timer_pid_type with clock_pid_type
      posix-cpu-timers: Replace __get_task_for_clock with pid_for_clock

 kernel/time/posix-cpu-timers.c | 102 ++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 57 deletions(-)

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

---

The changes can also be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git proc-testing

