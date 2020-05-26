Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC481DD643
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 20:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbgEUStH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 14:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729555AbgEUStH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 14:49:07 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C68EB2088E;
        Thu, 21 May 2020 18:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590086947;
        bh=MQiydCJAeNQDDg6xvAARulcUycFi5vbJdxdeJlhzfDE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QKmNH2VvPf57Na/zQ2gmA79CWHOkhxYqCWUHTz8GymARd56PJRzMnMs2ugMmGlMSL
         lWg2YzYv8S365N3SrLlBdxy2pcfoDtWYkKRmnetUqoAv3ba8S13xoQ2kkTYRrFJYT0
         oG6yUhQgBGpz9WjQLfD8WBJ0b6BuVT+DUGET+qBQ=
Date:   Thu, 21 May 2020 11:49:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Prakash Gupta <guptap@codeaurora.org>
Cc:     mhocko@suse.com, joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] iommu/dma: limit iova free size to unmmaped iova
Message-Id: <20200521114906.2f38fc04d3600d41f3409bd9@linux-foundation.org>
In-Reply-To: <20200521113004.12438-1-guptap@codeaurora.org>
References: <20200521113004.12438-1-guptap@codeaurora.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 17:00:04 +0530 Prakash Gupta <guptap@codeaurora.org> wrote:

> Limit the iova size while freeing based on unmapped size. In absence of
> this even with unmap failure, invalid iova is pushed to iova rcache and
> subsequently can cause panic while rcache magazine is freed.
> 
> Signed-off-by: Prakash Gupta <guptap@codeaurora.org>
> 

I think we need a cc:stable here?

> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -472,7 +472,8 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
>  
>  	if (!cookie->fq_domain)
>  		iommu_tlb_sync(domain, &iotlb_gather);
> -	iommu_dma_free_iova(cookie, dma_addr, size);
> +	if (unmapped)
> +		iommu_dma_free_iova(cookie, dma_addr, unmapped);
>  }
>  
>  static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,

I'll assume that Joerg will handle this fix?
