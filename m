Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456BF2A5C9F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 03:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgKDCQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 21:16:21 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52214 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729764AbgKDCQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 21:16:21 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A42GFRp007942;
        Wed, 4 Nov 2020 02:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : mime-version : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=erw7u5MM+etiNHAQKzo2tCxLDNXM9ykEwYhYCNlVB/4=;
 b=SyDg1iOIFWEHEfRfgRYAm2TQ1DsgCDtyloqPH1zPOfSeDls2XsyYz005VBv3qQl6Obvj
 yXyJManYbMbCbjCSctmCso6cNRofdQLzMD5FvodrTVEtaUChbqECc8PldtSkvTyW9sXl
 lffdKdlirOwPO/V6SPyaQX6HeDd8MHNhO6dZDjnZLofLJGOHQrprAuDQCEgS8tix7Ua+
 MJWeKjImQ2bkWP9g3NYNq1hrg2Rr2n8BmeKQ9LFE9sTOI3uU46nfcaXwsbmwehR8pA1+
 ORJBqzgJDRriuQz5pzG5WDuEjfNQvUp/0uL8Jl/7S4AcHg622lSxrC4EaRn7rHKYA2cw LQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34hhb24etr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 04 Nov 2020 02:16:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A42Ah8l148155;
        Wed, 4 Nov 2020 02:14:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34hw0efjxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Nov 2020 02:14:14 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A42EAtu013024;
        Wed, 4 Nov 2020 02:14:11 GMT
