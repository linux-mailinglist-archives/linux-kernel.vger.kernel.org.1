Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC571270B13
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 08:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgISGWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 02:22:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgISGWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 02:22:34 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5B1222208;
        Sat, 19 Sep 2020 06:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600496553;
        bh=Kuxz2KrdTf20dNUtZmk07m7aaNkacgtNpBvw3SbUQYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aH6o+6KJlF936JU2BCeVAUcxGQ/1gZEVmZcXoqFYc60DOttLJNcVoRL1mpBaYL5U6
         MAFlBhaIVxRRNStv/oLtoo1Zl/199MRZs1GlgXN5Lijz19bh9crAinFJoScH+lIE3R
         v1e+4bCe08tdcmWrOFkSjNuvabUHL0WDZTvaE9uQ=
Date:   Sat, 19 Sep 2020 08:22:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V3 6/8] mm: and drivers core: Convert
 hugetlb_report_node_meminfo to sysfs_emit
Message-ID: <20200919062228.GA438957@kroah.com>
References: <cover.1600285923.git.joe@perches.com>
 <894b351b82da6013cde7f36ff4b5493cd0ec30d0.1600285923.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <894b351b82da6013cde7f36ff4b5493cd0ec30d0.1600285923.git.joe@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 01:40:43PM -0700, Joe Perches wrote:
> Convert the unbound sprintf in hugetlb_report_node_meminfo to use
> sysfs_emit_at so that no possible overrun of a PAGE_SIZE buf can occur.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/base/node.c     |  2 +-
>  include/linux/hugetlb.h |  4 ++--
>  mm/hugetlb.c            | 18 ++++++++++--------
>  3 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index b33526a9fcfc..dafe03e82e7c 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -473,7 +473,7 @@ static ssize_t node_read_meminfo(struct device *dev,
>  				    HPAGE_PMD_NR)
>  #endif
>  			    );
> -	len += hugetlb_report_node_meminfo(nid, buf + len);
> +	len += hugetlb_report_node_meminfo(buf, len, nid);
>  	return len;
>  }
>  
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index d5cc5f802dd4..ebca2ef02212 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -129,7 +129,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  				unsigned long start, unsigned long end,
>  				struct page *ref_page);
>  void hugetlb_report_meminfo(struct seq_file *);
> -int hugetlb_report_node_meminfo(int, char *);
> +int hugetlb_report_node_meminfo(char *buf, int len, int nid);
>  void hugetlb_show_meminfo(void);
>  unsigned long hugetlb_total_pages(void);
>  vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> @@ -245,7 +245,7 @@ static inline void hugetlb_report_meminfo(struct seq_file *m)
>  {
>  }
>  
> -static inline int hugetlb_report_node_meminfo(int nid, char *buf)
> +static inline int hugetlb_report_node_meminfo(char *buf, int len, int nid)
>  {
>  	return 0;
>  }
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 61469fd3ad92..fe76f8fd5a73 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3571,18 +3571,20 @@ void hugetlb_report_meminfo(struct seq_file *m)
>  	seq_printf(m, "Hugetlb:        %8lu kB\n", total / 1024);
>  }
>  
> -int hugetlb_report_node_meminfo(int nid, char *buf)
> +int hugetlb_report_node_meminfo(char *buf, int len, int nid)
>  {
>  	struct hstate *h = &default_hstate;
> +
>  	if (!hugepages_supported())
>  		return 0;
> -	return sprintf(buf,
> -		"Node %d HugePages_Total: %5u\n"
> -		"Node %d HugePages_Free:  %5u\n"
> -		"Node %d HugePages_Surp:  %5u\n",
> -		nid, h->nr_huge_pages_node[nid],
> -		nid, h->free_huge_pages_node[nid],
> -		nid, h->surplus_huge_pages_node[nid]);
> +
> +	return sysfs_emit_at(buf, len,
> +			     "Node %d HugePages_Total: %5u\n"
> +			     "Node %d HugePages_Free:  %5u\n"
> +			     "Node %d HugePages_Surp:  %5u\n",
> +			     nid, h->nr_huge_pages_node[nid],
> +			     nid, h->free_huge_pages_node[nid],
> +			     nid, h->surplus_huge_pages_node[nid]);
>  }

That is NOT one-value-per-file, which is required for sysfs files.  This
should be 3 different sysfs files.

Ugh.

But that's separate from this series, thanks for redoing this.  I'll
take a look at it on Monday...

thanks,

greg k-h
