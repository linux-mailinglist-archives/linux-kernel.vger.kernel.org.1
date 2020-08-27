Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7697254D08
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 20:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgH0S1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 14:27:04 -0400
Received: from foss.arm.com ([217.140.110.172]:33130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgH0S1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:27:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71E80101E;
        Thu, 27 Aug 2020 11:27:02 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 888073F68F;
        Thu, 27 Aug 2020 11:27:01 -0700 (PDT)
Subject: Re: [PATCH v2] ARM/dma-mapping: use kvzalloc() in
 __iommu_alloc_buffer()
To:     Denis Efremov <efremov@linux.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>
References: <20200827151541.39662-1-efremov@linux.com>
 <20200827154332.41571-1-efremov@linux.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5c84eec0-c249-6e8f-590b-cbb32bad3601@arm.com>
Date:   Thu, 27 Aug 2020 19:27:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200827154332.41571-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-27 16:43, Denis Efremov wrote:
> Use kvzalloc() in __iommu_alloc_buffer() instead of open-coding it.
> Size computation wrapped in array_size() macro to prevent potential
> integer overflows.

FWIW I'm currently working on a much more thorough cleanup by way of 
removing this code entirely [1] ;)

Robin.

[1] 
https://lore.kernel.org/linux-arm-kernel/cover.1597931875.git.robin.murphy@arm.com/

> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> Changes in v2:
>   - array_size() added
> 
>   arch/arm/mm/dma-mapping.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 8a8949174b1c..c1f864ff7b84 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1199,14 +1199,10 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
>   {
>   	struct page **pages;
>   	int count = size >> PAGE_SHIFT;
> -	int array_size = count * sizeof(struct page *);
>   	int i = 0;
>   	int order_idx = 0;
>   
> -	if (array_size <= PAGE_SIZE)
> -		pages = kzalloc(array_size, GFP_KERNEL);
> -	else
> -		pages = vzalloc(array_size);
> +	pages = kvzalloc(array_size(sizeof(*pages), count), GFP_KERNEL);
>   	if (!pages)
>   		return NULL;
>   
> 
