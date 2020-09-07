Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8093225F428
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 09:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgIGHkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 03:40:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38306 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726780AbgIGHkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:40:02 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 49C84B6DC479BDDA8B6A;
        Mon,  7 Sep 2020 15:39:59 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 7 Sep 2020
 15:39:54 +0800
Subject: Re: [PATCH 1/1] block: move the PAGE_SECTORS definition into
 <linux/blkdev.h>
To:     Coly Li <colyli@suse.de>
CC:     Jens Axboe <axboe@kernel.dk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        dm-devel <dm-devel@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-bcache <linux-bcache@vger.kernel.org>
References: <20200821020345.3358-1-thunder.leizhen@huawei.com>
 <b4643e74-aad9-385f-01f2-f8e48ba4dbef@suse.de>
 <ad100923-e479-faf0-f749-ac8e4cf87899@huawei.com>
 <8aa638b7-6cfd-bf3d-8015-fbe59f28f31f@suse.de>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <c2f8cf50-d9f7-df19-40eb-0543e6208c0d@huawei.com>
Date:   Mon, 7 Sep 2020 15:39:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <8aa638b7-6cfd-bf3d-8015-fbe59f28f31f@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jens Axboe, Alasdair Kergon, Mike Snitzer:
  What's your opinion?


On 2020/8/21 15:05, Coly Li wrote:
> On 2020/8/21 14:48, Leizhen (ThunderTown) wrote:
>>
>>
>> On 8/21/2020 12:11 PM, Coly Li wrote:
>>> On 2020/8/21 10:03, Zhen Lei wrote:
>>>> There are too many PAGE_SECTORS definitions, and all of them are the
>>>> same. It looks a bit of a mess. So why not move it into <linux/blkdev.h>,
>>>> to achieve a basic and unique definition.
>>>>
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>
>>>
>>> A lazy question about page size > 4KB: currently in bcache code the
>>> sector size is assumed to be 512 sectors, if kernel page > 4KB, it is
>>> possible that PAGE_SECTORS in bcache will be a number > 8 ?
>>
>> Sorry, I don't fully understand your question. I known that the sector size
>> can be 512 or 4K, and the PAGE_SIZE can be 4K or 64K. So even if sector size
>> is 4K, isn't it greater than 8 for 64K pages?
>>
>> I'm not sure if the question you're asking is the one Matthew Wilcox has
>> answered before:
>> https://www.spinics.net/lists/raid/msg64345.html
> 
> Thank you for the above information. Currently bcache code assumes
> sector size is always 512 bytes, you may see how many "<< 9" or ">> 9"
> are used. Therefore I doubt whether current code may stably work on e.g.
> 4Kn SSDs (this is only doubt because I don't have such SSD).
> 
> Anyway your patch is fine to me. This change to bcache doesn't make
> thins worse or better, maybe it can be helpful to trigger my above
> suspicious early if people do have this kind of problem on 4Kn sector SSDs.
> 
> For the bcache part of this patch, you may add,
> Acked-by: Coly Li <colyli@suse.de>
> 
> Thanks.
> 
> Coly Li
> 
>>>> ---
>>>>  drivers/block/brd.c           | 1 -
>>>>  drivers/block/null_blk_main.c | 1 -
>>>>  drivers/md/bcache/util.h      | 2 --
>>>>  include/linux/blkdev.h        | 5 +++--
>>>>  include/linux/device-mapper.h | 1 -
>>>>  5 files changed, 3 insertions(+), 7 deletions(-)
>>>>
>>>
>>> [snipped]
>>>
>>>> diff --git a/drivers/md/bcache/util.h b/drivers/md/bcache/util.h
>>>> index c029f7443190805..55196e0f37c32c6 100644
>>>> --- a/drivers/md/bcache/util.h
>>>> +++ b/drivers/md/bcache/util.h
>>>> @@ -15,8 +15,6 @@
>>>>  
>>>>  #include "closure.h"
>>>>  
>>>> -#define PAGE_SECTORS		(PAGE_SIZE / 512)
>>>> -
>>>>  struct closure;
>>>>  
>>>>  #ifdef CONFIG_BCACHE_DEBUG
>>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>>> index bb5636cc17b91a7..b068dfc5f2ef0ab 100644
>>>> --- a/include/linux/blkdev.h
>>>> +++ b/include/linux/blkdev.h
>>>> @@ -949,11 +949,12 @@ static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
>>>>   * multiple of 512 bytes. Hence these two constants.
>>>>   */
>>>>  #ifndef SECTOR_SHIFT
>>>> -#define SECTOR_SHIFT 9
>>>> +#define SECTOR_SHIFT		9
>>>>  #endif
>>>>  #ifndef SECTOR_SIZE
>>>> -#define SECTOR_SIZE (1 << SECTOR_SHIFT)
>>>> +#define SECTOR_SIZE		(1 << SECTOR_SHIFT)
>>>>  #endif
>>>> +#define PAGE_SECTORS		(PAGE_SIZE / SECTOR_SIZE)
>>>>  
>>>>  /*
>>>>   * blk_rq_pos()			: the current sector
>>> [snipped]
>>>
>>>
>>
> 
> 
> .
> 

