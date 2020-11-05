Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E110A2A8A04
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbgKEWkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:40:22 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35832 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732046AbgKEWkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:40:21 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A5MdLr1108716;
        Thu, 5 Nov 2020 22:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : mime-version : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=cqWZm+4EoPfwmoGeHu0IrhFosnm7ha7NSRN73JiWl2k=;
 b=n6wmRoKKjgGFXtuSrwdivoS9w1PoZBn90gpoukxDDVMex7MrUZ1O9wU1X7SbIzbiDZmH
 LQvfFiFywZC9EaLK938xwvZ0Muhprp2RbGUVUi1MSb65/ZLE5+059FoO9ibOpGzW5izz
 FSq9nFArtTRgfflPhdVLm0bSSQupy4QgTZwBSAFF1WKIYGAPrRTMDm93bT6BflqxhZAZ
 trm2jeW3X/SmSibzkeNi6iYTwopRT80gvWhUJJk6bxCAM1OrjlwPZ/CFfZ2RSAiG7AE/
 QZ8M6+A8/VVFTiRrGppJWES3G4Dxgxbc/QT3YWgxbHtDGvWX0mUZk4Y6qFGgmRjJud2C Jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34hhw2xg1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 05 Nov 2020 22:40:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A5MUauw072666;
        Thu, 5 Nov 2020 22:40:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34hw0ne26m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Nov 2020 22:40:15 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A5MeDT7014778;
        Thu, 5 Nov 2020 22:40:14 GMT
Received: from [192.168.0.28] (/73.189.186.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Nov 2020 14:40:13 -0800
Message-ID: <5FA47F4C.2030504@oracle.com>
Date:   Thu, 05 Nov 2020 14:40:12 -0800
From:   si-wei liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        lingshan.zhu@intel.com
CC:     joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 2/2] vhost-vdpa: fix page pinning leakage in error path
 (rework)
