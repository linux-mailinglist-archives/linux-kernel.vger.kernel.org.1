Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71C92C586D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbgKZPoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:44:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:41482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbgKZPoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:44:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2A8F6ACC4;
        Thu, 26 Nov 2020 15:44:05 +0000 (UTC)
Subject: Re: [PATCH next] mm/swap.c: reduce lock contention in lru_cache_add
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Yu Zhao <yuzhao@google.com>, Alex Shi <alex.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1605860847-47445-1-git-send-email-alex.shi@linux.alibaba.com>
 <20201126045234.GA1014081@google.com>
 <ed19e3f7-33cb-20ae-537e-a7ada2036895@linux.alibaba.com>
 <20201126072402.GA1047005@google.com>
 <464fa387-9dfd-a8c7-3d86-040f26fd4115@suse.cz>
Message-ID: <c3d53633-af28-79c1-f42c-d5b851af4d56@suse.cz>
Date:   Thu, 26 Nov 2020 16:44:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <464fa387-9dfd-a8c7-3d86-040f26fd4115@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/20 12:22 PM, Vlastimil Babka wrote:
> On 11/26/20 8:24 AM, Yu Zhao wrote:
>> On Thu, Nov 26, 2020 at 02:39:03PM +0800, Alex Shi wrote:
>>> 
>>> 
>>> 在 2020/11/26 下午12:52, Yu Zhao 写道:
>>> >>   */
>>> >>  void __pagevec_lru_add(struct pagevec *pvec)
>>> >>  {
>>> >> -	int i;
>>> >> -	struct lruvec *lruvec = NULL;
>>> >> +	int i, nr_lruvec;
>>> >>  	unsigned long flags = 0;
>>> >> +	struct page *page;
>>> >> +	struct lruvecs lruvecs;
>>> >>  
>>> >> -	for (i = 0; i < pagevec_count(pvec); i++) {
>>> >> -		struct page *page = pvec->pages[i];
>>> >> +	nr_lruvec = sort_page_lruvec(&lruvecs, pvec);
>>> > Simply looping pvec multiple times (15 at most) for different lruvecs
>>> > would be better because 1) it requires no extra data structures and
>>> > therefore has better cache locality (theoretically faster) 2) it only
>>> > loops once when !CONFIG_MEMCG and !CONFIG_NUMA and therefore has no
>>> > impact on Android and Chrome OS.
>>> > 
>>> 
>>> With multiple memcgs, it do help a lot, I had gotten 30% grain on readtwice
>>> case. but yes, w/o MEMCG and NUMA, it's good to keep old behavior. So 
>>> would you like has a proposal for this?
>> 
>> Oh, no, I'm not against your idea. I was saying it doesn't seem
>> necessary to sort -- a nested loop would just do the job given
>> pagevec is small.
> 
> Yeah that could work. The worst case doesn't look nice (O(n^2)) but it should be
> rather rare to have pages from really multiple memcgs/nodes?

However, Matthew wanted to increase pagevec size [1] and once 15^2 becomes 63^2, 
it starts to be somewhat more worrying.

[1] https://lore.kernel.org/linux-mm/20201105172651.2455-1-willy@infradead.org/

> Maybe with the following change? Avoids going through the nulls if we got lucky
> (or have !MEMCG !NUMA).
> 
>> diff --git a/mm/swap.c b/mm/swap.c
>> index cb3794e13b48..1d238edc2907 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -996,15 +996,26 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
>>    */
>>   void __pagevec_lru_add(struct pagevec *pvec)
>>   {
>> -	int i;
>> +	int i, j;
> 
> int i, j, n;
> 
>>   	struct lruvec *lruvec = NULL;
>>   	unsigned long flags = 0;
>>   
> 
> n = pagevec_count(pvec);
>>   	for (i = 0; i < pagevec_count(pvec); i++) {
> 
>      	for (i = 0; n; i++) {
> 
>>   		struct page *page = pvec->pages[i];
>>   
>> +		if (!page)
>> +			continue;
>> +
>>   		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
>> -		__pagevec_lru_add_fn(page, lruvec);
> 
> 		n--;
> 
>> +
>> +		for (j = i; j < pagevec_count(pvec); j++) {
>> +			if (page_to_nid(pvec->pages[j]) != page_to_nid(page) ||
>> +			    page_memcg(pvec->pages[j]) != page_memcg(page))
>> +				continue;
>> +
>> +			__pagevec_lru_add_fn(pvec->pages[j], lruvec);
>> +			pvec->pages[j] = NULL;
> 
> 			n--;
>> +		}
>>   	}
>>   	if (lruvec)
>>   		unlock_page_lruvec_irqrestore(lruvec, flags);
>> 
> 

