Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BCA2C91DD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388638AbgK3W76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:59:58 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:40542 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgK3W76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:59:58 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kjs8Z-001bqu-Ue; Mon, 30 Nov 2020 15:59:15 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kjs8Z-0008Jw-B6; Mon, 30 Nov 2020 15:59:15 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>
Date:   Mon, 30 Nov 2020 16:58:46 -0600
Message-ID: <878saih2op.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kjs8Z-0008Jw-B6;;;mid=<878saih2op.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Y6q1ezVHxrrwTupDQXlbLEG2XON0U6dQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMGappySubj_01,XMSubLong,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4996]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 253 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.0 (1.6%), b_tie_ro: 2.7 (1.1%), parse: 0.59
        (0.2%), extract_message_metadata: 7 (2.9%), get_uri_detail_list: 0.64
        (0.3%), tests_pri_-1000: 10 (4.0%), tests_pri_-950: 0.97 (0.4%),
        tests_pri_-900: 0.78 (0.3%), tests_pri_-90: 70 (27.4%), check_bayes:
        68 (26.9%), b_tokenize: 3.7 (1.4%), b_tok_get_all: 5 (2.0%),
        b_comp_prob: 1.13 (0.4%), b_tok_touch_all: 55 (21.9%), b_finish: 0.73
        (0.3%), tests_pri_0: 149 (58.7%), check_dkim_signature: 0.36 (0.1%),
        check_dkim_adsp: 2.4 (1.0%), poll_dns_idle: 0.97 (0.4%), tests_pri_10:
        2.6 (1.0%), tests_pri_500: 7 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] exec: Move io_uring_task_cancel after the point of no return
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Now that unshare_files happens in begin_new_exec after the point of no
return, io_uring_task_cancel can also happen later.

Effectively this means io_uring activities for a task are only canceled
when exec succeeds.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

This is against my exec-for-v5.11 branch

 fs/exec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 14fae2ec1c9d..9e9368603168 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1257,6 +1257,11 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out;
 
+	/*
+	 * Cancel any io_uring activity across execve
+	 */
+	io_uring_task_cancel();
+
 	/* Ensure the files table is not shared. */
 	retval = unshare_files();
 	if (retval)
@@ -1783,11 +1788,6 @@ static int bprm_execve(struct linux_binprm *bprm,
 	struct file *file;
 	int retval;
 
-	/*
-	 * Cancel any io_uring activity across execve
-	 */
-	io_uring_task_cancel();
-
 	retval = prepare_bprm_creds(bprm);
 	if (retval)
 		return retval;
-- 
2.20.1

