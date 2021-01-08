Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8512EEB73
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 03:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbhAHCnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 21:43:33 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:36092 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726993AbhAHCnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 21:43:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UL1ZENl_1610073767;
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0UL1ZENl_1610073767)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 08 Jan 2021 10:42:47 +0800
Subject: Re: [PATCH v2 4.9 00/10] fix a race in release_task when flushing the
 dentry
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>
Cc:     Sasha Levin <sashal@kernel.org>,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
References: <20210107075222.62623-1-wenyang@linux.alibaba.com>
 <X/b781Kwn48xq8aS@kroah.com>
 <e0fa1641-d00b-acfc-91d7-9eb16fb61664@linux.alibaba.com>
 <X/dS37kyW+jf4gg/@kroah.com>
From:   Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <82fb683a-bc9d-2083-f657-116f3e96d785@linux.alibaba.com>
Date:   Fri, 8 Jan 2021 10:42:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <X/dS37kyW+jf4gg/@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/1/8 上午2:28, Greg Kroah-Hartman 写道:
> On Fri, Jan 08, 2021 at 12:21:38AM +0800, Wen Yang wrote:
>>
>>
>> 在 2021/1/7 下午8:17, Greg Kroah-Hartman 写道:
>>> On Thu, Jan 07, 2021 at 03:52:12PM +0800, Wen Yang wrote:
>>>> The dentries such as /proc/<pid>/ns/ have the DCACHE_OP_DELETE flag, they
>>>> should be deleted when the process exits.
>>>>
>>>> Suppose the following race appears：
>>>>
>>>> release_task                 dput
>>>> -> proc_flush_task
>>>>                                -> dentry->d_op->d_delete(dentry)
>>>> -> __exit_signal
>>>>                                -> dentry->d_lockref.count--  and return.
>>>>
>>>> In the proc_flush_task(), if another process is using this dentry, it will
>>>> not be deleted. At the same time, in dput(), d_op->d_delete() can be executed
>>>> before __exit_signal(pid has not been hashed), d_delete returns false, so
>>>> this dentry still cannot be deleted.
>>>>
>>>> This dentry will always be cached (although its count is 0 and the
>>>> DCACHE_OP_DELETE flag is set), its parent denry will also be cached too, and
>>>> these dentries can only be deleted when drop_caches is manually triggered.
>>>>
>>>> This will result in wasted memory. What's more troublesome is that these
>>>> dentries reference pid, according to the commit f333c700c610 ("pidns: Add a
>>>> limit on the number of pid namespaces"), if the pid cannot be released, it
>>>> may result in the inability to create a new pid_ns.
>>>>
>>>> This issue was introduced by 60347f6716aa ("pid namespaces: prepare
>>>> proc_flust_task() to flush entries from multiple proc trees"), exposed by
>>>> f333c700c610 ("pidns: Add a limit on the number of pid namespaces"), and then
>>>> fixed by 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc").
>>>
>>> Why are you just submitting a series for 4.9 and 4.19, what about 4.14?
>>> We can't have users move to a newer kernel and then experience old bugs,
>>> right?
>>>
>> Okay, the patches corresponding to 4.14 will be ready later.
> 
> Note for some reason you didn't cc: the stable list for these patches :(
> 
>>> But the larger question is why are you backporting a whole new feature
>>> here?  Why is CLONE_PIDFD needed?  That feels really wrong...
>>>
>>
>> The reason for backporting CLONE_PIDFD is because 7bc3e6e55acf ("proc: Use a
>> list of inodes to flush from proc") relies on wait_pidfd.lock. There are
>> indeed many associated modifications here. We are also testing it. Please
>> check the code more.
> 
> Is the only "issue" here wasted memory?  Will it eventually be freed
> anyway even if you do not echo to the proc file to flush caches?
> 
> You mention the inability to create a new pid for a specific namespace,
> is that really a problem?  Shouldn't the code handle such issues
> normally?  What breaks without these changes?
> 
> I think at this point, it might just time for you to move to a newer
> kernel release, as adding a whole new userspace feature for this feels
> really really odd.
> 
> What is preventing you from doing that today?  What holds you to older
> kernels that will not allow you to move forward?
> 

We have encountered this problem in the cloud server environment. Users 
will frequently create and delete containers, and the corresponding 
pid_ns will accumulate, eventually making it impossible to create a new 
container.

https://bugzilla.kernel.org/show_bug.cgi?id=208613

The kernels (4.9/4.19) used on a large scale in our current production 
environment (almost tens of thousands of machines) may need to be fixed.

Thanks.

-- 
Best wishes,
Wen


