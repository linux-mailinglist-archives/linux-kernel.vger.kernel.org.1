Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76502B9E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgKSX1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:27:02 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44864 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgKSX1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:27:01 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJNKk9c041578;
        Thu, 19 Nov 2020 23:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : mime-version : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=cRZ4sWIQ4ARfaY4GL/Fi7waJEAavuIeLP3xVj8Jeq/U=;
 b=mGJCAiog9q3yVuAL1SKbToknStZJ9y72yRFFLxeswT3fAbCTSt9QlMRRGeph+RznNQ5H
 zt9KA9x8FrF2X9/qdG188byMFva3Zxbr97/yfXQGm1PDtOdFeVPYNhNMtw7V0/e19UKw
 pCxS6S5k/bHmUAFVL0rPU6Nv3JiCcqhjgkN5bd3cBQARj+I2BwAlTzVdRUYPhRii17kc
 tHbp3tcK1BiaLxyRygQIcFwmhcpHnbEl+lGK59Gk9kaiFINTFlDsrTlQlA4bAuN9+dIc
 9gVSv2JBiJ/FIN9tgbP5oHROyPpwkgkC4tDpXHU6uhS1t0SbLYRR6k+i3EdxEBhOmjrD ZA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34t76m88qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 23:26:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJNJaoc156300;
        Thu, 19 Nov 2020 23:26:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 34ts0uf37a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 23:26:54 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AJNQqnf031042;
        Thu, 19 Nov 2020 23:26:53 GMT
Received: from [10.159.241.144] (/10.159.241.144)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Nov 2020 15:26:52 -0800
Message-ID: <5FB6FF3A.6060005@oracle.com>
Date:   Thu, 19 Nov 2020 15:26:50 -0800
From:   si-wei liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     mst@redhat.com
CC:     Jason Wang <jasowang@redhat.com>, lingshan.zhu@intel.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v3] vhost-vdpa: fix page pinning leakage in error path
 (rework)
References: <1604618793-4681-1-git-send-email-si-wei.liu@oracle.com> <9e4b0cda-8118-0ed0-7a27-5d284c49f936@redhat.com>
In-Reply-To: <9e4b0cda-8118-0ed0-7a27-5d284c49f936@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=3 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011190160
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A gentle reminder. Any chance this patch will get picked soon?

Thanks,
-Siwei

