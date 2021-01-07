Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5FD2EE819
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 23:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbhAGWFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 17:05:44 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33940 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbhAGWFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 17:05:43 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 107LtEAY072323;
        Thu, 7 Jan 2021 22:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GrCH6Lvgz6ROdInHx6NZ168A/eibRwVUHX6+Q+x+Klo=;
 b=TjNWXU3TFXfgk2NKU1qHsa4QdtDyqjVbachZvz19rhi4omCzfTf6WaGpfQOGCwmcA3aN
 MbWrVDjHxtg3W/4OpNnFM12uz76lQe67hpRTOjdUxZeVN/MX7DfrwZq0LgWwHcRU/A1v
 yYz3yXSL+s10QKjpnj+64tIbme+VsyJHFVLBYHkhRW1T9OLq2dVSuXpz8BTSKlDz5Fqh
 aJRczosiUmSO3wMxLyf9Keddoq1z7bgRiW80pBA6tJbIFCz9paAb9LACo5dJUlmeLTAT
 EYMDgiG7mJgsC41UN2McRQWKfBogo+5X2dTi5XyqIAeTyfYFvmqOr1toVhw3b1izfyAZ EA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 35wepmekqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 07 Jan 2021 22:04:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 107Lt9Ni126833;
        Thu, 7 Jan 2021 22:04:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 35v1fbs63t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jan 2021 22:04:43 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 107M4cdH010716;
        Thu, 7 Jan 2021 22:04:39 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Jan 2021 22:04:38 +0000
Subject: Re: [PATCH 3/6] hugetlb: add free page reporting support
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20210106034918.GA1154@open-light-1.localdomain>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3bfdbe48-5818-7470-4c3b-96e62d387fb4@oracle.com>
Date:   Thu, 7 Jan 2021 14:04:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210106034918.GA1154@open-light-1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101070125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101070125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/21 7:49 PM, Liang Li wrote:
> hugetlb manages its page in hstate's free page list, not in buddy
> system, this patch try to make it works for hugetlbfs. It canbe
> used for memory overcommit in virtualization and hugetlb pre zero
> out.

I am not looking closely at the hugetlb changes yet.  There seem to be
higher level questions about page reporting/etc.  Once those are sorted,
I will be happy to take a closer look.  One quick question below.

> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -41,6 +41,7 @@
>  #include <linux/node.h>
>  #include <linux/userfaultfd_k.h>
>  #include <linux/page_owner.h>
> +#include "page_reporting.h"
>  #include "internal.h"
>  
>  int hugetlb_max_hstate __read_mostly;
> @@ -1028,6 +1029,9 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
>  	list_move(&page->lru, &h->hugepage_freelists[nid]);
>  	h->free_huge_pages++;
>  	h->free_huge_pages_node[nid]++;
> +	if (hugepage_reported(page))
> +		__ClearPageReported(page);
> +	hugepage_reporting_notify_free(h->order);
>  }
>  
>  static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
> @@ -5531,6 +5535,21 @@ follow_huge_pgd(struct mm_struct *mm, unsigned long address, pgd_t *pgd, int fla
>  	return pte_page(*(pte_t *)pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT);
>  }
>  
> +void isolate_free_huge_page(struct page *page, struct hstate *h, int nid)
> +{
> +	VM_BUG_ON_PAGE(!PageHead(page), page);
> +
> +	list_move(&page->lru, &h->hugepage_activelist);
> +	set_page_refcounted(page);
> +}
> +
> +void putback_isolate_huge_page(struct hstate *h, struct page *page)
> +{
> +	int nid = page_to_nid(page);
> +
> +	list_move(&page->lru, &h->hugepage_freelists[nid]);
> +}

The above routines move pages between the free and active lists without any
update to free page counts.  How does that work?  Will the number of entries
on the free list get out of sync with the free_huge_pages counters?
-- 
Mike Kravetz
