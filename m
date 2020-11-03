Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3647B2A3EBA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgKCIRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:17:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7577 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgKCIRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:17:45 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CQN1v6N41zLsqq;
        Tue,  3 Nov 2020 16:17:39 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 3 Nov 2020
 16:17:40 +0800
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: move ioctl interface definitions to
 separated file
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201102062131.14205-1-yuchao0@huawei.com>
 <20201103032234.GB2875@sol.localdomain>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c7e47bac-16e6-2038-3eb3-0fdb787ce977@huawei.com>
Date:   Tue, 3 Nov 2020 16:17:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201103032234.GB2875@sol.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/3 11:22, Eric Biggers wrote:
> On Mon, Nov 02, 2020 at 02:21:31PM +0800, Chao Yu wrote:
>> +#define F2FS_IOC_MOVE_RANGE		_IOWR(F2FS_IOCTL_MAGIC, 9,	\
>> +						struct f2fs_move_range)
> [...]
>> +#define F2FS_IOC_GARBAGE_COLLECT_RANGE	_IOW(F2FS_IOCTL_MAGIC, 11,	\
>> +						struct f2fs_gc_range)
> [...]
>> +
>> +struct f2fs_gc_range {
>> +	__u32 sync;
>> +	__u64 start;
>> +	__u64 len;
>> +};
> [...]
>> +struct f2fs_move_range {
>> +	__u32 dst_fd;		/* destination fd */
>> +	__u64 pos_in;		/* start position in src_fd */
>> +	__u64 pos_out;		/* start position in dst_fd */
>> +	__u64 len;		/* size to move */
>> +};
> 
> These two structs are weird because there is implicit padding between the __u32
> field and the following __u64 field on some 32-bit architectures (e.g. x86_32)
> but not others (e.g. arm32).
> 
> But f2fs_compat_ioctl() doesn't handle these two ioctls specially, but rather
> just calls through to f2fs_ioctl().  That's wrong, and it means that
> F2FS_IOC_MOVE_RANGE and F2FS_IOC_GARBAGE_COLLECT_RANGE won't work when called
> from an x86_32 binary on an x86_64 kernel.

Nice catch!

> 
> So something needs to be fixed.  I wonder if it's safe to just explicitly add
> the padding field after the fact.  If no one is actually using these two ioctls
> in a case where both userspace and the kernel lack the implicit padding (e.g.,
> x86_32 userspace with x86_32 kernel), it should be fine...

IIRC, Jaegeuk added those interfaces, I hope it's not the requirement from other
f2fs userspace developers...if it is, there may be users.

I found one patch in ext4 which fixes the similar issue, I guess we can fix this
with the same way, thoughts?

commit 4d92dc0f00a775dc2e1267b0e00befb783902fe7
Author: Ben Hutchings <ben@decadent.org.uk>
Date:   Mon May 17 06:00:00 2010 -0400

     ext4: Fix compat EXT4_IOC_ADD_GROUP

     struct ext4_new_group_input needs to be converted because u64 has
     only 32-bit alignment on some 32-bit architectures, notably i386.

Thanks,

> 
> - Eric
> .
> 
