Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5DF2571E6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 04:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgHaCb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 22:31:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10735 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbgHaCb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 22:31:26 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 920CFA952F9902B1F4F0;
        Mon, 31 Aug 2020 10:31:22 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 31 Aug
 2020 10:31:17 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: prevent compressed file from being
 disabled after releasing cblocks
To:     Daeho Jeong <daeho43@gmail.com>
CC:     Chao Yu <chao@kernel.org>, Daeho Jeong <daehojeong@google.com>,
        <kernel-team@android.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200828054629.583577-1-daeho43@gmail.com>
 <61996dcd-6db1-13fc-8239-7e684f3ec49e@kernel.org>
 <CACOAw_wc29AROzFhcGyC73i_vYZC1NmHP60uQfP7X-j6y6=kSA@mail.gmail.com>
 <bd1a8ffa-83ff-b774-9bed-ed68025d0c7a@huawei.com>
 <CACOAw_y=O35_SFxdfsVER4+a+n-eE6f48NXF6CsAnj=Ms-dgkA@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c4f58675-9df5-e3af-45fc-6fa924e3ee68@huawei.com>
Date:   Mon, 31 Aug 2020 10:31:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACOAw_y=O35_SFxdfsVER4+a+n-eE6f48NXF6CsAnj=Ms-dgkA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/31 9:44, Daeho Jeong wrote:
> Sorry, I didn't get your point.
> 
> So, do you think this patch is ok? And we need to consider that we
> need more immutable checks for other cases?

Yes, this patch looks good to me.

But, IMO, we should discuss about whether we need to add more immutable checks
for other ioctl cases.

- open(O_RDWR)
- ioctl(FS_IOC_SETFLAGS, F2FS_COMPR_FL)
- write()
- ioctl(RELEASE_COMPRESS_BLOCKS) -- inode is immutable now
- ioctl(FS_IOC_SETFLAGS, ~F2FS_COMPR_FL) -- Should we allow to update immutable inode?
as we know, normally, immutable inode should deny open(O_WRONLY or O_RDWR) and later update.

Thanks,

> Or you want to remove this immutable check from here and add the check
> to each ioctl functions? >
> 2020년 8월 31일 (월) 오전 10:24, Chao Yu <yuchao0@huawei.com>님이 작성:
>>
>> On 2020/8/31 7:42, Daeho Jeong wrote:
>>> Do you have any reason not to put this check here?
>>
>> No, the place is okay to me. :)
>>
>>> If we do this check outside of here, we definitely make a mistake
>>> sooner or later.
>>
>> I just want to see whether we can cover all cases in where we missed to
>> add immutable check condition if necessary.
>>
>> Thanks,
>>
>>>
>>> 2020년 8월 30일 (일) 오후 12:24, Chao Yu <chao@kernel.org>님이 작성:
>>>>
>>>> On 2020-8-28 13:46, Daeho Jeong wrote:
>>>>> From: Daeho Jeong <daehojeong@google.com>
>>>>>
>>>>> After releasing cblocks, the compressed file can be accidentally
>>>>> disabled in compression mode, since it has zero cblocks. As we are
>>>>> using IMMUTABLE flag to present released cblocks state, we can add
>>>>> IMMUTABLE state check when considering the compressed file disabling.
>>>>>
>>>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>>>> ---
>>>>>    fs/f2fs/f2fs.h | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>> index 02811ce15059..14d30740ba03 100644
>>>>> --- a/fs/f2fs/f2fs.h
>>>>> +++ b/fs/f2fs/f2fs.h
>>>>> @@ -3936,6 +3936,8 @@ static inline u64 f2fs_disable_compressed_file(struct inode *inode)
>>>>>         if (!f2fs_compressed_file(inode))
>>>>>                 return 0;
>>>>>         if (S_ISREG(inode->i_mode)) {
>>>>> +             if (IS_IMMUTABLE(inode))
>>>>> +                     return 1;
>>>>
>>>> It looks most of callers are from ioctl, should we add immutable check in f2fs
>>>> ioctl interfaces if necessary? or I missed existed check.
>>>>
>>>> Thanks,
>>>>
>>>>>                 if (get_dirty_pages(inode))
>>>>>                         return 1;
>>>>>                 if (fi->i_compr_blocks)
>>>>>
>>>
>>>
>>> _______________________________________________
>>> Linux-f2fs-devel mailing list
>>> Linux-f2fs-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>
> .
> 
