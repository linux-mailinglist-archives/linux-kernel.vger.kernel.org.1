Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2138B2C5000
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 09:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388662AbgKZIJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 03:09:32 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:39780 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731457AbgKZIJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 03:09:32 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UGa28sv_1606378169;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UGa28sv_1606378169)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 Nov 2020 16:09:29 +0800
Subject: Re: [PATCH next] mm/swap.c: reduce lock contention in lru_cache_add
To:     Yu Zhao <yuzhao@google.com>
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1605860847-47445-1-git-send-email-alex.shi@linux.alibaba.com>
 <20201126045234.GA1014081@google.com>
 <ed19e3f7-33cb-20ae-537e-a7ada2036895@linux.alibaba.com>
 <20201126072402.GA1047005@google.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <0e14f1dc-31bb-5965-4711-9e59c51ee36d@linux.alibaba.com>
Date:   Thu, 26 Nov 2020 16:09:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201126072402.GA1047005@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/11/26 下午3:24, Yu Zhao 写道:
> Oh, no, I'm not against your idea. I was saying it doesn't seem
> necessary to sort -- a nested loop would just do the job given
> pagevec is small.
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index cb3794e13b48..1d238edc2907 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -996,15 +996,26 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
>   */
>  void __pagevec_lru_add(struct pagevec *pvec)
>  {
> -	int i;
> +	int i, j;
>  	struct lruvec *lruvec = NULL;
>  	unsigned long flags = 0;
>  
>  	for (i = 0; i < pagevec_count(pvec); i++) {
>  		struct page *page = pvec->pages[i];
>  
> +		if (!page)
> +			continue;
> +
>  		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
> -		__pagevec_lru_add_fn(page, lruvec);
> +
> +		for (j = i; j < pagevec_count(pvec); j++) {
> +			if (page_to_nid(pvec->pages[j]) != page_to_nid(page) ||
> +			    page_memcg(pvec->pages[j]) != page_memcg(page))
> +				continue;
> +
> +			__pagevec_lru_add_fn(pvec->pages[j], lruvec);
> +			pvec->pages[j] = NULL;
> +		}

Uh, I have to say your method is more better than mine.
And this could be reused for all relock_page_lruvec. I expect this could
speed up lru performance a lot!


>  	}
>  	if (lruvec)
>  		unlock_page_lruvec_irqrestore(lruvec, flags);
