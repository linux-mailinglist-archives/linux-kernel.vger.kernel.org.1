Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85DA1D68BF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 May 2020 18:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgEQQJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 May 2020 12:09:16 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:36642 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgEQQJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 12:09:15 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaLqk-0007sp-1s; Sun, 17 May 2020 10:09:14 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaLqj-0008VG-1v; Sun, 17 May 2020 10:09:13 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Willy Tarreau <w@1wt.eu>, Kees Cook <keescook@chromium.org>
Date:   Sun, 17 May 2020 11:05:35 -0500
Message-ID: <87imgu7dio.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jaLqj-0008VG-1v;;;mid=<87imgu7dio.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/V3gXJx7hQNIV5VkJ+RzUCl7Md0bFRkyQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubMetaSxObfu_03,
        XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 0; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: ; sa08 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 574 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 14 (2.4%), b_tie_ro: 12 (2.1%), parse: 1.00
        (0.2%), extract_message_metadata: 12 (2.2%), get_uri_detail_list: 2.4
        (0.4%), tests_pri_-1000: 12 (2.1%), tests_pri_-950: 1.33 (0.2%),
        tests_pri_-900: 1.10 (0.2%), tests_pri_-90: 271 (47.3%), check_bayes:
        269 (46.9%), b_tokenize: 6 (1.0%), b_tok_get_all: 110 (19.1%),
        b_comp_prob: 4.1 (0.7%), b_tok_touch_all: 144 (25.1%), b_finish: 1.44
        (0.3%), tests_pri_0: 248 (43.2%), check_dkim_signature: 0.43 (0.1%),
        check_dkim_adsp: 3.1 (0.5%), poll_dns_idle: 1.45 (0.3%), tests_pri_10:
        2.4 (0.4%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] Please pull exec fix for v5.7
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the exec-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-linus

   HEAD: f87d1c9559164294040e58f5e3b74a162bf7c6e8 exec: Move would_dump into flush_old_exec

While working on my exec cleanups I found a bug in exec that I
introduced by accident a couple of years ago.  I apparently missed the
fact that bprm->file can change.

Now I have a very personal motive to clean up exec and make it more
approachable.

The change is just moving woud_dump to where it acts on the final
bprm->file not the initial bprm->file.   I have been careful and
tested and verify this fix works.

Eric

---

From f87d1c9559164294040e58f5e3b74a162bf7c6e8 Mon Sep 17 00:00:00 2001
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Sat, 16 May 2020 16:29:20 -0500
Subject: [PATCH] exec: Move would_dump into flush_old_exec

I goofed when I added mm->user_ns support to would_dump.  I missed the
fact that in the case of binfmt_loader, binfmt_em86, binfmt_misc, and
binfmt_script bprm->file is reassigned.  Which made the move of
would_dump from setup_new_exec to __do_execve_file before exec_binprm
incorrect as it can result in would_dump running on the script instead
of the interpreter of the script.

The net result is that the code stopped making unreadable interpreters
undumpable.  Which allows them to be ptraced and written to disk
without special permissions.  Oops.

The move was necessary because the call in set_new_exec was after
bprm->mm was no longer valid.

To correct this mistake move the misplaced would_dump from
__do_execve_file into flos_old_exec, before exec_mmap is called.

I tested and confirmed that without this fix I can attach with gdb to
a script with an unreadable interpreter, and with this fix I can not.

Cc: stable@vger.kernel.org
Fixes: f84df2a6f268 ("exec: Ensure mm->user_ns contains the execed files")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 06b4c550af5d..2c465119affc 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1317,6 +1317,8 @@ int flush_old_exec(struct linux_binprm * bprm)
 	 */
 	set_mm_exe_file(bprm->mm, bprm->file);
 
+	would_dump(bprm, bprm->file);
+
 	/*
 	 * Release all of the old mmap stuff
 	 */
@@ -1876,8 +1878,6 @@ static int __do_execve_file(int fd, struct filename *filename,
 	if (retval < 0)
 		goto out;
 
-	would_dump(bprm, bprm->file);
-
 	retval = exec_binprm(bprm);
 	if (retval < 0)
 		goto out;
-- 
2.20.1

