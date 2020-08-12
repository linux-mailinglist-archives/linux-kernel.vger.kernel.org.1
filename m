Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28E72427DA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 11:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgHLJqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 05:46:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:21384 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbgHLJqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 05:46:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597225582; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=duR7d8Btk5Il+cLQiUQeHoY6/Wn6vjKdiB7JeFjEOrQ=; b=I5HAaxJyjkxrxdcO8azWFdPEtLaxwTpwwzt33JJ2Crqh0+MSNX9DEg3zzfZHsIlNkUDk6NpC
 PmXTBKBZ7hBXFW5QEJf1DSqJrBi6b7W8enGTzH0NiHKxaaAQvvspkJd74LtZ/8ORcEQvLRfc
 O+MMQvJz8J4s3gnzeyEt8xR8CVo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f33ba6003528d402430b0f1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 12 Aug 2020 09:46:08
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8CD1DC433C9; Wed, 12 Aug 2020 09:46:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,NICE_REPLY_A,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.103] (unknown [183.83.143.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9C1EFC433C6;
        Wed, 12 Aug 2020 09:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C1EFC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH V2] mm, page_alloc: fix core hung in free_pcppages_bulk()
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        mhocko@suse.com, vbabka@suse.cz, rientjes@google.com,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
References: <1597150703-19003-1-git-send-email-charante@codeaurora.org>
 <fdf574c8-82be-6bde-b73b-c97055f530a8@redhat.com>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <848b7d60-2995-d9ae-0055-f3864dece11f@codeaurora.org>
Date:   Wed, 12 Aug 2020 15:16:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <fdf574c8-82be-6bde-b73b-c97055f530a8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks David for the inputs.

On 8/12/2020 2:35 AM, David Hildenbrand wrote:
> On 11.08.20 14:58, Charan Teja Reddy wrote:
>> The following race is observed with the repeated online, offline and a
>> delay between two successive online of memory blocks of movable zone.
>>
>> P1						P2
>>
>> Online the first memory block in
>> the movable zone. The pcp struct
>> values are initialized to default
>> values,i.e., pcp->high = 0 &
>> pcp->batch = 1.
>>
>> 					Allocate the pages from the
>> 					movable zone.
>>
>> Try to Online the second memory
>> block in the movable zone thus it
>> entered the online_pages() but yet
>> to call zone_pcp_update().
>> 					This process is entered into
>> 					the exit path thus it tries
>> 					to release the order-0 pages
>> 					to pcp lists through
>> 					free_unref_page_commit().
>> 					As pcp->high = 0, pcp->count = 1
>> 					proceed to call the function
>> 					free_pcppages_bulk().
>> Update the pcp values thus the
>> new pcp values are like, say,
>> pcp->high = 378, pcp->batch = 63.
>> 					Read the pcp's batch value using
>> 					READ_ONCE() and pass the same to
>> 					free_pcppages_bulk(), pcp values
>> 					passed here are, batch = 63,
>> 					count = 1.
>>
>> 					Since num of pages in the pcp
>> 					lists are less than ->batch,
>> 					then it will stuck in
>> 					while(list_empty(list)) loop
>> 					with interrupts disabled thus
>> 					a core hung.
>>
>> Avoid this by ensuring free_pcppages_bulk() is called with proper count
>> of pcp list pages.
>>
>> The mentioned race is some what easily reproducible without [1] because
>> pcp's are not updated for the first memory block online and thus there
>> is a enough race window for P2 between alloc+free and pcp struct values
>> update through onlining of second memory block.
>>
>> With [1], the race is still exists but it is very much narrow as we
>> update the pcp struct values for the first memory block online itself.
>>
>> [1]: https://patchwork.kernel.org/patch/11696389/
>>
> 
> IIUC, this is not limited to the movable zone, it could also happen in
> corner cases with the normal zone (e.g., hotplug to a node that only has
> DMA memory, or no other memory yet).

Yes, this is my understanding too. I explained the above race in terms
of just movable zone for which it is observed. We can add the below line
in the end in patch commit message:
"This is not limited to the movable zone, it could also happen in cases
with the normal zone (e.g., hotplug to a node that only has DMA memory,
or no other memory yet)."

Just curious, there exists such systems where just a dma zone present
and we hot add the normal zone? I am not aware such thing in the
embedded world.
> 
>> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
>> ---
>>
>> v1: https://patchwork.kernel.org/patch/11707637/
>>
>>  mm/page_alloc.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index e4896e6..839039f 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1304,6 +1304,11 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>>  	struct page *page, *tmp;
>>  	LIST_HEAD(head);
>>  
>> +	/*
>> +	 * Ensure proper count is passed which otherwise would stuck in the
>> +	 * below while (list_empty(list)) loop.
>> +	 */
>> +	count = min(pcp->count, count);
>>  	while (count) {
>>  		struct list_head *list;
>>  
>>
> 
> Fixes: and Cc: stable... tags?

Fixes: 5f8dcc21211a ("page-allocator: split per-cpu list into
one-list-per-migrate-type")
Cc: <stable@vger.kernel.org> [2.6+]

I am not sure If I should have to raise V3 including these?
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
