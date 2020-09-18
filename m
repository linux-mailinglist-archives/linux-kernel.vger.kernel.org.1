Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13E326FBFB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgIRMCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:02:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:35560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgIRMCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:02:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2A018ADAD;
        Fri, 18 Sep 2020 12:03:20 +0000 (UTC)
Subject: Re: [RFC 4/5] mm, page_alloc: cache pageset high and batch in struct
 zone
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20200907163628.26495-1-vbabka@suse.cz>
 <20200907163628.26495-5-vbabka@suse.cz> <20200910113046.GA5848@linux>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <08421531-1df0-3cea-fe44-2e4e30808dfd@suse.cz>
Date:   Fri, 18 Sep 2020 14:02:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200910113046.GA5848@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/20 1:30 PM, Oscar Salvador wrote:
> On Mon, Sep 07, 2020 at 06:36:27PM +0200, Vlastimil Babka wrote:
>    */
>> -static void setup_pageset(struct per_cpu_pageset *p);
>> +static void pageset_init(struct per_cpu_pageset *p);
> 
> this belongs to the respective patches

Right, thanks.

>> -static void zone_set_pageset_high_and_batch(struct zone *zone)
>> +static void zone_set_pageset_high_and_batch(struct zone *zone, bool force_update)
>>  {
>>  	unsigned long new_high;
>>  	unsigned long new_batch;
>> @@ -6256,6 +6256,14 @@ static void zone_set_pageset_high_and_batch(struct zone *zone)
>>  		new_batch = max(1UL, 1 * new_batch);
>>  	}
>>  
>> +	if (zone->pageset_high != new_high ||
>> +	    zone->pageset_batch != new_batch) {
>> +		zone->pageset_high = new_high;
>> +		zone->pageset_batch = new_batch;
>> +	} else if (!force_update) {
>> +		return;
>> +	}
> 
> I am probably missimg something obvious, so sorry, but why do we need
> force_update here?
> AFAICS, we only want to call pageset_update() in case zone->pageset_high/batch
> and the new computed high/batch differs, so if everything is equal, why do we want
> to call it anyways?

My reasoning is that initially we don't have guarantee that
zone->pageset_high/batch matches the respective pcp->high/batch. So we could
detect no change in the zone values and return, but leave the pcp value
incoherent. But now I think it could be achieved also in a simpler way, so I'll try.


