Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB642A71EE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbgKDXmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:42:49 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38494 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732517AbgKDXlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:41:06 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A4NdTRH027609;
        Wed, 4 Nov 2020 23:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : mime-version : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=TmvYSJAEXaLiuZqwCoKufrk44V28jWvQyY1Rql+I8fE=;
 b=ZhC9ginK2YTXj5nolrEEswjRXpbG1XEb5wCrqsk5kgqjbzF9Ks/DaKFKPyBkC7b4PYLt
 JQ5HY2cG8Ni4FG8p0ommD5cOsUKnSm2cTNpJZXwcrRx9HO1gJTsdavyAthUD2knIotIJ
 BCwR/W2T4IZb5ln+FfSon13HodHKeGmv/romcJPkHCDcDTEawCNaNSNIEvGYJw3yKq+e
 Zwp+KO2/IQkhl787m+DQ/tY5L9aUfsht9jrtLCSbFE24Jp5ec0G1aPK9eBKwgEjkbhZN
 Y2qtMxvTAxqrFDOCk/6estO7z0fkcsBiPJ9/eDYRFCjV6M2k+YBeOz4DvcFeqQw4hmBF Yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34hhvchf0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 04 Nov 2020 23:40:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A4NdwS6095672;
        Wed, 4 Nov 2020 23:40:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 34hvryn7nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Nov 2020 23:40:59 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A4NevN5029823;
        Wed, 4 Nov 2020 23:40:57 GMT
Received: from [10.159.134.39] (/10.159.134.39)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Nov 2020 15:40:56 -0800
Message-ID: <5FA33C06.6010000@oracle.com>
Date:   Wed, 04 Nov 2020 15:40:54 -0800
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
References: <1604043944-4897-1-git-send-email-si-wei.liu@oracle.com> <1604043944-4897-2-git-send-email-si-wei.liu@oracle.com> <77a2aefe-ccad-bd51-3721-1139d4e535d7@redhat.com>
In-Reply-To: <77a2aefe-ccad-bd51-3721-1139d4e535d7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=2 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011040169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040169
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/3/2020 6:42 PM, Jason Wang wrote:
>
> On 2020/10/30 下午3:45, Si-Wei Liu wrote:
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
>>   drivers/vhost/vdpa.c | 64 
>> +++++++++++++++++++++++++++++++++++++---------------
>>   1 file changed, 46 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index b6d9016..8da8558 100644
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
>> @@ -607,52 +611,64 @@ static int 
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
>> +                if (ret)
>>                       goto out;
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
>> @@ -660,10 +676,22 @@ static int 
>> vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>                    map_pfn << PAGE_SHIFT, msg->perm);
>>   out:
>>       if (ret) {
>> +        if (nchunks && last_pfn) {
>
>
> Can we decrease npages where you did "nchunks++" then we can check 
> npages here instead?
Hmmm, I am not sure I get what you want... @nchunks gets reset to 0 
whenever a certain range of pinned pages is successfully mapped. The 
conditional (when nchunks is non-zero) here indicates if there's any 
_outstanding_ pinned page that has to clean up in the error handling 
path. While the decrement of @npages may not occur when resetting the 
@nchunks counter, rendering incorrect cleanup in the error path.

BTW while reviewing it I got noticed of an error in my code. There might 
be still page pinning leak from wherever the vhost_vdpa_map() error 
occurs towards the end of page_list. I will post a v2 to fix this.

Regards,
-Siwei

--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -656,8 +656,19 @@ static int vhost_vdpa_process_iotlb_update(struct 
vhost_vdpa *v,
                                 ret = vhost_vdpa_map(v, iova, csize,
                                                      map_pfn << PAGE_SHIFT,
                                                      msg->perm);
-                               if (ret)
+                               if (ret) {
+                                       /*
+                                        * Unpin the pages that are left 
unmapped
+                                        * from this point on in the current
+                                        * page_list. The remaining 
outstanding
+                                        * ones which may stride across 
several
+                                        * chunks will be covered in the 
common
+                                        * error path subsequently.
+                                        */
+ unpin_user_pages(&page_list[i],
+                                                        pinned - i);
                                         goto out;
+                               }

                                 map_pfn = this_pfn;
                                 iova += csize;



>
> Thanks
>
>
>> +            unsigned long pfn;
>> +
>> +            /*
>> +             * Unpin the outstanding pages which are unmapped.
>> +             * Mapped pages are accounted in vdpa_map(), thus
>> +             * will be handled by vdpa_unmap().
>> +             */
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

