Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBAE2EA84A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbhAEKL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 05:11:58 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:55376 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbhAEKL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:11:57 -0500
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 105AB3Yg011941;
        Tue, 5 Jan 2021 19:11:03 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp);
 Tue, 05 Jan 2021 19:11:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 105AB37V011938
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 5 Jan 2021 19:11:03 +0900 (JST)
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
 <239a6775-c514-e752-2520-16668b8bc344@i-love.sakura.ne.jp>
 <20210105075946.GC30414@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <3f6d88e6-6c0f-c954-25b0-df97263ca4bc@i-love.sakura.ne.jp>
Date:   Tue, 5 Jan 2021 19:11:03 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210105075946.GC30414@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/01/05 16:59, Christoph Hellwig wrote:
> On Wed, Dec 23, 2020 at 07:11:38PM +0900, Tetsuo Handa wrote:
>> due to commit 5e6e9852d6f76e01 ("uaccess: add infrastructure for kernel
>> builds with set_fs()") and follow up changes. Don't we need to change this
>> "uaccess_kernel()" with "(current->flags & PF_KTHREAD)" ?
> 
> No.  The real problem here is that when a this funtion is called

Called by "who" ?
Called by "a userspace process" ?
Called by "a kernel thread" ?
Called by "an io_uring service thread" ?

>                                                                  under
> set_fs it allows kernel memory access for all user pointers, and due to
> the indirection in the playload allows reading or changing kernel
> memory.  A kthread does not have that issue.

If this uaccess_kernel() is intended to reject calling this function from
"a userspace process", uaccess_kernel() is failing to reject because
uaccess_kernel() is always "false" for x86.

If this uaccess_kernel() is intended to reject calling this function from
"a kernel thread", uaccess_kernel() is failing to reject because
uaccess_kernel() is always "false" for x86.

If this uaccess_kernel() is intended to reject calling this function from
"an io_uring service thread", uaccess_kernel() is failing to reject because
uaccess_kernel() is always "false" for x86.

What does uaccess_kernel() in sg_check_file_access() (and uhid_char_write(),
ib_safe_file_access(), bpfilter_process_sockopt() etc.) want to check?

> 
>>>> For another example, if uaccess_kernel() is "false" due to CONFIG_SET_FS=n,
>>>> isn't TOMOYO unexpectedly checking permissions for socket operations?
>>>
>>> Can someone explain WTF TOMOYO is even doing there?  A security module
>>> has absolutely no business checking what context it is called from, but
>>> must check the process credentials instead.
>>>
>>
>> TOMOYO distinguishes userspace processes and kernel threads, and grants
>> kernel threads implicit permissions to perform socket operations.
> 
> And this is the problem we need to fix.  A kernel thread can't just have
> implicit permissions only because it is a kernel thread.  Think of e.g.
> the io_uring service threads.

We can use (current->flags & (PF_KTHREAD | PF_IO_WORKER)) == PF_KTHREAD like
https://lkml.kernel.org/r/dacfb329-de66-d0cf-dcf9-f030ea1370de@schaufler-ca.com does
in order to exclude e.g. the io_uring service threads, can't we?

