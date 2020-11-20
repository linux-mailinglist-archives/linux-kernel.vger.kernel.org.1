Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C857C2BA61C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgKTJ1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:27:32 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8568 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbgKTJ1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:27:31 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CcrmB6BLXzLrMn;
        Fri, 20 Nov 2020 17:27:06 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.144) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 20 Nov 2020
 17:27:26 +0800
Subject: Re: [PATCH 1/1] device-dax: delete a redundancy check in
 dev_dax_validate_align()
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201120092057.2144-1-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <7ccddd02-e2e6-ec48-43b8-10700285e61c@huawei.com>
Date:   Fri, 20 Nov 2020 17:27:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201120092057.2144-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/11/20 17:20, Zhen Lei wrote:
> After we have done the alignment check for the length of each range, the
> alignment check for dev_dax_size(dev_dax) is no longer needed, because it
> get the sum of the length of each range.

For example:
x/M + y/M = (x + y)/M
If x/M is a integer and y/M is also a integer, then (x + y)/M must be a integer.

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/dax/bus.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 1efae11d947a..35f9238c0139 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -1109,16 +1109,9 @@ static ssize_t align_show(struct device *dev,
>  
>  static ssize_t dev_dax_validate_align(struct dev_dax *dev_dax)
>  {
> -	resource_size_t dev_size = dev_dax_size(dev_dax);
>  	struct device *dev = &dev_dax->dev;
>  	int i;
>  
> -	if (dev_size > 0 && !alloc_is_aligned(dev_dax, dev_size)) {
> -		dev_dbg(dev, "%s: align %u invalid for size %pa\n",
> -			__func__, dev_dax->align, &dev_size);
> -		return -EINVAL;
> -	}
> -
>  	for (i = 0; i < dev_dax->nr_range; i++) {
>  		size_t len = range_len(&dev_dax->ranges[i].range);
>  
> 

