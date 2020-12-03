Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2B12CDF76
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 21:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgLCUM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 15:12:28 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:47842 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgLCUM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 15:12:28 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kkux8-00BSIe-Ol; Thu, 03 Dec 2020 13:11:46 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kkux7-0002Ss-ST; Thu, 03 Dec 2020 13:11:46 -0700
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
Date:   Thu, 03 Dec 2020 14:11:13 -0600
In-Reply-To: <87tut2bqik.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 03 Dec 2020 14:09:39 -0600")
Message-ID: <87k0tybqfy.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kkux7-0002Ss-ST;;;mid=<87k0tybqfy.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18X/lTXMU47KKi3VPZMth1CqPtHxJtVd1c=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 505 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.8 (0.5%), b_tie_ro: 1.88 (0.4%), parse: 0.62
        (0.1%), extract_message_metadata: 10 (1.9%), get_uri_detail_list: 1.16
        (0.2%), tests_pri_-1000: 19 (3.7%), tests_pri_-950: 0.96 (0.2%),
        tests_pri_-900: 0.76 (0.1%), tests_pri_-90: 201 (39.8%), check_bayes:
        200 (39.5%), b_tokenize: 6 (1.1%), b_tok_get_all: 5.0 (1.0%),
        b_comp_prob: 1.36 (0.3%), b_tok_touch_all: 185 (36.7%), b_finish: 0.62
        (0.1%), tests_pri_0: 262 (51.8%), check_dkim_signature: 0.37 (0.1%),
        check_dkim_adsp: 2.2 (0.4%), poll_dns_idle: 0.87 (0.2%), tests_pri_10:
        1.64 (0.3%), tests_pri_500: 5 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 2/3] rwsem: Implement down_read_interruptible
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In preparation for converting exec_update_mutex to a rwsem so that
multiple readers can execute in parallel and not deadlock, add
down_read_interruptible.  This is needed for perf_event_open to be
converted (with no semantic changes) from working on a mutex to
wroking on a rwsem.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/rwsem.h  |  1 +
 kernel/locking/rwsem.c | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 13021b08b2ed..4c715be48717 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -123,6 +123,7 @@ static inline int rwsem_is_contended(struct rw_semaphore *sem)
  * lock for reading
  */
 extern void down_read(struct rw_semaphore *sem);
+extern int __must_check down_read_interruptible(struct rw_semaphore *sem);
 extern int __must_check down_read_killable(struct rw_semaphore *sem);
 
 /*
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 54d11cb97551..a163542d178e 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1345,6 +1345,18 @@ static inline void __down_read(struct rw_semaphore *sem)
 	}
 }
 
+static inline int __down_read_interruptible(struct rw_semaphore *sem)
+{
+	if (!rwsem_read_trylock(sem)) {
+		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_INTERRUPTIBLE)))
+			return -EINTR;
+		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
+	} else {
+		rwsem_set_reader_owned(sem);
+	}
+	return 0;
+}
+
 static inline int __down_read_killable(struct rw_semaphore *sem)
 {
 	if (!rwsem_read_trylock(sem)) {
@@ -1495,6 +1507,20 @@ void __sched down_read(struct rw_semaphore *sem)
 }
 EXPORT_SYMBOL(down_read);
 
+int __sched down_read_interruptible(struct rw_semaphore *sem)
+{
+	might_sleep();
+	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
+
+	if (LOCK_CONTENDED_RETURN(sem, __down_read_trylock, __down_read_interruptible)) {
+		rwsem_release(&sem->dep_map, _RET_IP_);
+		return -EINTR;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(down_read_interruptible);
+
 int __sched down_read_killable(struct rw_semaphore *sem)
 {
 	might_sleep();
-- 
2.25.0

