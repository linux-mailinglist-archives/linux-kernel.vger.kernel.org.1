Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF085281160
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 13:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387728AbgJBLnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 07:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgJBLnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 07:43:16 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58ECC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 04:43:14 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id v123so937901qkd.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 04:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C4mW4jmQiUVM5ODOj2Y+K5sHn+/g6biBAH0gCyhwiEg=;
        b=gVXtVylePjM3/u0XGDB6MreiXopfmG2teSFQ22xJMa8IuhxllbxEs0hpxJto022pVB
         YJ2n/L4JxcA0ZpEDQHCNigywuT8CFvPg5raX6lFic7q0WGqRKaOiMhaSjoywXgpzPdME
         WsZH79mTQIwmVWRfa/RV0HnB8rek/VZ8caBooRhco5sNcoDR4gNTYC3sjso2ipA1AP2k
         /CBjQ/9M635HP+VAQfhf8CAW8KEMtC2WMYpcm8KBnW+JgXK0VUgqEBZOpy37wvKtIbnq
         sUK5LFTLUSng2W/xXkrsk22dZIX2xwLiBkAFimkV/WDPx6E6cm9c7eWFvCfPCQ/BZr57
         phRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C4mW4jmQiUVM5ODOj2Y+K5sHn+/g6biBAH0gCyhwiEg=;
        b=aABbyMlmOyvUhrfbHSz2Xrc12o4aNe47h3Vxt+hxqDEowCupgU0Lf5PBsU3zuOE9lz
         N3QEg7eHl7MZ5EBchdGIbz/r1bEOyxw4C2XywZSBMMv83TLLPVtLfqYjRBCcl1hulgip
         TMR4WdJOryE87aCbzgcmQeFCLoeAbTtDhCylzbdI54WQVFU98tghk7QdQ4sjL2+D9oHk
         n76ydqwxLx/ygHLr34aMPkItfLQd1LR2OPFcQvviCxJ9eAlUVvBolQbkSlfqENBzBzP5
         dfOoTO8FYnrOsDJifcgV4jt+b0NC7FJQk1/ZLX/1xvofma3p0s+Z4lQKH6UXYaCAukIM
         mWyQ==
X-Gm-Message-State: AOAM533h3jJAmDB6fI4Zrd0cijwP3rqXTOc5j/UrSeUxbyFStYnqrWHc
        N48azfwe1nQZ8JshMnEIytw2Pw==
X-Google-Smtp-Source: ABdhPJwj4XkAb9DCtBHvHQ8z80pFaHpYrtmCYbNEVt/MLnHuOBoPk0ZIs7I6F5cDt9HCcvKU78qZ9Q==
X-Received: by 2002:a37:7c4:: with SMTP id 187mr1587359qkh.112.1601638994028;
        Fri, 02 Oct 2020 04:43:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id v30sm815678qtj.52.2020.10.02.04.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 04:43:13 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kOJSy-005Z2Z-Lq; Fri, 02 Oct 2020 08:43:12 -0300
Date:   Fri, 2 Oct 2020 08:43:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH] mm: Remove src/dst mm parameter in copy_page_range()
Message-ID: <20201002114312.GI9916@ziepe.ca>
References: <20200930204950.6668-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930204950.6668-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 04:49:50PM -0400, Peter Xu wrote:
> Both of the mm pointers are not needed after commit 7a4830c380f3 ("mm/fork:
> Pass new vma pointer into copy_page_range()").
> 
> Reported-by: Kirill A. Shutemov <kirill@shutemov.name>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/mm.h |  3 +--
>  kernel/fork.c      |  2 +-
>  mm/memory.c        | 43 ++++++++++++++++++++++---------------------
>  3 files changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 16b799a0522c..8a0ec8dce5f6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1645,8 +1645,7 @@ struct mmu_notifier_range;
>  
>  void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
>  		unsigned long end, unsigned long floor, unsigned long ceiling);
> -int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
> -		    struct vm_area_struct *vma, struct vm_area_struct *new);
> +int copy_page_range(struct vm_area_struct *vma, struct vm_area_struct *new);
>  int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
>  		   struct mmu_notifier_range *range,
>  		   pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp);
> diff --git a/kernel/fork.c b/kernel/fork.c
> index da8d360fb032..5f42d4afe0ae 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -589,7 +589,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  
>  		mm->map_count++;
>  		if (!(tmp->vm_flags & VM_WIPEONFORK))
> -			retval = copy_page_range(mm, oldmm, mpnt, tmp);
> +			retval = copy_page_range(mpnt, tmp);
>  
>  		if (tmp->vm_ops && tmp->vm_ops->open)
>  			tmp->vm_ops->open(tmp);
> diff --git a/mm/memory.c b/mm/memory.c
> index fcfc4ca36eba..251bb5082f4e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -957,11 +957,12 @@ page_copy_prealloc(struct mm_struct *src_mm, struct vm_area_struct *vma,
>  	return new_page;
>  }
>  
> -static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> -		   pmd_t *dst_pmd, pmd_t *src_pmd, struct vm_area_struct *vma,
> -		   struct vm_area_struct *new,
> +static int copy_pte_range(pmd_t *dst_pmd, pmd_t *src_pmd,
> +		   struct vm_area_struct *vma, struct vm_area_struct *new,
>  		   unsigned long addr, unsigned long end)

I link this, my only minor quibble is the mixing of dst/src and new
language, and then reversing the order in each place. Would read
better to be consistent:

  copy_pte_range(dst_vma, dst_pmd, src_vma, src_pmd, addr, end)

Regards,
Jason