References: <1604043944-4897-1-git-send-email-si-wei.liu@oracle.com> <1604043944-4897-2-git-send-email-si-wei.liu@oracle.com> <77a2aefe-ccad-bd51-3721-1139d4e535d7@redhat.com> <5FA33C06.6010000@oracle.com> <38317b10-0f1f-1521-ec10-a462be83b5a6@redhat.com>
In-Reply-To: <38317b10-0f1f-1521-ec10-a462be83b5a6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=2 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=2 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050146
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/4/2020 7:12 PM, Jason Wang wrote:
>
> On 2020/11/5 上午7:40, si-wei liu wrote:
>>
>> On 11/3/2020 6:42 PM, Jason Wang wrote:
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
>>>>   drivers/vhost/vdpa.c | 64 
>>>> +++++++++++++++++++++++++++++++++++++---------------
>>>>   1 file changed, 46 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>>> index b6d9016..8da8558 100644
>>>> --- a/drivers/vhost/vdpa.c
>>>> +++ b/drivers/vhost/vdpa.c
>>>> @@ -560,6 +560,8 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
>>>>         if (r)
>>>>           vhost_iotlb_del_range(dev->iotlb, iova, iova + size - 1);
>>>> +    else
>>>> +        atomic64_add(size >> PAGE_SHIFT, &dev->mm->pinned_vm);
>>>>         return r;
>>>>   }
>>>> @@ -591,14 +593,16 @@ static int 
>>>> vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>>>       unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
>>>>       unsigned int gup_flags = FOLL_LONGTERM;
>>>>       unsigned long npages, cur_base, map_pfn, last_pfn = 0;
>>>> -    unsigned long locked, lock_limit, pinned, i;
>>>> +    unsigned long lock_limit, sz2pin, nchunks, i;
>>>>       u64 iova = msg->iova;
>>>> +    long pinned;
>>>>       int ret = 0;
>>>>         if (vhost_iotlb_itree_first(iotlb, msg->iova,
>>>>                       msg->iova + msg->size - 1))
>>>>           return -EEXIST;
>>>>   +    /* Limit the use of memory for bookkeeping */
>>>>       page_list = (struct page **) __get_free_page(GFP_KERNEL);
>>>>       if (!page_list)
>>>>           return -ENOMEM;
>>>> @@ -607,52 +611,64 @@ static int 
>>>> vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>>>           gup_flags |= FOLL_WRITE;
>>>>         npages = PAGE_ALIGN(msg->size + (iova & ~PAGE_MASK)) >> 
>>>> PAGE_SHIFT;
>>>> -    if (!npages)
>>>> -        return -EINVAL;
>>>> +    if (!npages) {
>>>> +        ret = -EINVAL;
>>>> +        goto free;
>>>> +    }
>>>>         mmap_read_lock(dev->mm);
>>>>   -    locked = atomic64_add_return(npages, &dev->mm->pinned_vm);
>>>>       lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>>>> -
>>>> -    if (locked > lock_limit) {
>>>> +    if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
>>>>           ret = -ENOMEM;
>>>> -        goto out;
>>>> +        goto unlock;
>>>>       }
>>>>         cur_base = msg->uaddr & PAGE_MASK;
>>>>       iova &= PAGE_MASK;
>>>> +    nchunks = 0;
>>>>         while (npages) {
>>>> -        pinned = min_t(unsigned long, npages, list_size);
>>>> -        ret = pin_user_pages(cur_base, pinned,
>>>> -                     gup_flags, page_list, NULL);
>>>> -        if (ret != pinned)
>>>> +        sz2pin = min_t(unsigned long, npages, list_size);
>>>> +        pinned = pin_user_pages(cur_base, sz2pin,
>>>> +                    gup_flags, page_list, NULL);
>>>> +        if (sz2pin != pinned) {
>>>> +            if (pinned < 0) {
>>>> +                ret = pinned;
>>>> +            } else {
>>>> +                unpin_user_pages(page_list, pinned);
>>>> +                ret = -ENOMEM;
>>>> +            }
>>>>               goto out;
>>>> +        }
>>>> +        nchunks++;
>>>>             if (!last_pfn)
>>>>               map_pfn = page_to_pfn(page_list[0]);
>>>>   -        for (i = 0; i < ret; i++) {
>>>> +        for (i = 0; i < pinned; i++) {
>>>>               unsigned long this_pfn = page_to_pfn(page_list[i]);
>>>>               u64 csize;
>>>>                 if (last_pfn && (this_pfn != last_pfn + 1)) {
>>>>                   /* Pin a contiguous chunk of memory */
>>>>                   csize = (last_pfn - map_pfn + 1) << PAGE_SHIFT;
>>>> -                if (vhost_vdpa_map(v, iova, csize,
>>>> -                           map_pfn << PAGE_SHIFT,
>>>> -                           msg->perm))
>>>> +                ret = vhost_vdpa_map(v, iova, csize,
>>>> +                             map_pfn << PAGE_SHIFT,
>>>> +                             msg->perm);
>>>> +                if (ret)
>>>>                       goto out;
>>>> +
>>>>                   map_pfn = this_pfn;
>>>>                   iova += csize;
>>>> +                nchunks = 0;
>>>>               }
>>>>                 last_pfn = this_pfn;
>>>>           }
>>>>   -        cur_base += ret << PAGE_SHIFT;
>>>> -        npages -= ret;
>>>> +        cur_base += pinned << PAGE_SHIFT;
>>>> +        npages -= pinned;
>>>>       }
>>>>         /* Pin the rest chunk */
>>>> @@ -660,10 +676,22 @@ static int 
>>>> vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>>>                    map_pfn << PAGE_SHIFT, msg->perm);
>>>>   out:
>>>>       if (ret) {
>>>> +        if (nchunks && last_pfn) {
>>>
>>>
>>> Can we decrease npages where you did "nchunks++" then we can check 
>>> npages here instead?
>> Hmmm, I am not sure I get what you want... @nchunks gets reset to 0 
>> whenever a certain range of pinned pages is successfully mapped. The 
>> conditional (when nchunks is non-zero) here indicates if there's any 
>> _outstanding_ pinned page that has to clean up in the error handling 
>> path. While the decrement of @npages may not occur when resetting the 
>> @nchunks counter, rendering incorrect cleanup in the error path.
>
>
> Yes, I meant e can decrease npages where you did "nchunks++". Anyhow, 
> it's just a optimization to avoid a local variable which is not a must.

To me that opportunity doesn't exist. @nchunks and @npages track 
different kind of things. @npages is not interchangeable to represent 
all possible error cases.

-Siwei

>
>
>>
>> BTW while reviewing it I got noticed of an error in my code. There 
>> might be still page pinning leak from wherever the vhost_vdpa_map() 
>> error occurs towards the end of page_list. I will post a v2 to fix this.
>>
>
> Sure, will review.
>
> Thanks
>
>
>> Regards,
>> -Siwei
>>
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -656,8 +656,19 @@ static int 
>> vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>                                 ret = vhost_vdpa_map(v, iova, csize,
>>                                                      map_pfn << 
>> PAGE_SHIFT,
>> msg->perm);
>> -                               if (ret)
>> +                               if (ret) {
>> +                                       /*
>> +                                        * Unpin the pages that are 
>> left unmapped
>> +                                        * from this point on in the 
>> current
>> +                                        * page_list. The remaining 
>> outstanding
>> +                                        * ones which may stride 
>> across several
>> +                                        * chunks will be covered in 
>> the common
>> +                                        * error path subsequently.
>> +                                        */
>> + unpin_user_pages(&page_list[i],
>> +                                                        pinned - i);
>>                                         goto out;
>> +                               }
>>
>>                                 map_pfn = this_pfn;
>>                                 iova += csize;
>>
>>
>>
>>>
>>> Thanks
>>>
>>>
>>>> +            unsigned long pfn;
>>>> +
>>>> +            /*
>>>> +             * Unpin the outstanding pages which are unmapped.
>>>> +             * Mapped pages are accounted in vdpa_map(), thus
>>>> +             * will be handled by vdpa_unmap().
>>>> +             */
>>>> +            for (pfn = map_pfn; pfn <= last_pfn; pfn++)
>>>> +                unpin_user_page(pfn_to_page(pfn));
>>>> +        }
>>>>           vhost_vdpa_unmap(v, msg->iova, msg->size);
>>>> -        atomic64_sub(npages, &dev->mm->pinned_vm);
>>>>       }
>>>> +unlock:
>>>>       mmap_read_unlock(dev->mm);
>>>> +free:
>>>>       free_page((unsigned long)page_list);
>>>>       return ret;
>>>>   }
>>>
>>
>

