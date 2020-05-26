Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAE11AE432
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 20:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgDQSBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 14:01:37 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:49226 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730278AbgDQSBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:01:36 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jPVJ0-0002nt-Hj; Fri, 17 Apr 2020 12:01:34 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jPVIy-0006x7-Sb; Fri, 17 Apr 2020 12:01:34 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Date:   Fri, 17 Apr 2020 12:58:31 -0500
Message-ID: <87y2quc7ug.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jPVIy-0006x7-Sb;;;mid=<87y2quc7ug.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18A/NXNfLi9rMluPPKH7xgUBMnP76m2akk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TooManySym_01,XMSubMetaSxObfu_03,
        XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1259 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 14 (1.1%), b_tie_ro: 12 (0.9%), parse: 1.60
        (0.1%), extract_message_metadata: 20 (1.6%), get_uri_detail_list: 3.7
        (0.3%), tests_pri_-1000: 14 (1.1%), tests_pri_-950: 1.35 (0.1%),
        tests_pri_-900: 1.15 (0.1%), tests_pri_-90: 101 (8.0%), check_bayes:
        98 (7.8%), b_tokenize: 11 (0.9%), b_tok_get_all: 13 (1.0%),
        b_comp_prob: 4.7 (0.4%), b_tok_touch_all: 64 (5.1%), b_finish: 1.22
        (0.1%), tests_pri_0: 265 (21.0%), check_dkim_signature: 0.46 (0.0%),
        check_dkim_adsp: 9 (0.7%), poll_dns_idle: 823 (65.4%), tests_pri_10:
        2.1 (0.2%), tests_pri_500: 835 (66.4%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] Please pull proc fixes for v5.7-rc2
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

   HEAD: 4fa3b1c417377c352208ee9f487e17cfcee32348 proc: Handle umounts cleanly

While running syzbot happened to spot one more oversight in my rework of
proc_flush_task.  The fields proc_self and proc_thread_self were not
being reinitialized on when proc was unmounted, which could cause
problems if the mount of proc fails.

---

From 4fa3b1c417377c352208ee9f487e17cfcee32348 Mon Sep 17 00:00:00 2001
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 15 Apr 2020 12:37:27 -0500
Subject: [PATCH] proc: Handle umounts cleanly

syzbot writes:
> KASAN: use-after-free Read in dput (2)
>
> proc_fill_super: allocate dentry failed
> ==================================================================
> BUG: KASAN: use-after-free in fast_dput fs/dcache.c:727 [inline]
> BUG: KASAN: use-after-free in dput+0x53e/0xdf0 fs/dcache.c:846
> Read of size 4 at addr ffff88808a618cf0 by task syz-executor.0/8426
>
> CPU: 0 PID: 8426 Comm: syz-executor.0 Not tainted 5.6.0-next-20200412-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x188/0x20d lib/dump_stack.c:118
>  print_address_description.constprop.0.cold+0xd3/0x315 mm/kasan/report.c:382
>  __kasan_report.cold+0x35/0x4d mm/kasan/report.c:511
>  kasan_report+0x33/0x50 mm/kasan/common.c:625
>  fast_dput fs/dcache.c:727 [inline]
>  dput+0x53e/0xdf0 fs/dcache.c:846
>  proc_kill_sb+0x73/0xf0 fs/proc/root.c:195
>  deactivate_locked_super+0x8c/0xf0 fs/super.c:335
>  vfs_get_super+0x258/0x2d0 fs/super.c:1212
>  vfs_get_tree+0x89/0x2f0 fs/super.c:1547
>  do_new_mount fs/namespace.c:2813 [inline]
>  do_mount+0x1306/0x1b30 fs/namespace.c:3138
>  __do_sys_mount fs/namespace.c:3347 [inline]
>  __se_sys_mount fs/namespace.c:3324 [inline]
>  __x64_sys_mount+0x18f/0x230 fs/namespace.c:3324
>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
>  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> RIP: 0033:0x45c889
> Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffc1930ec48 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000001324914 RCX: 000000000045c889
> RDX: 0000000020000140 RSI: 0000000020000040 RDI: 0000000000000000
> RBP: 000000000076bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
> R13: 0000000000000749 R14: 00000000004ca15a R15: 0000000000000013

Looking at the code now that it the internal mount of proc is no
longer used it is possible to unmount proc.   If proc is unmounted
the fields of the pid namespace that were used for filesystem
specific state are not reinitialized.

Which means that proc_self and proc_thread_self can be pointers to
already freed dentries.

The reported user after free appears to be from mounting and
unmounting proc followed by mounting proc again and using error
injection to cause the new root dentry allocation to fail.  This in
turn results in proc_kill_sb running with proc_self and
proc_thread_self still retaining their values from the previous mount
of proc.  Then calling dput on either proc_self of proc_thread_self
will result in double put.  Which KASAN sees as a use after free.

Solve this by always reinitializing the filesystem state stored
in the struct pid_namespace, when proc is unmounted.

Reported-by: syzbot+72868dd424eb66c6b95f@syzkaller.appspotmail.com
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Fixes: 69879c01a0c3 ("proc: Remove the now unnecessary internal mount of proc")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/proc/root.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index 2633f10446c3..cdbe9293ea55 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -196,6 +196,13 @@ static void proc_kill_sb(struct super_block *sb)
 	if (ns->proc_thread_self)
 		dput(ns->proc_thread_self);
 	kill_anon_super(sb);
+
+	/* Make the pid namespace safe for the next mount of proc */
+	ns->proc_self = NULL;
+	ns->proc_thread_self = NULL;
+	ns->pid_gid = GLOBAL_ROOT_GID;
+	ns->hide_pid = 0;
+
 	put_pid_ns(ns);
 }
 
-- 
2.20.1






