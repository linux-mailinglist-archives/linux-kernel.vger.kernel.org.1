Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C262E208F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 19:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgLWSsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 13:48:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40708 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgLWSsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 13:48:14 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BNIYgZb037946;
        Wed, 23 Dec 2020 18:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=iYoROx86NTx2ksasFQxH2ty1+3XivpjHZbb5niWScn0=;
 b=HVfIarz+h2iaJlr3p3mTqrAcrnrjOdN2Y7MgRHrSKSN5SplEY/BV+BbbpdXTCZADgqp+
 7DY7TG2ffIenChS7FRycQFmww0K6ksqLgXdt2JIWB+aHtS3FSdB04D0ax55I7O+olio/
 iohyEJMLXZcBCxKv4r5O8828DS3EJSQ8eyGS1TpN+uBbeEZdSLd9J7qpelZ0D7PXNiQu
 UgK8dHaZ9ApbH3htAcoFvkPt/p5Guq3Bhl0XwTfSXzEmqbqfbJTOR3NXZbayqpDGIV54
 FDJGz/ntXaxLdxmUsYYI1ti0JRzCL4CYNWsHrudQIfnLCAAXH/8Wicee79vVJLSpP7Fq Xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 35ku8du9ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Dec 2020 18:47:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BNIYdQI179168;
        Wed, 23 Dec 2020 18:47:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 35k0ev00un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Dec 2020 18:47:10 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BNIl5fh004571;
        Wed, 23 Dec 2020 18:47:05 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Dec 2020 10:47:05 -0800
Subject: Re: [RFC PATCH 1/3] mm: support hugetlb free page reporting
To:     Liang Li <liliang324@gmail.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
References: <20201222074656.GA30035@open-light-1.localdomain>
 <63318bf1-21ea-7202-e060-b4b2517c684e@oracle.com>
 <CA+2MQi_QDnnsbMdOH5B4Hhak-CWA-Xs6PLhxoGq2f+Vv13sgyg@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e9d835e1-5d7f-d0ca-bf42-1cfa64416db6@oracle.com>
Date:   Wed, 23 Dec 2020 10:47:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CA+2MQi_QDnnsbMdOH5B4Hhak-CWA-Xs6PLhxoGq2f+Vv13sgyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9844 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012230134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9844 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012230134
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/20 7:57 PM, Liang Li wrote:
>> On 12/21/20 11:46 PM, Liang Li wrote:
>>> +static int
>>> +hugepage_reporting_cycle(struct page_reporting_dev_info *prdev,
>>> +                      struct hstate *h, unsigned int nid,
>>> +                      struct scatterlist *sgl, unsigned int *offset)
>>> +{
>>> +     struct list_head *list = &h->hugepage_freelists[nid];
>>> +     unsigned int page_len = PAGE_SIZE << h->order;
>>> +     struct page *page, *next;
>>> +     long budget;
>>> +     int ret = 0, scan_cnt = 0;
>>> +
>>> +     /*
>>> +      * Perform early check, if free area is empty there is
>>> +      * nothing to process so we can skip this free_list.
>>> +      */
>>> +     if (list_empty(list))
>>> +             return ret;
>>
>> Do note that not all entries on the hugetlb free lists are free.  Reserved
>> entries are also on the free list.  The actual number of free entries is
>> 'h->free_huge_pages - h->resv_huge_pages'.
>> Is the intention to process reserved pages as well as free pages?
> 
> Yes, Reserved pages was treated as 'free pages'

If that is true, then this code breaks hugetlb.  hugetlb code assumes that
h->free_huge_pages is ALWAYS >= h->resv_huge_pages.  This code would break
that assumption.  If you really want to add support for hugetlb pages, then
you will need to take reserved pages into account.

P.S. There might be some confusion about 'reservations' based on the
commit message.  My comments are directed at hugetlb reservations described
in Documentation/vm/hugetlbfs_reserv.rst.

>>> +
>>> +     spin_lock_irq(&hugetlb_lock);
>>> +
>>> +     if (huge_page_order(h) > MAX_ORDER)
>>> +             budget = HUGEPAGE_REPORTING_CAPACITY;
>>> +     else
>>> +             budget = HUGEPAGE_REPORTING_CAPACITY * 32;
>>> +
>>> +     /* loop through free list adding unreported pages to sg list */
>>> +     list_for_each_entry_safe(page, next, list, lru) {
>>> +             /* We are going to skip over the reported pages. */
>>> +             if (PageReported(page)) {
>>> +                     if (++scan_cnt >= MAX_SCAN_NUM) {
>>> +                             ret = scan_cnt;
>>> +                             break;
>>> +                     }
>>> +                     continue;
>>> +             }
>>> +
>>> +             /*
>>> +              * If we fully consumed our budget then update our
>>> +              * state to indicate that we are requesting additional
>>> +              * processing and exit this list.
>>> +              */
>>> +             if (budget < 0) {
>>> +                     atomic_set(&prdev->state, PAGE_REPORTING_REQUESTED);
>>> +                     next = page;
>>> +                     break;
>>> +             }
>>> +
>>> +             /* Attempt to pull page from list and place in scatterlist */
>>> +             if (*offset) {
>>> +                     isolate_free_huge_page(page, h, nid);
>>
>> Once a hugetlb page is isolated, it can not be used and applications that
>> depend on hugetlb pages can start to fail.
>> I assume that is acceptable/expected behavior.  Correct?
>> On some systems, hugetlb pages are a precious resource and the sysadmin
>> carefully configures the number needed by applications.  Removing a hugetlb
>> page (even for a very short period of time) could cause serious application
>> failure.
> 
> That' true, especially for 1G pages. Any suggestions?
> Let the hugepage allocator be aware of this situation and retry ?

I would hate to add that complexity to the allocator.

This question is likely based on my lack of understanding of virtio-balloon
usage and this reporting mechanism.  But, why do the hugetlb pages have to
be 'temporarily' allocated for reporting purposes?

-- 
Mike Kravetz
