Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1541B879B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 18:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgDYQBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 12:01:48 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:44814 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgDYQBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 12:01:47 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jSNFS-0000Sj-De; Sat, 25 Apr 2020 10:01:46 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jSNFR-0003rJ-HH; Sat, 25 Apr 2020 10:01:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Date:   Sat, 25 Apr 2020 10:58:35 -0500
Message-ID: <878sijo8us.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jSNFR-0003rJ-HH;;;mid=<878sijo8us.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+KHl53AStV0dEp3mzBT+inUwLnzJN78vI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4992]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 420 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.7%), b_tie_ro: 10 (2.4%), parse: 0.82
        (0.2%), extract_message_metadata: 13 (3.0%), get_uri_detail_list: 1.89
        (0.5%), tests_pri_-1000: 13 (3.1%), tests_pri_-950: 1.23 (0.3%),
        tests_pri_-900: 0.99 (0.2%), tests_pri_-90: 141 (33.6%), check_bayes:
        140 (33.2%), b_tokenize: 6 (1.5%), b_tok_get_all: 51 (12.0%),
        b_comp_prob: 2.3 (0.5%), b_tok_touch_all: 76 (18.1%), b_finish: 1.02
        (0.2%), tests_pri_0: 226 (53.8%), check_dkim_signature: 0.49 (0.1%),
        check_dkim_adsp: 2.4 (0.6%), poll_dns_idle: 0.72 (0.2%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 7 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] Please pull proc_flush_pid fix for v5.7-rc3
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

   HEAD: 6ade99ec6175ab2b54c227521e181e1c3c2bfc8a proc: Put thread_pid in release_task not proc_flush_pid

Oleg noticed that put_pid(thread_pid) was not getting called when proc
was not compiled in.  Let's get that fixed before 5.7 is released and
causes problems for anyone.

Eric

---

From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 24 Apr 2020 15:41:20 -0500
Subject: [PATCH] proc: Put thread_pid in release_task not proc_flush_pid

Oleg pointed out that in the unlikely event the kernel is compiled
with CONFIG_PROC_FS unset that release_task will now leak the pid.

Move the put_pid out of proc_flush_pid into release_task to fix this
and to guarantee I don't make that mistake again.

When possible it makes sense to keep get and put in the same function
so it can easily been seen how they pair up.

Fixes: 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/proc/base.c | 1 -
 kernel/exit.c  | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6042b646ab27..42f43c7b9669 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3274,7 +3274,6 @@ static const struct inode_operations proc_tgid_base_inode_operations = {
 void proc_flush_pid(struct pid *pid)
 {
 	proc_invalidate_siblings_dcache(&pid->inodes, &pid->lock);
-	put_pid(pid);
 }
 
 static struct dentry *proc_pid_instantiate(struct dentry * dentry,
diff --git a/kernel/exit.c b/kernel/exit.c
index 389a88cb3081..ce2a75bc0ade 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -219,6 +219,7 @@ void release_task(struct task_struct *p)
 
 	write_unlock_irq(&tasklist_lock);
 	proc_flush_pid(thread_pid);
+	put_pid(thread_pid);
 	release_thread(p);
 	put_task_struct_rcu_user(p);
 
-- 
2.20.1




