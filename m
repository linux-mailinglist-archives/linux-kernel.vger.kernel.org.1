Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEE627A5C8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 05:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgI1DdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 23:33:08 -0400
Received: from foss.arm.com ([217.140.110.172]:43856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgI1DdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 23:33:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 994FB101E;
        Sun, 27 Sep 2020 20:33:07 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB8DA3F6CF;
        Sun, 27 Sep 2020 20:33:04 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [RFC] mm/vmstat: Add events for HugeTLB migration
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1601025149-13311-1-git-send-email-anshuman.khandual@arm.com>
 <20200925094912.GA31664@linux>
Message-ID: <c1ea761e-087d-645b-6c1a-ff2a930ab400@arm.com>
Date:   Mon, 28 Sep 2020 09:02:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200925094912.GA31664@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/25/2020 03:19 PM, Oscar Salvador wrote:
> On Fri, Sep 25, 2020 at 02:42:29PM +0530, Anshuman Khandual wrote:
>> Add following new vmstat events which will track HugeTLB page migration.
>>
>> 1. HUGETLB_MIGRATION_SUCCESS
>> 2. HUGETLB_MIGRATION_FAILURE
>>
>> It follows the existing semantics to accommodate HugeTLB subpages in total
>> page migration statistics. While here, this updates current trace event
>> "mm_migrate_pages" to accommodate now available HugeTLB based statistics.
>>
>> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: John Hubbard <jhubbard@nvidia.com>
>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Was this inspired by some usecase/debugging or just to follow THP's example?

Currently HugeTLB migration events get accommodated in PGMIGRATE_SUCCESS and
PGMIGRATE_FAIL event stats as normal single page instances. Previously this
might have just seemed okay as HugeTLB page could be viewed as a single page
entity, even though it was not fully accurate as PGMIGRATE_[SUCCESS|FAILURE]
tracked statistics in terms of normal base pages.

But tracking HugeTLB pages as single pages does not make sense any more, now
that THP pages are accounted for properly. This would complete the revamped
page migration accounting where PGMIGRATE_[SUCCESS|FAILURE] will track entire
page migration events in terms of normal base pages and THP_*/HUGETLB_* will
track specialized events when applicable.

> 
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
> 
> Should you not have put hugetlb_retry within the loop as well?
> Otherwise we might not rety for hugetlb pages now?
> 

Right, will fix it.
