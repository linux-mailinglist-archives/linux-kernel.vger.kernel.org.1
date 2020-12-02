Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C732CC221
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389051AbgLBQXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:23:00 -0500
Received: from mga03.intel.com ([134.134.136.65]:44494 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389016AbgLBQW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:22:59 -0500
IronPort-SDR: 5mh4z9xwl+b2zFZQ7rkp3agojTTeqadwR0zUV9xSrTn0Snc7EUxuVayjgcw5Du7ucMRpq6Zvqw
 GZwGOtodSG/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="173140268"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="173140268"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 08:22:16 -0800
IronPort-SDR: Era7pDZzgxbiaJpQIAK5imL4NHLKAQ/4FwHkMmx1lAR9MtAJkXNHgqqo1XehrVMUKUtykaI1w6
 juZiarijiT2g==
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="335612597"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 08:22:15 -0800
Date:   Wed, 2 Dec 2020 08:22:15 -0800
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
Subject: Re: [PATCH 1/6] mm/gup: perform check_dax_vmas only when FS_DAX is
 enabled
Message-ID: <20201202162215.GS1161629@iweiny-DESK2.sc.intel.com>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202052330.474592-2-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 12:23:25AM -0500, Pavel Tatashin wrote:
> There is no need to check_dax_vmas() and run through the npage loop of
> pinned pages if FS_DAX is not enabled.
> 
> Add a stub check_dax_vmas() function for no-FS_DAX case.

This looks like a good idea.

> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  mm/gup.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 98eb8e6d2609..cdb8b9eeb016 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1568,6 +1568,7 @@ struct page *get_dump_page(unsigned long addr)
>  #endif /* CONFIG_ELF_CORE */
>  
>  #if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)

In addition, I think it would make a lot of sense to clean up this config as
well like this:

08:20:10 > git di
diff --git a/mm/gup.c b/mm/gup.c
index 102877ed77a4..92cfda220aeb 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1567,7 +1567,7 @@ struct page *get_dump_page(unsigned long addr)
 }
 #endif /* CONFIG_ELF_CORE */
 
-#if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)
+#ifdef CONFIG_FS_DAX
 static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
 {
        long i;
@@ -1586,6 +1586,12 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
        }
        return false;
 }
+#else
+static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
+{
+       return false;
+}
+#endif /* CONFIG_FS_DAX */
 
 #ifdef CONFIG_CMA
 static long check_and_migrate_cma_pages(struct mm_struct *mm,
@@ -1691,6 +1697,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 }
 #endif /* CONFIG_CMA */
 
+#if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)
 /*
  * __gup_longterm_locked() is a wrapper for __get_user_pages_locked which
  * allows us to process the FOLL_LONGTERM flag.


That makes it more clear what is going on with __gup_longterm_locked() and
places both CMA and FS_DAX code within their own blocks.

Ira

> +#ifdef CONFIG_FS_DAX
>  static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
>  {
>  	long i;
> @@ -1586,6 +1587,12 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
>  	}
>  	return false;
>  }
> +#else
> +static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
> +{
> +	return false;
> +}
> +#endif
>  
>  #ifdef CONFIG_CMA
>  static long check_and_migrate_cma_pages(struct mm_struct *mm,
> -- 
> 2.25.1
> 
> 
