Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C15247494
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 21:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbgHQTMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 15:12:05 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:44150 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730722AbgHQTLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 15:11:55 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7kXw-000zWz-17; Mon, 17 Aug 2020 13:11:52 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7kXu-0001iW-UK; Mon, 17 Aug 2020 13:11:51 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Date:   Mon, 17 Aug 2020 14:08:20 -0500
Message-ID: <875z9h9jkr.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k7kXu-0001iW-UK;;;mid=<875z9h9jkr.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18HAp/xjXwztZnFuAbl0W2uKiUQ8VoMCIQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,XMSubLong,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 745 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 9 (1.2%), b_tie_ro: 8 (1.0%), parse: 1.00 (0.1%),
        extract_message_metadata: 12 (1.7%), get_uri_detail_list: 3.1 (0.4%),
        tests_pri_-1000: 13 (1.7%), tests_pri_-950: 1.19 (0.2%),
        tests_pri_-900: 0.93 (0.1%), tests_pri_-90: 205 (27.6%), check_bayes:
        204 (27.4%), b_tokenize: 11 (1.5%), b_tok_get_all: 10 (1.3%),
        b_comp_prob: 2.9 (0.4%), b_tok_touch_all: 176 (23.7%), b_finish: 0.91
        (0.1%), tests_pri_0: 492 (66.1%), check_dkim_signature: 0.60 (0.1%),
        check_dkim_adsp: 2.3 (0.3%), poll_dns_idle: 0.77 (0.1%), tests_pri_10:
        1.77 (0.2%), tests_pri_500: 6 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: [RFC][PATCH] seccomp: Fail immediately if any thread is performing an exec
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In seccomp_attach_filter when syncing the filter between all of the
threads in a thread group if any thread is performing an exec fail to
attach the filter immediately.

AKA "seccomp(SECCOMP_SET_MODE_MODE_FILTER, SECCOMP_FILTER_FLAG_TSYNC...)"
will now fail if one of the threads is executing exec.

Prior to this change when one of the threads was performing an exec
seccomp_attach_filter would block on cred_guard_mutex until the thread
performing the exec called de_thread and killed all of the other
threads.  With the result that seccomp would not set the new filter.

So this winds up being a very small change in semantics that causes
the filter to not be set if the exec fails.  Given that doing anything
in any thread in parallel to an exec is racy with the threads being
killed I will be surprised if anything in userspace will care
about this semantic change.

To allow in_execve to be read atomically with the seccomp state of the
threads in the thread group wrap the setting and clearing of
current->in_execve with the siglock from struct sighand_struct.

The code in seccomp_attach_filter has been taking the cred_guard_mutex
to ensure that the state of seccomp does not change during or after
the calculation of the new credentials during exec.  With
seccomp_can_sync_threads updated to test in_execve and fail
immediately taking cred_guard_mutex is no longer necessary.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

I think in general this is the right thing to do.  The big
advantage besides less and simpler code is that after this
the only places using cred_guard_mutex are places where ptrace
attach should not happen right now.  Which makes cred_guard_mutex
somewhat easier to reason about.

 fs/exec.c        | 16 +++++++++++++---
 kernel/seccomp.c | 29 ++++++++---------------------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a91003e28eaa..9d9eabbed9a9 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1885,6 +1885,16 @@ static int exec_binprm(struct linux_binprm *bprm)
 	return 0;
 }
 
+static void set_in_execve(bool in_execve)
+{
+	struct task_struct *me = current;
+	spinlock_t *lock = &me->sighand->siglock;
+
+	spin_lock_irq(lock);
+	me->in_execve = in_execve;
+	spin_unlock_irq(lock);
+}
+
 /*
  * sys_execve() executes a new program.
  */
@@ -1904,7 +1914,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 		goto out_files;
 
 	check_unsafe_exec(bprm);
-	current->in_execve = 1;
+	set_in_execve(true);
 
 	file = do_open_execat(fd, filename, flags);
 	retval = PTR_ERR(file);
