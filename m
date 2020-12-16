Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C762DB85C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 02:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgLPBSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 20:18:37 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:42548 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgLPBSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 20:18:36 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kpLRw-00GrHg-Qm; Tue, 15 Dec 2020 18:17:52 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kpLRv-0000rD-Rq; Tue, 15 Dec 2020 18:17:52 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Tue, 15 Dec 2020 19:17:06 -0600
Message-ID: <874kkm8s8d.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kpLRv-0000rD-Rq;;;mid=<874kkm8s8d.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+XzvTS2z4UYMtPKAdnvA4HmL32/JfDSRM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.8 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,TR_XM_SB_Phish,T_TooManySym_01,XMSubMetaSxObfu_03,
        XMSubMetaSx_00,XMSubPhish11 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1138]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.5 XMSubPhish11 Phishy Language Subject
        *  0.0 TR_XM_SB_Phish Phishing flag in subject of message
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 388 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (3.1%), b_tie_ro: 11 (2.7%), parse: 1.00
        (0.3%), extract_message_metadata: 4.0 (1.0%), get_uri_detail_list:
        1.61 (0.4%), tests_pri_-1000: 4.4 (1.1%), tests_pri_-950: 1.49 (0.4%),
        tests_pri_-900: 1.16 (0.3%), tests_pri_-90: 110 (28.4%), check_bayes:
        108 (27.8%), b_tokenize: 6 (1.6%), b_tok_get_all: 6 (1.6%),
        b_comp_prob: 2.1 (0.5%), b_tok_touch_all: 90 (23.2%), b_finish: 1.06
        (0.3%), tests_pri_0: 216 (55.6%), check_dkim_signature: 1.28 (0.3%),
        check_dkim_adsp: 4.4 (1.1%), poll_dns_idle: 0.43 (0.1%), tests_pri_10:
        4.4 (1.1%), tests_pri_500: 23 (6.0%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] exec-update-lock for v5.11
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the exec-update-lock-for-v5.11 branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-update-lock-for-v5.11

   HEAD: f7cfd871ae0c5008d94b6f66834e7845caa93c15 exec: Transform exec_update_mutex into a rw_semaphore   

These changes are on top of:
   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/rwsem

and have a slight conflict with 78af4dc949da ("perf: Break deadlock
involving exec_update_mutex") which moves where the lock is taken
in perf_event_open.

The key point of this is to transform exec_update_mutex into a
rw_semaphore so readers can be separated from writers.  This makes it
easier to understand what the holders of the lock are doing, and makes
it harder to contend or deadlock on the lock.  The real deadlock fix
wound up in perf_event_open.

Eric W. Biederman (3):
      rwsem: Implement down_read_killable_nested
      rwsem: Implement down_read_interruptible
      exec: Transform exec_update_mutex into a rw_semaphore

 fs/exec.c                    | 12 ++++++------
 fs/proc/base.c               | 10 +++++-----
 include/linux/rwsem.h        |  3 +++
 include/linux/sched/signal.h | 11 ++++++-----
 init/init_task.c             |  2 +-
 kernel/events/core.c         | 12 ++++++------
 kernel/fork.c                |  6 +++---
 kernel/kcmp.c                | 30 +++++++++++++++---------------
 kernel/locking/rwsem.c       | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/pid.c                 |  4 ++--
 10 files changed, 87 insertions(+), 43 deletions(-)

Eric
