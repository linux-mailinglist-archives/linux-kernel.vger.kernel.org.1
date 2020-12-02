Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180E32CC0B7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgLBPXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 10:23:12 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:45566 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgLBPXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:23:12 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kkTxe-008pWF-1s; Wed, 02 Dec 2020 08:22:30 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kkTxc-007fto-Ti; Wed, 02 Dec 2020 08:22:29 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>
References: <878saih2op.fsf@x220.int.ebiederm.org>
Date:   Wed, 02 Dec 2020 09:21:57 -0600
In-Reply-To: <878saih2op.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 30 Nov 2020 16:58:46 -0600")
Message-ID: <87lfegcjxm.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kkTxc-007fto-Ti;;;mid=<87lfegcjxm.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18k/nm6I5OVD9qQBrGSYbdgXRiQTuW2bmI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMGappySubj_01,XMSubLong,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 574 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 12 (2.1%), b_tie_ro: 11 (1.8%), parse: 0.99
        (0.2%), extract_message_metadata: 12 (2.2%), get_uri_detail_list: 1.01
        (0.2%), tests_pri_-1000: 14 (2.5%), tests_pri_-950: 1.52 (0.3%),
        tests_pri_-900: 1.22 (0.2%), tests_pri_-90: 336 (58.5%), check_bayes:
        333 (58.1%), b_tokenize: 10 (1.8%), b_tok_get_all: 6 (1.0%),
        b_comp_prob: 3.0 (0.5%), b_tok_touch_all: 310 (54.1%), b_finish: 1.13
        (0.2%), tests_pri_0: 181 (31.6%), check_dkim_signature: 0.70 (0.1%),
        check_dkim_adsp: 2.7 (0.5%), poll_dns_idle: 0.50 (0.1%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 9 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] exec: Move io_uring_task_cancel after the point of no return
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Now that unshare_files happens in begin_new_exec after the point of no
> return, io_uring_task_cancel can also happen later.
>
> Effectively this means io_uring activities for a task are only canceled
> when exec succeeds.
>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>
> This is against my exec-for-v5.11 branch

applied.

>  fs/exec.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 14fae2ec1c9d..9e9368603168 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1257,6 +1257,11 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	if (retval)
>  		goto out;
>  
> +	/*
> +	 * Cancel any io_uring activity across execve
> +	 */
> +	io_uring_task_cancel();
> +
>  	/* Ensure the files table is not shared. */
>  	retval = unshare_files();
>  	if (retval)
> @@ -1783,11 +1788,6 @@ static int bprm_execve(struct linux_binprm *bprm,
>  	struct file *file;
>  	int retval;
>  
> -	/*
> -	 * Cancel any io_uring activity across execve
> -	 */
> -	io_uring_task_cancel();
> -
>  	retval = prepare_bprm_creds(bprm);
>  	if (retval)
>  		return retval;