@@ -1934,7 +1944,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 
 	/* execve succeeded */
 	current->fs->in_exec = 0;
-	current->in_execve = 0;
+	set_in_execve(false);
 	rseq_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current, false);
@@ -1954,7 +1964,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 
 out_unmark:
 	current->fs->in_exec = 0;
-	current->in_execve = 0;
+	set_in_execve(false);
 
 out_files:
 	if (displaced)
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 3ee59ce0a323..2e78520ff2fd 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -379,7 +379,7 @@ static int is_ancestor(struct seccomp_filter *parent,
 /**
  * seccomp_can_sync_threads: checks if all threads can be synchronized
  *
- * Expects sighand and cred_guard_mutex locks to be held.
+ * Expects sighand siglock to be held.
  *
  * Returns 0 on success, -ve on error, or the pid of a thread which was
  * either not in the correct seccomp mode or did not have an ancestral
@@ -389,7 +389,6 @@ static inline pid_t seccomp_can_sync_threads(void)
 {
 	struct task_struct *thread, *caller;
 
-	BUG_ON(!mutex_is_locked(&current->signal->cred_guard_mutex));
 	assert_spin_locked(&current->sighand->siglock);
 
 	/* Validate all threads being eligible for synchronization. */
@@ -401,10 +400,11 @@ static inline pid_t seccomp_can_sync_threads(void)
 		if (thread == caller)
 			continue;
 
-		if (thread->seccomp.mode == SECCOMP_MODE_DISABLED ||
-		    (thread->seccomp.mode == SECCOMP_MODE_FILTER &&
-		     is_ancestor(thread->seccomp.filter,
-				 caller->seccomp.filter)))
+		if (!thread->in_execve &&
+		    (thread->seccomp.mode == SECCOMP_MODE_DISABLED ||
+		     (thread->seccomp.mode == SECCOMP_MODE_FILTER &&
+		      is_ancestor(thread->seccomp.filter,
+				  caller->seccomp.filter))))
 			continue;
 
 		/* Return the first thread that cannot be synchronized. */
@@ -474,16 +474,14 @@ void seccomp_filter_release(struct task_struct *tsk)
 /**
  * seccomp_sync_threads: sets all threads to use current's filter
  *
- * Expects sighand and cred_guard_mutex locks to be held, and for
- * seccomp_can_sync_threads() to have returned success already
- * without dropping the locks.
+ * Expects sighand siglock to be held, and for seccomp_can_sync_threads()
+ * to have returned success already without dropping the locks.
  *
  */
 static inline void seccomp_sync_threads(unsigned long flags)
 {
 	struct task_struct *thread, *caller;
 
-	BUG_ON(!mutex_is_locked(&current->signal->cred_guard_mutex));
 	assert_spin_locked(&current->sighand->siglock);
 
 	/* Synchronize all threads. */
@@ -1551,14 +1549,6 @@ static long seccomp_set_mode_filter(unsigned int flags,
 		}
 	}
 
-	/*
-	 * Make sure we cannot change seccomp or nnp state via TSYNC
-	 * while another thread is in the middle of calling exec.
-	 */
-	if (flags & SECCOMP_FILTER_FLAG_TSYNC &&
-	    mutex_lock_killable(&current->signal->cred_guard_mutex))
-		goto out_put_fd;
-
 	spin_lock_irq(&current->sighand->siglock);
 
 	if (!seccomp_may_assign_mode(seccomp_mode))
@@ -1573,9 +1563,6 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	seccomp_assign_mode(current, seccomp_mode, flags);
 out:
 	spin_unlock_irq(&current->sighand->siglock);
-	if (flags & SECCOMP_FILTER_FLAG_TSYNC)
-		mutex_unlock(&current->signal->cred_guard_mutex);
-out_put_fd:
 	if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) {
 		if (ret) {
 			listener_f->private_data = NULL;
-- 
2.20.1

