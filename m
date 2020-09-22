Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE25027477F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 19:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgIVRbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 13:31:06 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11730 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIVRbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 13:31:06 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6a34cd0000>; Tue, 22 Sep 2020 10:30:53 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Sep
 2020 17:31:02 +0000
Subject: Re: [PATCH] mm/hmm/test: use after free in dmirror_allocate_chunk()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Wei Yongjun <weiyongjun1@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20200922081234.GA1274646@mwanda>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <c25729e4-8a53-07e3-ae98-d77919f3ac21@nvidia.com>
Date:   Tue, 22 Sep 2020 10:31:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200922081234.GA1274646@mwanda>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600795853; bh=FlTvSkg2VeAuml+QolVZZc+aE27r29315SlOmjxh39E=;
        h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=n2rX4xtVEiYQ+FBTCrawg4dcPx1HKTKZZHFu0wsmNM8BaYERwT533PghchwBmk3j8
         s5yMw/N9YH0s1iYauljogWzTK3X8jTUXNAPy33WzDSN5K1btEOE4hNX5k53kx58ECM
         ClVIdF7hiCenQf2kBsArGICJ/IlK45S6P8oh719RJxsPpoYc3+kuLDJnsztru8Ln64
         ievHxAsZuu3L1QDQjmjxs4HymhO5JABI6r7NJcW4L6BSXOqBnR3yr6Mk5xaMHZlfls
         NppkhtfMRJXOM5ZSAZ5JN/3HUGAAf9ZMeXSf1fTzM1YLnmaCiveLzz+YAwb3FK04q+
         fpbNBkpGmJlgQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/22/20 1:12 AM, Dan Carpenter wrote:
> The error handling code does this:
> 
> err_free:
> 	kfree(devmem);
>          ^^^^^^^^^^^^^
> err_release:
> 	release_mem_region(devmem->pagemap.range.start, range_len(&devmem->pagemap.range));
>                             ^^^^^^^^
> The problem is that when we use "devmem->pagemap.range.start" the
> "devmem" pointer is either NULL or freed.
> 
> Neither the allocation nor the call to request_free_mem_region() has to
> be done under the lock so I moved those to the start of the function.
> 
> Fixes: b2ef9f5a5cb3 ("mm/hmm/test: add selftest driver for HMM")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> It's weird that I didn't catch the use after free when this code was
> merged in May...  My bad.  Not sure what happened there.  How I found
> this was that I have been reviewing release_mem_region() leaks and the
> NULL dereference path is a leak.
> 

Thanks for fixing this. I missed it too. :-)

>   lib/test_hmm.c | 47 ++++++++++++++++++++++++-----------------------
>   1 file changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> index c8133f50160b..0503c78cb322 100644
> --- a/lib/test_hmm.c
> +++ b/lib/test_hmm.c
> @@ -459,6 +459,22 @@ static bool dmirror_allocate_chunk(struct dmirror_device *mdevice,
>   	unsigned long pfn_last;
>   	void *ptr;
>   
> +	devmem = kzalloc(sizeof(*devmem), GFP_KERNEL);
> +	if (!devmem)
> +		return -ENOMEM;
> +
> +	res = request_free_mem_region(&iomem_resource, DEVMEM_CHUNK_SIZE,
> +				      "hmm_dmirror");
> +	if (IS_ERR(res))
> +		goto err_devmem;
> +
> +	devmem->pagemap.type = MEMORY_DEVICE_PRIVATE;
> +	devmem->pagemap.range.start = res->start;
> +	devmem->pagemap.range.end = res->end;
> +	devmem->pagemap.nr_range = 1;
> +	devmem->pagemap.ops = &dmirror_devmem_ops;
> +	devmem->pagemap.owner = mdevice;
> +
>   	mutex_lock(&mdevice->devmem_lock);
>   
>   	if (mdevice->devmem_count == mdevice->devmem_capacity) {
> @@ -471,30 +487,16 @@ static bool dmirror_allocate_chunk(struct dmirror_device *mdevice,
>   				sizeof(new_chunks[0]) * new_capacity,
>   				GFP_KERNEL);
>   		if (!new_chunks)

Need to call mutex_unlock(&mdevice->devmem_lock).
In fact, why not make this goto err_unlock and add
err_unlock: mutex_unlock() before the err_release:.

> -			goto err;
> +			goto err_release;>   		mdevice->devmem_capacity = new_capacity;
>   		mdevice->devmem_chunks = new_chunks;
>   	}
>   
> -	res = request_free_mem_region(&iomem_resource, DEVMEM_CHUNK_SIZE,
> -					"hmm_dmirror");
> -	if (IS_ERR(res))
> -		goto err;
> -
> -	devmem = kzalloc(sizeof(*devmem), GFP_KERNEL);
> -	if (!devmem)
> -		goto err_release;
> -
> -	devmem->pagemap.type = MEMORY_DEVICE_PRIVATE;
> -	devmem->pagemap.range.start = res->start;
> -	devmem->pagemap.range.end = res->end;
> -	devmem->pagemap.nr_range = 1;
> -	devmem->pagemap.ops = &dmirror_devmem_ops;
> -	devmem->pagemap.owner = mdevice;
> -
>   	ptr = memremap_pages(&devmem->pagemap, numa_node_id());
> -	if (IS_ERR(ptr))
> -		goto err_free;
> +	if (IS_ERR(ptr)) {
> +		mutex_unlock(&mdevice->devmem_lock);
> +		goto err_release;
> +	}

This could then be just goto err_unlock.

>   	devmem->mdevice = mdevice;
>   	pfn_first = devmem->pagemap.range.start >> PAGE_SHIFT;
> @@ -525,12 +527,11 @@ static bool dmirror_allocate_chunk(struct dmirror_device *mdevice,
>   
>   	return true;
>   
> -err_free:
> -	kfree(devmem);
>   err_release:
>   	release_mem_region(devmem->pagemap.range.start, range_len(&devmem->pagemap.range));
> -err:
> -	mutex_unlock(&mdevice->devmem_lock);
> +err_devmem:
> +	kfree(devmem);
> +
>   	return false;
>   }
>   

With the suggested change, you can add
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

