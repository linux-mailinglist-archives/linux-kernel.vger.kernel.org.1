Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC2D2AC98E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 00:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgKIX4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 18:56:32 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52154 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKIX4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 18:56:32 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9NsZBe071595;
        Mon, 9 Nov 2020 23:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : mime-version : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=j+8SZ6jURM8CsRuUQ1SQdJjcxLcOCiihnxI0zbDA42g=;
 b=fcineMcoqkURJTWSkcCEIsVlyEpqMDCQHH7R9u8vuk1pRzie/BXLitFeRi2ricyZn1J6
 b+c+9+5i/BwODc8hCUhnazOQgKUrnQdqXG8wHZHdIGa1/O1YlYxlWUEvLz2GxB4pLRDW
 ydkGIiMHyJMrjX2Su228NcUm2minY7+60DGXpcRbeuwVNcr6QNJny+bbNn1X920zP02H
 f3zOMI8Q4hvWZ2pEeb9rnt45wX3EL/Q0nlYYuzaWXRbxSZfAT3QNyscNVxyWps07vkCj
 bPIW8it7QFqpaS+NJUgl7wz7Z3Hvx9ooYydKdVErfwVJbB095Atf8al46KU2+MTbs9Ox kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34nkhkrw2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 23:56:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Nu5jU013145;
        Mon, 9 Nov 2020 23:56:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 34p5gw18qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 23:56:24 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9NuNhP032277;
        Mon, 9 Nov 2020 23:56:23 GMT
Received: from [10.159.155.223] (/10.159.155.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 15:56:22 -0800
Message-ID: <5FA9D725.3050906@oracle.com>
Date:   Mon, 09 Nov 2020 15:56:21 -0800
From:   si-wei liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Jason Wang <jasowang@redhat.com>, lingshan.zhu@intel.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2] vhost-vdpa: fix page pinning leakage in error path
 (rework)
