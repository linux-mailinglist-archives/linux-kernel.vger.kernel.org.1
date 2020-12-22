Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E642C2E0DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 18:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgLVRf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 12:35:26 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:50134 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgLVRf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 12:35:26 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1krlYY-00EzCF-Go; Tue, 22 Dec 2020 10:34:42 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1krlYW-0000Fv-VN; Tue, 22 Dec 2020 10:34:42 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <0bcc0c63-31a3-26fd-bccb-b28af0375c34@i-love.sakura.ne.jp>
Date:   Tue, 22 Dec 2020 11:33:58 -0600
In-Reply-To: <0bcc0c63-31a3-26fd-bccb-b28af0375c34@i-love.sakura.ne.jp>
        (Tetsuo Handa's message of "Tue, 22 Dec 2020 23:39:08 +0900")
Message-ID: <87a6u5iw3d.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1krlYW-0000Fv-VN;;;mid=<87a6u5iw3d.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/YCQJ6h27iCJXzD92zJcYHBr4oU/lpD/g=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1291 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.8 (0.3%), b_tie_ro: 2.6 (0.2%), parse: 0.67
        (0.1%), extract_message_metadata: 9 (0.7%), get_uri_detail_list: 1.42
        (0.1%), tests_pri_-1000: 2.4 (0.2%), tests_pri_-950: 1.05 (0.1%),
        tests_pri_-900: 0.80 (0.1%), tests_pri_-90: 135 (10.5%), check_bayes:
        134 (10.4%), b_tokenize: 6 (0.4%), b_tok_get_all: 7 (0.6%),
        b_comp_prob: 1.66 (0.1%), b_tok_touch_all: 116 (9.0%), b_finish: 0.79
        (0.1%), tests_pri_0: 1049 (81.3%), check_dkim_signature: 0.40 (0.0%),
        check_dkim_adsp: 796 (61.6%), poll_dns_idle: 866 (67.0%),
        tests_pri_10: 1.71 (0.1%), tests_pri_500: 85 (6.6%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: Does uaccess_kernel() work for detecting kernel thread?
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:

> Commit db68ce10c4f0a27c ("new helper: uaccess_kernel()") replaced segment_eq(get_fs(), KERNEL_DS)
> with uaccess_kernel(). But uaccess_kernel() became an unconditional "false" for some architectures
> due to commit 5e6e9852d6f76e01 ("uaccess: add infrastructure for kernel builds with set_fs()") and
> follow up changes in Linux 5.10. As a result, I guess that uaccess_kernel() can no longer be used
> as a condition for checking whether current thread is a kernel thread or not.
>
> For example, if uaccess_kernel() is "false" due to CONFIG_SET_FS=n,
> isn't sg_check_file_access() failing to detect kernel context?
>
> static int sg_check_file_access(struct file *filp, const char *caller)
> {
> 	if (filp->f_cred != current_real_cred()) {
> 		pr_err_once("%s: process %d (%s) changed security contexts after opening file descriptor, this is not allowed.\n",
> 			caller, task_tgid_vnr(current), current->comm);
> 		return -EPERM;
> 	}
> 	if (uaccess_kernel()) {
> 		pr_err_once("%s: process %d (%s) called from kernel context, this is not allowed.\n",
> 			caller, task_tgid_vnr(current), current->comm);
> 		return -EACCES;
> 	}
> 	return 0;
> }
>
> For another example, if uaccess_kernel() is "false" due to CONFIG_SET_FS=n,
> isn't TOMOYO unexpectedly checking permissions for socket operations?
>
> static bool tomoyo_kernel_service(void)
> {
> 	/* Nothing to do if I am a kernel service. */
> 	return uaccess_kernel();
> }
>
> static u8 tomoyo_sock_family(struct sock *sk)
> {
> 	u8 family;
>
> 	if (tomoyo_kernel_service())
> 		return 0;
> 	family = sk->sk_family;
> 	switch (family) {
> 	case PF_INET:
> 	case PF_INET6:
> 	case PF_UNIX:
> 		return family;
> 	default:
> 		return 0;
> 	}
> }
>
> Don't we need to replace such usage with something like (current->flags & PF_KTHREAD) ?
> I don't know about io_uring, but according to
> https://lkml.kernel.org/r/dacfb329-de66-d0cf-dcf9-f030ea1370de@schaufler-ca.com ,
> should (current->flags & (PF_KTHREAD | PF_IO_WORKER)) == PF_KTHREAD be used instead?

I think you are reading the situation properly.

I skimmed the tomoyo code and it appears that you are excluding kernel
threads so as not to limit kernel threads such as nfsd.  For
PF_IO_WORKER kernel threads which are running code on behalf of a user
we want to perform the ordinary permission checks.  So you want
the idiom you pasted above.

I do wonder though if perhaps we should create a is_user_cred helper to
detect the difference between the creds of kernel threads and the thread
of ordinary userspace.   Which would handle io_uring that copy creds
around and check them at a later time more cleanly.

Eric


