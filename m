Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EB82AB764
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgKILnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:43:37 -0500
Received: from foss.arm.com ([217.140.110.172]:38304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgKILnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:43:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9901106F;
        Mon,  9 Nov 2020 03:43:36 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CE423F718;
        Mon,  9 Nov 2020 03:43:32 -0800 (PST)
Subject: Re: [PATCH] dma-pool: no need to check return value of debugfs_create
 functions
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
References: <1604743392-21601-1-git-send-email-yangtiezhu@loongson.cn>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <936ffd36-8814-a8d2-ab94-3edc0642e5a7@arm.com>
Date:   Mon, 9 Nov 2020 11:43:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <1604743392-21601-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-07 10:03, Tiezhu Yang wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.

Well, the only difference in behaviour is that it won't attempt to call 
further debugfs functions if they're definitely going to fail anyway, so 
no "real" logic is affected. AFAICS it's not possible for 
debugfs_create_dir() to return NULL, so this check makes no practical 
difference, just means that if it did ever fail we would save a bit of 
unnecessary work by not subsequently calling all the way down to the "if 
(IS_ERR(parent))" check in start_creating() several times.

So the given justification is a little overdramatic for this particular 
situation, when it's really just that it's not worth optimising an 
unexpected failure case, but the change itself is obviously fine.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   kernel/dma/pool.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index d4637f7..5f84e6c 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -38,9 +38,6 @@ static void __init dma_atomic_pool_debugfs_init(void)
>   	struct dentry *root;
>   
>   	root = debugfs_create_dir("dma_pools", NULL);
> -	if (IS_ERR_OR_NULL(root))
> -		return;
> -
>   	debugfs_create_ulong("pool_size_dma", 0400, root, &pool_size_dma);
>   	debugfs_create_ulong("pool_size_dma32", 0400, root, &pool_size_dma32);
>   	debugfs_create_ulong("pool_size_kernel", 0400, root, &pool_size_kernel);
> 
