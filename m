Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65192E1AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 11:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgLWKMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 05:12:34 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:51200 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgLWKMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 05:12:34 -0500
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0BNABeL4021663;
        Wed, 23 Dec 2020 19:11:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav305.sakura.ne.jp);
 Wed, 23 Dec 2020 19:11:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav305.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0BNABe05021659
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 23 Dec 2020 19:11:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: Does uaccess_kernel() work for detecting kernel thread?
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <0bcc0c63-31a3-26fd-bccb-b28af0375c34@i-love.sakura.ne.jp>
 <20201223075307.GA4185@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <239a6775-c514-e752-2520-16668b8bc344@i-love.sakura.ne.jp>
Date:   Wed, 23 Dec 2020 19:11:38 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201223075307.GA4185@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/23 16:53, Christoph Hellwig wrote:
> On Tue, Dec 22, 2020 at 11:39:08PM +0900, Tetsuo Handa wrote:
>> For example, if uaccess_kernel() is "false" due to CONFIG_SET_FS=n,
>> isn't sg_check_file_access() failing to detect kernel context?
> 
> sg_check_file_access does exactly the right thing - fail for all kernel
> threads as those can't support the magic it does.

My question is, in Linux 5.10, sg_check_file_access() for x86 became

static int sg_check_file_access(struct file *filp, const char *caller)
{
	if (filp->f_cred != current_real_cred()) {
		pr_err_once("%s: process %d (%s) changed security contexts after opening file descriptor, this is not allowed.\n",
			caller, task_tgid_vnr(current), current->comm);
		return -EPERM;
	}
	if (0) {
		pr_err_once("%s: process %d (%s) called from kernel context, this is not allowed.\n",
			caller, task_tgid_vnr(current), current->comm);
		return -EACCES;
	}
	return 0;
}

due to commit 5e6e9852d6f76e01 ("uaccess: add infrastructure for kernel
builds with set_fs()") and follow up changes. Don't we need to change this
"uaccess_kernel()" with "(current->flags & PF_KTHREAD)" ?

> 
>> For another example, if uaccess_kernel() is "false" due to CONFIG_SET_FS=n,
>> isn't TOMOYO unexpectedly checking permissions for socket operations?
> 
> Can someone explain WTF TOMOYO is even doing there?  A security module
> has absolutely no business checking what context it is called from, but
> must check the process credentials instead.
> 

TOMOYO distinguishes userspace processes and kernel threads, and grants
kernel threads implicit permissions to perform socket operations.
Since "uaccess_kernel()" became "0" for x86, TOMOYO is no longer able to
grant kernel threads implicit permissions to perform socket operations.
Since Eric says "For PF_IO_WORKER kernel threads which are running code on behalf
of a user we want to perform the ordinary permission checks.", I think that
TOMOYO wants to use "(current->flags & (PF_KTHREAD | PF_IO_WORKER)) == PF_KTHREAD"
instead.

