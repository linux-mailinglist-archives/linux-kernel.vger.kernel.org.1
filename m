Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D45285445
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 00:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgJFWEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 18:04:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:46744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgJFWED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 18:04:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D3C80AC1D;
        Tue,  6 Oct 2020 22:04:02 +0000 (UTC)
Subject: Re: [PATCH 2/9] mm, page_alloc: calculate pageset high and batch once
 per zone
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20200922143712.12048-1-vbabka@suse.cz>
 <20200922143712.12048-3-vbabka@suse.cz>
 <20201005125247.GX4555@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <325c9545-a307-5bbe-261c-43aaeda34322@suse.cz>
Date:   Wed, 7 Oct 2020 00:04:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201005125247.GX4555@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/20 2:52 PM, Michal Hocko wrote:
> On Tue 22-09-20 16:37:05, Vlastimil Babka wrote:
>> We currently call pageset_set_high_and_batch() for each possible cpu, which
>> repeats the same calculations of high and batch values.
>> 
>> Instead call the function just once per zone, and make it apply the calculated
>> values to all per-cpu pagesets of the zone.
>> 
>> This also allows removing the zone_pageset_init() and __zone_pcp_update()
>> wrappers.
>> 
>> No functional change.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> I like this. One question below
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.

> I hope I am not misreading the diff but it seems that setup_zone_pageset
> is calling pageset_init which is then done again by
> zone_set_pageset_high_and_batch as a part of pageset_update

No, pageset_init() is not called again from there, so must be insufficient diff 
context giving that impression.

