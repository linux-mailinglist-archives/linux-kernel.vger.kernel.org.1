Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AD22DDE6F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 07:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732627AbgLRGKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 01:10:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9226 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgLRGKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 01:10:01 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cxz236Fl7zksDZ;
        Fri, 18 Dec 2020 14:08:27 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.9) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Fri, 18 Dec 2020
 14:09:16 +0800
Subject: Re: [PATCH 1/1] device-dax: avoid an unnecessary check in
 alloc_dev_dax_range()
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201120092251.2197-1-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <55970773-35ff-1afb-940b-8342b09aea9a@huawei.com>
Date:   Fri, 18 Dec 2020 14:09:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201120092251.2197-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/11/20 17:22, Zhen Lei wrote:
> Swap the calling sequence of krealloc() and __request_region(), call the
> latter first. In this way, the value of dev_dax->nr_range does not need to
> be considered when __request_region() failed.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/dax/bus.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 27513d311242..1efae11d947a 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -763,23 +763,15 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
>  		return 0;
>  	}
>  
> -	ranges = krealloc(dev_dax->ranges, sizeof(*ranges)
> -			* (dev_dax->nr_range + 1), GFP_KERNEL);
> -	if (!ranges)
> -		return -ENOMEM;
> -
>  	alloc = __request_region(res, start, size, dev_name(dev), 0);
> -	if (!alloc) {
> -		/*
> -		 * If this was an empty set of ranges nothing else
> -		 * will release @ranges, so do it now.
> -		 */
> -		if (!dev_dax->nr_range) {
> -			kfree(ranges);
> -			ranges = NULL;
> -		}
> -		dev_dax->ranges = ranges;
> +	if (!alloc)
>  		return -ENOMEM;
> +
> +	ranges = krealloc(dev_dax->ranges, sizeof(*ranges)
> +			* (dev_dax->nr_range + 1), GFP_KERNEL);
> +	if (!ranges) {
> +		rc = -ENOMEM;
> +		goto err;

Hi, Dan Williams:
In fact, after adding the new helper dev_dax_trim_range(), we can
directly call __release_region() and return error code at here. Replace goto.

>  	}
>  
>  	for (i = 0; i < dev_dax->nr_range; i++)
> @@ -808,11 +800,14 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
>  		dev_dbg(dev, "delete range[%d]: %pa:%pa\n", dev_dax->nr_range - 1,
>  				&alloc->start, &alloc->end);
>  		dev_dax->nr_range--;
> -		__release_region(res, alloc->start, resource_size(alloc));
> -		return rc;
> +		goto err;
>  	}
>  
>  	return 0;
> +
> +err:
> +	__release_region(res, alloc->start, resource_size(alloc));
> +	return rc;
>  }
>  
>  static int adjust_dev_dax_range(struct dev_dax *dev_dax, struct resource *res, resource_size_t size)
> 

