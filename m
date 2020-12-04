Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3A72CE6F7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgLDEOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgLDEOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:14:48 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F1CC061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 20:14:08 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t37so2748488pga.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 20:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pGb5tYdXTIHw0gCNf+of2HGwxKrKK7IlDBCj0fu+AOM=;
        b=MsDMZuDY10nWFoBR/gcu03C/av/dSgjG/utX07HPwgp1HIlBmrDe0nClaL+lDpDEy9
         TPpMzBv3HnIXa41P/DFThDxrWVbBjgZ/84uLbzSbr5x0535lFs+7XIfuKXGRKE4rVmJa
         M/kaQuJz0IW3u7ykdynuiGltMeefde1rOfDY0pm+7bFRXNLHsEW88HuZ+yDT3xy7FhMk
         /JUmKMIym5rfuI8Ii0tF24DyphXAv6jqDS38wEuMXw1vNlHsZn6ZmBfyu0CbaLdyKsD0
         KZziQracMUM1oVhhEuX6VuKNDodErya9SqQ8jlmnTcwmd55CjofTNvBTryz6HObpRMJg
         7qTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pGb5tYdXTIHw0gCNf+of2HGwxKrKK7IlDBCj0fu+AOM=;
        b=mU+Z8Qw3ZUnRdb0osU0P/Qasn8rugXdRfp4jhwcpLFNBHFs1wFZ/GqX6ZSgXZAr+ry
         CjS9E1y2g0HgwAKQnOlfhpBhsXkq4mCvaHPepN+x91zUtF2UPW3yekXQPdUUsZ3JfVy0
         Av5+1eLYyKJfzN4E+iEVdOp6t4574l7S04DK5qFYo/xt2lrthQY8upkrE9bo0xRqKFlT
         isbCOXO5bACbRTEhV8QTcglBT8r32B5qVE4IlUr7q84/6gkRa8CcgQDYaxlCKfrNDFWn
         9IdJXhsRlK8GXd2yk7TY6bFsuVy0e8EmzX9GK9+dkKsIngN4kCt3r6JEdtCsOcitokLW
         QRgA==
X-Gm-Message-State: AOAM531V5JGPT43OZRPHR6WALiWNNMh/BUASg5cGlPW691PH4xZOIEcr
        nmeuxAmawH6emS9d//P8lms=
X-Google-Smtp-Source: ABdhPJxqx6Ggju8lEonYoZZUv5mHRZahn4nMT0spxkBw3KONMojdfsB/s3SP9sQ1D5wzTycnSub5Ww==
X-Received: by 2002:a05:6a00:2382:b029:198:15a2:aaf9 with SMTP id f2-20020a056a002382b029019815a2aaf9mr1997334pfc.39.1607055248344;
        Thu, 03 Dec 2020 20:14:08 -0800 (PST)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id s30sm2516339pgl.39.2020.12.03.20.14.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2020 20:14:07 -0800 (PST)
Date:   Fri, 4 Dec 2020 13:13:59 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com
Subject: Re: [PATCH 6/6] mm/gup: migrate pinned pages out of movable zone
Message-ID: <20201204041358.GB17056@js1304-desktop>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-7-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202052330.474592-7-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 12:23:30AM -0500, Pavel Tatashin wrote:
> We do not allocate pin pages in ZONE_MOVABLE, but if pages were already
> allocated before pinning they need to migrated to a different zone.
> Currently, we migrate movable CMA pages only. Generalize the function
> that migrates CMA pages to migrate all movable pages.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/migrate.h        |  1 +
>  include/trace/events/migrate.h |  3 +-
>  mm/gup.c                       | 56 +++++++++++++---------------------
>  3 files changed, 24 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 0f8d1583fa8e..00bab23d1ee5 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -27,6 +27,7 @@ enum migrate_reason {
>  	MR_MEMPOLICY_MBIND,
>  	MR_NUMA_MISPLACED,
>  	MR_CONTIG_RANGE,
> +	MR_LONGTERM_PIN,
>  	MR_TYPES
>  };
>  
> diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
> index 4d434398d64d..363b54ce104c 100644
> --- a/include/trace/events/migrate.h
> +++ b/include/trace/events/migrate.h
> @@ -20,7 +20,8 @@
>  	EM( MR_SYSCALL,		"syscall_or_cpuset")		\
>  	EM( MR_MEMPOLICY_MBIND,	"mempolicy_mbind")		\
>  	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
> -	EMe(MR_CONTIG_RANGE,	"contig_range")
> +	EM( MR_CONTIG_RANGE,	"contig_range")			\
> +	EMe(MR_LONGTERM_PIN,	"longterm_pin")
>  
>  /*
>   * First define the enums in the above macros to be exported to userspace
> diff --git a/mm/gup.c b/mm/gup.c
> index 724d8a65e1df..1d511f65f8a7 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1593,19 +1593,18 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
>  }
>  #endif
>  
> -#ifdef CONFIG_CMA
> -static long check_and_migrate_cma_pages(struct mm_struct *mm,
> -					unsigned long start,
> -					unsigned long nr_pages,
> -					struct page **pages,
> -					struct vm_area_struct **vmas,
> -					unsigned int gup_flags)
> +static long check_and_migrate_movable_pages(struct mm_struct *mm,
> +					    unsigned long start,
> +					    unsigned long nr_pages,
> +					    struct page **pages,
> +					    struct vm_area_struct **vmas,
> +					    unsigned int gup_flags)
>  {
>  	unsigned long i;
>  	unsigned long step;
>  	bool drain_allow = true;
>  	bool migrate_allow = true;
> -	LIST_HEAD(cma_page_list);
> +	LIST_HEAD(page_list);
>  	long ret = nr_pages;
>  	struct migration_target_control mtc = {
>  		.nid = NUMA_NO_NODE,
> @@ -1623,13 +1622,12 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
>  		 */
>  		step = compound_nr(head) - (pages[i] - head);
>  		/*
> -		 * If we get a page from the CMA zone, since we are going to
> -		 * be pinning these entries, we might as well move them out
> -		 * of the CMA zone if possible.
> +		 * If we get a movable page, since we are going to be pinning
> +		 * these entries, try to move them out if possible.
>  		 */
> -		if (is_migrate_cma_page(head)) {
> +		if (is_migrate_movable(get_pageblock_migratetype(head))) {

is_migrate_movable() isn't a check for the ZONE. It's a check for the
MIGRATE_TYPE. MIGRATE_TYPE doesn't require hard guarantee for
migration, and, most of memory, including ZONE_NORMAL, is
MIGRATE_MOVABLE. With this code, long term gup would always fails due
to not enough memory. I think that correct change would be
"is_migrate_cma_page(hear) && zone == ZONE_MOVABLE".

Patch #5 also has this problem. Please fix it too.

Thanks.
