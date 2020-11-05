Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4702A7439
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 02:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387984AbgKEBBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 20:01:07 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7413 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgKEBBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 20:01:06 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CRQF92qWxz71p3;
        Thu,  5 Nov 2020 09:01:01 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 5 Nov 2020
 09:00:59 +0800
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: fix compat F2FS_IOC_{MOVE,
 GARBAGE_COLLECT}_RANGE
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201104064310.15769-1-yuchao0@huawei.com>
 <20201104064310.15769-2-yuchao0@huawei.com>
 <20201104180153.GB846@sol.localdomain>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <2bec3d16-e920-12b9-562d-0e055c1af28e@huawei.com>
Date:   Thu, 5 Nov 2020 09:00:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201104180153.GB846@sol.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/5 2:01, Eric Biggers wrote:
> On Wed, Nov 04, 2020 at 02:43:10PM +0800, Chao Yu wrote:
>> +static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
>> +{
>> +	struct f2fs_gc_range range;
>> +	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
>> +
>> +	if (!capable(CAP_SYS_ADMIN))
>> +		return -EPERM;
>> +	if (f2fs_readonly(sbi->sb))
>> +		return -EROFS;
>> +	if (copy_from_user(&range, (struct f2fs_gc_range __user *)arg,
>> +							sizeof(range)))
>> +		return -EFAULT;
>> +
>> +	return __f2fs_ioc_gc_range(filp, &range);
>> +}
> [...]
>>   #ifdef CONFIG_COMPAT
>> +static int f2fs_compat_ioc_gc_range(struct file *file, unsigned long arg)
>> +{
>> +	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(file));
>> +	struct compat_f2fs_gc_range __user *urange;
>> +	struct f2fs_gc_range range;
>> +	int err;
>> +
>> +	if (unlikely(f2fs_cp_error(sbi)))
>> +		return -EIO;
>> +	if (!f2fs_is_checkpoint_ready(sbi))
>> +		return -ENOSPC;
>> +	if (!capable(CAP_SYS_ADMIN))
>> +		return -EPERM;
>> +	if (f2fs_readonly(sbi->sb))
>> +		return -EROFS;
>> +
>> +	urange = compat_ptr(arg);
>> +	err = get_user(range.sync, &urange->sync);
>> +	err |= get_user(range.start, &urange->start);
>> +	err |= get_user(range.len, &urange->len);
>> +	if (err)
>> +		return -EFAULT;
>> +
>> +	return __f2fs_ioc_gc_range(file, &range);
>> +}
> 
> It would be better to have __f2fs_ioc_gc_range() handle the f2fs_cp_error(),
> f2fs_is_checkpoint_ready(), capable(), and f2fs_readonly() checks, so that they
> don't have to be duplicated in the native and compat cases.
> 
> Similarly for "move range".

Will clean up in v3.

Thanks,

> 
> - Eric
> .
> 
