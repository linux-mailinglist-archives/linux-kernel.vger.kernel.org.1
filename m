Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79ABD2AAF79
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgKIC3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:29:33 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7468 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgKIC3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:29:32 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CTw1L1NDxzhjDT;
        Mon,  9 Nov 2020 10:29:26 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 9 Nov 2020
 10:29:25 +0800
Subject: Re: [f2fs-dev] [PATCH v4 2/2] f2fs: fix compat F2FS_IOC_{MOVE,
 GARBAGE_COLLECT}_RANGE
To:     Eric Biggers <ebiggers@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201106065331.76236-1-yuchao0@huawei.com>
 <20201106180324.GA78548@sol.localdomain>
 <a7e78b61-021a-444d-eb36-68ce7aae133e@kernel.org>
 <20201107171635.GA841@sol.localdomain>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <63efaa5c-bc19-4b16-653d-840bc6a6d9d1@huawei.com>
Date:   Mon, 9 Nov 2020 10:29:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201107171635.GA841@sol.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/8 1:16, Eric Biggers wrote:
> On Sat, Nov 07, 2020 at 05:25:23PM +0800, Chao Yu wrote:
>> On 2020/11/7 2:03, Eric Biggers wrote:
>>> On Fri, Nov 06, 2020 at 02:53:31PM +0800, Chao Yu wrote:
>>>> +#if defined(__KERNEL__)
>>>> +struct compat_f2fs_gc_range {
>>>> +	u32 sync;
>>>> +	compat_u64 start;
>>>> +	compat_u64 len;
>>>> +};
>>>
>>> There's no need to use '#if defined(__KERNEL__)' in kernel source files.
>>>
>>> Likewise for compat_f2fs_move_range.
>>
>> Correct.
>>
>>>
>>>> +static int f2fs_compat_ioc_gc_range(struct file *file, unsigned long arg)
>>>> +{
>>>> +	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(file));
>>>> +	struct compat_f2fs_gc_range __user *urange;
>>>> +	struct f2fs_gc_range range;
>>>> +	int err;
>>>> +
>>>> +	if (unlikely(f2fs_cp_error(sbi)))
>>>> +		return -EIO;
>>>> +	if (!f2fs_is_checkpoint_ready(sbi))
>>>> +		return -ENOSPC;
>>>
>>> I still don't understand why this checkpoint-related stuff is getting added
>>> here, and only to the compat versions of the ioctls.  It wasn't in the original
>>> version.  If they are needed then they should be added to __f2fs_ioc_gc_range()
>>> and __f2fs_ioc_move_range() (preferably by a separate patch) so that they are
>>
>> If so, cp-related stuff will be checked redundantly in both f2fs_ioctl() and
>> __f2fs_ioc_xxx() function for native GC_RANGE and MOVE_RANGE ioctls, it's
>> not needed.
>>
> 
> Oh I see, the cp-related checks are at the beginning of f2fs_ioctl() too.
> 
> In that case a much better approach would be to add __f2fs_ioctl() which is
> called by f2fs_ioctl() and f2fs_compat_ioctl(), and have f2fs_ioctl() and
> f2fs_compat_ioctl() do the cp-related checks but not __f2fs_ioctl().

Will this cleanup make sense to you?

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 458724c00d98..1439577108c2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4249,16 +4249,10 @@ struct compat_f2fs_gc_range {

  static int f2fs_compat_ioc_gc_range(struct file *file, unsigned long arg)
  {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(file));
  	struct compat_f2fs_gc_range __user *urange;
  	struct f2fs_gc_range range;
  	int err;

-	if (unlikely(f2fs_cp_error(sbi)))
-		return -EIO;
-	if (!f2fs_is_checkpoint_ready(sbi))
-		return -ENOSPC;
-
  	urange = compat_ptr(arg);
  	err = get_user(range.sync, &urange->sync);
  	err |= get_user(range.start, &urange->start);
@@ -4280,16 +4274,10 @@ struct compat_f2fs_move_range {

  static int f2fs_compat_ioc_move_range(struct file *file, unsigned long arg)
  {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(file));
  	struct compat_f2fs_move_range __user *urange;
  	struct f2fs_move_range range;
  	int err;

-	if (unlikely(f2fs_cp_error(sbi)))
-		return -EIO;
-	if (!f2fs_is_checkpoint_ready(sbi))
-		return -ENOSPC;
-
  	urange = compat_ptr(arg);
  	err = get_user(range.dst_fd, &urange->dst_fd);
  	err |= get_user(range.pos_in, &urange->pos_in);
@@ -4301,6 +4289,27 @@ static int f2fs_compat_ioc_move_range(struct file *file, unsigned long arg)
  	return __f2fs_ioc_move_range(file, &range);
  }

+static long __f2fs_compat_ioctl(struct file *file, unsigned int cmd,
+							unsigned long arg)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(file));
+
+	if (unlikely(f2fs_cp_error(sbi)))
+		return -EIO;
+	if (!f2fs_is_checkpoint_ready(sbi))
+		return -ENOSPC;
+
+	switch (cmd) {
+	case F2FS_IOC32_GARBAGE_COLLECT_RANGE:
+		return f2fs_compat_ioc_gc_range(file, arg);
+	case F2FS_IOC32_MOVE_RANGE:
+		return f2fs_compat_ioc_move_range(file, arg);
+	default:
+		return -ENOIOCTLCMD;
+	}
+	return 0;
+}
+
  long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
  {
  	switch (cmd) {
@@ -4314,9 +4323,8 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
  		cmd = FS_IOC_GETVERSION;
  		break;
  	case F2FS_IOC32_GARBAGE_COLLECT_RANGE:
-		return f2fs_compat_ioc_gc_range(file, arg);
  	case F2FS_IOC32_MOVE_RANGE:
-		return f2fs_compat_ioc_move_range(file, arg);
+		return __f2fs_compat_ioctl(file, cmd, arg);
  	case F2FS_IOC_START_ATOMIC_WRITE:
  	case F2FS_IOC_COMMIT_ATOMIC_WRITE:
  	case F2FS_IOC_START_VOLATILE_WRITE:

Thanks,

> 
> I feel that's still not entirely correct, because ENOTTY should take precedence
> over EIO or ENOSPC from the cp-related stuff.  But at least it would be
> consistent between the native and compat ioctls, and the cp-related checks
> wouldn't have to be duplicated in random ioctls...
> 
> - Eric
> .
> 
