Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58112AEE08
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgKKJp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:45:29 -0500
Received: from z5.mailgun.us ([104.130.96.5]:25205 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgKKJp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:45:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605087926; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=KmUJFdZ5vaTRSgEI19I+n3kwXGfObMB5GTEXWs9QZO0=; b=TC85br+wgXgWKBj5LRYOSWPTsZmixjhXL3fEJw7RWZrQvOXxsa3kStOKPYpPcGW6vWKG/J+E
 8J4ZTtaT/gXXEfxIQ7OB2ZBDiXctFC1VThOWxN7iZPLxQVuHUtMJp2DX3tthEWCK5zA4c4UY
 zX/iqYLJSjIYOGh2SaRkNSoDtQs=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5fabb2aed3e05bb6dbc7888d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Nov 2020 09:45:18
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 68B69C433FE; Wed, 11 Nov 2020 09:45:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.43.20] (unknown [106.208.38.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A0CDC433C8;
        Wed, 11 Nov 2020 09:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A0CDC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
Subject: Re: [PATCH] mm: memblock: always inline memblock_alloc
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
References: <1605010817-21065-1-git-send-email-faiyazm@codeaurora.org>
 <20201110184157.GD4758@kernel.org>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <97ca3445-c405-cdc1-b9e6-6ed2386c9c57@codeaurora.org>
Date:   Wed, 11 Nov 2020 15:15:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201110184157.GD4758@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/11/2020 12:11 AM, Mike Rapoport wrote:
> Hi,
>
> On Tue, Nov 10, 2020 at 05:50:17PM +0530, Faiyaz Mohammed wrote:
>> Since memblock_alloc is not getting inlined, memblock_reserve owner info
>> is lost. Below information is not enough for memory accounting.
>> for example:
>> [    0.000000] memblock_alloc_try_nid: 1490 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 memblock_alloc+0x20/0x2c
>> [    0.000000] memblock_reserve: [0x000000023f09a3c0-0x000000023f09a991] memblock_alloc_range_nid+0xc0/0x188
>>
>> Add "__always_inline" to make sure it get inlined and to get the exact
>> owner of the memblock_reserve.
>> After adding __always_inline:
>> [    0.000000] memblock_alloc_try_nid: 1490 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 start_kernel+0xa4/0x568
>> [    0.000000] memblock_reserve: [0x000000023f09a3c0-0x000000023f09a991] memblock_alloc_range_nid+0xc0/0x188
>   
> I agree that making memblock_alloc() inline as well as other similar
> wrappers would improve the debugability.
> Still, it has nothing to do with memory accounting and owner tracking.
> Please update the patch description to better explain what it actually
> improves.

As describe in other thread, do memblock reserved accounting to track 
owners

to know size of memory allocated by different drivers/owners through

memblock_reserve, which help in comparing different kernel version and in

optimizations.
>
>> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
>> ---
>>   include/linux/memblock.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index ef13125..54f9544 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -404,7 +404,7 @@ void *memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align,
>>   			     phys_addr_t min_addr, phys_addr_t max_addr,
>>   			     int nid);
>>   
>> -static inline void * __init memblock_alloc(phys_addr_t size,  phys_addr_t align)
>> +static __always_inline void * __init memblock_alloc(phys_addr_t size,  phys_addr_t align)
> I think simply dropping __init here will make memblock_alloc() inline.
> There are also several more convenience wrappers marked __init, do you
> mind removing the __init annotation for them as well?
Yes, if we drop __init, memblock_alloc will get inline but would it not 
increase

kernel footprint as the function will no more be released after kernel 
init?

>>   {
>>   	return memblock_alloc_try_nid(size, align, MEMBLOCK_LOW_LIMIT,
>>   				      MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE);
