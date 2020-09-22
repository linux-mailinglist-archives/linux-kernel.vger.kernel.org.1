Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBDE2741BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 14:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgIVMFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 08:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgIVMFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 08:05:12 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4094FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 05:05:12 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id y11so15252781qtn.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 05:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WzIXZoR0LdxywGLZGuzcb6+7NezKMV4HLOr+hyN4ucs=;
        b=VTAh7UaQGkPZN3uDhiLIaUvDm4ZZs64f0cMpY/SCi98BQkfrsmaqHNbHd7oQ2mMdpL
         7p9OcmrhyX3pEjvnjzbXtVBO1uL/Om0Hqu4NdRijJJm9gBOGD/pkL1ZURCJg7dITo5fX
         rGKFyOLqLAxpf+DVz78tU/TCE5eq162vlAPwoGH5eon2DhAR8aBBjMcdMCAkVKEhP3cC
         awoGK/hsI/8snERu8TKTcyNIMmsxrisIaGqlbCtTqOBLPA3Qe3cAmUwHaE4EWUUqQuvd
         Zn7YC37CfFp0rRvwRDo9hRQiQPhebUtU4Y6RoHWp3d6ue8HUlXXKy6+7dbfvChbTFCbR
         3sBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WzIXZoR0LdxywGLZGuzcb6+7NezKMV4HLOr+hyN4ucs=;
        b=KC/Pxlutkv8nPDlgdcqiBtj8b/xPeCoG3qM8SEyB1mYzt1e9iKe5OWlBoja32pWyZD
         ef955tsZHYDlS0eo6OcE9Lk1ZdubJr099BaEb7WPMPU/ZaeKaNCNyp983ss2qk2akXS2
         oy5hoDQ7BwYcbVGuz1RmpqwX2vc4rqADWwTfZwwbDYHWV9zFtPke9j4whA+25tUPwx7d
         T8MEDqV6yISMYXhRkubFO/EhIz1tObXBag7sy7haSRPWQZho21H1mvX2kooKIgN4CQFL
         LF7hGwQU8FKOJJqHSZsQblOShYY850KcqE9F6/jZNU8bNqJ4sn5cC9pL80z5rBoNfm7v
         J5mQ==
X-Gm-Message-State: AOAM531aLcmvHkofg49ERoBhz0gPxU8e7F2w/6Qc8Sg3eJEO1fEBL5uU
        bBMr+U3PzZPBhXvCeIhpNYn9iw==
X-Google-Smtp-Source: ABdhPJxsOhM2mvGEoU3xAot9iOtGbxLSdtavFLJAVYOGRNqz0wSzFm/1MyNUvG+rSkqoellji8P6nA==
X-Received: by 2002:aed:2c06:: with SMTP id f6mr4338295qtd.362.1600776311411;
        Tue, 22 Sep 2020 05:05:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id m10sm12533625qti.46.2020.09.22.05.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 05:05:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kKh2f-0030mM-CZ; Tue, 22 Sep 2020 09:05:05 -0300
Date:   Tue, 22 Sep 2020 09:05:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 5/5] mm/thp: Split huge pmds/puds if they're pinned when
 fork()
Message-ID: <20200922120505.GH8409@ziepe.ca>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212031.25233-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921212031.25233-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 05:20:31PM -0400, Peter Xu wrote:
> Pinned pages shouldn't be write-protected when fork() happens, because follow
> up copy-on-write on these pages could cause the pinned pages to be replaced by
> random newly allocated pages.
> 
> For huge PMDs, we split the huge pmd if pinning is detected.  So that future
> handling will be done by the PTE level (with our latest changes, each of the
> small pages will be copied).  We can achieve this by let copy_huge_pmd() return
> -EAGAIN for pinned pages, so that we'll fallthrough in copy_pmd_range() and
> finally land the next copy_pte_range() call.
> 
> Huge PUDs will be even more special - so far it does not support anonymous
> pages.  But it can actually be done the same as the huge PMDs even if the split
> huge PUDs means to erase the PUD entries.  It'll guarantee the follow up fault
> ins will remap the same pages in either parent/child later.
> 
> This might not be the most efficient way, but it should be easy and clean
> enough.  It should be fine, since we're tackling with a very rare case just to
> make sure userspaces that pinned some thps will still work even without
> MADV_DONTFORK and after they fork()ed.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
>  mm/huge_memory.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 7ff29cc3d55c..c40aac0ad87e 100644
> +++ b/mm/huge_memory.c
> @@ -1074,6 +1074,23 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  
>  	src_page = pmd_page(pmd);
>  	VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
> +
> +	/*
> +	 * If this page is a potentially pinned page, split and retry the fault
> +	 * with smaller page size.  Normally this should not happen because the
> +	 * userspace should use MADV_DONTFORK upon pinned regions.  This is a
> +	 * best effort that the pinned pages won't be replaced by another
> +	 * random page during the coming copy-on-write.
> +	 */
> +	if (unlikely(READ_ONCE(src_mm->has_pinned) &&
> +		     page_maybe_dma_pinned(src_page))) {
> +		pte_free(dst_mm, pgtable);
> +		spin_unlock(src_ptl);
> +		spin_unlock(dst_ptl);
> +		__split_huge_pmd(vma, src_pmd, addr, false, NULL);
> +		return -EAGAIN;
> +	}

Not sure why, but the PMD stuff here is not calling is_cow_mapping()
before doing the write protect. Seems like it might be an existing
bug?

In any event, the has_pinned logic shouldn't be used without also
checking is_cow_mapping(), so it should be added to that test. Same
remarks for PUD

Jason
