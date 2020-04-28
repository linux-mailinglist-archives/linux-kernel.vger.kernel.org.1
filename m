Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7F51BCF21
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 23:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgD1Vvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 17:51:46 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:40852 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgD1Vvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:51:45 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTY8m-0008BK-RQ; Tue, 28 Apr 2020 15:51:44 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTY8m-000269-2H; Tue, 28 Apr 2020 15:51:44 -0600
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
Date:   Tue, 28 Apr 2020 16:48:29 -0500
In-Reply-To: <87mu6v70in.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 28 Apr 2020 16:39:44 -0500")
Message-ID: <87a72v7042.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jTY8m-000269-2H;;;mid=<87a72v7042.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+iavlXQHTsBTgaU92yr/aKzEyuu1uex60=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_TooManySym_02,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4985]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;LKML <linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 354 ms - load_scoreonly_sql: 0.16 (0.0%),
        signal_user_changed: 14 (3.8%), b_tie_ro: 11 (3.2%), parse: 1.62
        (0.5%), extract_message_metadata: 18 (5.1%), get_uri_detail_list: 1.77
        (0.5%), tests_pri_-1000: 20 (5.5%), tests_pri_-950: 1.69 (0.5%),
        tests_pri_-900: 1.31 (0.4%), tests_pri_-90: 100 (28.3%), check_bayes:
        98 (27.6%), b_tokenize: 7 (2.0%), b_tok_get_all: 9 (2.4%),
        b_comp_prob: 2.3 (0.6%), b_tok_touch_all: 76 (21.5%), b_finish: 1.10
        (0.3%), tests_pri_0: 179 (50.4%), check_dkim_signature: 0.81 (0.2%),
        check_dkim_adsp: 2.9 (0.8%), poll_dns_idle: 0.61 (0.2%), tests_pri_10:
        4.3 (1.2%), tests_pri_500: 11 (3.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 2/4] posix-cpu-timer: Unify the now redundant code in lookup_task
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Now that both !thread paths through lookup_task call
thread_group_leader, unify them into the single test at the end of
lookup_task.
    
This unification just makes it clear what is happening in the gettime
special case of lookup_task.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/time/posix-cpu-timers.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index e4051e417bcb..b7f972fb115e 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -66,14 +66,13 @@ static struct task_struct *lookup_task(const pid_t pid, bool thread,
 	if (thread)
 		return same_thread_group(p, current) ? p : NULL;
 
-	if (gettime) {
-		/*
-		 * For clock_gettime(PROCESS) the task does not need to be
-		 * the actual group leader. task->signal gives
-		 * access to the group's clock.
-		 */
-		return (p == current || thread_group_leader(p)) ? p : NULL;
-	}
+	/*
+	 * For clock_gettime(PROCESS) the task does not need to be
+	 * the actual group leader. task->signal gives
+	 * access to the group's clock.
+	 */
+	if (gettime && (p == current))
+		return p;
 
 	/*
 	 * For processes require that p is group leader.
-- 
2.20.1

