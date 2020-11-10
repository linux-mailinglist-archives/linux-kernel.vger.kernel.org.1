Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B712ACBAF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 04:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgKJD16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 22:27:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729454AbgKJD15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604978875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OdCoLTrBfFCRAJuNHfetWuIU7FDMdIZe8NhWrpGSAhw=;
        b=jKjvk18ADxfj2Qs/DK5MX87gT6ui+5oPiDA94VuBd2GrxCPdsrS4Sw2vIpY1ZURrSKDr8d
        n78VYnZARbkqcRfYxZNf84k7hgPfYiLPaOLX6CGC83PYcisU0rgVAM+x9IU4p9tnrBfsvI
        dqXes8k2KYGDlXQ6pgFM01+zFb6hb80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-pnvPGuLDMqikGu0rbBpPqg-1; Mon, 09 Nov 2020 22:27:51 -0500
X-MC-Unique: pnvPGuLDMqikGu0rbBpPqg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE76C57207;
        Tue, 10 Nov 2020 03:27:49 +0000 (UTC)
Received: from [10.72.13.94] (ovpn-13-94.pek2.redhat.com [10.72.13.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D89235C1D0;
        Tue, 10 Nov 2020 03:27:43 +0000 (UTC)
Subject: Re: [PATCH v2] vhost-vdpa: fix page pinning leakage in error path
 (rework)
To:     si-wei liu <si-wei.liu@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     lingshan.zhu@intel.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <1604532796-12757-1-git-send-email-si-wei.liu@oracle.com>
 <dcbe4f3e-42f3-d245-9ee4-b17977ad27a5@redhat.com>
 <5FA48342.4060404@oracle.com>
 <64fb6179-c5ff-9552-381f-85b63e704057@redhat.com>
 <5FA9B823.9060609@oracle.com> <20201109173236-mutt-send-email-mst@kernel.org>
 <5FA9D725.3050906@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <41804db9-27fe-5f5c-9d87-34fd380f3693@redhat.com>
Date:   Tue, 10 Nov 2020 11:27:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5FA9D725.3050906@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/10 上午7:56, si-wei liu wrote:
>
> On 11/9/2020 2:42 PM, Michael S. Tsirkin wrote:
>> On Mon, Nov 09, 2020 at 01:44:03PM -0800, si-wei liu wrote:
>>> On 11/8/2020 7:21 PM, Jason Wang wrote:
>>>> On 2020/11/6 上午6:57, si-wei liu wrote:
>>>>> On 11/4/2020 7:26 PM, Jason Wang wrote:
>>>>>> On 2020/11/5 上午7:33, Si-Wei Liu wrote:
>>>>>>> Pinned pages are not properly accounted particularly when
>>>>>>> mapping error occurs on IOTLB update. Clean up dangling
>>>>>>> pinned pages for the error path.
>>>>>>>
>>>>>>> The memory usage for bookkeeping pinned pages is reverted
>>>>>>> to what it was before: only one single free page is needed.
>>>>>>> This helps reduce the host memory demand for VM with a large
>>>>>>> amount of memory, or in the situation where host is running
>>>>>>> short of free memory.
>>>>>>>
>>>>>>> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
>>>>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>>>> ---
>>>>>>> Changes in v2:
>>>>>>> - Drop the reversion patch
>>>>>>> - Fix unhandled page leak towards the end of page_list
>>>>>>>
>>>>>>>    drivers/vhost/vdpa.c | 79
>>>>>>> ++++++++++++++++++++++++++++++++++++++++------------
>>>>>>>    1 file changed, 61 insertions(+), 18 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>>>>>> index b6d9016..e112854 100644
>>>>>>> --- a/drivers/vhost/vdpa.c
>>>>>>> +++ b/drivers/vhost/vdpa.c
>>>>>>> @@ -560,6 +560,8 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
>>>>>>>          if (r)
>>>>>>>            vhost_iotlb_del_range(dev->iotlb, iova, iova + size - 
>>>>>>> 1);
>>>>>>> +    else
>>>>>>> +        atomic64_add(size >> PAGE_SHIFT, &dev->mm->pinned_vm);
>>>>>>>          return r;
>>>>>>>    }
>>>>>>> @@ -591,14 +593,16 @@ static int
>>>>>>> vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>>>>>>        unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
>>>>>>>        unsigned int gup_flags = FOLL_LONGTERM;
>>>>>>>        unsigned long npages, cur_base, map_pfn, last_pfn = 0;
>>>>>>> -    unsigned long locked, lock_limit, pinned, i;
>>>>>>> +    unsigned long lock_limit, sz2pin, nchunks, i;
>>>>>>>        u64 iova = msg->iova;
>>>>>>> +    long pinned;
>>>>>>>        int ret = 0;
>>>>>>>          if (vhost_iotlb_itree_first(iotlb, msg->iova,
>>>>>>>                        msg->iova + msg->size - 1))
>>>>>>>            return -EEXIST;
>>>>>>>    +    /* Limit the use of memory for bookkeeping */
>>>>>>>        page_list = (struct page **) __get_free_page(GFP_KERNEL);
>>>>>>>        if (!page_list)
>>>>>>>            return -ENOMEM;
>>>>>>> @@ -607,52 +611,75 @@ static int
>>>>>>> vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>>>>>>            gup_flags |= FOLL_WRITE;
>>>>>>>          npages = PAGE_ALIGN(msg->size + (iova & ~PAGE_MASK))
>>>>>>>>> PAGE_SHIFT;
>>>>>>> -    if (!npages)
>>>>>>> -        return -EINVAL;
>>>>>>> +    if (!npages) {
>>>>>>> +        ret = -EINVAL;
>>>>>>> +        goto free;
>>>>>>> +    }
>>>>>>>          mmap_read_lock(dev->mm);
>>>>>>>    -    locked = atomic64_add_return(npages, &dev->mm->pinned_vm);
>>>>>>>        lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>>>>>>> -
>>>>>>> -    if (locked > lock_limit) {
>>>>>>> +    if (npages + atomic64_read(&dev->mm->pinned_vm) > 
>>>>>>> lock_limit) {
>>>>>>>            ret = -ENOMEM;
>>>>>>> -        goto out;
>>>>>>> +        goto unlock;
>>>>>>>        }
>>>>>>>          cur_base = msg->uaddr & PAGE_MASK;
>>>>>>>        iova &= PAGE_MASK;
>>>>>>> +    nchunks = 0;
>>>>>>>          while (npages) {
>>>>>>> -        pinned = min_t(unsigned long, npages, list_size);
>>>>>>> -        ret = pin_user_pages(cur_base, pinned,
>>>>>>> -                     gup_flags, page_list, NULL);
>>>>>>> -        if (ret != pinned)
>>>>>>> +        sz2pin = min_t(unsigned long, npages, list_size);
>>>>>>> +        pinned = pin_user_pages(cur_base, sz2pin,
>>>>>>> +                    gup_flags, page_list, NULL);
>>>>>>> +        if (sz2pin != pinned) {
>>>>>>> +            if (pinned < 0) {
>>>>>>> +                ret = pinned;
>>>>>>> +            } else {
>>>>>>> +                unpin_user_pages(page_list, pinned);
>>>>>>> +                ret = -ENOMEM;
>>>>>>> +            }
>>>>>>>                goto out;
>>>>>>> +        }
>>>>>>> +        nchunks++;
>>>>>>>              if (!last_pfn)
>>>>>>>                map_pfn = page_to_pfn(page_list[0]);
>>>>>>>    -        for (i = 0; i < ret; i++) {
>>>>>>> +        for (i = 0; i < pinned; i++) {
>>>>>>>                unsigned long this_pfn = page_to_pfn(page_list[i]);
>>>>>>>                u64 csize;
>>>>>>>                  if (last_pfn && (this_pfn != last_pfn + 1)) {
>>>>>>>                    /* Pin a contiguous chunk of memory */
>>>>>>>                    csize = (last_pfn - map_pfn + 1) << PAGE_SHIFT;
>>>>>>> -                if (vhost_vdpa_map(v, iova, csize,
>>>>>>> -                           map_pfn << PAGE_SHIFT,
>>>>>>> -                           msg->perm))
>>>>>>> +                ret = vhost_vdpa_map(v, iova, csize,
>>>>>>> +                             map_pfn << PAGE_SHIFT,
>>>>>>> +                             msg->perm);
>>>>>>> +                if (ret) {
>>>>>>> +                    /*
>>>>>>> +                     * Unpin the pages that are left unmapped
>>>>>>> +                     * from this point on in the current
>>>>>>> +                     * page_list. The remaining outstanding
>>>>>>> +                     * ones which may stride across several
>>>>>>> +                     * chunks will be covered in the common
>>>>>>> +                     * error path subsequently.
>>>>>>> +                     */
>>>>>>> + unpin_user_pages(&page_list[i],
>>>>>>> +                             pinned - i);
>>>>>>
>>>>>> Can we simply do last_pfn = this_pfn here?
>>>>> Nope. They are not contiguous segments of memory. Noted the
>>>>> conditional (this_pfn != last_pfn + 1) being held here.
>>>>
>>>> Right.
>>>>
>>>>
>>>>>>
>>>>>>>                        goto out;
>>>>>>> +                }
>>>>>>> +
>>>>>>>                    map_pfn = this_pfn;
>>>>>>>                    iova += csize;
>>>>>>> +                nchunks = 0;
>>>>>>>                }
>>>>>>>                  last_pfn = this_pfn;
>>>>>>>            }
>>>>>>>    -        cur_base += ret << PAGE_SHIFT;
>>>>>>> -        npages -= ret;
>>>>>>> +        cur_base += pinned << PAGE_SHIFT;
>>>>>>> +        npages -= pinned;
>>>>>>>        }
>>>>>>>          /* Pin the rest chunk */
>>>>>>> @@ -660,10 +687,26 @@ static int
>>>>>>> vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>>>>>>                     map_pfn << PAGE_SHIFT, msg->perm);
>>>>>>>    out:
>>>>>>>        if (ret) {
>>>>>>> +        if (nchunks && last_pfn) {
>>>>>>
>>>>>> Any reason for checking last_pfn here?
>>>>>>
>>>>>> Note that we did:
>>>>>>
>>>>>> +        nchunks++;
>>>>>>
>>>>>>           if (!last_pfn)
>>>>>>               map_pfn = page_to_pfn(page_list[0]);
>>>>> It's for explicit coding to make sure this common error path can be
>>>>> reused no matter if last_pfn has a sane value assigned or not. I can
>>>>> change it to an implicit WARN_ON() if need be.
>>>>
>>>> Just to make sure I understand. A question, when will we get 
>>>> nchunks !=
>>>> 0 but last_pfn == 0?
>>> The current code has implicit assumption that nchunks != 0 infers 
>>> last_pfn
>>> != 0. However, this assumption could break subject to code structure 
>>> changes
>>> for eg. failure may occur after the increment of nchunks and before 
>>> the for
>>> loop. I feel it'd be the best to capture this assumption with something
>>> explicit.
>>>
>>> -Siwei
>> if here isn't really an explicit way to document assumptions,
>> it's a way to avoid assumptions :)
> Agreed. I was referring to the v3 patch which had turned the defensive 
> coding to a WARN_ON().


I think I get you now.


>
>> A way to document assumptions is probably BUG_ON.
> If you're fine with below checkpatch warning I can definitely convert 
> it to a BUG_ON:
>
> WARNING: Avoid crashing the kernel - try using WARN_ON & recovery code 
> rather than BUG() or BUG_ON()
>
> Let me know if I need to post a v4 for this nit.


I will ack for V3.

Thanks


>
> Thanks
> -Siwei
>
>
>
>>
>>>> Thanks
>>>>
>>>>
>>>>> Thanks,
>>>>> -Siwei
>>>>>
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>>
>>>>>>> +            unsigned long pfn;
>>>>>>> +
>>>>>>> +            /*
>>>>>>> +             * Unpin the outstanding pages which are yet to be
>>>>>>> +             * mapped but haven't due to vdpa_map() or
>>>>>>> +             * pin_user_pages() failure.
>>>>>>> +             *
>>>>>>> +             * Mapped pages are accounted in vdpa_map(), hence
>>>>>>> +             * the corresponding unpinning will be handled by
>>>>>>> +             * vdpa_unmap().
>>>>>>> +             */
>>>>>>> +            for (pfn = map_pfn; pfn <= last_pfn; pfn++)
>>>>>>> +                unpin_user_page(pfn_to_page(pfn));
>>>>>>> +        }
>>>>>>>            vhost_vdpa_unmap(v, msg->iova, msg->size);
>>>>>>> -        atomic64_sub(npages, &dev->mm->pinned_vm);
>>>>>>>        }
>>>>>>> +unlock:
>>>>>>>        mmap_read_unlock(dev->mm);
>>>>>>> +free:
>>>>>>>        free_page((unsigned long)page_list);
>>>>>>>        return ret;
>>>>>>>    }
>

