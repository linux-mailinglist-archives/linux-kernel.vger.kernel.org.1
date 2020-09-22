Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA0D274563
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgIVPgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbgIVPgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600788978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9qUAnZcDPIOTE8chUJkXUfmB3Qkup6kzfAgtjloNLEI=;
        b=D7SpHD/MSDqyl/Isg0aKiGQhr8iongeuGCxvzAQKchoW0S9P8Itvd6/layAOIXHtfrK3+Y
        5TqGzpYKGQ0KwvuWu0kHwLr8Y3rUjadrMlovyDZIMk5mYB4oItkQjD6wk5NWo/bIHZpiym
        N3plq7JoDxjo/s4c0uhn4hXK0+FkiFQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-yy8jg3zsMByaHDUKirfgmw-1; Tue, 22 Sep 2020 11:36:16 -0400
X-MC-Unique: yy8jg3zsMByaHDUKirfgmw-1
Received: by mail-qt1-f199.google.com with SMTP id e6so16305949qtg.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9qUAnZcDPIOTE8chUJkXUfmB3Qkup6kzfAgtjloNLEI=;
        b=ldtbYkJVclAMOmmxITuZixF+g/dFkytmmHbIg1Tn6I96IwlNxuyIh1eG/hHB2cU+YH
         k+lbE9lSmd6U/NSRVlL+XwVlO5az5f+VXasNtLulLvaU1hDgb3pBOQYHVx+LNet9/FQ4
         TiLv1MS+ebxz0/WoEOiga03nZnLQLqMJrHBaX9fCSUFd7JulEusKlSVO0dG0Z78eGMlB
         tjjGzLUeDMSGrtkQWIcYA4XRMobYz/7N1lTAU5tGXHLZJsng2KqWTN8QJF8WzimQCxoQ
         QJzZYtmwJqOU3l22PM32bXb6Vc+YI0u+V32gCvSMJ98MiDNlL9vw0aexZGZ6rst5pt3v
         57Fw==
X-Gm-Message-State: AOAM532iV+i3dp5eRazXr4D/yo4J7wntyxpBuTsXZgh1i7w/vEYJQLc/
        f8WLIdQAzCgfbqy+3qIaOsxB3Y1y9b8dfaHCY35ZHDuatWY0gPeeb7ML4h7chXYKxT+Y3bAKHrB
        Hd2OG9Vg+f40YyOQUCoY7sWd4
X-Received: by 2002:a37:8883:: with SMTP id k125mr5113342qkd.387.1600788975030;
        Tue, 22 Sep 2020 08:36:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3nN2tbkiA28XqYXkWFBSdDPKBDK4RDcM0qhYUN5Ac6FIwGRsUoFXx4b9P9kPZ3JzBgvSuyw==
X-Received: by 2002:a37:8883:: with SMTP id k125mr5113311qkd.387.1600788974750;
        Tue, 22 Sep 2020 08:36:14 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id v16sm11433232qkg.37.2020.09.22.08.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 08:36:14 -0700 (PDT)
Date:   Tue, 22 Sep 2020 11:36:12 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 3/5] mm: Rework return value for copy_one_pte()
Message-ID: <20200922153612.GF19098@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-4-peterx@redhat.com>
 <20200922100840.GA11679@redhat.com>
 <20200922101815.GB11679@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922101815.GB11679@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 12:18:16PM +0200, Oleg Nesterov wrote:
> On 09/22, Oleg Nesterov wrote:
> >
> > On 09/21, Peter Xu wrote:
> > >
> > > @@ -866,13 +877,18 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> > >  	pte_unmap_unlock(orig_dst_pte, dst_ptl);
> > >  	cond_resched();
> > >
> > > -	if (entry.val) {
> > > -		if (add_swap_count_continuation(entry, GFP_KERNEL) < 0)
> > > +	switch (copy_ret) {
> > > +	case COPY_MM_SWAP_CONT:
> > > +		if (add_swap_count_continuation(data.entry, GFP_KERNEL) < 0)
> > >  			return -ENOMEM;
> > > -		progress = 0;
> > > +		break;
> >
> > Note that you didn't clear copy_ret, it is still COPY_MM_SWAP_CONT,
> >
> > > +	default:
> > > +		break;
> > >  	}
> > > +
> > >  	if (addr != end)
> > >  		goto again;
> >
> > After that the main loop can stop again because of need_resched(), and
> > in this case add_swap_count_continuation(data.entry) will be called again?
> 
> No, this is not possible, copy_one_pte() should be called at least once,
> progress = 0 before restart. Sorry for noise.

Oh wait, I think you're right... when we get a COPY_MM_SWAP_CONT, goto "again",
then if there're 32 pte_none() ptes _plus_ an need_resched(), then we might
reach again at the same add_swap_count_continuation() with the same swp entry.

However since I didn't change this logic in this patch, it probably means this
bug is also in the original code before this series...  I'm thinking maybe I
should prepare a standalone patch to clear the swp_entry_t and cc stable.

Thanks,

-- 
Peter Xu