On 11/9/2020 7:28 PM, Jason Wang wrote:
>
> On 2020/11/6 上午7:26, Si-Wei Liu wrote:
>> Pinned pages are not properly accounted particularly when
>> mapping error occurs on IOTLB update. Clean up dangling
>> pinned pages for the error path.
>>
>> The memory usage for bookkeeping pinned pages is reverted
>> to what it was before: only one single free page is needed.
>> This helps reduce the host memory demand for VM with a large
>> amount of memory, or in the situation where host is running
>> short of free memory.
>>
>> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>> Changes in v3:
>> - Turn explicit last_pfn check to a WARN_ON() (Jason)
>>
>> Changes in v2:
>> - Drop the reversion patch
>> - Fix unhandled page leak towards the end of page_list
>
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>
>
>>
>>   drivers/vhost/vdpa.c | 80 
>> ++++++++++++++++++++++++++++++++++++++++------------
>>   1 file changed, 62 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index b6d9016..5b13dfd 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -560,6 +560,8 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
>>         if (r)
>>           vhost_iotlb_del_range(dev->iotlb, iova, iova + size - 1);
>> +    else
>> +        atomic64_add(size >> PAGE_SHIFT, &dev->mm->pinned_vm);
>>         return r;
>>   }
>> @@ -591,14 +593,16 @@ static int 
>> vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>       unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
>>       unsigned int gup_flags = FOLL_LONGTERM;
>>       unsigned long npages, cur_base, map_pfn, last_pfn = 0;
>> -    unsigned long locked, lock_limit, pinned, i;
>> +    unsigned long lock_limit, sz2pin, nchunks, i;
>>       u64 iova = msg->iova;
>> +    long pinned;
>>       int ret = 0;
>>         if (vhost_iotlb_itree_first(iotlb, msg->iova,
>>                       msg->iova + msg->size - 1))
>>           return -EEXIST;
>>   +    /* Limit the use of memory for bookkeeping */
>>       page_list = (struct page **) __get_free_page(GFP_KERNEL);
>>       if (!page_list)
>>           return -ENOMEM;
>> @@ -607,52 +611,75 @@ static int 
>> vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>           gup_flags |= FOLL_WRITE;
>>         npages = PAGE_ALIGN(msg->size + (iova & ~PAGE_MASK)) >> 
>> PAGE_SHIFT;
>> -    if (!npages)
>> -        return -EINVAL;
>> +    if (!npages) {
>> +        ret = -EINVAL;
>> +        goto free;
>> +    }
>>         mmap_read_lock(dev->mm);
>>   -    locked = atomic64_add_return(npages, &dev->mm->pinned_vm);
>>       lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>> -
>> -    if (locked > lock_limit) {
>> +    if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
>>           ret = -ENOMEM;
>> -        goto out;
>> +        goto unlock;
>>       }
>>         cur_base = msg->uaddr & PAGE_MASK;
>>       iova &= PAGE_MASK;
>> +    nchunks = 0;
>>         while (npages) {
>> -        pinned = min_t(unsigned long, npages, list_size);
>> -        ret = pin_user_pages(cur_base, pinned,
>> -                     gup_flags, page_list, NULL);
>> -        if (ret != pinned)
>> +        sz2pin = min_t(unsigned long, npages, list_size);
>> +        pinned = pin_user_pages(cur_base, sz2pin,
>> +                    gup_flags, page_list, NULL);
>> +        if (sz2pin != pinned) {
>> +            if (pinned < 0) {
>> +                ret = pinned;
>> +            } else {
>> +                unpin_user_pages(page_list, pinned);
>> +                ret = -ENOMEM;
>> +            }
>>               goto out;
>> +        }
>> +        nchunks++;
>>             if (!last_pfn)
>>               map_pfn = page_to_pfn(page_list[0]);
>>   -        for (i = 0; i < ret; i++) {
>> +        for (i = 0; i < pinned; i++) {
>>               unsigned long this_pfn = page_to_pfn(page_list[i]);
>>               u64 csize;
>>                 if (last_pfn && (this_pfn != last_pfn + 1)) {
>>                   /* Pin a contiguous chunk of memory */
>>                   csize = (last_pfn - map_pfn + 1) << PAGE_SHIFT;
>> -                if (vhost_vdpa_map(v, iova, csize,
>> -                           map_pfn << PAGE_SHIFT,
>> -                           msg->perm))
>> +                ret = vhost_vdpa_map(v, iova, csize,
>> +                             map_pfn << PAGE_SHIFT,
>> +                             msg->perm);
>> +                if (ret) {
>> +                    /*
>> +                     * Unpin the pages that are left unmapped
>> +                     * from this point on in the current
>> +                     * page_list. The remaining outstanding
>> +                     * ones which may stride across several
>> +                     * chunks will be covered in the common
>> +                     * error path subsequently.
>> +                     */
>> +                    unpin_user_pages(&page_list[i],
>> +                             pinned - i);
>>                       goto out;
>> +                }
>> +
>>                   map_pfn = this_pfn;
>>                   iova += csize;
>> +                nchunks = 0;
>>               }
>>                 last_pfn = this_pfn;
>>           }
>>   -        cur_base += ret << PAGE_SHIFT;
>> -        npages -= ret;
>> +        cur_base += pinned << PAGE_SHIFT;
>> +        npages -= pinned;
>>       }
>>         /* Pin the rest chunk */
>> @@ -660,10 +687,27 @@ static int 
>> vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>                    map_pfn << PAGE_SHIFT, msg->perm);
>>   out:
>>       if (ret) {
>> +        if (nchunks) {
>> +            unsigned long pfn;
>> +
>> +            /*
>> +             * Unpin the outstanding pages which are yet to be
>> +             * mapped but haven't due to vdpa_map() or
>> +             * pin_user_pages() failure.
>> +             *
>> +             * Mapped pages are accounted in vdpa_map(), hence
>> +             * the corresponding unpinning will be handled by
>> +             * vdpa_unmap().
>> +             */
>> +            WARN_ON(!last_pfn);
>> +            for (pfn = map_pfn; pfn <= last_pfn; pfn++)
>> +                unpin_user_page(pfn_to_page(pfn));
>> +        }
>>           vhost_vdpa_unmap(v, msg->iova, msg->size);
>> -        atomic64_sub(npages, &dev->mm->pinned_vm);
>>       }
>> +unlock:
>>       mmap_read_unlock(dev->mm);
>> +free:
>>       free_page((unsigned long)page_list);
>>       return ret;
>>   }
>

