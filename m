Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EFA27B8F7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 02:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgI2AoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 20:44:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56074 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgI2AoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 20:44:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08SM50pl143487;
        Mon, 28 Sep 2020 22:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=s8jrkztwqNu8uoQVR5dNenzXRIrISb5JAN3KL/9nVic=;
 b=HdpTHx5SVjsjmHAxoxuWKF8zSGQb2I+ALxgtDc6iMqQrXXNs8a4iGSVc5fwZu3UAyHBm
 kPG1e7IRy76uiawu97h3AK7PHuy/CTxITY81AHYdVdPOlNoc3pRfft6/bB+iPZNqMfO0
 rVDMG3ZJHdW+/4uV6JTdG388xn+zKtCeItnn1fPIQa23QGDCB2SmItI9wmsgenFX6Q+5
 jlF36SQQtkP0dVrs3xSZZKNBkBkNmC1ECtR5BjiPkNljw64BNZ43FpUZOhytdIAMdx/i
 JSLcPLjoAFPgDjMds7no0WwfAOD/WaU0s+CyuQXRKsAHFDusDoRpWTjjvWs81MkUOmhN qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33sx9myjq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Sep 2020 22:06:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08SM4haq092415;
        Mon, 28 Sep 2020 22:04:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33tfdqvd6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Sep 2020 22:04:44 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08SM4fS5004892;
        Mon, 28 Sep 2020 22:04:41 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Sep 2020 15:04:40 -0700
Subject: Re: [RFC] mm/vmstat: Add events for HugeTLB migration
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1601025149-13311-1-git-send-email-anshuman.khandual@arm.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <78e77883-9ba9-159c-200a-e8303bbfc206@oracle.com>
Date:   Mon, 28 Sep 2020 15:04:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1601025149-13311-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9758 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009280167
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9758 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009280167
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/20 2:12 AM, Anshuman Khandual wrote:
> Add following new vmstat events which will track HugeTLB page migration.
> 
> 1. HUGETLB_MIGRATION_SUCCESS
> 2. HUGETLB_MIGRATION_FAILURE
> 
> It follows the existing semantics to accommodate HugeTLB subpages in total
> page migration statistics. While here, this updates current trace event
> "mm_migrate_pages" to accommodate now available HugeTLB based statistics.

Thanks.  This makes sense with recent THP changes.

> diff --git a/mm/migrate.c b/mm/migrate.c
> index 3ab965f83029..d53dd101ffff 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1415,13 +1415,17 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  {
>  	int retry = 1;
>  	int thp_retry = 1;
> +	int hugetlb_retry = 1;
>  	int nr_failed = 0;
>  	int nr_succeeded = 0;
>  	int nr_thp_succeeded = 0;
>  	int nr_thp_failed = 0;
>  	int nr_thp_split = 0;
> +	int nr_hugetlb_succeeded = 0;
> +	int nr_hugetlb_failed = 0;
>  	int pass = 0;
>  	bool is_thp = false;
> +	bool is_hugetlb = false;
>  	struct page *page;
>  	struct page *page2;
>  	int swapwrite = current->flags & PF_SWAPWRITE;
> @@ -1433,6 +1437,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
>  		retry = 0;
>  		thp_retry = 0;
> +		hugetlb_retry = 0;
>  
>  		list_for_each_entry_safe(page, page2, from, lru) {
>  retry:
> @@ -1442,7 +1447,12 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  			 * during migration.
>  			 */
>  			is_thp = PageTransHuge(page) && !PageHuge(page);
> +			is_hugetlb = PageTransHuge(page) && PageHuge(page);

PageHuge does not depend on PageTransHuge.  So, this could just be
			is_hugetlb = PageHuge(page);

Actually, the current version of PageHuge is more expensive than PageTransHuge.
So, the most optimal way to set these would be something like.
			if (PageTransHuge(page))
				if (PageHuge(page))
					is_hugetlb = true;
				else
					is_thp = true;

Although, the compiler may be able to optimize.  I did not check.

> +
>  			nr_subpages = thp_nr_pages(page);
> +			if (is_hugetlb)
> +				nr_subpages = pages_per_huge_page(page_hstate(page));

Can we just use compound_order() here for all cases?

-- 
Mike Kravetz
