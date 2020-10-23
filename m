Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9832978AA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 23:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755334AbgJWVJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 17:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755323AbgJWVJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 17:09:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB443C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 14:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=URKMB+l8lr+9mNV3UVoDcLLnTLfY/moWX1npvKJgs6g=; b=h1zpfDEgO90CZITyuoe0+XKlAq
        TnHTtX9Vne+elsmCyPlv4dvH419GP8HJgSvDu3d94ciTv985sCImVUZBEeL0vZqhVjHAzUjULo52q
        sCXqE7ziAOp8jR7OaSIIKh7yie11M7fYPPhtW3xc/oAykCJft7oTZ7Xl9uPsO8nbIT66/gj1++x4O
        taKLmy9FaBXu9Yeq8J0GUYMJceOOLFh+DQMbsiYQWhC1ZTH1jbnzdSC4VWha/lvYbSc9WvyMau3vP
        MLlAoaXg7e8952+Dv7X/kvELtT9vFDfDJHj9y5MV/vvnD/kwxmJXV19CQ7RHrmHj5KvJeptTbc7mH
        3OC1Ml9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kW4Jb-0002Lv-VJ; Fri, 23 Oct 2020 21:09:36 +0000
Date:   Fri, 23 Oct 2020 22:09:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Hugh Dickins <hughd@google.com>, Yu Xu <xuyu@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm,thp,shmem: limit shmem THP alloc gfp_mask
Message-ID: <20201023210935.GG20115@casper.infradead.org>
References: <20201023164708.5842f3fb@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023164708.5842f3fb@imladris.surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 04:47:08PM -0400, Rik van Riel wrote:
> +++ b/include/linux/gfp.h
> @@ -614,6 +614,8 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask);
>  extern void pm_restrict_gfp_mask(void);
>  extern void pm_restore_gfp_mask(void);
>  
> +extern gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma);

Without the types, the name of this function makes me think it allocates
something.  Like alloc_hugepage_vma() does.  With the types, it's obvious
that it gets the gfpmask.  Can this patch rename it, perhaps to

gfp_t vma_thp_gfp_mask(struct vm_area_struct *vma);

(hugepage is also ambiguous because it might be for hugetlbfs and we use,
eg, mapping_gfp_mask, not mapping_gfpmask).

