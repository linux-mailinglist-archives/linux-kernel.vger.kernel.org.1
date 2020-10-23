Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D6629689A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 04:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460250AbgJWCyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 22:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374794AbgJWCyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 22:54:50 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4951C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 19:54:50 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id c5so89731otr.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 19:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=OhlO/LzneaK56JyPnno414NEIqe0lQnV0xWgz8QTSSs=;
        b=GwO/S5qckQ87lNn4nYQwzre4r+MI9DIp0YjQQkzmuurhzIVVOK2mBprOQhX3H6eLW6
         OuFT5GJnMqf3BOF8gKjGlBvN39sLm8jCEqIxaJa+n+raWG9SX0m0lUSEVxUj1NBsPh+O
         iARFRKH4lCR8I5iLG0EQ4XikblpJU3ALJ7fYVR8OVI7fu9ad8xRcon7nDbFywIyyNrQx
         fvIWU2J8hd2JRl6HogFjAKjdjVKgwRNsXr/obqRfnSQdQfYYosM6QVKKcQEZBOTbx+pU
         0v0BqwLu0VtfYne3eA3JmTWj/s30jMg/Mknz65rIPM1XYHlbOWGeWbtg+9xoqmeIRXeX
         nUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=OhlO/LzneaK56JyPnno414NEIqe0lQnV0xWgz8QTSSs=;
        b=S+oSOFU90WmR+ACyLEATgUAdPcSrWKeP0lTfzy0IZJCaBBxvLdvjni6RLh5cnCAyCL
         jYlzAz6NhODIzVnnoxlXu8Va2nAHllmC+c6pXgcqKrRjygCrUB2DmO+DpetL4kLG9W4j
         nV5fTwpWyu5GKyfhB2N0NCLORwcn5hlTIZl2+cenVFuJ22MWljs88adbihGufu0AxqtR
         OAn4tjpobkHHprtB4Xdpy//0AhHslCd2VCuBSK5flVoeSqOO/so8iENttgy9TgwZYamx
         hil+xnu0fC7p11AOOeQ9wyPFFMhdJURE67q3Jxtmlui6/EdmbhFRGh2RsMj44zZJO0ME
         6/Hw==
X-Gm-Message-State: AOAM531+fBr4b6Y19r32jWNlStmG7fURyEkYJhcJxFnnb7b0t95ocs8e
        oWqRIOV/6Us0Enqh6aIm52XwQg==
X-Google-Smtp-Source: ABdhPJyoNYb9JnNfDzXvSXmyfDXZJo5rmRr8ZofQa7TSvfGqhjrrUwafPizl541YRUq/vhiwFv1MCQ==
X-Received: by 2002:a9d:6052:: with SMTP id v18mr78892otj.33.1603421689657;
        Thu, 22 Oct 2020 19:54:49 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g22sm58652oti.26.2020.10.22.19.54.47
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 22 Oct 2020 19:54:48 -0700 (PDT)
Date:   Thu, 22 Oct 2020 19:54:34 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Rik van Riel <riel@surriel.com>
cc:     Hugh Dickins <hughd@google.com>, Yu Xu <xuyu@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm,thp,shmem: limit shmem THP alloc gfp_mask
In-Reply-To: <20201022124511.72448a5f@imladris.surriel.com>
Message-ID: <alpine.LSU.2.11.2010221909060.1001@eggly.anvils>
References: <20201022124511.72448a5f@imladris.surriel.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020, Rik van Riel wrote:

> The allocation flags of anonymous transparent huge pages can be controlled
> through the files in /sys/kernel/mm/transparent_hugepage/defrag, which can
> help the system from getting bogged down in the page reclaim and compaction
> code when many THPs are getting allocated simultaneously.
> 
> However, the gfp_mask for shmem THP allocations were not limited by those
> configuration settings, and some workloads ended up with all CPUs stuck
> on the LRU lock in the page reclaim code, trying to allocate dozens of
> THPs simultaneously.
> 
> This patch applies the same configurated limitation of THPs to shmem
> hugepage allocations, to prevent that from happening.
> 
> This way a THP defrag setting of "never" or "defer+madvise" will result
> in quick allocation failures without direct reclaim when no 2MB free
> pages are available.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>

NAK in its present untested form: see below.

I'm open to change here, particularly to Yu Xu's point (in other mail)
about direct reclaim - we avoid that here in Google too: though it's
not so much to avoid the direct reclaim, as to avoid the latencies of
direct compaction, which __GFP_DIRECT_RECLAIM allows as a side-effect.

> --- 
> v2: move gfp calculation to shmem_getpage_gfp as suggested by Yu Xu
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index c603237e006c..0a5b164a26d9 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -614,6 +614,8 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask);
>  extern void pm_restrict_gfp_mask(void);
>  extern void pm_restore_gfp_mask(void);
>  
> +extern gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma);
> +
>  #ifdef CONFIG_PM_SLEEP
>  extern bool pm_suspended_storage(void);
>  #else
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9474dbc150ed..9b08ce5cc387 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -649,7 +649,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>   *	    available
>   * never: never stall for any thp allocation
>   */
> -static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma)
> +gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma)
>  {
>  	const bool vma_madvised = !!(vma->vm_flags & VM_HUGEPAGE);
>  
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 537c137698f8..9710b9df91e9 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1545,8 +1545,8 @@ static struct page *shmem_alloc_hugepage(gfp_t gfp,
>  		return NULL;
>  
>  	shmem_pseudo_vma_init(&pvma, info, hindex);
> -	page = alloc_pages_vma(gfp | __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN,
> -			HPAGE_PMD_ORDER, &pvma, 0, numa_node_id(), true);
> +	page = alloc_pages_vma(gfp, HPAGE_PMD_ORDER, &pvma, 0, numa_node_id(),
> +			       true);

Commendably neat so far.

>  	shmem_pseudo_vma_destroy(&pvma);
>  	if (page)
>  		prep_transhuge_page(page);
> @@ -1802,6 +1802,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>  	struct page *page;
>  	enum sgp_type sgp_huge = sgp;
>  	pgoff_t hindex = index;
> +	gfp_t huge_gfp;
>  	int error;
>  	int once = 0;
>  	int alloced = 0;
> @@ -1887,7 +1888,8 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>  	}
>  
>  alloc_huge:
> -	page = shmem_alloc_and_acct_page(gfp, inode, index, true);
> +	huge_gfp = alloc_hugepage_direct_gfpmask(vma);

Still looks nice: but what about the crash when vma is NULL?

It may work for shmem_fault() (though I'll probably disagree on the
details): but tmpfs is a filesystem, so most if not all of the system
calls which arrive here have no vma to offer.

Michal is right to remember pushback before, because tmpfs is a
filesystem, and "huge=" is a mount option: in using a huge=always
filesystem, the user has already declared a preference for huge pages.
Whereas the original anon THP had to deduce that preference from sys
tunables and vma madvice.

I certainly found it a lot easier to ignore all the shifting sandmaze
of the anon THP tunables, and I think Kirill followed me on that.

But it's likely that they have accumulated some defrag wisdom, which
tmpfs can take on board - but please accept that in using a huge mount,
the preference for huge has already been expressed, so I don't expect
anon THP alloc_hugepage_direct_gfpmask() choices will map one to one.

> +	page = shmem_alloc_and_acct_page(huge_gfp, inode, index, true);
>  	if (IS_ERR(page)) {
>  alloc_nohuge:
>  		page = shmem_alloc_and_acct_page(gfp, inode,
> 

Hugh
