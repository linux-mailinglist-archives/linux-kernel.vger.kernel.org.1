Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9183D2A3F5B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgKCIyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:54:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725997AbgKCIyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:54:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604393647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OQfTZ4/yLchqNBLCJcAj/4AvwpoGngxw+tG1Kqjj4u0=;
        b=OFRkPO0Zl5eQdZOH4DQVdVfhIM/6nDI7XXbHoQS3wnPgWa4sfTVuphmpSgPatJWMM9IU7W
        yUZ0NTZRSyzBNmI7S+zwW1RiAQyNOCpPdExfsbVq1RNqhR/63KAQDm49XVrcvYqEhi1kLz
        GOZ7UQMdm1k5U/xBHbupQCxbtUTE2xw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-17qyTZoZNHyXfsNLIKtlCg-1; Tue, 03 Nov 2020 03:54:03 -0500
X-MC-Unique: 17qyTZoZNHyXfsNLIKtlCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41AA2879514;
        Tue,  3 Nov 2020 08:54:02 +0000 (UTC)
Received: from [10.72.13.208] (ovpn-13-208.pek2.redhat.com [10.72.13.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC4EB389;
        Tue,  3 Nov 2020 08:53:49 +0000 (UTC)
Subject: Re: [PATCH 1/2] Revert "vhost-vdpa: fix page pinning leakage in error
 path"
To:     Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com,
        lingshan.zhu@intel.com
Cc:     joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <1604043944-4897-1-git-send-email-si-wei.liu@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <174406aa-9a3a-5def-530d-cd19b451be99@redhat.com>
Date:   Tue, 3 Nov 2020 16:53:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1604043944-4897-1-git-send-email-si-wei.liu@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/10/30 下午3:45, Si-Wei Liu wrote:
> This reverts commit 7ed9e3d97c32d969caded2dfb6e67c1a2cc5a0b1.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>   drivers/vhost/vdpa.c | 119 +++++++++++++++++++++------------------------------
>   1 file changed, 48 insertions(+), 71 deletions(-)


I saw this has been reverted there 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/vhost?id=5e1a3149eec8675c2767cc465903f5e4829de5b0.

:)

Thanks


>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index a2dbc85..b6d9016 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -588,19 +588,21 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>   	struct vhost_dev *dev = &v->vdev;
>   	struct vhost_iotlb *iotlb = dev->iotlb;
>   	struct page **page_list;
> -	struct vm_area_struct **vmas;
> +	unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
>   	unsigned int gup_flags = FOLL_LONGTERM;
> -	unsigned long map_pfn, last_pfn = 0;
> -	unsigned long npages, lock_limit;
> -	unsigned long i, nmap = 0;
> +	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
> +	unsigned long locked, lock_limit, pinned, i;
>   	u64 iova = msg->iova;
> -	long pinned;
>   	int ret = 0;
>   
>   	if (vhost_iotlb_itree_first(iotlb, msg->iova,
>   				    msg->iova + msg->size - 1))
>   		return -EEXIST;
>   
> +	page_list = (struct page **) __get_free_page(GFP_KERNEL);
> +	if (!page_list)
> +		return -ENOMEM;
> +
>   	if (msg->perm & VHOST_ACCESS_WO)
>   		gup_flags |= FOLL_WRITE;
>   
> @@ -608,86 +610,61 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>   	if (!npages)
>   		return -EINVAL;
>   
> -	page_list = kvmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
> -	vmas = kvmalloc_array(npages, sizeof(struct vm_area_struct *),
> -			      GFP_KERNEL);
> -	if (!page_list || !vmas) {
> -		ret = -ENOMEM;
> -		goto free;
> -	}
> -
>   	mmap_read_lock(dev->mm);
>   
> +	locked = atomic64_add_return(npages, &dev->mm->pinned_vm);
>   	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> -	if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
> -		ret = -ENOMEM;
> -		goto unlock;
> -	}
>   
> -	pinned = pin_user_pages(msg->uaddr & PAGE_MASK, npages, gup_flags,
> -				page_list, vmas);
> -	if (npages != pinned) {
> -		if (pinned < 0) {
> -			ret = pinned;
> -		} else {
> -			unpin_user_pages(page_list, pinned);
> -			ret = -ENOMEM;
> -		}
> -		goto unlock;
> +	if (locked > lock_limit) {
> +		ret = -ENOMEM;
> +		goto out;
>   	}
>   
> +	cur_base = msg->uaddr & PAGE_MASK;
>   	iova &= PAGE_MASK;
> -	map_pfn = page_to_pfn(page_list[0]);
> -
> -	/* One more iteration to avoid extra vdpa_map() call out of loop. */
> -	for (i = 0; i <= npages; i++) {
> -		unsigned long this_pfn;
> -		u64 csize;
> -
> -		/* The last chunk may have no valid PFN next to it */
> -		this_pfn = i < npages ? page_to_pfn(page_list[i]) : -1UL;
> -
> -		if (last_pfn && (this_pfn == -1UL ||
> -				 this_pfn != last_pfn + 1)) {
> -			/* Pin a contiguous chunk of memory */
> -			csize = last_pfn - map_pfn + 1;
> -			ret = vhost_vdpa_map(v, iova, csize << PAGE_SHIFT,
> -					     map_pfn << PAGE_SHIFT,
> -					     msg->perm);
> -			if (ret) {
> -				/*
> -				 * Unpin the rest chunks of memory on the
> -				 * flight with no corresponding vdpa_map()
> -				 * calls having been made yet. On the other
> -				 * hand, vdpa_unmap() in the failure path
> -				 * is in charge of accounting the number of
> -				 * pinned pages for its own.
> -				 * This asymmetrical pattern of accounting
> -				 * is for efficiency to pin all pages at
> -				 * once, while there is no other callsite
> -				 * of vdpa_map() than here above.
> -				 */
> -				unpin_user_pages(&page_list[nmap],
> -						 npages - nmap);
> -				goto out;
> +
> +	while (npages) {
> +		pinned = min_t(unsigned long, npages, list_size);
> +		ret = pin_user_pages(cur_base, pinned,
> +				     gup_flags, page_list, NULL);
> +		if (ret != pinned)
> +			goto out;
> +
> +		if (!last_pfn)
> +			map_pfn = page_to_pfn(page_list[0]);
> +
> +		for (i = 0; i < ret; i++) {
> +			unsigned long this_pfn = page_to_pfn(page_list[i]);
> +			u64 csize;
> +
> +			if (last_pfn && (this_pfn != last_pfn + 1)) {
> +				/* Pin a contiguous chunk of memory */
> +				csize = (last_pfn - map_pfn + 1) << PAGE_SHIFT;
> +				if (vhost_vdpa_map(v, iova, csize,
> +						   map_pfn << PAGE_SHIFT,
> +						   msg->perm))
> +					goto out;
> +				map_pfn = this_pfn;
> +				iova += csize;
>   			}
> -			atomic64_add(csize, &dev->mm->pinned_vm);
> -			nmap += csize;
> -			iova += csize << PAGE_SHIFT;
> -			map_pfn = this_pfn;
> +
> +			last_pfn = this_pfn;
>   		}
> -		last_pfn = this_pfn;
> +
> +		cur_base += ret << PAGE_SHIFT;
> +		npages -= ret;
>   	}
>   
> -	WARN_ON(nmap != npages);
> +	/* Pin the rest chunk */
> +	ret = vhost_vdpa_map(v, iova, (last_pfn - map_pfn + 1) << PAGE_SHIFT,
> +			     map_pfn << PAGE_SHIFT, msg->perm);
>   out:
> -	if (ret)
> +	if (ret) {
>   		vhost_vdpa_unmap(v, msg->iova, msg->size);
> -unlock:
> +		atomic64_sub(npages, &dev->mm->pinned_vm);
> +	}
>   	mmap_read_unlock(dev->mm);
> -free:
> -	kvfree(vmas);
> -	kvfree(page_list);
> +	free_page((unsigned long)page_list);
>   	return ret;
>   }
>   

