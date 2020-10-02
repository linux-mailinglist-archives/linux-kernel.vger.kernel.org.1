Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772F02811F6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 14:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbgJBME0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 08:04:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:47056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgJBME0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 08:04:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601640263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JvzVPZEkSvXvXBMnzB4eoNToeoyAB0M+HsSF4s1YySU=;
        b=Kpgt3g/2f1yfXxFS6RbXDM4sCBbVM+cExvNOoNeeF4vjEky4KEtCVP4ESg9IwBTLRuk2Qg
        2LxGGEWPsCpAP36wEEXHSrpb6QEeIhGhosEoN/4sa7SGMR7m2PAr6LZ98CNbD6cZdNF9GB
        LvLqxwLhdyvpSW5FSQVBuRu/2x7gCOo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F61CAD82;
        Fri,  2 Oct 2020 12:04:23 +0000 (UTC)
Date:   Fri, 2 Oct 2020 14:04:22 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC V2] mm/vmstat: Add events for HugeTLB migration
Message-ID: <20201002120422.GE4555@dhcp22.suse.cz>
References: <1601445649-22163-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601445649-22163-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30-09-20 11:30:49, Anshuman Khandual wrote:
> Add following new vmstat events which will track HugeTLB page migration.
> 
> 1. HUGETLB_MIGRATION_SUCCESS
> 2. HUGETLB_MIGRATION_FAILURE
> 
> It follows the existing semantics to accommodate HugeTLB subpages in total
> page migration statistics. While here, this updates current trace event
> 'mm_migrate_pages' to accommodate now available HugeTLB based statistics.

What is the actual usecase? And how do you deal with the complexity
introduced by many different hugetlb page sizes. Really, what is the
point to having such a detailed view on hugetlb migration?

