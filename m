Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C9C1C8C0B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 15:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgEGNYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 09:24:06 -0400
Received: from foss.arm.com ([217.140.110.172]:59298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgEGNYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:24:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05D9CD6E;
        Thu,  7 May 2020 06:24:05 -0700 (PDT)
Received: from [10.57.36.85] (unknown [10.57.36.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01DA23F68F;
        Thu,  7 May 2020 06:24:03 -0700 (PDT)
Subject: Re: [PATCH] iommu/iova: Retry from last rb tree node if iova search
 fails
To:     vjitta@codeaurora.org, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     vinmenon@codeaurora.org, kernel-team@android.com
References: <1588795317-20879-1-git-send-email-vjitta@codeaurora.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d9bfde9f-8f16-bf1b-311b-ea6c2b8ab93d@arm.com>
Date:   Thu, 7 May 2020 14:24:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588795317-20879-1-git-send-email-vjitta@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-06 9:01 pm, vjitta@codeaurora.org wrote:
> From: Vijayanand Jitta <vjitta@codeaurora.org>
> 
> When ever a new iova alloc request comes iova is always searched
> from the cached node and the nodes which are previous to cached
> node. So, even if there is free iova space available in the nodes
> which are next to the cached node iova allocation can still fail
> because of this approach.
> 
> Consider the following sequence of iova alloc and frees on
> 1GB of iova space
> 
> 1) alloc - 500MB
> 2) alloc - 12MB
> 3) alloc - 499MB
> 4) free -  12MB which was allocated in step 2
> 5) alloc - 13MB
> 
> After the above sequence we will have 12MB of free iova space and
> cached node will be pointing to the iova pfn of last alloc of 13MB
> which will be the lowest iova pfn of that iova space. Now if we get an
> alloc request of 2MB we just search from cached node and then look
> for lower iova pfn's for free iova and as they aren't any, iova alloc
> fails though there is 12MB of free iova space.

Yup, this could definitely do with improving. Unfortunately I think this 
particular implementation is slightly flawed...

> To avoid such iova search failures do a retry from the last rb tree node
> when iova search fails, this will search the entire tree and get an iova
> if its available
> 
> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
> ---
>   drivers/iommu/iova.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 0e6a953..2985222 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -186,6 +186,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>   	unsigned long flags;
>   	unsigned long new_pfn;
>   	unsigned long align_mask = ~0UL;
> +	bool retry = false;
>   
>   	if (size_aligned)
>   		align_mask <<= fls_long(size - 1);
> @@ -198,6 +199,8 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>   
>   	curr = __get_cached_rbnode(iovad, limit_pfn);
>   	curr_iova = rb_entry(curr, struct iova, node);
> +
> +retry_search:
>   	do {
>   		limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
>   		new_pfn = (limit_pfn - size) & align_mask;
> @@ -207,6 +210,14 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>   	} while (curr && new_pfn <= curr_iova->pfn_hi);
>   
>   	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
> +		if (!retry) {
> +			curr = rb_last(&iovad->rbroot);

Why walk when there's an anchor node there already? However...

> +			curr_iova = rb_entry(curr, struct iova, node);
> +			limit_pfn = curr_iova->pfn_lo;

...this doesn't look right, as by now we've lost the original limit_pfn 
supplied by the caller, so are highly likely to allocate beyond the 
range our caller asked for. In fact AFAICS we'd start allocating from 
directly directly below the anchor node, beyond the end of the entire 
address space.

The logic I was imagining we want here was something like the rapidly 
hacked up (and untested) diff below.

Thanks,
Robin.

----->8-----
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 0e6a9536eca6..3574c19272d6 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -186,6 +186,7 @@ static int __alloc_and_insert_iova_range(struct 
iova_domain *iovad,
         unsigned long flags;
         unsigned long new_pfn;
         unsigned long align_mask = ~0UL;
+       unsigned long alloc_hi, alloc_lo;

         if (size_aligned)
                 align_mask <<= fls_long(size - 1);
@@ -196,17 +197,27 @@ static int __alloc_and_insert_iova_range(struct 
iova_domain *iovad,
                         size >= iovad->max32_alloc_size)
                 goto iova32_full;

+       alloc_hi = IOVA_ANCHOR;
+       alloc_lo = iovad->start_pfn;
+retry:
         curr = __get_cached_rbnode(iovad, limit_pfn);
         curr_iova = rb_entry(curr, struct iova, node);
+       if (alloc_hi < curr_iova->pfn_hi) {
+               alloc_lo = curr_iova->pfn_hi;
+               alloc_hi = limit_pfn;
+       }
+
         do {
-               limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
-               new_pfn = (limit_pfn - size) & align_mask;
+               alloc_hi = min(alloc_hi, curr_iova->pfn_lo);
+               new_pfn = (alloc_hi - size) & align_mask;
                 prev = curr;
                 curr = rb_prev(curr);
                 curr_iova = rb_entry(curr, struct iova, node);
         } while (curr && new_pfn <= curr_iova->pfn_hi);

-       if (limit_pfn < size || new_pfn < iovad->start_pfn) {
+       if (limit_pfn < size || new_pfn < alloc_lo) {
+               if (alloc_lo == iovad->start_pfn)
+                       goto retry;
                 iovad->max32_alloc_size = size;
                 goto iova32_full;
         }
