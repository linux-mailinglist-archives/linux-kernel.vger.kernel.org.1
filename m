Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B242C6A71
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbgK0RN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:13:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:47566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731582AbgK0RN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:13:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08897AC0C;
        Fri, 27 Nov 2020 17:13:26 +0000 (UTC)
Subject: Re: [PATCH -next] mm/page_alloc: Mark some symbols with static
 keyword
To:     Zou Wei <zou_wei@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1605517365-65858-1-git-send-email-zou_wei@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <27899673-2d79-2a26-fc66-d2ecce9cb1b3@suse.cz>
Date:   Fri, 27 Nov 2020 18:13:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1605517365-65858-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/20 10:02 AM, Zou Wei wrote:
> Fix the following sparse warnings:
> 
> mm/page_alloc.c:3040:6: warning: symbol '__drain_all_pages' was not declared. Should it be static?
> mm/page_alloc.c:6349:6: warning: symbol '__zone_set_pageset_high_and_batch' was not declared. Should it be static?
> 
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>   mm/page_alloc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 63d8d8b..e7548344 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3037,7 +3037,7 @@ static void drain_local_pages_wq(struct work_struct *work)
>    * that need the guarantee that every CPU has drained can disable the
>    * optimizing racy check.
>    */
> -void __drain_all_pages(struct zone *zone, bool force_all_cpus)
> +static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
>   {
>   	int cpu;
>   
> @@ -6346,7 +6346,7 @@ static void pageset_init(struct per_cpu_pageset *p)
>   	pcp->batch = BOOT_PAGESET_BATCH;
>   }
>   
> -void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long high,
> +static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long high,
>   		unsigned long batch)
>   {
>   	struct per_cpu_pageset *p;
> 

