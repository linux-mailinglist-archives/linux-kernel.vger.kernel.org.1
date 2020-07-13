Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E7E21AF6F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 08:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgGJGbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 02:31:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7287 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbgGJGbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 02:31:11 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 65F1A16FA19CD90A6785;
        Fri, 10 Jul 2020 14:31:07 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 10 Jul
 2020 14:31:05 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: change the way of handling range.len in
 F2FS_IOC_SEC_TRIM_FILE
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Daeho Jeong <daeho43@gmail.com>,
        Daeho Jeong <daehojeong@google.com>, <kernel-team@android.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200710021505.2405872-1-daeho43@gmail.com>
 <20200710030246.GA545837@google.com>
 <62c9dd7a-5d18-8bb6-8e43-c055fcff51cc@huawei.com>
 <20200710033100.GE545837@google.com>
 <ede6620c-6fc9-797d-e3ea-e630eb76b309@huawei.com>
 <20200710035215.GI545837@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <34cad197-75eb-d7c2-4465-261d5debfd3b@huawei.com>
Date:   Fri, 10 Jul 2020 14:31:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200710035215.GI545837@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/10 11:52, Jaegeuk Kim wrote:
> On 07/10, Chao Yu wrote:
>> On 2020/7/10 11:31, Jaegeuk Kim wrote:
>>> On 07/10, Chao Yu wrote:
>>>> On 2020/7/10 11:02, Jaegeuk Kim wrote:
>>>>> On 07/10, Daeho Jeong wrote:
>>>>>> From: Daeho Jeong <daehojeong@google.com>
>>>>>>
>>>>>> Changed the way of handling range.len of F2FS_IOC_SEC_TRIM_FILE.
>>>>>>  1. Added -1 value support for range.len to signify the end of file.
>>>>>>  2. If the end of the range passes over the end of file, it means until
>>>>>>     the end of file.
>>>>>>  3. ignored the case of that range.len is zero to prevent the function
>>>>>>     from making end_addr zero and triggering different behaviour of
>>>>>>     the function.
>>>>>>
>>>>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>>>>> ---
>>>>>>  fs/f2fs/file.c | 16 +++++++---------
>>>>>>  1 file changed, 7 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>>> index 368c80f8e2a1..1c4601f99326 100644
>>>>>> --- a/fs/f2fs/file.c
>>>>>> +++ b/fs/f2fs/file.c
>>>>>> @@ -3813,21 +3813,19 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
>>>>>>  	file_start_write(filp);
>>>>>>  	inode_lock(inode);
>>>>>>  
>>>>>> -	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
>>>>>> +	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode) ||
>>>>>> +			range.start >= inode->i_size) {
>>>>>>  		ret = -EINVAL;
>>>>>>  		goto err;
>>>>>>  	}
>>>>>>  
>>>>>> -	if (range.start >= inode->i_size) {
>>>>>> -		ret = -EINVAL;
>>>>>> +	if (range.len == 0)
>>>>>>  		goto err;
>>>>>> -	}
>>>>>>  
>>>>>> -	if (inode->i_size - range.start < range.len) {
>>>>>> -		ret = -E2BIG;
>>>>>> -		goto err;
>>>>>> -	}
>>>>>> -	end_addr = range.start + range.len;
>>>>>> +	if (range.len == (u64)-1 || inode->i_size - range.start < range.len)
>>>>>> +		end_addr = inode->i_size;
>>>>
>>>> We can remove 'range.len == (u64)-1' condition since later condition can cover
>>>> this?
>>>>
>>>>>
>>>>> Hmm, what if there are blocks beyond i_size? Do we need to check i_blocks for
>>>>
>>>> The blocks beyond i_size will never be written, there won't be any valid message
>>>> there, so we don't need to worry about that.
>>>
>>> I don't think we have a way to guarantee the order of i_size and block
>>> allocation in f2fs. See f2fs_write_begin and f2fs_write_end.
>>
>> However, write_begin & write_end are covered by inode_lock, it could not be
>> racy with inode size check in f2fs_sec_trim_file() as it hold inode_lock as
>> well?
> 
> Like Daeho said, write_begin -> checkpoint -> power-cut can give bigger i_blocks
> than i_size.

The path won't, cp only persists reserved block in dnode rather than written
data block in segment, because data will be copied to page cache after write_begin.

I think truncation path could as Daeho said:

1. truncate -> i_size update however blocks wasn't truncated yet -> checkpoint -> recovery
2. truncate failed -> i_size update however partial blocks was truncated -> fsync

> 
>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>>> ending criteria?
>>>>>
>>>>>> +	else
>>>>>> +		end_addr = range.start + range.len;
>>>>>>  
>>>>>>  	to_end = (end_addr == inode->i_size);
>>>>>>  	if (!IS_ALIGNED(range.start, F2FS_BLKSIZE) ||
>>>>>> -- 
>>>>>> 2.27.0.383.g050319c2ae-goog
>>>>>>
>>>>>>
>>>>>>
>>>>>> _______________________________________________
>>>>>> Linux-f2fs-devel mailing list
>>>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> Linux-f2fs-devel mailing list
>>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>>> .
>>>>>
>>> .
>>>
> .
> 
