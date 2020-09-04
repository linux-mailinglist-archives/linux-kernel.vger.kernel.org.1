Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F11625D542
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 11:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbgIDJhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 05:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgIDJhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:37:39 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4B7C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 02:37:34 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 92BC3A6D; Fri,  4 Sep 2020 11:37:33 +0200 (CEST)
Date:   Fri, 4 Sep 2020 11:37:32 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Yuqi Jin <jinyuqi@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/iova: Replace cmpxchg with xchg in queue_iova
Message-ID: <20200904093732.GN6714@8bytes.org>
References: <1598517834-30275-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598517834-30275-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Robin.

On Thu, Aug 27, 2020 at 04:43:54PM +0800, Shaokun Zhang wrote:
> From: Yuqi Jin <jinyuqi@huawei.com>
> 
> The performance of the atomic_xchg is better than atomic_cmpxchg because
> no comparison is required. While the value of @fq_timer_on can only be 0
> or 1. Let's use atomic_xchg instead of atomic_cmpxchg here because we
> only need to check that the value changes from 0 to 1 or from 1 to 1.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Yuqi Jin <jinyuqi@huawei.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  drivers/iommu/iova.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 45a251da5453..30d969a4c5fd 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -579,7 +579,7 @@ void queue_iova(struct iova_domain *iovad,
>  
>  	/* Avoid false sharing as much as possible. */
>  	if (!atomic_read(&iovad->fq_timer_on) &&
> -	    !atomic_cmpxchg(&iovad->fq_timer_on, 0, 1))
> +	    !atomic_xchg(&iovad->fq_timer_on, 1))
>  		mod_timer(&iovad->fq_timer,
>  			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
>  }
> -- 
> 2.7.4
