Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E7E2854A1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 00:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgJFWbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 18:31:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:33474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbgJFWbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 18:31:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8D80CAA55;
        Tue,  6 Oct 2020 22:31:43 +0000 (UTC)
Subject: Re: [PATCH 6/9] mm, page_alloc: cache pageset high and batch in
 struct zone
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20200922143712.12048-1-vbabka@suse.cz>
 <20200922143712.12048-7-vbabka@suse.cz>
 <be6a28ce-1933-8355-1f9f-44cca6327065@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <f347d29a-99a4-d756-32e9-5ea25486c737@suse.cz>
Date:   Wed, 7 Oct 2020 00:31:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <be6a28ce-1933-8355-1f9f-44cca6327065@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/20 12:34 PM, David Hildenbrand wrote:
> On 22.09.20 16:37, Vlastimil Babka wrote:
>> @@ -6300,6 +6310,8 @@ static __meminit void zone_pcp_init(struct zone *zone)
>>  	 * offset of a (static) per cpu variable into the per cpu area.
>>  	 */
>>  	zone->pageset = &boot_pageset;
>> +	zone->pageset_high = BOOT_PAGESET_HIGH;
>> +	zone->pageset_batch = BOOT_PAGESET_BATCH;
> 
> I do wonder if copying from any cpuvar inside boot_pageset is cleaner.
> 
> zone->pageset_high = &this_cpu_ptr(zone->pageset)->pcp.high;

Uh I don't know. That would be like admitting they can be different than what 
was initialized. But then they could be also different depending on what cpu we 
happen to run it on. It's why I added the #define BOOT_PAGESET_* in the first 
place - to ensure same value used in two places. Makes sense?

