Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB412A5CD4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 03:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbgKDCwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 21:52:19 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7045 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbgKDCwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 21:52:18 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CQrlx4zPzzhZlN;
        Wed,  4 Nov 2020 10:52:13 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 4 Nov 2020
 10:52:14 +0800
Subject: Re: [f2fs-dev] [PATCH RFC] f2fs: fix compat F2FS_IOC_{MOVE,
 GARBAGE_COLLECT}_RANGE
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201104021906.108534-1-yuchao0@huawei.com>
 <20201104022908.GA832@sol.localdomain>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <2d1f5f85-f1a1-edf1-82a4-ee47fd46c349@huawei.com>
Date:   Wed, 4 Nov 2020 10:52:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201104022908.GA832@sol.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/4 10:29, Eric Biggers wrote:
> On Wed, Nov 04, 2020 at 10:19:06AM +0800, Chao Yu wrote:
>> Eric reported a ioctl bug in below link:
>>
>> https://lore.kernel.org/linux-f2fs-devel/20201103032234.GB2875@sol.localdomain/
>>
>> That said, on some 32-bit architectures, u64 has only 32-bit alignment,
>> notably i386 and x86_32, so that size of struct f2fs_gc_range compiled
>> in x86_32 is 20 bytes, however the size in x86_64 is 24 bytes, binary
>> compiled in x86_32 can not call F2FS_IOC_GARBAGE_COLLECT_RANGE successfully
>> due to mismatched value of ioctl command in betweeen binary and f2fs
>> module, similarly, F2FS_IOC_MOVE_RANGE will fail too.
>>
>> In this patch we introduce two ioctls for compatibility of above special
>> 32-bit binary:
>> - F2FS_IOC32_GARBAGE_COLLECT_RANGE
>> - F2FS_IOC32_MOVE_RANGE
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>
>> Jaegeuk, Eric,
>>
>> I have no 32-bit machine now, so I don't run any test on this patch,
>> please take a look at this RFC patch first.
> 
> You can test this by running a 32-bit binary on a machine with a 64-bit kernel.
> E.g. on x86_64, compile a binary with 'gcc -m32'.

Ah, thanks for providing the option, I can try that.

> 
>>   #ifdef CONFIG_COMPAT
>> +static int f2fs_compat_ioc_gc_range(struct file *file, unsigned long arg)
>> +{
>> +	struct compat_f2fs_gc_range __user *urange;
>> +	struct f2fs_gc_range range;
>> +	int err;
>> +
>> +	urange = compat_ptr(arg);
>> +	err = get_user(range.sync, &urange->sync);
>> +	err |= get_user(range.start, &urange->start);
>> +	err |= get_user(range.len, &urange->len);
>> +	if (err)
>> +		return -EFAULT;
>> +	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(file)))))
>> +		return -EIO;
>> +	if (!f2fs_is_checkpoint_ready(F2FS_I_SB(file_inode(file))))
>> +		return -ENOSPC;
>> +	return f2fs_ioc_gc_range(file, (unsigned long)&range);
>> +}
> 
> This won't work because f2fs_ioc_gc_range() expects a user pointer.  You'll need
> to make the native and compat versions do the copy from user separately, and
> have them call a helper function that takes a pointer to the argument in kernel
> memory.

Yes, I need to introduce function like __f2fs_ioc_gc_range() to accepted pointer
parameter which points kernel memory.

Will do test and resend v2 soon.

Thanks,

> 
> - Eric
> .
> 
