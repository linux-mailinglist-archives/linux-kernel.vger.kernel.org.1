Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803D9273A27
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 07:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgIVF1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 01:27:31 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:34599 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726790AbgIVF1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 01:27:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U9kbxxV_1600752447;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U9kbxxV_1600752447)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Sep 2020 13:27:28 +0800
Subject: Re: [PATCH] mm/shmem.c: Fix the missing unaccount on the failed path
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200920163005.97079-1-tianjia.zhang@linux.alibaba.com>
 <alpine.LSU.2.11.2009201141510.4318@eggly.anvils>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <97780c27-4e66-0dc4-c05f-36adc11234a2@linux.alibaba.com>
Date:   Tue, 22 Sep 2020 13:27:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2009201141510.4318@eggly.anvils>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/20 2:49 AM, Hugh Dickins wrote:
> On Mon, 21 Sep 2020, Tianjia Zhang wrote:
> 
>> In function __shmem_file_setup(), shmem_unacct_size() is forgotten
>> on the failed path, so add it.
>>
>> Fixes: 93dec2da7b234 ("... and switch shmem_file_setup() to alloc_file_pseudo()")
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> ---
>>   mm/shmem.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 8e2b35ba93ad..591410dc3541 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -4200,8 +4200,10 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, l
>>   	if (!IS_ERR(res))
>>   		res = alloc_file_pseudo(inode, mnt, name, O_RDWR,
>>   				&shmem_file_operations);
>> -	if (IS_ERR(res))
>> +	if (IS_ERR(res)) {
>>   		iput(inode);
>> +		shmem_unacct_size(flags, size);
>> +	}
>>   	return res;
>>   }
>>   
>> -- 
>> 2.19.1.3.ge56e4f7
> 
> Looks mistaken to me.
> 
> Is this something you noticed by source inspection,
> or something you have observed in practice?
> 
> I haven't tried exercising this path while injecting errors into
> alloc_file_pseudo(); but what I'd expect to happen is that the
> iput(inode), which you see already on that error path, will get
> to evict the inode, which will entail calling shmem_evict_inode(),
> which does that shmem_unacct_size() itself.
> 
> Hugh
> 

I noticed by looking at the code. you are right, I neglected this point, 
thanks for your explanation.

Thanks,
Tianjia
