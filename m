Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715722A760E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 04:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388589AbgKED0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 22:26:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728511AbgKED0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 22:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604546776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mRshB1IOA1Mf1aSFztDMxd/O6v4KPO2Fmpz6wnpNUi0=;
        b=ZjLRp3dnh7Igp+sVYRyuWvKXW+PxM/2Z7YIUVZqLwgzZRs3Kgcjs8Rw+Dokg91u08DKtsO
        T3W+18+tajYS7N4lfa2jPYRQv6iEP42Pe9pp+eVKp9wGJ8aRKTKscwE1YSkVfHFgVGwrZF
        frvfPRSbZdP2tJ6apoSicRxf0Lf7TqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516--fVdYd2zMxyenc99WivaXw-1; Wed, 04 Nov 2020 22:26:12 -0500
X-MC-Unique: -fVdYd2zMxyenc99WivaXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51DE31007464;
        Thu,  5 Nov 2020 03:26:11 +0000 (UTC)
Received: from [10.72.13.154] (ovpn-13-154.pek2.redhat.com [10.72.13.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8093F6CE4E;
        Thu,  5 Nov 2020 03:26:05 +0000 (UTC)
Subject: Re: [PATCH v2] vhost-vdpa: fix page pinning leakage in error path
 (rework)
To:     Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com,
        lingshan.zhu@intel.com
Cc:     joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <1604532796-12757-1-git-send-email-si-wei.liu@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <dcbe4f3e-42f3-d245-9ee4-b17977ad27a5@redhat.com>
Date:   Thu, 5 Nov 2020 11:26:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1604532796-12757-1-git-send-email-si-wei.liu@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/5 上午7:33, Si-Wei Liu wrote:
> Pinned pages are not properly accounted particularly when
> mapping error occurs on IOTLB update. Clean up dangling
> pinned pages for the error path.
>
> The memory usage for bookkeeping pinned pages is reverted
> to what it was before: only one single free page is needed.
> This helps reduce the host memory demand for VM with a large
> amount of memory, or in the situation where host is running
> short of free memory.
>
> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
> Changes in v2:
> - Drop the reversion patch
> - Fix unhandled page leak towards the end of page_list
>
>   drivers/vhost/vdpa.c | 79 ++++++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 61 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index b6d9016..e112854 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -560,6 +560,8 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
>   
>   	if (r)
>   		vhost_iotlb_del_range(dev->iotlb, iova, iova + size - 1);
> +	else
> +		atomic64_add(size >> PAGE_SHIFT, &dev->mm->pinned_vm);
>   
>   	return r;
>   }
> @@ -591,14 +593,16 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>   	unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
>   	unsigned int gup_flags = FOLL_LONGTERM;
>   	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
> -	unsigned long locked, lock_limit, pinned, i;
> +	unsigned long lock_limit, sz2pin, nchunks, i;
>   	u64 iova = msg->iova;
> +	long pinned;
>   	int ret = 0;
>   
>   	if (vhost_iotlb_itree_first(iotlb, msg->iova,
>   				    msg->iova + msg->size - 1))
>   		return -EEXIST;
>   
> +	/* Limit the use of memory for bookkeeping */
>   	page_list = (struct page **) __get_free_page(GFP_KERNEL);
>   	if (!page_list)
>   		return -ENOMEM;
> @@ -607,52 +611,75 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>   		gup_flags |= FOLL_WRITE;
>   
>   	npages = PAGE_ALIGN(msg->size + (iova & ~PAGE_MASK)) >> PAGE_SHIFT;
> -	if (!npages)
> -		return -EINVAL;
> +	if (!npages) {
> +		ret = -EINVAL;
> +		goto free;
> +	}
>   
>   	mmap_read_lock(dev->mm);
>   
> -	locked = atomic64_add_return(npages, &dev->mm->pinned_vm);
>   	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> -
> -	if (locked > lock_limit) {
> +	if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
>   		ret = -ENOMEM;
> -		goto out;
> +		goto unlock;
>   	}
>   
>   	cur_base = msg->uaddr & PAGE_MASK;
>   	iova &= PAGE_MASK;
> +	nchunks = 0;
>   
>   	while (npages) {
> -		pinned = min_t(unsigned long, npages, list_size);
> -		ret = pin_user_pages(cur_base, pinned,
> -				     gup_flags, page_list, NULL);
> -		if (ret != pinned)
> +		sz2pin = min_t(unsigned long, npages, list_size);
> +		pinned = pin_user_pages(cur_base, sz2pin,
> +					gup_flags, page_list, NULL);
> +		if (sz2pin != pinned) {
> +			if (pinned < 0) {
> +				ret = pinned;
> +			} else {
> +				unpin_user_pages(page_list, pinned);
> +				ret = -ENOMEM;
> +			}
>   			goto out;
> +		}
> +		nchunks++;
>   
>   		if (!last_pfn)
>   			map_pfn = page_to_pfn(page_list[0]);
>   
> -		for (i = 0; i < ret; i++) {
> +		for (i = 0; i < pinned; i++) {
>   			unsigned long this_pfn = page_to_pfn(page_list[i]);
>   			u64 csize;
>   
>   			if (last_pfn && (this_pfn != last_pfn + 1)) {
>   				/* Pin a contiguous chunk of memory */
>   				csize = (last_pfn - map_pfn + 1) << PAGE_SHIFT;
> -				if (vhost_vdpa_map(v, iova, csize,
> -						   map_pfn << PAGE_SHIFT,
> -						   msg->perm))
> +				ret = vhost_vdpa_map(v, iova, csize,
> +						     map_pfn << PAGE_SHIFT,
> +						     msg->perm);
> +				if (ret) {
> +					/*
> +					 * Unpin the pages that are left unmapped
> +					 * from this point on in the current
> +					 * page_list. The remaining outstanding
> +					 * ones which may stride across several
> +					 * chunks will be covered in the common
> +					 * error path subsequently.
> +					 */
> +					unpin_user_pages(&page_list[i],
> +							 pinned - i);


Can we simply do last_pfn = this_pfn here?


>   					goto out;
> +				}
> +
>   				map_pfn = this_pfn;
>   				iova += csize;
> +				nchunks = 0;
>   			}
>   
>   			last_pfn = this_pfn;
>   		}
>   
> -		cur_base += ret << PAGE_SHIFT;
> -		npages -= ret;
> +		cur_base += pinned << PAGE_SHIFT;
> +		npages -= pinned;
>   	}
>   
>   	/* Pin the rest chunk */
> @@ -660,10 +687,26 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>   			     map_pfn << PAGE_SHIFT, msg->perm);
>   out:
>   	if (ret) {
> +		if (nchunks && last_pfn) {


Any reason for checking last_pfn here?

Note that we did:

+		nchunks++;
  
  		if (!last_pfn)
  			map_pfn = page_to_pfn(page_list[0]);


Thanks


> +			unsigned long pfn;
> +
> +			/*
> +			 * Unpin the outstanding pages which are yet to be
> +			 * mapped but haven't due to vdpa_map() or
> +			 * pin_user_pages() failure.
> +			 *
> +			 * Mapped pages are accounted in vdpa_map(), hence
> +			 * the corresponding unpinning will be handled by
> +			 * vdpa_unmap().
> +			 */
> +			for (pfn = map_pfn; pfn <= last_pfn; pfn++)
> +				unpin_user_page(pfn_to_page(pfn));
> +		}
>   		vhost_vdpa_unmap(v, msg->iova, msg->size);
> -		atomic64_sub(npages, &dev->mm->pinned_vm);
>   	}
> +unlock:
>   	mmap_read_unlock(dev->mm);
> +free:
>   	free_page((unsigned long)page_list);
>   	return ret;
>   }

