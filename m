Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52050266A21
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 23:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgIKVhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 17:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgIKVhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 17:37:31 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48200C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 14:37:30 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d19so1486073pld.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 14:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Au8E1kKt1UHq4JG19/8B0I53kV6K5bU9t6w3fjcopN8=;
        b=dL0RnwHZEp/J1fRReBaj/jhXk9A8XjA2kfmdlZ3bM6aNYJifGdNd1xXY8jFGKH2XkR
         m3S78IQqiEl7oqjjI1kQxESCSfB3unaoMi/fMS7YpPfncUnHV9aHeUw/gEzTudWwvpUO
         Ex5Dn4FOlJmeEiQn0uPFKWjuu6pR2TnTiKvcNzQSccQt69yvFc3DrskX/wMcGywpN0V7
         IATBL7Pg1lQUesl+HWp3SPJP7BWezub93k4FNy65WJDN8sJEj60oBq7xIzSpU4/pD2kJ
         DoOO2Wy3H+StEpGDuCSXeX4p5TcE0f4ee017eWFgW4kEULxYav0TCz15iq17CH9PMjHJ
         hbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Au8E1kKt1UHq4JG19/8B0I53kV6K5bU9t6w3fjcopN8=;
        b=opSxtaACuHpRNAjrjhe+8gaohKGCOxUoLHsnQNI8mcdkK61RwnglSuLf35AMV1WZ12
         HecovgivCbsrB6XL0eZG3JpB2MTxl0byzu2lv2WhRaD1jdBdqJ9mwxeoymrMaY+9K5Ic
         IdjB2KcdtX9s+wgSz03rFHVepIjYpuRVK3T0zrwL19yesXL300utD/8gNnxLOC05vaYL
         MNk4Aglu9TPlkqejPW7xYqqk5ZSCaYAzdORkRR3mse2WylycE4uGdX+2HQP6L588Wil4
         lIpgqHjl7/AHENVEVxYhKdBGIvcZv5PGlyosQ1nkoMD1vt6eCBcj/A9iM1HbreBdMV+z
         ikmQ==
X-Gm-Message-State: AOAM530NNKRiPMYgVM06lhDjNBkGjJ5Ci73jzEzPk8WMtLdY9tEsb3eH
        qoAba1THpcSSXGNfFs6i8+k=
X-Google-Smtp-Source: ABdhPJxeKK5hQIo+Q0nTGusVVxEsD98neDC/J4v+kxouyjhsv4l8D7zsOKtactfhuYddysevSgPuzw==
X-Received: by 2002:a17:902:7608:b029:d0:cbe1:e70e with SMTP id k8-20020a1709027608b02900d0cbe1e70emr4207225pll.28.1599860250109;
        Fri, 11 Sep 2020 14:37:30 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l79sm3152945pfd.210.2020.09.11.14.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 14:37:29 -0700 (PDT)
Subject: Re: [PATCH v2] mm: cma: indefinitely retry allocations in cma_alloc
To:     Chris Goldsworthy <cgoldswo@codeaurora.org>,
        linux-kernel@vger.kernel.org
Cc:     Vinayak Menon <vinmenon@codeaurora.org>
References: <1599857630-23714-1-git-send-email-cgoldswo@codeaurora.org>
 <010101747ef2b8fc-a5e44a5a-dcf4-4828-a1d4-a099df63f2df-000000@us-west-2.amazonses.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <410a4e0c-f924-4564-ae1e-cc9f6292c88e@gmail.com>
Date:   Fri, 11 Sep 2020 14:37:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <010101747ef2b8fc-a5e44a5a-dcf4-4828-a1d4-a099df63f2df-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/2020 1:54 PM, Chris Goldsworthy wrote:
> CMA allocations will fail if 'pinned' pages are in a CMA area, since we
> cannot migrate pinned pages. The _refcount of a struct page being greater
> than _mapcount for that page can cause pinning for anonymous pages.  This
> is because try_to_unmap(), which (1) is called in the CMA allocation path,
> and (2) decrements both _refcount and _mapcount for a page, will stop
> unmapping a page from VMAs once the _mapcount for a page reaches 0.  This
> implies that after try_to_unmap() has finished successfully for a page
> where _recount > _mapcount, that _refcount will be greater than 0.  Later
> in the CMA allocation path in migrate_page_move_mapping(), we will have one
> more reference count than intended for anonymous pages, meaning the
> allocation will fail for that page.
> 
> One example of where _refcount can be greater than _mapcount for a page we
> would not expect to be pinned is inside of copy_one_pte(), which is called
> during a fork. For ptes for which pte_present(pte) == true, copy_one_pte()
> will increment the _refcount field followed by the  _mapcount field of a
> page. If the process doing copy_one_pte() is context switched out after
> incrementing _refcount but before incrementing _mapcount, then the page
> will be temporarily pinned.
> 
> So, inside of cma_alloc(), instead of giving up when alloc_contig_range()
> returns -EBUSY after having scanned a whole CMA-region bitmap, perform
> retries indefinitely, with sleeps, to give the system an opportunity to
> unpin any pinned pages.

I am by no means an authoritative CMA person but this behavior does not 
seem acceptable, there is no doubt the existing one is sub-optimal under 
specific circumstances, but an indefinite retry, as well as a 100ms 
sleep appear to be arbitrary at best. How about you introduce a 
parameter that allows the tuning of the number of retries and/or delay 
between retries?

> 
> Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
> Co-developed-by: Vinayak Menon <vinmenon@codeaurora.org>
> Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
> ---
>   mm/cma.c | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 7f415d7..90bb505 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -32,6 +32,7 @@
>   #include <linux/highmem.h>
>   #include <linux/io.h>
>   #include <linux/kmemleak.h>
> +#include <linux/delay.h>
>   #include <trace/events/cma.h>
>   
>   #include "cma.h"
> @@ -442,8 +443,28 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>   				bitmap_maxno, start, bitmap_count, mask,
>   				offset);
>   		if (bitmap_no >= bitmap_maxno) {
> -			mutex_unlock(&cma->lock);
> -			break;
> +			if (ret == -EBUSY) {
> +				mutex_unlock(&cma->lock);
> +
> +				/*
> +				 * Page may be momentarily pinned by some other
> +				 * process which has been scheduled out, e.g.
> +				 * in exit path, during unmap call, or process
> +				 * fork and so cannot be freed there. Sleep
> +				 * for 100ms and retry the allocation.
> +				 */
> +				start = 0;
> +				ret = -ENOMEM;
> +				msleep(100);
> +				continue;
> +			} else {
> +				/*
> +				 * ret == -ENOMEM - all bits in cma->bitmap are
> +				 * set, so we break accordingly.
> +				 */
> +				mutex_unlock(&cma->lock);
> +				break;
> +			}
>   		}
>   		bitmap_set(cma->bitmap, bitmap_no, bitmap_count);
>   		/*
> 

-- 
Florian
