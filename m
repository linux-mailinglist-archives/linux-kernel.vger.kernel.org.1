Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D62320E4E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 00:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387505AbgF2VaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 17:30:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:40462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728888AbgF2SlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8266DAFAA;
        Mon, 29 Jun 2020 10:27:20 +0000 (UTC)
Subject: Re: [PATCH for v5.8 3/3] mm/memory: fix IO cost for anonymous page
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1592288204-27734-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592288204-27734-4-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <882baec9-6d8e-55e9-ef67-67266458cbe0@suse.cz>
Date:   Mon, 29 Jun 2020 12:27:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592288204-27734-4-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/20 8:16 AM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> With synchronous IO swap device, swap-in is directly handled in fault
> code. Since IO cost notation isn't added there, with synchronous IO swap
> device, LRU balancing could be wrongly biased. Fix it to count it
> in fault code.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/memory.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index bc6a471..3359057 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3143,6 +3143,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  				if (err)
>  					goto out_page;
>  
> +				/*
> +				 * XXX: Move to lru_cache_add() when it
> +				 * supports new vs putback
> +				 */
> +				spin_lock_irq(&page_pgdat(page)->lru_lock);
> +				lru_note_cost_page(page);
> +				spin_unlock_irq(&page_pgdat(page)->lru_lock);
> +
>  				lru_cache_add(page);
>  				swap_readpage(page, true);
>  			}
> 

