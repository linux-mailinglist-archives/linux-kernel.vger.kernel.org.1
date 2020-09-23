Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646CD275CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgIWQGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36564 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbgIWQGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600877199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g9MGzjQTQMPnRUsSx/lmVQbkvLVRsS27fhyulwST0XU=;
        b=TUj/cy7NBJlgNMvw4MaJHdLGrwtbTfXnOziWsf4f1JcY45iGhJzzQwJ6TzRhpyEUC0uN2T
        +4D0GLGQeFQ2GEx1MrF5l8xZKouYGwKs2X8v8sCOdpOrDFap0y0oQL/6A4FBqXXAt+ZzQb
        blC55qMO//sC+wQdg8tR3RVJEO/ExVU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-e5o_p2JpN0WTa4fTqU-reg-1; Wed, 23 Sep 2020 12:06:37 -0400
X-MC-Unique: e5o_p2JpN0WTa4fTqU-reg-1
Received: by mail-qv1-f71.google.com with SMTP id v14so344947qvq.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 09:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g9MGzjQTQMPnRUsSx/lmVQbkvLVRsS27fhyulwST0XU=;
        b=DbSfgY93ztR2gQOAvrGZt6VdzT6bc15zKKaT/nik3chsE0yEtsmrsiuQQdqPPTmf/T
         sWKLf+nIoChu05S+/646Cu2/M2JQ1GZTk5fuEPzvvlGvOvxiKOyVx5QC2cczoQSgmHj6
         MBIQeprONF231WfL2WJtA0keQwYVpHoQxL1ZPxIXVOyL5qc9cQrBXm7N0sG/mao8vnj/
         GismYyIVh9Y4lA6VN8q0dyPVwIwiPQca8d5IBAhUK2mUU546I2we0Oo35UHG8YK7yAqY
         ycO05YEwcv4vmpzWZIT9QSEnRAD9wDSLPU/pkkiIlcq0EE3Ep+fmS7j2AV9gANVXxhhm
         DPSw==
X-Gm-Message-State: AOAM531dq8tz8wR8/wN1fSRj4YaJHqHHlqe29z20RH2MAWgHpe4DhjlI
        bQIsbHYiZ/RXLzmmObH7IA4Yc9vmMATbBFZqMbnTlv2WCwC83iyZcbr9MoZ/7iqd8zUSQDI50SW
        aTw2OQKxHzAypvgrTgwjaZckU
X-Received: by 2002:a37:6786:: with SMTP id b128mr597723qkc.396.1600877196924;
        Wed, 23 Sep 2020 09:06:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMhpSDZv71ipNi3jgBBqCnCadJV34DOqLzVrH9WYRv604yXJamPJEKzMb/swh825Lz8wGJVw==
X-Received: by 2002:a37:6786:: with SMTP id b128mr597698qkc.396.1600877196646;
        Wed, 23 Sep 2020 09:06:36 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id e13sm108882qtr.85.2020.09.23.09.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 09:06:35 -0700 (PDT)
Date:   Wed, 23 Sep 2020 12:06:34 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 5/5] mm/thp: Split huge pmds/puds if they're pinned when
 fork()
Message-ID: <20200923160634.GB79898@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212031.25233-1-peterx@redhat.com>
 <5e594e71-537f-3e9f-85b6-034b7f5fedbe@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e594e71-537f-3e9f-85b6-034b7f5fedbe@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 11:41:16PM -0700, John Hubbard wrote:
> On 9/21/20 2:20 PM, Peter Xu wrote:
> ...
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 7ff29cc3d55c..c40aac0ad87e 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1074,6 +1074,23 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> >   	src_page = pmd_page(pmd);
> >   	VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
> > +
> > +	/*
> > +	 * If this page is a potentially pinned page, split and retry the fault
> > +	 * with smaller page size.  Normally this should not happen because the
> > +	 * userspace should use MADV_DONTFORK upon pinned regions.  This is a
> > +	 * best effort that the pinned pages won't be replaced by another
> > +	 * random page during the coming copy-on-write.
> > +	 */
> > +	if (unlikely(READ_ONCE(src_mm->has_pinned) &&
> > +		     page_maybe_dma_pinned(src_page))) {

[...]

> > +		pte_free(dst_mm, pgtable);
> > +		spin_unlock(src_ptl);
> > +		spin_unlock(dst_ptl);
> > +		__split_huge_pmd(vma, src_pmd, addr, false, NULL);
> > +		return -EAGAIN;
> > +	}
> 
> 
> Why wait until we are so deep into this routine to detect this and unwind?
> It seems like if you could do a check near the beginning of this routine, and
> handle it there, with less unwinding? In fact, after taking only the src_ptl,
> the check could be made, right?

Because that's where we've fetched the page from the pmd so I can directly
reference src_page.  Also I think at least I need to check against swp entries?
So it seems still easier to keep it here, considering it's an unlikely path.

Thanks,

-- 
Peter Xu

