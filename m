Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3DD2D5293
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 05:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbgLJEH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 23:07:26 -0500
Received: from mga17.intel.com ([192.55.52.151]:18541 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731986AbgLJEHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 23:07:05 -0500
IronPort-SDR: 2eoUH9XhRqJnRd7TCgH850thxP5pn4+7D8KVtng9w7/15zkxXHmwKW8L+aYbvuTMZyexxmATmG
 I0aCP+slH8vg==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="153999163"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="153999163"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 20:06:19 -0800
IronPort-SDR: 2yLRbXl1/SMNxb/j0Fi5OnKn8YGbzpse05mx+yG5B9ZZJfvWvYZxm9kkc/AhTBzU0eO2LRlSCA
 s3rrjworJk+A==
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="376793430"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 20:06:19 -0800
Date:   Wed, 9 Dec 2020 20:06:19 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        iamjoonsoo.kim@lge.com, mike.kravetz@oracle.com,
        rostedt@goodmis.org, mingo@redhat.com, jgg@ziepe.ca,
        peterz@infradead.org, mgorman@suse.de, willy@infradead.org,
        rientjes@google.com, jhubbard@nvidia.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 3/8] mm/gup: make __gup_longterm_locked common
Message-ID: <20201210040618.GR1563847@iweiny-DESK2.sc.intel.com>
References: <20201210004335.64634-1-pasha.tatashin@soleen.com>
 <20201210004335.64634-4-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210004335.64634-4-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 07:43:30PM -0500, Pavel Tatashin wrote:
> __gup_longterm_locked() has CMA || FS_DAX version and a common stub
> version. In the preparation of prohibiting longterm pinning of pages from
> movable zone make the CMA || FS_DAX version common, and delete the stub
> version.

I thought Jason sent a patch which got rid of this as well?

Ira

> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/gup.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 3a76c005a3e2..0e2de888a8b0 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1567,7 +1567,6 @@ struct page *get_dump_page(unsigned long addr)
>  }
>  #endif /* CONFIG_ELF_CORE */
>  
> -#if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)
>  #ifdef CONFIG_FS_DAX
>  static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
>  {
> @@ -1757,18 +1756,6 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>  		kfree(vmas_tmp);
>  	return rc;
>  }
> -#else /* !CONFIG_FS_DAX && !CONFIG_CMA */
> -static __always_inline long __gup_longterm_locked(struct mm_struct *mm,
> -						  unsigned long start,
> -						  unsigned long nr_pages,
> -						  struct page **pages,
> -						  struct vm_area_struct **vmas,
> -						  unsigned int flags)
> -{
> -	return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
> -				       NULL, flags);
> -}
> -#endif /* CONFIG_FS_DAX || CONFIG_CMA */
>  
>  static bool is_valid_gup_flags(unsigned int gup_flags)
>  {
> -- 
> 2.25.1
> 
> 
