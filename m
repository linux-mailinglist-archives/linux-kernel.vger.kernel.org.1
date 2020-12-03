Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11FE2CDF73
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 21:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgLCULt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 15:11:49 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:47680 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729071AbgLCULs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 15:11:48 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kkuwU-00BS9Z-Hs; Thu, 03 Dec 2020 13:11:06 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kkuwT-00B38k-2w; Thu, 03 Dec 2020 13:11:06 -0700
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
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
Date:   Thu, 03 Dec 2020 14:10:32 -0600
In-Reply-To: <87tut2bqik.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 03 Dec 2020 14:09:39 -0600")
Message-ID: <87o8jabqh3.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kkuwT-00B38k-2w;;;mid=<87o8jabqh3.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18vkmZsHEZxXZ0gWrolGwg6cT1OeuUlaFQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMGappySubj_01,XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 691 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 10 (1.4%), b_tie_ro: 8 (1.2%), parse: 1.48 (0.2%),
         extract_message_metadata: 23 (3.3%), get_uri_detail_list: 2.9 (0.4%),
        tests_pri_-1000: 34 (4.9%), tests_pri_-950: 1.50 (0.2%),
        tests_pri_-900: 1.13 (0.2%), tests_pri_-90: 136 (19.6%), check_bayes:
        133 (19.3%), b_tokenize: 9 (1.4%), b_tok_get_all: 8 (1.1%),
        b_comp_prob: 2.4 (0.4%), b_tok_touch_all: 110 (15.9%), b_finish: 1.21
        (0.2%), tests_pri_0: 472 (68.3%), check_dkim_signature: 0.76 (0.1%),
        check_dkim_adsp: 3.1 (0.4%), poll_dns_idle: 0.69 (0.1%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 6 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 1/3] rwsem: Implement down_read_killable_nested
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In preparation for converting exec_update_mutex to a rwsem so that
multiple readers can execute in parallel and not deadlock, add
down_read_killable_nested.  This is needed so that kcmp_lock
can be converted from working on a mutexes to working on rw_semaphores.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/rwsem.h  |  2 ++
 kernel/locking/rwsem.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 25e3fde85617..13021b08b2ed 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -171,6 +171,7 @@ extern void downgrade_write(struct rw_semaphore *sem);
  * See Documentation/locking/lockdep-design.rst for more details.)
  */
 extern void down_read_nested(struct rw_semaphore *sem, int subclass);
+extern int __must_check down_read_killable_nested(struct rw_semaphore *sem, int subclass);
 extern void down_write_nested(struct rw_semaphore *sem, int subclass);
 extern int down_write_killable_nested(struct rw_semaphore *sem, int subclass);
 extern void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_map *nest_lock);
@@ -191,6 +192,7 @@ extern void down_read_non_owner(struct rw_semaphore *sem);
 extern void up_read_non_owner(struct rw_semaphore *sem);
 #else
 # define down_read_nested(sem, subclass)		down_read(sem)
+# define down_read_killable_nested(sem, subclass)	down_read_killable(sem)
 # define down_write_nest_lock(sem, nest_lock)	down_write(sem)
 # define down_write_nested(sem, subclass)	down_write(sem)
 # define down_write_killable_nested(sem, subclass)	down_write_killable(sem)
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index f11b9bd3431d..54d11cb97551 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1605,6 +1605,20 @@ void down_read_nested(struct rw_semaphore *sem, int subclass)
 }
 EXPORT_SYMBOL(down_read_nested);
 
+int down_read_killable_nested(struct rw_semaphore *sem, int subclass)
+{
+	might_sleep();
+	rwsem_acquire_read(&sem->dep_map, subclass, 0, _RET_IP_);
+
+	if (LOCK_CONTENDED_RETURN(sem, __down_read_trylock, __down_read_killable)) {
+		rwsem_release(&sem->dep_map, _RET_IP_);
+		return -EINTR;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(down_read_killable_nested);
+
 void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_map *nest)
 {
 	might_sleep();
-- 
2.25.0

