Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB692E0BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 15:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgLVOkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 09:40:04 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:65284 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgLVOkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:40:03 -0500
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0BMEd8CK006238;
        Tue, 22 Dec 2020 23:39:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp);
 Tue, 22 Dec 2020 23:39:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0BMEd7o5006232
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 22 Dec 2020 23:39:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
To:     Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Does uaccess_kernel() work for detecting kernel thread?
Message-ID: <0bcc0c63-31a3-26fd-bccb-b28af0375c34@i-love.sakura.ne.jp>
Date:   Tue, 22 Dec 2020 23:39:08 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit db68ce10c4f0a27c ("new helper: uaccess_kernel()") replaced segment_eq(get_fs(), KERNEL_DS)
with uaccess_kernel(). But uaccess_kernel() became an unconditional "false" for some architectures
due to commit 5e6e9852d6f76e01 ("uaccess: add infrastructure for kernel builds with set_fs()") and
follow up changes in Linux 5.10. As a result, I guess that uaccess_kernel() can no longer be used
as a condition for checking whether current thread is a kernel thread or not.

For example, if uaccess_kernel() is "false" due to CONFIG_SET_FS=n,
isn't sg_check_file_access() failing to detect kernel context?

static int sg_check_file_access(struct file *filp, const char *caller)
{
	if (filp->f_cred != current_real_cred()) {
		pr_err_once("%s: process %d (%s) changed security contexts after opening file descriptor, this is not allowed.\n",
			caller, task_tgid_vnr(current), current->comm);
		return -EPERM;
	}
	if (uaccess_kernel()) {
		pr_err_once("%s: process %d (%s) called from kernel context, this is not allowed.\n",
			caller, task_tgid_vnr(current), current->comm);
		return -EACCES;
	}
	return 0;
}

For another example, if uaccess_kernel() is "false" due to CONFIG_SET_FS=n,
isn't TOMOYO unexpectedly checking permissions for socket operations?

static bool tomoyo_kernel_service(void)
{
	/* Nothing to do if I am a kernel service. */
	return uaccess_kernel();
}

static u8 tomoyo_sock_family(struct sock *sk)
{
	u8 family;

	if (tomoyo_kernel_service())
		return 0;
	family = sk->sk_family;
	switch (family) {
	case PF_INET:
	case PF_INET6:
	case PF_UNIX:
		return family;
	default:
		return 0;
	}
}

Don't we need to replace such usage with something like (current->flags & PF_KTHREAD) ?
I don't know about io_uring, but according to
https://lkml.kernel.org/r/dacfb329-de66-d0cf-dcf9-f030ea1370de@schaufler-ca.com ,
should (current->flags & (PF_KTHREAD | PF_IO_WORKER)) == PF_KTHREAD be used instead?
