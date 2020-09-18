Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D60226F96E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgIRJhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:37:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:43836 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgIRJhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:37:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 818A5AE4B;
        Fri, 18 Sep 2020 09:38:25 +0000 (UTC)
Subject: Re: [RFC 3/5] mm, page_alloc(): remove setup_pageset()
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20200907163628.26495-1-vbabka@suse.cz>
 <20200907163628.26495-4-vbabka@suse.cz> <20200910092307.GD2285@linux>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <2c38b1f8-4e60-39f8-66c7-c0bbdb9df3cc@suse.cz>
Date:   Fri, 18 Sep 2020 11:37:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200910092307.GD2285@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/20 11:23 AM, Oscar Salvador wrote:
> On Mon, Sep 07, 2020 at 06:36:26PM +0200, Vlastimil Babka wrote:
>> We initialize boot-time pagesets with setup_pageset(), which sets high and
>> batch values that effectively disable pcplists.
>> 
>> We can remove this wrapper if we just set these values for all pagesets in
>> pageset_init(). Non-boot pagesets then subsequently update them to specific
>> values.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks!

> Just one question below:
> 
>> -static void setup_pageset(struct per_cpu_pageset *p)
>> -{
>> -	pageset_init(p);
>> -	pageset_update(&p->pcp, 0, 1);
>> +	/*
>> +	 * Set batch and high values safe for a boot pageset. Proper pageset's
>> +	 * initialization will update them.
>> +	 */
>> +	pcp->high = 0;
>> +	pcp->batch  = 1;
> 
> pageset_update was manipulating these values with barriers in between.
> I guess we do not care here because we are not really updating but
> initializing them, right?

Sure. We just initialized all the list heads, so there can be no concurrent
access at this point. But I'll mention it in the comment.