> 
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Applies on linux-next and v5.9-rc7.
> 
> Changes in RFC V2:
> 
> - Added the missing hugetlb_retry in the loop per Oscar
> - Changed HugeTLB and THP detection sequence per Mike
> - Changed nr_subpages fetch from compound_nr() instead per Mike
> 
> Changes in RFC V1: (https://patchwork.kernel.org/patch/11799395/)
> 
>  include/linux/vm_event_item.h  |  2 ++
>  include/trace/events/migrate.h | 13 ++++++---
>  mm/migrate.c                   | 48 +++++++++++++++++++++++++++++-----
>  mm/vmstat.c                    |  2 ++
>  4 files changed, 56 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index 18e75974d4e3..d1ddad835c19 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -60,6 +60,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  		THP_MIGRATION_SUCCESS,
>  		THP_MIGRATION_FAIL,
>  		THP_MIGRATION_SPLIT,
> +		HUGETLB_MIGRATION_SUCCESS,
> +		HUGETLB_MIGRATION_FAIL,
>  #endif
>  #ifdef CONFIG_COMPACTION
>  		COMPACTMIGRATE_SCANNED, COMPACTFREE_SCANNED,
> diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
> index 4d434398d64d..f8ffb8aece48 100644
> --- a/include/trace/events/migrate.h
> +++ b/include/trace/events/migrate.h
> @@ -47,10 +47,11 @@ TRACE_EVENT(mm_migrate_pages,
>  
>  	TP_PROTO(unsigned long succeeded, unsigned long failed,
>  		 unsigned long thp_succeeded, unsigned long thp_failed,
> -		 unsigned long thp_split, enum migrate_mode mode, int reason),
> +		 unsigned long thp_split, unsigned long hugetlb_succeeded,
> +		 unsigned long hugetlb_failed, enum migrate_mode mode, int reason),
>  
>  	TP_ARGS(succeeded, failed, thp_succeeded, thp_failed,
> -		thp_split, mode, reason),
> +		thp_split, hugetlb_succeeded, hugetlb_failed, mode, reason),
>  
>  	TP_STRUCT__entry(
>  		__field(	unsigned long,		succeeded)
> @@ -58,6 +59,8 @@ TRACE_EVENT(mm_migrate_pages,
>  		__field(	unsigned long,		thp_succeeded)
>  		__field(	unsigned long,		thp_failed)
>  		__field(	unsigned long,		thp_split)
> +		__field(	unsigned long,		hugetlb_succeeded)
> +		__field(	unsigned long,		hugetlb_failed)
>  		__field(	enum migrate_mode,	mode)
>  		__field(	int,			reason)
>  	),
> @@ -68,16 +71,20 @@ TRACE_EVENT(mm_migrate_pages,
>  		__entry->thp_succeeded	= thp_succeeded;
>  		__entry->thp_failed	= thp_failed;
>  		__entry->thp_split	= thp_split;
> +		__entry->hugetlb_succeeded	= hugetlb_succeeded;
> +		__entry->hugetlb_failed		= hugetlb_failed;
>  		__entry->mode		= mode;
>  		__entry->reason		= reason;
>  	),
>  
> -	TP_printk("nr_succeeded=%lu nr_failed=%lu nr_thp_succeeded=%lu nr_thp_failed=%lu nr_thp_split=%lu mode=%s reason=%s",
> +	TP_printk("nr_succeeded=%lu nr_failed=%lu nr_thp_succeeded=%lu nr_thp_failed=%lu nr_thp_split=%lu nr_hugetlb_succeeded=%lu nr_hugetlb_failed=%lu mode=%s reason=%s",
>  		__entry->succeeded,
>  		__entry->failed,
>  		__entry->thp_succeeded,
>  		__entry->thp_failed,
>  		__entry->thp_split,
> +		__entry->hugetlb_succeeded,
> +		__entry->hugetlb_failed,
>  		__print_symbolic(__entry->mode, MIGRATE_MODE),
>  		__print_symbolic(__entry->reason, MIGRATE_REASON))
>  );
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 5ca5842df5db..0aac9d39778c 100644
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
> @@ -1430,9 +1434,10 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	if (!swapwrite)
>  		current->flags |= PF_SWAPWRITE;
>  
> -	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
> +	for (pass = 0; pass < 10 && (retry || thp_retry || hugetlb_retry); pass++) {
>  		retry = 0;
>  		thp_retry = 0;
> +		hugetlb_retry = 0;
>  
>  		list_for_each_entry_safe(page, page2, from, lru) {
>  retry:
> @@ -1441,11 +1446,19 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  			 * Capture required information that might get lost
>  			 * during migration.
>  			 */
> -			is_thp = PageTransHuge(page) && !PageHuge(page);
> -			nr_subpages = thp_nr_pages(page);
> +			is_thp = false;
> +			is_hugetlb = false;
> +			if (PageTransHuge(page)) {
> +				if (PageHuge(page))
> +					is_hugetlb = true;
> +				else
> +					is_thp = true;
> +			}
> +			nr_subpages = compound_nr(page);
> +
>  			cond_resched();
>  
> -			if (PageHuge(page))
> +			if (is_hugetlb)
>  				rc = unmap_and_move_huge_page(get_new_page,
>  						put_new_page, private, page,
>  						pass > 2, mode, reason);
> @@ -1481,6 +1494,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  					nr_failed += nr_subpages;
>  					goto out;
>  				}
> +				if (is_hugetlb) {
> +					nr_hugetlb_failed++;
> +					nr_failed += nr_subpages;
> +					goto out;
> +				}
>  				nr_failed++;
>  				goto out;
>  			case -EAGAIN:
> @@ -1488,6 +1506,10 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  					thp_retry++;
>  					break;
>  				}
> +				if (is_hugetlb) {
> +					hugetlb_retry++;
> +					break;
> +				}
>  				retry++;
>  				break;
>  			case MIGRATEPAGE_SUCCESS:
> @@ -1496,6 +1518,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  					nr_succeeded += nr_subpages;
>  					break;
>  				}
> +				if (is_hugetlb) {
> +					nr_hugetlb_succeeded++;
> +					nr_succeeded += nr_subpages;
> +					break;
> +				}
>  				nr_succeeded++;
>  				break;
>  			default:
> @@ -1510,13 +1537,19 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  					nr_failed += nr_subpages;
>  					break;
>  				}
> +				if (is_hugetlb) {
> +					nr_hugetlb_failed++;
> +					nr_failed += nr_subpages;
> +					break;
> +				}
>  				nr_failed++;
>  				break;
>  			}
>  		}
>  	}
> -	nr_failed += retry + thp_retry;
> +	nr_failed += retry + thp_retry + hugetlb_retry;
>  	nr_thp_failed += thp_retry;
> +	nr_hugetlb_failed += hugetlb_retry;
>  	rc = nr_failed;
>  out:
>  	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
> @@ -1524,8 +1557,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
>  	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
>  	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
> +	count_vm_events(HUGETLB_MIGRATION_SUCCESS, nr_hugetlb_succeeded);
> +	count_vm_events(HUGETLB_MIGRATION_FAIL, nr_hugetlb_failed);
>  	trace_mm_migrate_pages(nr_succeeded, nr_failed, nr_thp_succeeded,
> -			       nr_thp_failed, nr_thp_split, mode, reason);
> +			       nr_thp_failed, nr_thp_split, nr_hugetlb_succeeded,
> +			       nr_hugetlb_failed, mode, reason);
>  
>  	if (!swapwrite)
>  		current->flags &= ~PF_SWAPWRITE;
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 79e5cd0abd0e..12fd35ba135f 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1286,6 +1286,8 @@ const char * const vmstat_text[] = {
>  	"thp_migration_success",
>  	"thp_migration_fail",
>  	"thp_migration_split",
> +	"hugetlb_migration_success",
> +	"hugetlb_migration_fail",
>  #endif
>  #ifdef CONFIG_COMPACTION
>  	"compact_migrate_scanned",
> -- 
> 2.20.1
> 

-- 
Michal Hocko
SUSE Labs
