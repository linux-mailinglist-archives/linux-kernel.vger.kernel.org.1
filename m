Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864CF2A5C76
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 02:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbgKDB63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 20:58:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728301AbgKDB63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 20:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604455106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/UAWX/l1lwuyu7yfRs5oPUEbyXJnB4GGE7rO3NI4ilQ=;
        b=N+EBIz1YlxvhhMWnPmuhL/nL25nDuidVCcCqcf7nIoatG/gQ1jahSYDsJTp1EaoTq9XS/w
        ZDqeFkwRi0HyKBiJF5qCagnD0/rpr0rrYzMp7EOrUo33wAz86KgGCdGq3+mgowfcSJ1jMD
        YmRGFEewcHdiWxavFs0rRhM4V1tO59c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-UaK9TAl2MnS_77rMomrX-g-1; Tue, 03 Nov 2020 20:58:22 -0500
X-MC-Unique: UaK9TAl2MnS_77rMomrX-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5457A8030C8;
        Wed,  4 Nov 2020 01:58:21 +0000 (UTC)
Received: from [10.72.13.133] (ovpn-13-133.pek2.redhat.com [10.72.13.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C93895D9D3;
        Wed,  4 Nov 2020 01:58:11 +0000 (UTC)
Subject: Re: [PATCH 2/2] vhost-vdpa: fix page pinning leakage in error path
 (rework)
To:     si-wei liu <si-wei.liu@oracle.com>, mst@redhat.com,
        lingshan.zhu@intel.com
Cc:     joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <1604043944-4897-1-git-send-email-si-wei.liu@oracle.com>
 <1604043944-4897-2-git-send-email-si-wei.liu@oracle.com>
 <42fe6ef3-90f6-ddb9-f206-e60c1e98c301@redhat.com>
 <5FA1FE87.4050909@oracle.com> <5FA1FF1B.1000303@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <328b6e09-7393-00d8-54d9-aac508b3016e@redhat.com>
Date:   Wed, 4 Nov 2020 09:58:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5FA1FF1B.1000303@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/4 上午9:08, si-wei liu wrote:
>
> On 11/3/2020 5:06 PM, si-wei liu wrote:
>>
>> On 11/3/2020 5:00 AM, Jason Wang wrote:
>>>
>>> On 2020/10/30 下午3:45, Si-Wei Liu wrote:
>>>> Pinned pages are not properly accounted particularly when
>>>> mapping error occurs on IOTLB update. Clean up dangling
>>>> pinned pages for the error path.
>>>>
>>>> The memory usage for bookkeeping pinned pages is reverted
>>>> to what it was before: only one single free page is needed.
>>>> This helps reduce the host memory demand for VM with a large
>>>> amount of memory, or in the situation where host is running
>>>> short of free memory.
>>>>
>>>> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>> ---
>>>>   drivers/vhost/vdpa.c | 64 
>>>> +++++++++++++++++++++++++++++++++++++---------------
>>>>   1 file changed, 46 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>>> index b6d9016..8da8558 100644
>>>> --- a/drivers/vhost/vdpa.c
>>>> +++ b/drivers/vhost/vdpa.c
>>>> @@ -560,6 +560,8 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
>>>>         if (r)
>>>>           vhost_iotlb_del_range(dev->iotlb, iova, iova + size - 1);
>>>> +    else
>>>> +        atomic64_add(size >> PAGE_SHIFT, &dev->mm->pinned_vm);
>>>>         return r;
>>>>   }
>>>> @@ -591,14 +593,16 @@ static int 
>>>> vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>>>       unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
>>>>       unsigned int gup_flags = FOLL_LONGTERM;
>>>>       unsigned long npages, cur_base, map_pfn, last_pfn = 0;
>>>> -    unsigned long locked, lock_limit, pinned, i;
>>>> +    unsigned long lock_limit, sz2pin, nchunks, i;
>>>>       u64 iova = msg->iova;
>>>> +    long pinned;
>>>>       int ret = 0;
>>>>         if (vhost_iotlb_itree_first(iotlb, msg->iova,
>>>>                       msg->iova + msg->size - 1))
>>>>           return -EEXIST;
>>>>   +    /* Limit the use of memory for bookkeeping */
>>>>       page_list = (struct page **) __get_free_page(GFP_KERNEL);
>>>>       if (!page_list)
>>>>           return -ENOMEM;
>>>> @@ -607,52 +611,64 @@ static int 
>>>> vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>>>           gup_flags |= FOLL_WRITE;
>>>>         npages = PAGE_ALIGN(msg->size + (iova & ~PAGE_MASK)) >> 
>>>> PAGE_SHIFT;
>>>> -    if (!npages)
>>>> -        return -EINVAL;
>>>> +    if (!npages) {
>>>> +        ret = -EINVAL;
>>>> +        goto free;
>>>> +    }
>>>>         mmap_read_lock(dev->mm);
>>>>   -    locked = atomic64_add_return(npages, &dev->mm->pinned_vm);
>>>>       lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>>>> -
>>>> -    if (locked > lock_limit) {
>>>> +    if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
>>>>           ret = -ENOMEM;
>>>> -        goto out;
>>>> +        goto unlock;
>>>>       }
>>>>         cur_base = msg->uaddr & PAGE_MASK;
>>>>       iova &= PAGE_MASK;
>>>> +    nchunks = 0;
>>>>         while (npages) {
>>>> -        pinned = min_t(unsigned long, npages, list_size);
>>>> -        ret = pin_user_pages(cur_base, pinned,
>>>> -                     gup_flags, page_list, NULL);
>>>> -        if (ret != pinned)
>>>> +        sz2pin = min_t(unsigned long, npages, list_size);
>>>> +        pinned = pin_user_pages(cur_base, sz2pin,
>>>> +                    gup_flags, page_list, NULL);
>>>> +        if (sz2pin != pinned) {
>>>> +            if (pinned < 0) {
>>>> +                ret = pinned;
>>>> +            } else {
>>>> +                unpin_user_pages(page_list, pinned);
>>>> +                ret = -ENOMEM;
>>>> +            }
>>>>               goto out;
>>>> +        }
>>>> +        nchunks++;
>>>>             if (!last_pfn)
>>>>               map_pfn = page_to_pfn(page_list[0]);
>>>>   -        for (i = 0; i < ret; i++) {
>>>> +        for (i = 0; i < pinned; i++) {
>>>>               unsigned long this_pfn = page_to_pfn(page_list[i]);
>>>>               u64 csize;
>>>>                 if (last_pfn && (this_pfn != last_pfn + 1)) {
>>>>                   /* Pin a contiguous chunk of memory */
>>>>                   csize = (last_pfn - map_pfn + 1) << PAGE_SHIFT;
>>>> -                if (vhost_vdpa_map(v, iova, csize,
>>>> -                           map_pfn << PAGE_SHIFT,
>>>> -                           msg->perm))
>>>> +                ret = vhost_vdpa_map(v, iova, csize,
>>>> +                             map_pfn << PAGE_SHIFT,
>>>> +                             msg->perm);
>>>> +                if (ret)
>>>>                       goto out;
>>>> +
>>>>                   map_pfn = this_pfn;
>>>>                   iova += csize;
>>>> +                nchunks = 0;
>>>>               }
>>>>                 last_pfn = this_pfn;
>>>>           }
>>>>   -        cur_base += ret << PAGE_SHIFT;
>>>> -        npages -= ret;
>>>> +        cur_base += pinned << PAGE_SHIFT;
>>>> +        npages -= pinned;
>>>>       }
>>>>         /* Pin the rest chunk */
>>>> @@ -660,10 +676,22 @@ static int 
>>>> vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>>>                    map_pfn << PAGE_SHIFT, msg->perm);
>>>>   out:
>>>>       if (ret) {
>>>> +        if (nchunks && last_pfn) {
>>>> +            unsigned long pfn;
>>>> +
>>>> +            /*
>>>> +             * Unpin the outstanding pages which are unmapped.
>>>> +             * Mapped pages are accounted in vdpa_map(), thus
>>>> +             * will be handled by vdpa_unmap().
>>>> +             */
>>>> +            for (pfn = map_pfn; pfn <= last_pfn; pfn++)
>>>> +                unpin_user_page(pfn_to_page(pfn));
>>>> +        }
>>>>           vhost_vdpa_unmap(v, msg->iova, msg->size);
>>>
>>>
>>> I want to know what's wrong with current code.
>>>
>>> We call vhost_vdpa_unmap() on error which calls 
>>> vhost_vdpa_iotlb_unmap() that will unpin and reduce the pinned_vm.
>> Think about the case where vhost_vdpa_map() fails in the middle after 
>> making a few successful ones. In the current code, the 
>> vhost_vdpa_iotlb_unmap() unpins what had been mapped, but does not 
>> unpin those that have not yet been mapped. These outstanding pinned 
>> pages will be leaked after leaving the vhost_vdpa_map() function.
> Typo: ... leaving the vhost_vdpa_process_iotlb_update() function.
>>
>> Also, the subtraction accounting at the end of the function is 
>> incorrect in that case: @npages is deduced by @pinned in each 
>> iteration. That's why I moved the accounting to vhost_vdpa_map() to 
>> be symmetric with vhost_vdpa_unmap().
>>

I see, then I wonder if it would have more easy to read code if we do 
(un)pinning/accouting only in vhost_vdpa_map()/vhost_vdpa_unmap()?

Thanks


>>
>> -Siwei
>>>
>>> Thanks
>>>
>>>
>>>> -        atomic64_sub(npages, &dev->mm->pinned_vm);
>>>>       }
>>>> +unlock:
>>>>       mmap_read_unlock(dev->mm);
>>>> +free:
>>>>       free_page((unsigned long)page_list);
>>>>       return ret;
>>>>   }
>>>
>>
>