References: <1604532796-12757-1-git-send-email-si-wei.liu@oracle.com> <dcbe4f3e-42f3-d245-9ee4-b17977ad27a5@redhat.com> <5FA48342.4060404@oracle.com> <64fb6179-c5ff-9552-381f-85b63e704057@redhat.com> <5FA9B823.9060609@oracle.com> <20201109173236-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201109173236-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=2 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/9/2020 2:42 PM, Michael S. Tsirkin wrote:
> On Mon, Nov 09, 2020 at 01:44:03PM -0800, si-wei liu wrote:
>> On 11/8/2020 7:21 PM, Jason Wang wrote:
>>> On 2020/11/6 上午6:57, si-wei liu wrote:
>>>> On 11/4/2020 7:26 PM, Jason Wang wrote:
>>>>> On 2020/11/5 上午7:33, Si-Wei Liu wrote:
>>>>>> Pinned pages are not properly accounted particularly when
>>>>>> mapping error occurs on IOTLB update. Clean up dangling
>>>>>> pinned pages for the error path.
>>>>>>
>>>>>> The memory usage for bookkeeping pinned pages is reverted
>>>>>> to what it was before: only one single free page is needed.
>>>>>> This helps reduce the host memory demand for VM with a large
>>>>>> amount of memory, or in the situation where host is running
>>>>>> short of free memory.
>>>>>>
>>>>>> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
>>>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>>> ---
>>>>>> Changes in v2:
>>>>>> - Drop the reversion patch
>>>>>> - Fix unhandled page leak towards the end of page_list
>>>>>>
>>>>>>    drivers/vhost/vdpa.c | 79
>>>>>> ++++++++++++++++++++++++++++++++++++++++------------
>>>>>>    1 file changed, 61 insertions(+), 18 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>>>>> index b6d9016..e112854 100644
>>>>>> --- a/drivers/vhost/vdpa.c
>>>>>> +++ b/drivers/vhost/vdpa.c
>>>>>> @@ -560,6 +560,8 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
>>>>>>          if (r)
>>>>>>            vhost_iotlb_del_range(dev->iotlb, iova, iova + size - 1);
>>>>>> +    else
>>>>>> +        atomic64_add(size >> PAGE_SHIFT, &dev->mm->pinned_vm);
>>>>>>          return r;
>>>>>>    }
>>>>>> @@ -591,14 +593,16 @@ static int
>>>>>> vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>>>>>        unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
>>>>>>        unsigned int gup_flags = FOLL_LONGTERM;
>>>>>>        unsigned long npages, cur_base, map_pfn, last_pfn = 0;
>>>>>> -    unsigned long locked, lock_limit, pinned, i;
>>>>>> +    unsigned long lock_limit, sz2pin, nchunks, i;
>>>>>>        u64 iova = msg->iova;
>>>>>> +    long pinned;
>>>>>>        int ret = 0;
>>>>>>          if (vhost_iotlb_itree_first(iotlb, msg->iova,
>>>>>>                        msg->iova + msg->size - 1))
>>>>>>            return -EEXIST;
>>>>>>    +    /* Limit the use of memory for bookkeeping */
>>>>>>        page_list = (struct page **) __get_free_page(GFP_KERNEL);
>>>>>>        if (!page_list)
>>>>>>            return -ENOMEM;
>>>>>> @@ -607,52 +611,75 @@ static int
>>>>>> vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>>>>>            gup_flags |= FOLL_WRITE;
>>>>>>          npages = PAGE_ALIGN(msg->size + (iova & ~PAGE_MASK))
>>>>>>>> PAGE_SHIFT;
>>>>>> -    if (!npages)
>>>>>> -        return -EINVAL;
>>>>>> +    if (!npages) {
>>>>>> +        ret = -EINVAL;
>>>>>> +        goto free;
>>>>>> +    }
>>>>>>          mmap_read_lock(dev->mm);
>>>>>>    -    locked = atomic64_add_return(npages, &dev->mm->pinned_vm);
>>>>>>        lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>>>>>> -
>>>>>> -    if (locked > lock_limit) {
>>>>>> +    if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
>>>>>>            ret = -ENOMEM;
>>>>>> -        goto out;
>>>>>> +        goto unlock;
>>>>>>        }
>>>>>>          cur_base = msg->uaddr & PAGE_MASK;
>>>>>>        iova &= PAGE_MASK;
>>>>>> +    nchunks = 0;
>>>>>>          while (npages) {
>>>>>> -        pinned = min_t(unsigned long, npages, list_size);
>>>>>> -        ret = pin_user_pages(cur_base, pinned,
>>>>>> -                     gup_flags, page_list, NULL);
>>>>>> -        if (ret != pinned)
>>>>>> +        sz2pin = min_t(unsigned long, npages, list_size);
>>>>>> +        pinned = pin_user_pages(cur_base, sz2pin,
>>>>>> +                    gup_flags, page_list, NULL);
>>>>>> +        if (sz2pin != pinned) {
>>>>>> +            if (pinned < 0) {
>>>>>> +                ret = pinned;
>>>>>> +            } else {
>>>>>> +                unpin_user_pages(page_list, pinned);
>>>>>> +                ret = -ENOMEM;
>>>>>> +            }
>>>>>>                goto out;
>>>>>> +        }
>>>>>> +        nchunks++;
>>>>>>              if (!last_pfn)
>>>>>>                map_pfn = page_to_pfn(page_list[0]);
>>>>>>    -        for (i = 0; i < ret; i++) {
>>>>>> +        for (i = 0; i < pinned; i++) {
>>>>>>                unsigned long this_pfn = page_to_pfn(page_list[i]);
>>>>>>                u64 csize;
>>>>>>                  if (last_pfn && (this_pfn != last_pfn + 1)) {
>>>>>>                    /* Pin a contiguous chunk of memory */
>>>>>>                    csize = (last_pfn - map_pfn + 1) << PAGE_SHIFT;
>>>>>> -                if (vhost_vdpa_map(v, iova, csize,
>>>>>> -                           map_pfn << PAGE_SHIFT,
>>>>>> -                           msg->perm))
>>>>>> +                ret = vhost_vdpa_map(v, iova, csize,
>>>>>> +                             map_pfn << PAGE_SHIFT,
>>>>>> +                             msg->perm);
>>>>>> +                if (ret) {
>>>>>> +                    /*
>>>>>> +                     * Unpin the pages that are left unmapped
>>>>>> +                     * from this point on in the current
>>>>>> +                     * page_list. The remaining outstanding
>>>>>> +                     * ones which may stride across several
>>>>>> +                     * chunks will be covered in the common
>>>>>> +                     * error path subsequently.
>>>>>> +                     */
>>>>>> +                    unpin_user_pages(&page_list[i],
>>>>>> +                             pinned - i);
>>>>>
>>>>> Can we simply do last_pfn = this_pfn here?
>>>> Nope. They are not contiguous segments of memory. Noted the
>>>> conditional (this_pfn != last_pfn + 1) being held here.
>>>
>>> Right.
>>>
>>>
>>>>>
>>>>>>                        goto out;
>>>>>> +                }
>>>>>> +
>>>>>>                    map_pfn = this_pfn;
>>>>>>                    iova += csize;
>>>>>> +                nchunks = 0;
>>>>>>                }
>>>>>>                  last_pfn = this_pfn;
>>>>>>            }
>>>>>>    -        cur_base += ret << PAGE_SHIFT;
>>>>>> -        npages -= ret;
>>>>>> +        cur_base += pinned << PAGE_SHIFT;
>>>>>> +        npages -= pinned;
>>>>>>        }
>>>>>>          /* Pin the rest chunk */
>>>>>> @@ -660,10 +687,26 @@ static int
>>>>>> vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>>>>>                     map_pfn << PAGE_SHIFT, msg->perm);
>>>>>>    out:
>>>>>>        if (ret) {
>>>>>> +        if (nchunks && last_pfn) {
>>>>>
>>>>> Any reason for checking last_pfn here?
>>>>>
>>>>> Note that we did:
>>>>>
>>>>> +        nchunks++;
>>>>>
>>>>>           if (!last_pfn)
>>>>>               map_pfn = page_to_pfn(page_list[0]);
>>>> It's for explicit coding to make sure this common error path can be
>>>> reused no matter if last_pfn has a sane value assigned or not. I can
>>>> change it to an implicit WARN_ON() if need be.
>>>
>>> Just to make sure I understand. A question, when will we get nchunks !=
>>> 0 but last_pfn == 0?
>> The current code has implicit assumption that nchunks != 0 infers last_pfn
>> != 0. However, this assumption could break subject to code structure changes
>> for eg. failure may occur after the increment of nchunks and before the for
>> loop. I feel it'd be the best to capture this assumption with something
>> explicit.
>>
>> -Siwei
> if here isn't really an explicit way to document assumptions,
> it's a way to avoid assumptions :)
Agreed. I was referring to the v3 patch which had turned the defensive 
coding to a WARN_ON().

> A way to document assumptions is probably BUG_ON.
If you're fine with below checkpatch warning I can definitely convert it 
to a BUG_ON:

WARNING: Avoid crashing the kernel - try using WARN_ON & recovery code 
rather than BUG() or BUG_ON()

Let me know if I need to post a v4 for this nit.

Thanks
-Siwei



>
>>> Thanks
>>>
>>>
>>>> Thanks,
>>>> -Siwei
>>>>
>>>>>
>>>>> Thanks
>>>>>
>>>>>
>>>>>> +            unsigned long pfn;
>>>>>> +
>>>>>> +            /*
>>>>>> +             * Unpin the outstanding pages which are yet to be
>>>>>> +             * mapped but haven't due to vdpa_map() or
>>>>>> +             * pin_user_pages() failure.
>>>>>> +             *
>>>>>> +             * Mapped pages are accounted in vdpa_map(), hence
>>>>>> +             * the corresponding unpinning will be handled by
>>>>>> +             * vdpa_unmap().
>>>>>> +             */
>>>>>> +            for (pfn = map_pfn; pfn <= last_pfn; pfn++)
>>>>>> +                unpin_user_page(pfn_to_page(pfn));
>>>>>> +        }
>>>>>>            vhost_vdpa_unmap(v, msg->iova, msg->size);
>>>>>> -        atomic64_sub(npages, &dev->mm->pinned_vm);
>>>>>>        }
>>>>>> +unlock:
>>>>>>        mmap_read_unlock(dev->mm);
>>>>>> +free:
>>>>>>        free_page((unsigned long)page_list);
>>>>>>        return ret;
>>>>>>    }

