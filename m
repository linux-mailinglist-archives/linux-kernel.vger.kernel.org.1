Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F06294705
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 05:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411782AbgJUDhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 23:37:20 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35272 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411775AbgJUDhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 23:37:19 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09L3TYE6123389;
        Wed, 21 Oct 2020 03:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=qppGELAd/QVZQdRXML5jn5r4+rkgBkW65YyLU9TSwGs=;
 b=XE6ui6XzjXQMGn8nQTp+PLiwSZG7YviHRb6DNM9Bov2ZwbYoKFrJyShaU4S5f0Kk/fEe
 BaqL8p0U7UJsHZ7oxM6EgqhykQMPWg8j93S8MHoy+lJwCluFo5iW6c9yXZJpYBsTyld1
 FZSJWOyfgoEXYXIwKnT9UraBKpIEe2Fq2xOl6frVv8l+xp2+XE4MLnLlGTCGZPrY4CaT
 chyUjE7UkcwoxoEP1PfePu7yZbT+V4fSWGnLgM0PZH0wF8cVPplDja8axJlaPQwHa7bg
 CE/W2qJWwPmTNHYpggkJ+RgfLrOuKOIhdsFalLl56WuXTR3qRxjB1D99NuPhdwSNzbbS 7A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 347p4axd5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Oct 2020 03:37:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09L3TuNn056326;
        Wed, 21 Oct 2020 03:35:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 348acrjbbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Oct 2020 03:35:06 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09L3Z5QM009755;
        Wed, 21 Oct 2020 03:35:05 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Oct 2020 20:35:04 -0700
Subject: Re: cgroup and FALLOC_FL_PUNCH_HOLE: WARNING: CPU: 13 PID: 2438 at
 mm/page_counter.c:57 page_counter_uncharge+0x4b/0x5
To:     David Hildenbrand <david@redhat.com>,
        Mina Almasry <almasrymina@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Privoznik <mprivozn@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>
References: <c1ea7548-622c-eda7-66f4-e4ae5b6ee8fc@redhat.com>
 <563d1eef-b780-835a-ebf0-88ae111b20c2@redhat.com>
 <CAHS8izPEHZunoeXYS5ONfRoSRMpC7DQwtpjJ8g4nXiddTfNoaA@mail.gmail.com>
 <65a1946f-dbf9-5767-5b51-9c1b786051d1@redhat.com>
 <5f196069-8b98-0ad3-55e8-19af03d715cd@oracle.com>
 <c78634ee-0d6f-c98c-3c2a-8cb500c0ae47@oracle.com>
 <b24380ad-b87c-a3a1-d25e-ee30c10ed0d2@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <312246f4-4e5f-1425-1bc2-1b356db0fbad@oracle.com>
Date:   Tue, 20 Oct 2020 20:35:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <b24380ad-b87c-a3a1-d25e-ee30c10ed0d2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9780 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010210028
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9780 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010210028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/20 6:38 AM, David Hildenbrand wrote:
> 
> I'm bisecting the warning right now. Looks like it was introduced in v5.7.

I found the following bugs in the cgroup reservation accounting.  The ones
in region_del are pretty obvious as the number of pages to uncharge would
always be zero.  The one on alloc_huge_page needs racing code to expose.

With these fixes, my testing is showing consistent/correct results for
hugetlb reservation cgroup accounting.

It would be good if Mina (at least) would look these over.  Would also
be interesting to know if these fixes address the bug seen with the qemu
use case.

I'm still doing more testing and code inspection to look for other issues.

From 861bcd7d0443f18a5fed3c3ddc5f1c71e78c4ef4 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Tue, 20 Oct 2020 20:21:42 -0700
Subject: [PATCH] hugetlb_cgroup: fix reservation accounting

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 67fc6383995b..c92366313780 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -685,17 +685,17 @@ static long region_del(struct resv_map *resv, long f, long t)
 		}
 
 		if (f <= rg->from) {	/* Trim beginning of region */
-			del += t - rg->from;
-			rg->from = t;
-
 			hugetlb_cgroup_uncharge_file_region(resv, rg,
 							    t - rg->from);
-		} else {		/* Trim end of region */
-			del += rg->to - f;
-			rg->to = f;
 
+			del += t - rg->from;
+			rg->from = t;
+		} else {		/* Trim end of region */
 			hugetlb_cgroup_uncharge_file_region(resv, rg,
 							    rg->to - f);
+
+			del += rg->to - f;
+			rg->to = f;
 		}
 	}
 
@@ -2454,6 +2454,9 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 
 		rsv_adjust = hugepage_subpool_put_pages(spool, 1);
 		hugetlb_acct_memory(h, -rsv_adjust);
+		if (deferred_reserve)
+			hugetlb_cgroup_uncharge_page_rsvd(hstate_index(h),
+					pages_per_huge_page(h), page);
 	}
 	return page;
 
-- 
2.25.4

