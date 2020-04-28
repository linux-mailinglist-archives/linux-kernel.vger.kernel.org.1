Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A83E1BCF05
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 23:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgD1VnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 17:43:02 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:44202 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgD1VnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:43:01 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTY0K-0004u4-GB; Tue, 28 Apr 2020 15:43:00 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTY0J-00015a-OA; Tue, 28 Apr 2020 15:43:00 -0600
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
Date:   Tue, 28 Apr 2020 16:39:44 -0500
In-Reply-To: <20200428180540.GB29960@redhat.com> (Oleg Nesterov's message of
        "Tue, 28 Apr 2020 20:05:41 +0200")
Message-ID: <87mu6v70in.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jTY0J-00015a-OA;;;mid=<87mu6v70in.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+UtBNkHu4rLIVo9CsZRAkkaksr2Rapk5s=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMGappySubj_01 autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4875]
        *  0.5 XMGappySubj_01 Very gappy subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;LKML <linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 219 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (5.1%), b_tie_ro: 10 (4.4%), parse: 0.79
        (0.4%), extract_message_metadata: 2.4 (1.1%), get_uri_detail_list:
        0.54 (0.2%), tests_pri_-1000: 3.4 (1.6%), tests_pri_-950: 1.31 (0.6%),
        tests_pri_-900: 0.98 (0.4%), tests_pri_-90: 66 (30.2%), check_bayes:
        65 (29.5%), b_tokenize: 4.4 (2.0%), b_tok_get_all: 11 (5.1%),
        b_comp_prob: 1.69 (0.8%), b_tok_touch_all: 44 (20.0%), b_finish: 0.95
        (0.4%), tests_pri_0: 116 (52.8%), check_dkim_signature: 0.49 (0.2%),
        check_dkim_adsp: 2.4 (1.1%), poll_dns_idle: 0.76 (0.3%), tests_pri_10:
        2.7 (1.2%), tests_pri_500: 7 (3.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v1 0/4] signal: Removing has_group_leader_pid
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


With de_thread now calling exchange_tids has_group_leader_pid no longer
makes any sense and is equivalent to calling thread_group_leader.

As there are only 2 remaining users of has_group_leader_pid let's
update the code and get rid of has_group_leader_pid.

There is one extra patch to lookup_task that performs that unifies
to code paths that become identical when has_group_leader_pid went
away.

Eric W. Biederman (4):
      posix-cpu-timer: Tidy up group_leader logic in lookup_task
      posix-cpu-timer:  Unify the now redundant code in lookup_task
      exec: Remove BUG_ON(has_group_leader_pid)
      signal: Remove has_group_leader_pid

 fs/exec.c                      |  1 -
 include/linux/sched/signal.h   | 11 -----------
 kernel/time/posix-cpu-timers.c | 21 ++++++++-------------
 3 files changed, 8 insertions(+), 25 deletions(-)
