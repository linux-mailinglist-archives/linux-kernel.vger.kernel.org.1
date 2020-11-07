Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBDE2AA43D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 10:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgKGJZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 04:25:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727810AbgKGJZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 04:25:27 -0500
Received: from [192.168.0.113] (unknown [117.89.214.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 733BF20719;
        Sat,  7 Nov 2020 09:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604741127;
        bh=iqpA6o35pg+nbMb5DHnGD+JQW+uCz/XmulgnMdR5h2c=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=V78g9n4PnmWuyNsGps29ODYrO88XCFjh1LRUbIDP8HTFqBncFcQv/dgtDrbIBA4Bj
         JA/LYIYiHHhszX300/tLH4kENFN2RlmHt4d9tylqitlpT72h7GDYwNB8+QsJzmiyKW
         K03db7oG1Lp8Mo1me9HYrrXb2ve8Ov1CrDG0+mJ0=
From:   Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v4 2/2] f2fs: fix compat F2FS_IOC_{MOVE,
 GARBAGE_COLLECT}_RANGE
To:     Eric Biggers <ebiggers@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20201106065331.76236-1-yuchao0@huawei.com>
 <20201106180324.GA78548@sol.localdomain>
Message-ID: <a7e78b61-021a-444d-eb36-68ce7aae133e@kernel.org>
Date:   Sat, 7 Nov 2020 17:25:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201106180324.GA78548@sol.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/7 2:03, Eric Biggers wrote:
> On Fri, Nov 06, 2020 at 02:53:31PM +0800, Chao Yu wrote:
>> +#if defined(__KERNEL__)
>> +struct compat_f2fs_gc_range {
>> +	u32 sync;
>> +	compat_u64 start;
>> +	compat_u64 len;
>> +};
> 
> There's no need to use '#if defined(__KERNEL__)' in kernel source files.
> 
> Likewise for compat_f2fs_move_range.

Correct.

> 
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
> 
> I still don't understand why this checkpoint-related stuff is getting added
> here, and only to the compat versions of the ioctls.  It wasn't in the original
> version.  If they are needed then they should be added to __f2fs_ioc_gc_range()
> and __f2fs_ioc_move_range() (preferably by a separate patch) so that they are

If so, cp-related stuff will be checked redundantly in both f2fs_ioctl() and 
__f2fs_ioc_xxx() function for native GC_RANGE and MOVE_RANGE ioctls, it's not 
needed.

Thanks,

> done for both the native and compat versions of these ioctls.
> 
> - Eric
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
