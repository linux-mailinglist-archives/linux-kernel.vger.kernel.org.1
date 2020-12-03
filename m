Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0D62CDF6C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 21:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbgLCULC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 15:11:02 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:56650 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgLCULB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 15:11:01 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kkuvd-00BMPH-Py; Thu, 03 Dec 2020 13:10:13 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kkuvc-00B32W-N8; Thu, 03 Dec 2020 13:10:13 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jann Horn <jannh@google.com>,
        Vasiliy Kulikov <segoon@openwall.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Christopher Yeoh <cyeoh@au1.ibm.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Date:   Thu, 03 Dec 2020 14:09:39 -0600
Message-ID: <87tut2bqik.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kkuvc-00B32W-N8;;;mid=<87tut2bqik.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+KAKkx+upN+DyhS/e8mfHxnCYAh8W63fM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_XM_SB_Phish,T_TooManySym_01,XMNoVowels,XMSubLong,
        XMSubPhish11 autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4988]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.5 XMSubPhish11 Phishy Language Subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 TR_XM_SB_Phish Phishing flag in subject of message
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 438 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.5 (0.8%), b_tie_ro: 2.4 (0.5%), parse: 0.56
        (0.1%), extract_message_metadata: 2.1 (0.5%), get_uri_detail_list:
        0.70 (0.2%), tests_pri_-1000: 3.2 (0.7%), tests_pri_-950: 1.02 (0.2%),
        tests_pri_-900: 0.82 (0.2%), tests_pri_-90: 201 (45.9%), check_bayes:
        200 (45.7%), b_tokenize: 4.7 (1.1%), b_tok_get_all: 6 (1.3%),
        b_comp_prob: 1.37 (0.3%), b_tok_touch_all: 185 (42.3%), b_finish: 0.70
        (0.2%), tests_pri_0: 212 (48.5%), check_dkim_signature: 0.34 (0.1%),
        check_dkim_adsp: 2.1 (0.5%), poll_dns_idle: 0.70 (0.2%), tests_pri_10:
        1.77 (0.4%), tests_pri_500: 6 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/3] exec: Transform exec_update_mutex into a rw_semaphore
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Recently syzbot reported[0] that there is a deadlock amongst the users
of exec_update_mutex.

The simplest and most robust solution appears to be making
exec_update_mutex a read/write lock and having everything execept for
exec take the lock for read.

This set of changes upgrades rwsem so it has the functionality needed
and uses a rw_semaphore to replace the current mutex.

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

[0] https://lkml.kernel.org/r/00000000000063640c05ade8e3de@google.com

Eric
