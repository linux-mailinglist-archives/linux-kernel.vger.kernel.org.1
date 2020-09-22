Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378B1274515
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgIVPRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:17:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54310 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbgIVPRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600787863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=stngSWzZPetsvj++1tiyUoEccJXuMfV3PLP1Yk0w4TE=;
        b=BijKpcdNnp1TElmDJDvTziWXJk5Q9zVxSx8U6CMwMePgGNGYleCpF0Uk25naC+AWOmXfvV
        5y5bbsa0ihRm3S5orbPh+vEfH1zToXr9BsgheXRNI/85PnFxXkCDYXpzQDgpP9oc8Pd5bN
        G8zyJY+JEOkO1Y3uVRT40NXIMqyyjF8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-li7MeSfMOfGEOdHre-FCug-1; Tue, 22 Sep 2020 11:17:40 -0400
X-MC-Unique: li7MeSfMOfGEOdHre-FCug-1
Received: by mail-qv1-f72.google.com with SMTP id l1so11739125qvr.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=stngSWzZPetsvj++1tiyUoEccJXuMfV3PLP1Yk0w4TE=;
        b=TW9L2qbswqEdS5J2sei8SHQW4umQL8qwg/MshaVZu7b8XasaXeE5JPssuPYk50WJgh
         Q1g/+wezKISnufJIJzxo0okBgSFglfHZqZM57iA7iSdwiwSCU5iFDcIBrt4neNV5M0qB
         jrm1Kn/J2uMVToaLRTahua/9jDkJM0617Qe8roQfNBPBLZiNNVO7bFeDAsI2m8gvta2a
         axnjhVfAJlQAEJfDU4MsaDpuRUJVhR3yXG2XwtIoSaqkD3ew6vlmqGclHQ0OJ8GQMK2G
         j3Y4K7zXfIjQ+JG1kKcxtube3zhTDQDYRxXT3fJhI5EoftOB5yoe7Q0AQOyBwwqj920J
         xSwA==
X-Gm-Message-State: AOAM531bMSLR7bqbjWYqGCdIHTLkr6mwiX4FW1waTdMvPaUxz4QmZIRV
        RoRbG00db9TlpE/FaK7uGmkgMLCzeo4Wyrq036kUP+Lbyet6+8H0sETXqEx+hU24iIw31HZrtmm
        hInFqlYEwdH38JHSVXh/Nm/Z4
X-Received: by 2002:a37:8484:: with SMTP id g126mr4829941qkd.119.1600787859240;
        Tue, 22 Sep 2020 08:17:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNj2fsPXKI9avxY2ntwJeZST+nN/BfCLVpgNX+5WSlsWAV7mZfn+bK9EKVHF1t74PJCuFT0Q==
X-Received: by 2002:a37:8484:: with SMTP id g126mr4829914qkd.119.1600787858869;
        Tue, 22 Sep 2020 08:17:38 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id x197sm11883363qkb.17.2020.09.22.08.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 08:17:38 -0700 (PDT)
Date:   Tue, 22 Sep 2020 11:17:36 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Message-ID: <20200922151736.GD19098@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-2-peterx@redhat.com>
 <224908c1-5d0f-8e01-baa9-94ec2374971f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <224908c1-5d0f-8e01-baa9-94ec2374971f@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 04:53:38PM -0700, John Hubbard wrote:
> On 9/21/20 2:17 PM, Peter Xu wrote:
> > (Commit message collected from Jason Gunthorpe)
> > 
> > Reduce the chance of false positive from page_maybe_dma_pinned() by keeping
> 
> Not yet, it doesn't. :)  More:
> 
> > track if the mm_struct has ever been used with pin_user_pages(). mm_structs
> > that have never been passed to pin_user_pages() cannot have a positive
> > page_maybe_dma_pinned() by definition. This allows cases that might drive up
> > the page ref_count to avoid any penalty from handling dma_pinned pages.
> > 
> > Due to complexities with unpining this trivial version is a permanent sticky
> > bit, future work will be needed to make this a counter.
> 
> How about this instead:
> 
> Subsequent patches intend to reduce the chance of false positives from
> page_maybe_dma_pinned(), by also considering whether or not a page has
> even been part of an mm struct that has ever had pin_user_pages*()
> applied to any of its pages.
> 
> In order to allow that, provide a boolean value (even though it's not
> implemented exactly as a boolean type) within the mm struct, that is
> simply set once and never cleared. This will suffice for an early, rough
> implementation that fixes a few problems.
> 
> Future work is planned, to provide a more sophisticated solution, likely
> involving a counter, and *not* involving something that is set and never
> cleared.

This looks good, thanks.  Though I think Jason's version is good too (as long
as we remove the confusing sentence, that's the one starting with "mm_structs
that have never been passed... ").  Before I drop Jason's version, I think I'd
better figure out what's the major thing we missed so that maybe we can add
another paragraph.  E.g., "future work will be needed to make this a counter"
already means "involving a counter, and *not* involving something that is set
and never cleared" to me... Because otherwise it won't be called a counter..

> 
> > 
> > Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   include/linux/mm_types.h | 10 ++++++++++
> >   kernel/fork.c            |  1 +
> >   mm/gup.c                 |  6 ++++++
> >   3 files changed, 17 insertions(+)
> > 
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 496c3ff97cce..6f291f8b74c6 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -441,6 +441,16 @@ struct mm_struct {
> >   #endif
> >   		int map_count;			/* number of VMAs */
> > +		/**
> > +		 * @has_pinned: Whether this mm has pinned any pages.  This can
> > +		 * be either replaced in the future by @pinned_vm when it
> > +		 * becomes stable, or grow into a counter on its own. We're
> > +		 * aggresive on this bit now - even if the pinned pages were
> > +		 * unpinned later on, we'll still keep this bit set for the
> > +		 * lifecycle of this mm just for simplicity.
> > +		 */
> > +		int has_pinned;
> 
> I think this would be elegant as an atomic_t, and using atomic_set() and
> atomic_read(), which seem even more self-documenting that what you have here.
> 
> But it's admittedly a cosmetic point, combined with my perennial fear that
> I'm missing something when I look at a READ_ONCE()/WRITE_ONCE() pair. :)

Yeah but I hope I'm using it right.. :) I used READ_ONCE/WRITE_ONCE explicitly
because I think they're cheaper than atomic operations, (which will, iiuc, lock
the bus).

> 
> It's completely OK to just ignore this comment, but I didn't want to completely
> miss the opportunity to make it a tiny bit cleaner to the reader.

This can always become an atomic in the future, or am I wrong?  Actually if
we're going to the counter way I feel like it's a must.

Thanks,

-- 
Peter Xu

