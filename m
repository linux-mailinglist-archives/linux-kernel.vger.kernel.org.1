Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B8C2CC263
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbgLBQc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:32:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:42423 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727942AbgLBQc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:32:29 -0500
IronPort-SDR: c/g/9fgAXJeKlmvjCd9r9YozRjzhmJngLjygoPRvElk0JVrpNNPQOGBDkzVAlt/hSxjm6ncyyh
 jQsbypFA+vrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="170477863"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="170477863"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 08:31:48 -0800
IronPort-SDR: 4R8GAaP+MXQvaCeENcvjHsLHoWad5QG2FdKtSrqVyb8nbIgGMyaPDVtWup+wmQee72BsMjm9HT
 uoU9P7HY3Kdw==
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="550123095"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 08:31:45 -0800
Date:   Wed, 2 Dec 2020 08:31:45 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        iamjoonsoo.kim@lge.com, mike.kravetz@oracle.com,
        rostedt@goodmis.org, mingo@redhat.com, jgg@ziepe.ca,
        peterz@infradead.org, mgorman@suse.de, willy@infradead.org,
        rientjes@google.com, jhubbard@nvidia.com
Subject: Re: [PATCH 3/6] mm/gup: make __gup_longterm_locked common
Message-ID: <20201202163145.GT1161629@iweiny-DESK2.sc.intel.com>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-4-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202052330.474592-4-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 12:23:27AM -0500, Pavel Tatashin wrote:
> __gup_longterm_locked() has CMA || FS_DAX version and a common stub
> version. In the preparation of prohibiting longterm pinning of pages from
> movable zone make the CMA || FS_DAX version common, and delete the stub
> version.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
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

Isn't this going to potentially allocate vmas_tmp only to not need it when
!FS_DAX and !CMA?

Ira

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
