Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBA42C68F3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 16:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbgK0Ptr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 10:49:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:38202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730675AbgK0Ptr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 10:49:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 67FC6AE30;
        Fri, 27 Nov 2020 15:49:46 +0000 (UTC)
Subject: Re: [PATCH] mm: cma: improve pr_debug log in cma_release()
To:     Charan Teja Reddy <charante@codeaurora.org>,
        akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
References: <1606318341-29521-1-git-send-email-charante@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <f6744947-72b5-39e0-9eb0-7f3f09f773b3@suse.cz>
Date:   Fri, 27 Nov 2020 16:49:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1606318341-29521-1-git-send-email-charante@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/20 4:32 PM, Charan Teja Reddy wrote:
> It is required to print 'count' of pages, along with the pages, passed
> to cma_release to debug the cases of mismatched count value passed
> between cma_alloc() and cma_release() from a code path.
> 
> As an example, consider the below scenario:
> 1) CMA pool size is 4MB and
> 2) User doing the erroneous step of allocating 2 pages but freeing 1
> page in a loop from this CMA pool.
> The step 2 causes cma_alloc() to return NULL at one point of time
> because of -ENOMEM condition.
> 
> And the current pr_debug logs is not giving the info about these types
> of allocation patterns because of count value not being printed in
> cma_release().
> 
> We are printing the count value in the trace logs, just extend the same
> to pr_debug logs too.
> 
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>   mm/cma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 7f415d7..07c904b 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -512,7 +512,7 @@ bool cma_release(struct cma *cma, const struct page *pages, unsigned int count)
>   	if (!cma || !pages)
>   		return false;
>   
> -	pr_debug("%s(page %p)\n", __func__, (void *)pages);
> +	pr_debug("%s(page %p, count %zu)\n", __func__, (void *)pages, count);
>   
>   	pfn = page_to_pfn(pages);
>   
> 

