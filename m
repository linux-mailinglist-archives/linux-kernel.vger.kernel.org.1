Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87ECC278458
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgIYJtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:49:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:33926 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbgIYJtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:49:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BBFB1B1AE;
        Fri, 25 Sep 2020 09:49:19 +0000 (UTC)
Date:   Fri, 25 Sep 2020 11:49:16 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm/vmstat: Add events for HugeTLB migration
Message-ID: <20200925094912.GA31664@linux>
References: <1601025149-13311-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601025149-13311-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 02:42:29PM +0530, Anshuman Khandual wrote:
> Add following new vmstat events which will track HugeTLB page migration.
> 
> 1. HUGETLB_MIGRATION_SUCCESS
> 2. HUGETLB_MIGRATION_FAILURE
> 
> It follows the existing semantics to accommodate HugeTLB subpages in total
> page migration statistics. While here, this updates current trace event
> "mm_migrate_pages" to accommodate now available HugeTLB based statistics.
> 
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Was this inspired by some usecase/debugging or just to follow THP's example?

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

Should you not have put hugetlb_retry within the loop as well?
Otherwise we might not rety for hugetlb pages now?

-- 
Oscar Salvador
SUSE L3