Received: from [10.159.249.36] (/10.159.249.36)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Nov 2020 18:14:09 -0800
Message-ID: <5FA20E70.9010606@oracle.com>
Date:   Tue, 03 Nov 2020 18:14:08 -0800
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
References: <1604043944-4897-1-git-send-email-si-wei.liu@oracle.com> <1604043944-4897-2-git-send-email-si-wei.liu@oracle.com> <42fe6ef3-90f6-ddb9-f206-e60c1e98c301@redhat.com> <5FA1FE87.4050909@oracle.com> <5FA1FF1B.1000303@oracle.com> <328b6e09-7393-00d8-54d9-aac508b3016e@redhat.com>
In-Reply-To: <328b6e09-7393-00d8-54d9-aac508b3016e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9794 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9794 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=2
 clxscore=1015 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011040014
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/3/2020 5:58 PM, Jason Wang wrote:
>
> On 2020/11/4 上午9:08, si-wei liu wrote:
>>
>> On 11/3/2020 5:06 PM, si-wei liu wrote:
>>>
>>> On 11/3/2020 5:00 AM, Jason Wang wrote:
>>>>
>>>> On 2020/10/30 下午3:45, Si-Wei Liu wrote:
>>>>> Pinned pages are not properly accounted particularly when
>>>>> mapping error occurs on IOTLB update. Clean up dangling
>>>>> pinned pages for the error path.
>>>>>
>>>>> The memory usage for bookkeeping pinned pages is reverted
>>>>> to what it was before: only one single free page is needed.
>>>>> This helps reduce the host memory demand for VM with a large
>>>>> amount of memory, or in the situation where host is running
>>>>> short of free memory.
>>>>>
>>>>> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
>>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>> ---
>>>>>   drivers/vhost/vdpa.c | 64 
>>>>> +++++++++++++++++++++++++++++++++++++---------------
>>>>>   1 file changed, 46 insertions(+), 18 deletions(-)
>>>>>
>>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>>>> index b6d9016..8da8558 100644
>>>>> --- a/drivers/vhost/vdpa.c
>>>>> +++ b/drivers/vhost/vdpa.c
>>>>> @@ -560,6 +560,8 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
>>>>>         if (r)
>>>>>           vhost_iotlb_del_range(dev->iotlb, iova, iova + size - 1);
>>>>> +    else
>>>>> +        atomic64_add(size >> PAGE_SHIFT, &dev->mm->pinned_vm);
>>>>>         return r;
>>>>>   }
>>>>> @@ -591,14 +593,16 @@ static int 
>>>>> vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>>>>       unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
>>>>>       unsigned int gup_flags = FOLL_LONGTERM;
>>>>>       unsigned long npages, cur_base, map_pfn, last_pfn = 0;
>>>>> -    unsigned long locked, lock_limit, pinned, i;
>>>>> +    unsigned long lock_limit, sz2pin, nchunks, i;
>>>>>       u64 iova = msg->iova;
>>>>> +    long pinned;
>>>>>       int ret = 0;
>>>>>         if (vhost_iotlb_itree_first(iotlb, msg->iova,
>>>>>                       msg->iova + msg->size - 1))
>>>>>           return -EEXIST;
>>>>>   +    /* Limit the use of memory for bookkeeping */
>>>>>       page_list = (struct page **) __get_free_page(GFP_KERNEL);
>>>>>       if (!page_list)
>>>>>           return -ENOMEM;
>>>>> @@ -607,52 +611,64 @@ static int 
>>>>> vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>>>>           gup_flags |= FOLL_WRITE;
>>>>>         npages = PAGE_ALIGN(msg->size + (iova & ~PAGE_MASK)) >> 
>>>>> PAGE_SHIFT;
>>>>> -    if (!npages)
>>>>> -        return -EINVAL;
>>>>> +    if (!npages) {
>>>>> +        ret = -EINVAL;
>>>>> +        goto free;
>>>>> +    }
>>>>>         mmap_read_lock(dev->mm);
>>>>>   -    locked = atomic64_add_return(npages, &dev->mm->pinned_vm);
>>>>>       lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>>>>> -
>>>>> -    if (locked > lock_limit) {
>>>>> +    if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
>>>>>           ret = -ENOMEM;
>>>>> -        goto out;
>>>>> +        goto unlock;
>>>>>       }
>>>>>         cur_base = msg->uaddr & PAGE_MASK;
>>>>>       iova &= PAGE_MASK;
>>>>> +    nchunks = 0;
>>>>>         while (npages) {
>>>>> -        pinned = min_t(unsigned long, npages, list_size);
>>>>> -        ret = pin_user_pages(cur_base, pinned,
>>>>> -                     gup_flags, page_list, NULL);
>>>>> -        if (ret != pinned)
>>>>> +        sz2pin = min_t(unsigned long, npages, list_size);
>>>>> +        pinned = pin_user_pages(cur_base, sz2pin,
>>>>> +                    gup_flags, page_list, NULL);
>>>>> +        if (sz2pin != pinned) {
>>>>> +            if (pinned < 0) {
>>>>> +                ret = pinned;
>>>>> +            } else {
>>>>> +                unpin_user_pages(page_list, pinned);
>>>>> +                ret = -ENOMEM;
>>>>> +            }
>>>>>               goto out;
>>>>> +        }
>>>>> +        nchunks++;
>>>>>             if (!last_pfn)
>>>>>               map_pfn = page_to_pfn(page_list[0]);
>>>>>   -        for (i = 0; i < ret; i++) {
>>>>> +        for (i = 0; i < pinned; i++) {
>>>>>               unsigned long this_pfn = page_to_pfn(page_list[i]);
>>>>>               u64 csize;
>>>>>                 if (last_pfn && (this_pfn != last_pfn + 1)) {
>>>>>                   /* Pin a contiguous chunk of memory */
>>>>>                   csize = (last_pfn - map_pfn + 1) << PAGE_SHIFT;
>>>>> -                if (vhost_vdpa_map(v, iova, csize,
>>>>> -                           map_pfn << PAGE_SHIFT,
>>>>> -                           msg->perm))
>>>>> +                ret = vhost_vdpa_map(v, iova, csize,
>>>>> +                             map_pfn << PAGE_SHIFT,
>>>>> +                             msg->perm);
>>>>> +                if (ret)
>>>>>                       goto out;
>>>>> +
>>>>>                   map_pfn = this_pfn;
>>>>>                   iova += csize;
>>>>> +                nchunks = 0;
>>>>>               }
>>>>>                 last_pfn = this_pfn;
>>>>>           }
>>>>>   -        cur_base += ret << PAGE_SHIFT;
>>>>> -        npages -= ret;
>>>>> +        cur_base += pinned << PAGE_SHIFT;
>>>>> +        npages -= pinned;
>>>>>       }
>>>>>         /* Pin the rest chunk */
>>>>> @@ -660,10 +676,22 @@ static int 
>>>>> vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>>>>                    map_pfn << PAGE_SHIFT, msg->perm);
>>>>>   out:
>>>>>       if (ret) {
>>>>> +        if (nchunks && last_pfn) {
>>>>> +            unsigned long pfn;
>>>>> +
>>>>> +            /*
>>>>> +             * Unpin the outstanding pages which are unmapped.
>>>>> +             * Mapped pages are accounted in vdpa_map(), thus
>>>>> +             * will be handled by vdpa_unmap().
>>>>> +             */
>>>>> +            for (pfn = map_pfn; pfn <= last_pfn; pfn++)
>>>>> +                unpin_user_page(pfn_to_page(pfn));
>>>>> +        }
>>>>>           vhost_vdpa_unmap(v, msg->iova, msg->size);
>>>>
>>>>
>>>> I want to know what's wrong with current code.
>>>>
>>>> We call vhost_vdpa_unmap() on error which calls 
>>>> vhost_vdpa_iotlb_unmap() that will unpin and reduce the pinned_vm.
>>> Think about the case where vhost_vdpa_map() fails in the middle 
>>> after making a few successful ones. In the current code, the 
>>> vhost_vdpa_iotlb_unmap() unpins what had been mapped, but does not 
>>> unpin those that have not yet been mapped. These outstanding pinned 
>>> pages will be leaked after leaving the vhost_vdpa_map() function.
>> Typo: ... leaving the vhost_vdpa_process_iotlb_update() function.
>>>
>>> Also, the subtraction accounting at the end of the function is 
>>> incorrect in that case: @npages is deduced by @pinned in each 
>>> iteration. That's why I moved the accounting to vhost_vdpa_map() to 
>>> be symmetric with vhost_vdpa_unmap().
>>>
>
> I see, then I wonder if it would have more easy to read code if we do 
> (un)pinning/accouting only in vhost_vdpa_map()/vhost_vdpa_unmap()?

Yes. That's what I've done in my new code. Though, the caller still has 
to unpin the outstanding pages that aren't accounted for in 
vhost_vdpa_map().

-Siwei


>
> Thanks
>
>
>>>
>>> -Siwei
>>>>
>>>> Thanks
>>>>
>>>>
>>>>> -        atomic64_sub(npages, &dev->mm->pinned_vm);
>>>>>       }
>>>>> +unlock:
>>>>>       mmap_read_unlock(dev->mm);
>>>>> +free:
>>>>>       free_page((unsigned long)page_list);
>>>>>       return ret;
>>>>>   }
>>>>
>>>
>>
>

