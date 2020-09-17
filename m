Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248AF26E0A0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 18:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgIQQZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 12:25:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:33002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728418AbgIQQXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:23:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AD7A1B2C6;
        Thu, 17 Sep 2020 16:06:08 +0000 (UTC)
Subject: Re: [RFC 1/5] mm, page_alloc: clean up pageset high and batch update
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20200907163628.26495-1-vbabka@suse.cz>
 <20200907163628.26495-2-vbabka@suse.cz> <20200910083116.GA2285@linux>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <78f43f31-4388-923f-83aa-dc9831de6e18@suse.cz>
Date:   Thu, 17 Sep 2020 18:05:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200910083116.GA2285@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/20 10:31 AM, Oscar Salvador wrote:
> On Mon, Sep 07, 2020 at 06:36:24PM +0200, Vlastimil Babka wrote:
> 
>> -/*
>> - * pageset_set_high() sets the high water mark for hot per_cpu_pagelist
>> - * to the value high for the pageset p.
>> - */
>> -static void pageset_set_high(struct per_cpu_pageset *p,
>> -				unsigned long high)
>> -{
>> -	unsigned long batch = max(1UL, high / 4);
>> -	if ((high / 4) > (PAGE_SHIFT * 8))
>> -		batch = PAGE_SHIFT * 8;
>> -
>> -	pageset_update(&p->pcp, high, batch);
>> +	pageset_update(&p->pcp, 0, 1);
>>  }
> 
> Could we restore the comment we had in pageset_set_high, and maybe
> update it to match this new function? I think it would be useful.

Same as David, I didn't find the comment useful at all. But I can try writing a
better one instead.

>>  
>>  static void pageset_set_high_and_batch(struct zone *zone,
>> -				       struct per_cpu_pageset *pcp)
>> +				       struct per_cpu_pageset *p)
>>  {
>> -	if (percpu_pagelist_fraction)
>> -		pageset_set_high(pcp,
>> -			(zone_managed_pages(zone) /
>> -				percpu_pagelist_fraction));
>> -	else
>> -		pageset_set_batch(pcp, zone_batchsize(zone));
>> +	unsigned long new_high;
>> +	unsigned long new_batch;
>> +	int fraction = READ_ONCE(percpu_pagelist_fraction);
> 
> Why the READ_ONCE? In case there is a parallel update so things to get
> messed up?

Yeah, I think online of a new zone can race with sysctl update to
percpu_pagelist_fraction, because online doesn't take pcp_batch_high_lock...
until patch 5. But you're right this should be separate.

> as I said, I'd appreciate a comment in pageset_set_high_and_batch to be
> restored and updated, otherwise:
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de> 

Thanks!

> Thanks
> 

