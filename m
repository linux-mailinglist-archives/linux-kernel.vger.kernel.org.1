Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF1A2AF95A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 20:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgKKT72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 14:59:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbgKKT71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605124765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b66wQ5nrB6gSlcuiEZtdKUP5zPut4fVBmwWpg3DYUA8=;
        b=TfKPOlMsWU8pqEHcznzkHhb05SdWkAPCSQGdmHVKxmJLv/Wc5wllczohIWUL2Fx1sMSkLy
        x/yJlV5JjQOuG/Oy/6MmlorpUiIu8bfO23xl5yneGnnnd5NaN++YQa1bMzSHdfnWkpWIvE
        2UcmxF1HPHXSiq4yIuIKPUH5M/+FwCw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-nY3pLDDRPFOqIrdQBLj3rA-1; Wed, 11 Nov 2020 14:59:23 -0500
X-MC-Unique: nY3pLDDRPFOqIrdQBLj3rA-1
Received: by mail-qk1-f200.google.com with SMTP id t70so2478497qka.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 11:59:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b66wQ5nrB6gSlcuiEZtdKUP5zPut4fVBmwWpg3DYUA8=;
        b=VQjHK5827An9RsMaKAoypReBNSPOqXMqs6g7SvKudVufQoyYcv9SmLwznwl5+Ohnln
         Oy71kKBMwA1quHoVOdhFQyxM/kik8ALkCeHEoJb2vCeJM+2QDFdAYhOEgeHZnYmyAkgT
         BPW/2srnHtF/RoSan9ZPaG14koGW84ZINmYO19+Zi/aKxlvaGVU2HKSuYLIpW0sOdItV
         E5/jtYsIPlvp2B/UUFUtBjJ/MLggNxvxkBfZsJ6yxkuUcx+RoCdo8uo4/WtEhRYpGp4Z
         dFAc+NfhcRXiUQBY1TF7VvkANHpycuhy6G0Br+NK4wrd5xvJaS8vZ5/2Nfg70/Mb7csv
         AAvQ==
X-Gm-Message-State: AOAM531GPfTxiqX9N9wqvQ4JWiJDCFldKqdX0caAfSsdPwBPVbZ1e2gN
        YIDwyJsZL5sQ1MykTvgvTjByYx9bWcPlAuCeP2iRSoLwgXu7aHd5yUdHPkCvzkzYxFKbIN3emru
        Zy6u9zUc8lhW6wOz+PwoGrknA
X-Received: by 2002:ad4:4673:: with SMTP id z19mr14372836qvv.60.1605124763414;
        Wed, 11 Nov 2020 11:59:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUcZStWcSPU8GFgkNP6BEiNh0tQ4sbZVHVIUHiRmmdkCJXdwgNZEdbAhv41PRh0pVlaHGmvw==
X-Received: by 2002:ad4:4673:: with SMTP id z19mr14372815qvv.60.1605124763163;
        Wed, 11 Nov 2020 11:59:23 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-196.dsl.bell.ca. [174.93.89.196])
        by smtp.gmail.com with ESMTPSA id q70sm3213742qka.87.2020.11.11.11.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:59:22 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:59:20 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v4 2/2] mm: prevent gup_fast from racing with COW during
 fork
Message-ID: <20201111195920.GO26342@xz-x1>
References: <0-v4-908497cf359a+4782-gup_fork_jgg@nvidia.com>
 <2-v4-908497cf359a+4782-gup_fork_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2-v4-908497cf359a+4782-gup_fork_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 07:44:09PM -0400, Jason Gunthorpe wrote:
> Since commit 70e806e4e645 ("mm: Do early cow for pinned pages during
> fork() for ptes") pages under a FOLL_PIN will not be write protected
> during COW for fork. This means that pages returned from
> pin_user_pages(FOLL_WRITE) should not become write protected while the pin
> is active.
> 
> However, there is a small race where get_user_pages_fast(FOLL_PIN) can
> establish a FOLL_PIN at the same time copy_present_page() is write
> protecting it:
> 
>         CPU 0                             CPU 1
>    get_user_pages_fast()
>     internal_get_user_pages_fast()
>                                        copy_page_range()
>                                          pte_alloc_map_lock()
>                                            copy_present_page()
>                                              atomic_read(has_pinned) == 0
> 					     page_maybe_dma_pinned() == false
>      atomic_set(has_pinned, 1);
>      gup_pgd_range()
>       gup_pte_range()
>        pte_t pte = gup_get_pte(ptep)
>        pte_access_permitted(pte)
>        try_grab_compound_head()
>                                              pte = pte_wrprotect(pte)
> 	                                     set_pte_at();
>                                          pte_unmap_unlock()
>       // GUP now returns with a write protected page
> 
> The first attempt to resolve this by using the write protect caused
> problems (and was missing a barrrier), see commit f3c64eda3e50 ("mm: avoid
> early COW write protect games during fork()")
> 
> Instead wrap copy_p4d_range() with the write side of a seqcount and check
> the read side around gup_pgd_range(). If there is a collision then
> get_user_pages_fast() fails and falls back to slow GUP.
> 
> Slow GUP is safe against this race because copy_page_range() is only
> called while holding the exclusive side of the mmap_lock on the src
> mm_struct.
> 
> Fixes: f3c64eda3e50 ("mm: avoid early COW write protect games during fork()")
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/r/CAHk-=wi=iCnYCARbPGjkVJu9eyYeZ13N64tZYLdOB8CP5Q_PLw@mail.gmail.com
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

