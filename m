Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8156296DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 13:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462967AbgJWL3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 07:29:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:33164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S462945AbgJWL3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 07:29:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 21138B1B6;
        Fri, 23 Oct 2020 11:29:17 +0000 (UTC)
Subject: Re: [PATCH] mm/cma.c: remove redundant cma_mutex lock
To:     David Hildenbrand <david@redhat.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     matthias.bgg@gmail.com, akpm@linux-foundation.org,
        yj.chiang@mediatek.com
References: <20201020102241.3729-1-lecopzer.chen@mediatek.com>
 <458cdc24-f637-ef4b-19de-513ceab14f23@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <fb838857-d0dc-5041-4e94-df5e09a9c403@suse.cz>
Date:   Fri, 23 Oct 2020 13:29:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <458cdc24-f637-ef4b-19de-513ceab14f23@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/20 1:27 PM, David Hildenbrand wrote:
> On 20.10.20 12:22, Lecopzer Chen wrote:
>> The cma_mutex which protects alloc_contig_range() was first appeared in
>> commit 7ee793a62fa8c ("cma: Remove potential deadlock situation"),
>> at that time, there is no guarantee the behavior of concurrency inside
>> alloc_contig_range().
>> 
>> After the commit 2c7452a075d4db2dc
>> ("mm/page_isolation.c: make start_isolate_page_range() fail if already isolated")
>>   > However, two subsystems (CMA and gigantic
>>   > huge pages for example) could attempt operations on the same range.  If
>>   > this happens, one thread may 'undo' the work another thread is doing.
>>   > This can result in pageblocks being incorrectly left marked as
>>   > MIGRATE_ISOLATE and therefore not available for page allocation.
>> The concurrency inside alloc_contig_range() was clarified.
>> 
>> Now we can find that hugepage and virtio call alloc_contig_range() without
>> any lock, thus cma_mutex is "redundant" in cma_alloc() now.
>> 
>> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
>> ---
>>  mm/cma.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>> 
>> diff --git a/mm/cma.c b/mm/cma.c
>> index 7f415d7cda9f..3692a34e2353 100644
>> --- a/mm/cma.c
>> +++ b/mm/cma.c
>> @@ -38,7 +38,6 @@
>>  
>>  struct cma cma_areas[MAX_CMA_AREAS];
>>  unsigned cma_area_count;
>> -static DEFINE_MUTEX(cma_mutex);
>>  
>>  phys_addr_t cma_get_base(const struct cma *cma)
>>  {
>> @@ -454,10 +453,9 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>>  		mutex_unlock(&cma->lock);
>>  
>>  		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
>> -		mutex_lock(&cma_mutex);
>>  		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
>>  				     GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0));
>> -		mutex_unlock(&cma_mutex);
>> +
>>  		if (ret == 0) {
>>  			page = pfn_to_page(pfn);
>>  			break;
>> 
> 
> I guess this is fine. In case there is a race we return with -EBUSY -
> which is suboptimal (as it could just be a temporary issue if the other
> user backs off), but should be good enough for now.

Agreed.

> Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

