Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D975A1BCF47
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 00:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgD1V7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 17:59:41 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42936 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgD1V7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:59:40 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTYGR-0000Tk-EL; Tue, 28 Apr 2020 15:59:39 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTYGQ-0003k8-Pl; Tue, 28 Apr 2020 15:59:39 -0600
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
Date:   Tue, 28 Apr 2020 16:56:24 -0500
In-Reply-To: <87mu6v70in.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 28 Apr 2020 16:39:44 -0500")
Message-ID: <87pnbr5l6f.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jTYGQ-0003k8-Pl;;;mid=<87pnbr5l6f.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/RFDt7kKDsm8z1PG360s6aH2eNeEKiKPE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMGappySubj_01 autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4984]
        *  0.5 XMGappySubj_01 Very gappy subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;LKML <linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 261 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (4.3%), b_tie_ro: 10 (3.7%), parse: 0.84
        (0.3%), extract_message_metadata: 12 (4.5%), get_uri_detail_list: 1.12
        (0.4%), tests_pri_-1000: 13 (4.9%), tests_pri_-950: 1.25 (0.5%),
        tests_pri_-900: 1.04 (0.4%), tests_pri_-90: 72 (27.6%), check_bayes:
        71 (27.0%), b_tokenize: 5 (2.1%), b_tok_get_all: 5 (2.0%),
        b_comp_prob: 1.69 (0.6%), b_tok_touch_all: 55 (21.1%), b_finish: 0.85
        (0.3%), tests_pri_0: 139 (53.0%), check_dkim_signature: 0.48 (0.2%),
        check_dkim_adsp: 2.0 (0.8%), poll_dns_idle: 0.45 (0.2%), tests_pri_10:
        2.2 (0.9%), tests_pri_500: 7 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v4 4/4] signal: Remove has_group_leader_pid
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


After the introduction of exchange_tids has_group_leader_pid is
equivalent to thread_group_leader.  After the last couple of cleanups
has_group_leader_pid has no more callers.

So remove the now unused and redundant has_group_leader_pid.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 3e5b090c16d4..0ee5e696c5d8 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -654,17 +654,6 @@ static inline bool thread_group_leader(struct task_struct *p)
 	return p->exit_signal >= 0;
 }
 
-/* Do to the insanities of de_thread it is possible for a process
- * to have the pid of the thread group leader without actually being
- * the thread group leader.  For iteration through the pids in proc
- * all we care about is that we have a task with the appropriate
- * pid, we don't actually care if we have the right task.
- */
-static inline bool has_group_leader_pid(struct task_struct *p)
-{
-	return task_pid(p) == task_tgid(p);
-}
-
 static inline
 bool same_thread_group(struct task_struct *p1, struct task_struct *p2)
 {
-- 
2.20.1

