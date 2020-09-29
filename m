Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BEB27BCB9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 08:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgI2GDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 02:03:20 -0400
Received: from foss.arm.com ([217.140.110.172]:35436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgI2GDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:03:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 228D331B;
        Mon, 28 Sep 2020 23:03:19 -0700 (PDT)
Received: from [10.163.73.175] (unknown [10.163.73.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29F053F6CF;
        Mon, 28 Sep 2020 23:03:16 -0700 (PDT)
Subject: Re: [RFC] mm/vmstat: Add events for HugeTLB migration
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1601025149-13311-1-git-send-email-anshuman.khandual@arm.com>
 <78e77883-9ba9-159c-200a-e8303bbfc206@oracle.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <4b6a2b8b-5370-ac5d-dd41-38b800dd0e3a@arm.com>
Date:   Tue, 29 Sep 2020 11:32:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <78e77883-9ba9-159c-200a-e8303bbfc206@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/29/2020 03:34 AM, Mike Kravetz wrote:
> On 9/25/20 2:12 AM, Anshuman Khandual wrote:
>> Add following new vmstat events which will track HugeTLB page migration.
>>
>> 1. HUGETLB_MIGRATION_SUCCESS
>> 2. HUGETLB_MIGRATION_FAILURE
>>
>> It follows the existing semantics to accommodate HugeTLB subpages in total
>> page migration statistics. While here, this updates current trace event
>> "mm_migrate_pages" to accommodate now available HugeTLB based statistics.
> 
> Thanks.  This makes sense with recent THP changes.
> 
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 3ab965f83029..d53dd101ffff 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1415,13 +1415,17 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  {
>>  	int retry = 1;
>>  	int thp_retry = 1;
>> +	int hugetlb_retry = 1;
>>  	int nr_failed = 0;
>>  	int nr_succeeded = 0;
>>  	int nr_thp_succeeded = 0;
>>  	int nr_thp_failed = 0;
>>  	int nr_thp_split = 0;
>> +	int nr_hugetlb_succeeded = 0;
>> +	int nr_hugetlb_failed = 0;
>>  	int pass = 0;
>>  	bool is_thp = false;
>> +	bool is_hugetlb = false;
>>  	struct page *page;
>>  	struct page *page2;
>>  	int swapwrite = current->flags & PF_SWAPWRITE;
>> @@ -1433,6 +1437,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
>>  		retry = 0;
>>  		thp_retry = 0;
>> +		hugetlb_retry = 0;
>>  
>>  		list_for_each_entry_safe(page, page2, from, lru) {
>>  retry:
>> @@ -1442,7 +1447,12 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  			 * during migration.
>>  			 */
>>  			is_thp = PageTransHuge(page) && !PageHuge(page);
>> +			is_hugetlb = PageTransHuge(page) && PageHuge(page);
> 
> PageHuge does not depend on PageTransHuge.  So, this could just be
> 			is_hugetlb = PageHuge(page);

Sure.

> 
> Actually, the current version of PageHuge is more expensive than PageTransHuge.
> So, the most optimal way to set these would be something like.
> 			if (PageTransHuge(page))
> 				if (PageHuge(page))
> 					is_hugetlb = true;
> 				else
> 					is_thp = true;
> 
> Although, the compiler may be able to optimize.  I did not check.

Both is_hugetlb and is_thp need to have either a true or false value
during each iteration as they are not getting reset otherwise. Hence
basically it should either be

is_thp = PageTransHuge(page) && !PageHuge(page);
is_hugetlb = PageHuge(page);

OR

is_hugetlb = false;
is_thp = false;
if (PageTransHuge(page))
	if (PageHuge(page))
		is_hugetlb = true;
	else
		is_thp = true;
}

> 
>> +
>>  			nr_subpages = thp_nr_pages(page);
>> +			if (is_hugetlb)
>> +				nr_subpages = pages_per_huge_page(page_hstate(page));
> 
> Can we just use compound_order() here for all cases?

Sure but we could also directly use compound_nr().
