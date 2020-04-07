Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 231F11A048B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 03:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgDGBfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 21:35:13 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:38406 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDGBfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:35:13 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jLd8x-0002nH-UH; Mon, 06 Apr 2020 19:35:11 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jLd8x-0007TI-6M; Mon, 06 Apr 2020 19:35:11 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
        <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
        <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
        <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
        <87lfnda3w3.fsf@x220.int.ebiederm.org>
        <CAHk-=wjuv_J+2KOi+Fhr_nBKYf5CXr76DQKThA3uxXm3rCC3Uw@mail.gmail.com>
        <87wo6s3wxd.fsf_-_@x220.int.ebiederm.org>
Date:   Mon, 06 Apr 2020 20:32:23 -0500
In-Reply-To: <87wo6s3wxd.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 06 Apr 2020 20:29:50 -0500")
Message-ID: <87d08k3wt4.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jLd8x-0007TI-6M;;;mid=<87d08k3wt4.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/cbcBqpEVn6/Ni+GkF8hln+PRdagDMoeY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMGappySubj_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 297 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 15 (4.9%), b_tie_ro: 13 (4.3%), parse: 1.12
        (0.4%), extract_message_metadata: 12 (4.0%), get_uri_detail_list: 1.52
        (0.5%), tests_pri_-1000: 14 (4.5%), tests_pri_-950: 1.27 (0.4%),
        tests_pri_-900: 1.13 (0.4%), tests_pri_-90: 72 (24.3%), check_bayes:
        70 (23.6%), b_tokenize: 5 (1.8%), b_tok_get_all: 7 (2.5%),
        b_comp_prob: 2.3 (0.8%), b_tok_touch_all: 50 (16.9%), b_finish: 1.27
        (0.4%), tests_pri_0: 166 (55.9%), check_dkim_signature: 0.46 (0.2%),
        check_dkim_adsp: 2.8 (0.9%), poll_dns_idle: 1.18 (0.4%), tests_pri_10:
        3.5 (1.2%), tests_pri_500: 8 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 3/3] exec: Rename the flag called_exec_mmap point_of_no_return
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Update the comments and make the code easier to understand by
renaming this flag.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c               | 12 ++++++------
 include/linux/binfmts.h |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 28c87020da9b..a61987d6dc33 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1300,12 +1300,12 @@ int flush_old_exec(struct linux_binprm * bprm)
 		goto out;
 
 	/*
-	 * After setting bprm->called_exec_mmap (to mark that current is
-	 * using the prepared mm now), we have nothing left of the original
-	 * process. If anything from here on returns an error, the check
-	 * in search_binary_handler() will SEGV current.
+	 * With the new mm installed it is completely impossible to
+	 * fail and return to the original process.  If anything from
+	 * here on returns an error, the check in
+	 * search_binary_handler() will SEGV current.
 	 */
-	bprm->called_exec_mmap = 1;
+	bprm->point_of_no_return = true;
 	bprm->mm = NULL;
 
 #ifdef CONFIG_POSIX_TIMERS
@@ -1694,7 +1694,7 @@ int search_binary_handler(struct linux_binprm *bprm)
 
 		read_lock(&binfmt_lock);
 		put_binfmt(fmt);
-		if (retval < 0 && bprm->called_exec_mmap) {
+		if (retval < 0 && bprm->point_of_no_return) {
 			/* we got to flush_old_exec() and failed after it */
 			read_unlock(&binfmt_lock);
 			force_sigsegv(SIGSEGV);
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 6f564b9ad882..8f479dad7931 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -46,10 +46,10 @@ struct linux_binprm {
 		 */
 		secureexec:1,
 		/*
-		 * Set by flush_old_exec, when exec_mmap has been called.
-		 * This is past the point of no return.
+		 * Set when errors can no longer be returned to the
+		 * original userspace.
 		 */
-		called_exec_mmap:1;
+		point_of_no_return:1;
 #ifdef __alpha__
 	unsigned int taso:1;
 #endif
-- 
2.25.0

