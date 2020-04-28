Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FCD1BCF3C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 23:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgD1V4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 17:56:47 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47642 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgD1V4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:56:47 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTYDe-0006CL-8g; Tue, 28 Apr 2020 15:56:46 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTYDd-0003Kw-J2; Tue, 28 Apr 2020 15:56:46 -0600
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
Date:   Tue, 28 Apr 2020 16:53:31 -0500
In-Reply-To: <87mu6v70in.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 28 Apr 2020 16:39:44 -0500")
Message-ID: <87zhav5lb8.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jTYDd-0003Kw-J2;;;mid=<87zhav5lb8.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/9SFOGLrwqMnM+GMHpEChkArNfTp8VniM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TooManySym_01,T_TooManySym_02,
        T_TooManySym_03,XMGappySubj_01 autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.5 XMGappySubj_01 Very gappy subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;LKML <linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 259 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.9 (1.5%), b_tie_ro: 2.7 (1.1%), parse: 0.71
        (0.3%), extract_message_metadata: 8 (3.3%), get_uri_detail_list: 0.70
        (0.3%), tests_pri_-1000: 11 (4.2%), tests_pri_-950: 1.00 (0.4%),
        tests_pri_-900: 0.79 (0.3%), tests_pri_-90: 90 (34.8%), check_bayes:
        89 (34.4%), b_tokenize: 3.9 (1.5%), b_tok_get_all: 5 (2.1%),
        b_comp_prob: 1.17 (0.5%), b_tok_touch_all: 76 (29.3%), b_finish: 0.70
        (0.3%), tests_pri_0: 134 (51.6%), check_dkim_signature: 0.37 (0.1%),
        check_dkim_adsp: 2.2 (0.8%), poll_dns_idle: 0.87 (0.3%), tests_pri_10:
        1.76 (0.7%), tests_pri_500: 5 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v1 3/4] exec: Remove BUG_ON(has_group_leader_pid)
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


With the introduction of exchange_tids thread_group_leader and
has_group_leader_pid have become equivalent.  Further at this point in the
code a thread group has exactly two threads, the previous thread_group_leader
that is waiting to be reaped and tsk.  So we know it is impossible for tsk to
be the thread_group_leader.

This is also the last user of has_group_leader_pid so removing this check
will allow has_group_leader_pid to be removed.

So remove the "BUG_ON(has_group_leader_pid)" that will never fire.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 9b60f927afd7..6ab1c19d84fa 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1176,7 +1176,6 @@ static int de_thread(struct task_struct *tsk)
 		tsk->start_boottime = leader->start_boottime;
 
 		BUG_ON(!same_thread_group(leader, tsk));
-		BUG_ON(has_group_leader_pid(tsk));
 		/*
 		 * An exec() starts a new thread group with the
 		 * TGID of the previous thread group. Rehash the
-- 
2.20.1

