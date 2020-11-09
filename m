Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBAF2AAF3B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgKICO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:14:59 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7467 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgKICO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:14:58 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CTvhY092Qzhj9x;
        Mon,  9 Nov 2020 10:14:53 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 9 Nov 2020
 10:14:56 +0800
Subject: Re: [f2fs-dev] [PATCH v3 2/2] f2fs: fix compat F2FS_IOC_{MOVE,
 GARBAGE_COLLECT}_RANGE
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <daeho43@gmail.com>
CC:     Eric Biggers <ebiggers@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201105010934.16018-1-yuchao0@huawei.com>
 <20201106000550.GD2555324@gmail.com>
 <07454135-539d-a159-deb8-ff29df7e22de@huawei.com>
 <20201106214028.GC1474936@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <3108fbd8-94c2-31e6-cbaf-ec4756f3dd88@huawei.com>
Date:   Mon, 9 Nov 2020 10:14:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201106214028.GC1474936@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/7 5:40, Jaegeuk Kim wrote:
> On 11/06, Chao Yu wrote:
>> On 2020/11/6 8:05, Eric Biggers wrote:
>>> This patch is marked 2/2, but it seems you sent it out on its own.  Patch series
>>> are supposed to be resend in full; otherwise people can see just one patch and
>>> have no context.
>>
>> That's a historical problem, as in last many years, we (f2fs community) don't have
>> other long-term reviewers except Jaegeuk and me, so we have unwritten rule: only
>> resending changed patch in patchset.
>>
>> IMO, that helps to skip traversing unchanged patches, and focusing reviewing on the
>> real change lines, and certainly we have its context in mind.
>>
>> Personally, I prefer to revise, resend or review patch{,es} of patchset have real
>> change line in f2fs mailing list, anyway we can discuss about the rule here.
> 
> Chao, I think we need to change this to resend whole patch-set again, since
> it's a bit difficult to catch which part of patches were the latest one.

Oh, I've no objection, if it really helps you.

+Daeho,

Thanks,

> 
>>
>>>
>>> On Thu, Nov 05, 2020 at 09:09:34AM +0800, Chao Yu wrote:
>>>> Eric reported a ioctl bug in below link:
>>>>
>>>> https://lore.kernel.org/linux-f2fs-devel/20201103032234.GB2875@sol.localdomain/
>>>>
>>>> That said, on some 32-bit architectures, u64 has only 32-bit alignment,
>>>> notably i386 and x86_32, so that size of struct f2fs_gc_range compiled
>>>> in x86_32 is 20 bytes, however the size in x86_64 is 24 bytes, binary
>>>> compiled in x86_32 can not call F2FS_IOC_GARBAGE_COLLECT_RANGE successfully
>>>> due to mismatched value of ioctl command in between binary and f2fs
>>>> module, similarly, F2FS_IOC_MOVE_RANGE will fail too.
>>>>
>>>> In this patch we introduce two ioctls for compatibility of above special
>>>> 32-bit binary:
>>>> - F2FS_IOC32_GARBAGE_COLLECT_RANGE
>>>> - F2FS_IOC32_MOVE_RANGE
>>>>
>>>
>>> It would be good to add a proper reported-by line, otherwise it's not clear who
>>> "Eric" is (there are lots of Erics):
>>>
>>> Reported-by: Eric Biggers <ebiggers@google.com>
>> Sure, although I attached the link includes original report email, in where it
>> points out who "Eric" is.
>>
>>>
>>>> +static int __f2fs_ioc_gc_range(struct file *filp, struct f2fs_gc_range *range)
>>>>    {
>>>> -	struct inode *inode = file_inode(filp);
>>>> -	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>> -	struct f2fs_gc_range range;
>>>> +	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
>>>>    	u64 end;
>>>>    	int ret;
>>>> +	if (unlikely(f2fs_cp_error(sbi)))
>>>> +		return -EIO;
>>>> +	if (!f2fs_is_checkpoint_ready(sbi))
>>>> +		return -ENOSPC;
>>>
>>> These two checkpoint-related checks weren't present in the original version.
>>> Is that intentional?
>>
>> Quoted
>>
>>> It would be better to have __f2fs_ioc_gc_range() handle the f2fs_cp_error(),
>>> f2fs_is_checkpoint_ready(), capable(), and f2fs_readonly() checks, so that they
>>> don't have to be duplicated in the native and compat cases.
>>
>>> Similarly for "move range".
>>
>> I missed to check the detail, and just follow, I can clean up it.
>>
>>>
>>>> +static int __f2fs_ioc_move_range(struct file *filp,
>>>> +				struct f2fs_move_range *range)
>>>>    {
>>>> -	struct f2fs_move_range range;
>>>> +	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
>>>>    	struct fd dst;
>>>>    	int err;
>>>> +	if (unlikely(f2fs_cp_error(sbi)))
>>>> +		return -EIO;
>>>> +	if (!f2fs_is_checkpoint_ready(sbi))
>>>> +		return -ENOSPC;
>>>> +
>>>
>>> Likewise here.
>>>
>>>> diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
>>>> index f00199a2e38b..8c14e88a9645 100644
>>>> --- a/include/uapi/linux/f2fs.h
>>>> +++ b/include/uapi/linux/f2fs.h
>>>> @@ -5,6 +5,10 @@
>>>>    #include <linux/types.h>
>>>>    #include <linux/ioctl.h>
>>>> +#ifdef __KERNEL__
>>>> +#include <linux/compat.h>
>>>> +#endif
>>>> +
>>>>    /*
>>>>     * f2fs-specific ioctl commands
>>>>     */
>>>> @@ -65,6 +69,16 @@ struct f2fs_gc_range {
>>>>    	__u64 len;
>>>>    };
>>>> +#if defined(__KERNEL__) && defined(CONFIG_COMPAT)
>>>> +struct compat_f2fs_gc_range {
>>>> +	u32 sync;
>>>> +	compat_u64 start;
>>>> +	compat_u64 len;
>>>> +};
>>>> +#define F2FS_IOC32_GARBAGE_COLLECT_RANGE	_IOW(F2FS_IOCTL_MAGIC, 11,\
>>>> +						struct compat_f2fs_gc_range)
>>>> +#endif
>>>> +
>>>>    struct f2fs_defragment {
>>>>    	__u64 start;
>>>>    	__u64 len;
>>>> @@ -77,6 +91,17 @@ struct f2fs_move_range {
>>>>    	__u64 len;		/* size to move */
>>>>    };
>>>> +#if defined(__KERNEL__) && defined(CONFIG_COMPAT)
>>>> +struct compat_f2fs_move_range {
>>>> +	u32 dst_fd;
>>>> +	compat_u64 pos_in;
>>>> +	compat_u64 pos_out;
>>>> +	compat_u64 len;
>>>> +};
>>>> +#define F2FS_IOC32_MOVE_RANGE		_IOWR(F2FS_IOCTL_MAGIC, 9,	\
>>>> +					struct compat_f2fs_move_range)
>>>> +#endif
>>>> +
>>>>    struct f2fs_flush_device {
>>>>    	__u32 dev_num;		/* device number to flush */
>>>>    	__u32 segments;		/* # of segments to flush */
>>>> -- 
>>>
>>> Did you consider instead putting these compat definitions in an internal kernel
>>> header, or even just in the .c file, to avoid cluttering up the UAPI header?
>>
>> Better.
>>
>> I can move them before their use.
>>
>>>
>>> - Eric
>>> .
>>>
> .
> 
