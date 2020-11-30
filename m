Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2996D2C7CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 03:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgK3CGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 21:06:51 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8884 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgK3CGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 21:06:51 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CkpVJ6JF8z6vcd;
        Mon, 30 Nov 2020 10:05:44 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 30 Nov
 2020 10:06:00 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: add compr_inode and compr_blocks sysfs
 nodes
To:     Daeho Jeong <daeho43@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <kernel-team@android.com>, Daeho Jeong <daehojeong@google.com>
References: <20201016051455.1913795-1-daeho43@gmail.com>
 <f8359dde-7e0c-b2fc-451f-2984c50fa552@huawei.com>
 <CACOAw_wrTSZ3DWBUJA=ePe=fDRgEgqCfsbSqKmE6+ACW8A-RQg@mail.gmail.com>
 <2d354bbe-9d1e-f3e0-b918-b9ec023a93ba@huawei.com>
 <CACOAw_x1Zkn-yY-cmWwQUByHVg5mUDqYz86e+TFKWWuhas+_MA@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <3e3e3ec4-89cb-9dc6-e84b-ec4acfba4ffe@huawei.com>
Date:   Mon, 30 Nov 2020 10:05:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACOAw_x1Zkn-yY-cmWwQUByHVg5mUDqYz86e+TFKWWuhas+_MA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, let's export readonly stats in new directory once you have such requirement. :)

Thanks,

On 2020/11/30 10:02, Daeho Jeong wrote:
> Sure, but I don't think we need to expose compr_inode and compr_block right now.
> 
> 2020년 11월 27일 (금) 오후 6:44, Chao Yu <yuchao0@huawei.com>님이 작성:
>>
>> Daeho,
>>
>> How about updating this patch based on below patch?
>>
>>          f2fs: introduce a new per-sb directory in sysfs
>>
>> On 2020/10/22 10:53, Daeho Jeong wrote:
>>> Yep, It sounds good to me.
>>>
>>> 2020년 10월 21일 (수) 오후 3:08, Chao Yu <yuchao0@huawei.com>님이 작성:
>>>>
>>>> On 2020/10/16 13:14, Daeho Jeong wrote:
>>>>> From: Daeho Jeong <daehojeong@google.com>
>>>>>
>>>>> Added compr_inode to show compressed inode count and compr_blocks to
>>>>> show compressed block count in sysfs.
>>>>
>>>> As there are so many entries in ../f2fs/<disk>/ directory, it looks a mess
>>>> there, I suggest that we can add a new directory 'stats' in ../f2fs/<disk>/,
>>>> in where we can store all readonly stats related entries there later.
>>>>
>>>> How do you think?
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>>>> ---
>>>>>     Documentation/ABI/testing/sysfs-fs-f2fs | 10 ++++++++++
>>>>>     fs/f2fs/sysfs.c                         | 17 +++++++++++++++++
>>>>>     2 files changed, 27 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
>>>>> index 834d0becae6d..a01c26484c69 100644
>>>>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
>>>>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
>>>>> @@ -350,3 +350,13 @@ Date:            April 2020
>>>>>     Contact:    "Daeho Jeong" <daehojeong@google.com>
>>>>>     Description:        Give a way to change iostat_period time. 3secs by default.
>>>>>                 The new iostat trace gives stats gap given the period.
>>>>> +
>>>>> +What:                /sys/fs/f2fs/<disk>/compr_inode
>>>>> +Date:                October 2020
>>>>> +Contact:     "Daeho Jeong" <daehojeong@google.com>
>>>>> +Description: Show compressed inode count
>>>>> +
>>>>> +What:                /sys/fs/f2fs/<disk>/compr_blocks
>>>>> +Date:                October 2020
>>>>> +Contact:     "Daeho Jeong" <daehojeong@google.com>
>>>>> +Description: Show compressed block count
>>>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>>>>> index 94c98e412aa1..7139a29a00d3 100644
>>>>> --- a/fs/f2fs/sysfs.c
>>>>> +++ b/fs/f2fs/sysfs.c
>>>>> @@ -223,6 +223,19 @@ static ssize_t avg_vblocks_show(struct f2fs_attr *a,
>>>>>         f2fs_update_sit_info(sbi);
>>>>>         return sprintf(buf, "%llu\n", (unsigned long long)(si->avg_vblocks));
>>>>>     }
>>>>> +
>>>>> +static ssize_t compr_inode_show(struct f2fs_attr *a,
>>>>> +                             struct f2fs_sb_info *sbi, char *buf)
>>>>> +{
>>>>> +     return sprintf(buf, "%u\n", atomic_read(&sbi->compr_inode));
>>>>> +}
>>>>> +
>>>>> +static ssize_t compr_blocks_show(struct f2fs_attr *a,
>>>>> +                             struct f2fs_sb_info *sbi, char *buf)
>>>>> +{
>>>>> +     return sprintf(buf, "%llu\n", atomic64_read(&sbi->compr_blocks));
>>>>> +}
>>>>> +
>>>>>     #endif
>>>>>
>>>>>     static ssize_t main_blkaddr_show(struct f2fs_attr *a,
>>>>> @@ -591,6 +604,8 @@ F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, gc_background_calls, bg_gc);
>>>>>     F2FS_GENERAL_RO_ATTR(moved_blocks_background);
>>>>>     F2FS_GENERAL_RO_ATTR(moved_blocks_foreground);
>>>>>     F2FS_GENERAL_RO_ATTR(avg_vblocks);
>>>>> +F2FS_GENERAL_RO_ATTR(compr_inode);
>>>>> +F2FS_GENERAL_RO_ATTR(compr_blocks);
>>>>>     #endif
>>>>>
>>>>>     #ifdef CONFIG_FS_ENCRYPTION
>>>>> @@ -675,6 +690,8 @@ static struct attribute *f2fs_attrs[] = {
>>>>>         ATTR_LIST(moved_blocks_foreground),
>>>>>         ATTR_LIST(moved_blocks_background),
>>>>>         ATTR_LIST(avg_vblocks),
>>>>> +     ATTR_LIST(compr_inode),
>>>>> +     ATTR_LIST(compr_blocks),
>>>>>     #endif
>>>>>         NULL,
>>>>>     };
>>>>>
>>> .
>>>
> .
> 
