Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9CA2D384D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 02:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgLIBex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 20:34:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9556 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgLIBex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 20:34:53 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CrKLx3kDKzM22W;
        Wed,  9 Dec 2020 09:33:29 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 9 Dec 2020
 09:34:07 +0800
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix race of pending_pages in
 decompression
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
CC:     Daeho Jeong <daehojeong@google.com>, <kernel-team@android.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201205042626.1113600-1-daeho43@gmail.com>
 <X86RJdLhOVRm28Eu@gmail.com>
 <CACOAw_yp0LU-vcT2+NTF3ipibF6GvqfaQ4V=957CDPQLbes92Q@mail.gmail.com>
 <X88ZC4f2hZxAU3C0@gmail.com> <X9ASZV4ZBBPxCpU/@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <55db08c3-6b3f-a78b-c40d-7f61cd7693b7@huawei.com>
Date:   Wed, 9 Dec 2020 09:34:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <X9ASZV4ZBBPxCpU/@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/9 7:55, Jaegeuk Kim wrote:
> On 12/07, Eric Biggers wrote:
>> On Tue, Dec 08, 2020 at 08:51:45AM +0900, Daeho Jeong wrote:
>>>> I am trying to review this but it is very hard, as the f2fs compression code is
>>>> very hard to understand.
>>>>
>>>> It looks like a 'struct decompress_io_ctx' represents the work to decompress a
>>>> particular cluster.  Since the compressed data of the cluster can be read using
>>>> multiple bios, there is a reference count of how many pages are remaining to be
>>>> read before all the cluster's pages have been read and decompression can start.
>>>>
>>>> What I don't understand is why that reference counting needs to work differently
>>>> depending on whether verity is enabled or not.  Shouldn't it be exactly the
>>>> same?
>>>>
>>>> There also seems to be some confusion about the scope of STEP_VERITY.  Before
>>>> f2fs compression was added, it was a per-bio thing.  But now in a compressed
>>>> file, it's really a per-cluster thing, since all decompressed pages in a
>>>> compressed cluster are verified (or not verified) at once.
>>>>
>>>> Wouldn't it make a lot more sense to, when a cluster needs both compression and
>>>> verity, *not* set STEP_VERITY on the bios, but rather set a similar flag in the
>>>> decompress_io_ctx?
>>>>
>>>
>>> Eric,
>>>
>>> Decompression and verity can be executed in different thread contexts
>>> in different timing, so we need separate counts for each.
>>>
>>> We already use STEP_VERITY for non-compression case, so I think using
>>> this flag in here looks more making sense.
>>>
>>> Thanks,
>>
>> That didn't really answer my questions.
>>
>> I gave up trying to review this patch as the compression post-read handling is
>> just way too weird and hard to understand.  I wrote a patch to clean it all up
>> instead, please take a look:
>> https://lkml.kernel.org/r/20201208060328.2237091-1-ebiggers@kernel.org
> 
> Eric,
> I also tried to review your patch, but it's quite hard to follow quickly and

Me too, it needs more time to check whether the cleanup doesn't miss any cases.

Thanks,

> requires stress tests for a while. Given upcoming merge window and urgency of
> the bug, let me apply Daeho's fix first. By any chance, may I ask revisiting
> your clean-up on top of the fix in the next cycle?
> 
> Thanks,
> 
>>
>> - Eric
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
