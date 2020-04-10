Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC9B61A469A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 15:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDJNGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 09:06:02 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:45600 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgDJNGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 09:06:02 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMtM9-0005XH-Ka; Fri, 10 Apr 2020 07:06:01 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMtM8-0001Jt-FR; Fri, 10 Apr 2020 07:06:01 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
Date:   Fri, 10 Apr 2020 08:03:04 -0500
In-Reply-To: <87blobnq02.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Wed, 01 Apr 2020 11:13:17 -0500")
Message-ID: <87sghbmr1z.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jMtM8-0001Jt-FR;;;mid=<87sghbmr1z.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18gW2WaviSeFrVKDX1mAWUGDxDqLmZvAN8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TooManySym_01,XMSubMetaSxObfu_03,
        XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 576 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.9%), b_tie_ro: 10 (1.7%), parse: 1.63
        (0.3%), extract_message_metadata: 27 (4.7%), get_uri_detail_list: 7
        (1.1%), tests_pri_-1000: 24 (4.2%), tests_pri_-950: 1.24 (0.2%),
        tests_pri_-900: 1.00 (0.2%), tests_pri_-90: 93 (16.1%), check_bayes:
        91 (15.8%), b_tokenize: 12 (2.1%), b_tok_get_all: 11 (1.9%),
        b_comp_prob: 3.6 (0.6%), b_tok_touch_all: 60 (10.5%), b_finish: 0.73
        (0.1%), tests_pri_0: 404 (70.2%), check_dkim_signature: 0.60 (0.1%),
        check_dkim_adsp: 2.3 (0.4%), poll_dns_idle: 0.80 (0.1%), tests_pri_10:
        1.99 (0.3%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] proc fix for 5.7-rc1
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the for-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

   HEAD: 63f818f46af9f8b3f17b9695501e8d08959feb60 proc: Use a dedicated lock in struct pid

A brown paper bag slipped through my proc changes, and syzcaller caught
it when the code ended up in your tree.  I have opted to fix it the
simplest cleanest way I know how.  So there is no reasonable chance
for the bug to repeat.

Eric

From 63f818f46af9f8b3f17b9695501e8d08959feb60 Mon Sep 17 00:00:00 2001
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 7 Apr 2020 09:43:04 -0500
Subject: [PATCH] proc: Use a dedicated lock in struct pid

syzbot wrote:
> ========================================================
> WARNING: possible irq lock inversion dependency detected
> 5.6.0-syzkaller #0 Not tainted
> --------------------------------------------------------
> swapper/1/0 just changed the state of lock:
> ffffffff898090d8 (tasklist_lock){.+.?}-{2:2}, at: send_sigurg+0x9f/0x320 fs/fcntl.c:840
> but this lock took another, SOFTIRQ-unsafe lock in the past:
>  (&pid->wait_pidfd){+.+.}-{2:2}
>
>
> and interrupts could create inverse lock ordering between them.
>
>
> other info that might help us debug this:
>  Possible interrupt unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&pid->wait_pidfd);
>                                local_irq_disable();
>                                lock(tasklist_lock);
>                                lock(&pid->wait_pidfd);
>   <Interrupt>
>     lock(tasklist_lock);
>
>  *** DEADLOCK ***
>
> 4 locks held by swapper/1/0:

The problem is that because wait_pidfd.lock is taken under the tasklist
lock.  It must always be taken with irqs disabled as tasklist_lock can be
taken from interrupt context and if wait_pidfd.lock was already taken this
would create a lock order inversion.

Oleg suggested just disabling irqs where I have added extra calls to
wait_pidfd.lock.  That should be safe and I think the code will eventually
do that.  It was rightly pointed out by Christian that sharing the
wait_pidfd.lock was a premature optimization.

It is also true that my pre-merge window testing was insufficient.  So
remove the premature optimization and give struct pid a dedicated lock of
it's own for struct pid things.  I have verified that lockdep sees all 3
paths where we take the new pid->lock and lockdep does not complain.

It is my current day dream that one day pid->lock can be used to guard the
task lists as well and then the tasklist_lock won't need to be held to
deliver signals.  That will require taking pid->lock with irqs disabled.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Link: https://lore.kernel.org/lkml/00000000000011d66805a25cd73f@google.com/
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Reported-by: syzbot+343f75cdeea091340956@syzkaller.appspotmail.com
Reported-by: syzbot+832aabf700bc3ec920b9@syzkaller.appspotmail.com
Reported-by: syzbot+f675f964019f884dbd0f@syzkaller.appspotmail.com
Reported-by: syzbot+a9fb1457d720a55d6dc5@syzkaller.appspotmail.com
Fixes: 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/proc/base.c      | 10 +++++-----
 include/linux/pid.h |  1 +
 kernel/pid.c        |  1 +
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 74f948a6b621..6042b646ab27 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1839,9 +1839,9 @@ void proc_pid_evict_inode(struct proc_inode *ei)
 	struct pid *pid = ei->pid;
 
 	if (S_ISDIR(ei->vfs_inode.i_mode)) {
-		spin_lock(&pid->wait_pidfd.lock);
+		spin_lock(&pid->lock);
 		hlist_del_init_rcu(&ei->sibling_inodes);
-		spin_unlock(&pid->wait_pidfd.lock);
+		spin_unlock(&pid->lock);
 	}
 
 	put_pid(pid);
@@ -1877,9 +1877,9 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
 	/* Let the pid remember us for quick removal */
 	ei->pid = pid;
 	if (S_ISDIR(mode)) {
-		spin_lock(&pid->wait_pidfd.lock);
+		spin_lock(&pid->lock);
 		hlist_add_head_rcu(&ei->sibling_inodes, &pid->inodes);
-		spin_unlock(&pid->wait_pidfd.lock);
+		spin_unlock(&pid->lock);
 	}
 
 	task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
@@ -3273,7 +3273,7 @@ static const struct inode_operations proc_tgid_base_inode_operations = {
 
 void proc_flush_pid(struct pid *pid)
 {
-	proc_invalidate_siblings_dcache(&pid->inodes, &pid->wait_pidfd.lock);
+	proc_invalidate_siblings_dcache(&pid->inodes, &pid->lock);
 	put_pid(pid);
 }
 
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 01a0d4e28506..cc896f0fc4e3 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -60,6 +60,7 @@ struct pid
 {
 	refcount_t count;
 	unsigned int level;
+	spinlock_t lock;
 	/* lists of tasks that use this pid */
 	struct hlist_head tasks[PIDTYPE_MAX];
 	struct hlist_head inodes;
diff --git a/kernel/pid.c b/kernel/pid.c
index efd34874b3d1..517d0855d4cf 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -246,6 +246,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 
 	get_pid_ns(ns);
 	refcount_set(&pid->count, 1);
+	spin_lock_init(&pid->lock);
 	for (type = 0; type < PIDTYPE_MAX; ++type)
 		INIT_HLIST_HEAD(&pid->tasks[type]);
 
-- 
2.20.1

