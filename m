Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424BC26F4AC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 05:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgIRDYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 23:24:37 -0400
Received: from foss.arm.com ([217.140.110.172]:59610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgIRDYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 23:24:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6822830E;
        Thu, 17 Sep 2020 20:24:36 -0700 (PDT)
Received: from [10.163.74.228] (unknown [10.163.74.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 888843F73B;
        Thu, 17 Sep 2020 20:24:34 -0700 (PDT)
Subject: Re: [PATCH v2] mm/migrate: correct thp migration stats.
To:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20200917210413.1462975-1-zi.yan@sent.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <50eb6f68-40be-89ee-3431-e382cf94f7c5@arm.com>
Date:   Fri, 18 Sep 2020 08:53:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200917210413.1462975-1-zi.yan@sent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zi,

On 09/18/2020 02:34 AM, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> PageTransHuge returns true for both thp and hugetlb, so thp stats was
> counting both thp and hugetlb migrations. Exclude hugetlb migration by
> setting is_thp variable right.

Coincidentally, I had just detected this problem last evening and was
in the process of sending a patch this morning :) Nonetheless, thanks
for the patch.

Earlier there was a similar THP-HugeTLB ambiguity down the error path
as well. In hindsight, I should have noticed or remembered about this
earlier fix during the THP stats patch.

e6112fc30070 (mm/migrate.c: split only transparent huge pages when allocation fails)

> 
> Clean up thp handling code too when we are there.
> 
> Fixes: 1a5bae25e3cf ("mm/vmstat: add events for THP migration without split")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  mm/migrate.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 941b89383cf3..6bc9559afc70 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1445,7 +1445,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  			 * Capture required information that might get lost
>  			 * during migration.
>  			 */
> -			is_thp = PageTransHuge(page);
> +			is_thp = PageTransHuge(page) && !PageHuge(page);
>  			nr_subpages = thp_nr_pages(page);
>  			cond_resched();
>  
> @@ -1471,7 +1471,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  				 * we encounter them after the rest of the list
>  				 * is processed.
>  				 */
> -				if (PageTransHuge(page) && !PageHuge(page)) {
> +				if (is_thp) {
>  					lock_page(page);
>  					rc = split_huge_page_to_list(page, from);
>  					unlock_page(page);
> @@ -1480,8 +1480,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  						nr_thp_split++;
>  						goto retry;
>  					}
> -				}
> -				if (is_thp) {
> +
>  					nr_thp_failed++;
>  					nr_failed += nr_subpages;
>  					goto out;
> 

Moving the failure path inside the split path makes sense, now
that it is already established that the page is indeed a THP.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
