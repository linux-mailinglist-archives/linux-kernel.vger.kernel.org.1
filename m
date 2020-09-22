Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4CF274441
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgIVO2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:28:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31255 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726692AbgIVO2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600784887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4KeBzI9+ks+mK6pPN0E4gOcdT+Ebd4ElJn6Z0ui1YyE=;
        b=Ktw6SPuG+ULdJiWy45IT2K0fXW7v3YEPf3p7wor5wRilZLRKY6pzxs39gEEJ2wtgbNIvOK
        pZdRpUgQ0AbHOnfg5PatSa3H0ClqA7XP7WXDg5P6U6MP8Dvf6DnupPVEzTp5i4CFfRn6kM
        Yozv9pEaLs4IoenUJizlCirTQBlpOG8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-rpJ33FncNQKvPN450kSvZA-1; Tue, 22 Sep 2020 10:28:06 -0400
X-MC-Unique: rpJ33FncNQKvPN450kSvZA-1
Received: by mail-qv1-f69.google.com with SMTP id p20so11765482qvl.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 07:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4KeBzI9+ks+mK6pPN0E4gOcdT+Ebd4ElJn6Z0ui1YyE=;
        b=HntuYmO7Mg0V352gsKACEWVAUClUPMWLONeOTZtQJUh8ntRU7hpdkRzn4hAh+K05Xk
         /oRaS18DFJeqvIyhiSdHw0/cTtC606QC56y3tgtO5nVnxbx2igiuM0/zM9+T9atzxMO+
         BucBwpQOY3msLw05MOfntA3/nv0l2RuN4mggPwxBTd0jnmlTvpNP55mGSx5wNKg//MCb
         xq5hlBEFURICUOOJZnK2fWoC/aw4uvViwYedWG1RPZl8MZFLKuNKyLx5mI8aORFrnXT9
         Giy7vPblaSXEQxclz8etUeKAbsOhhCDGzt69xG6YeG3A1lBKQrjCehbaJ6dzfo5TIxPN
         Ygkw==
X-Gm-Message-State: AOAM532bFA51ozzwB+iOhochBnXZaOxhzEruk/CgQ/JEntERHEp7Hbq3
        QOmTYlI8igpBX+7kTsfLdMqvKeyb2WV91CiaXgKMnoaFN8O1hA2vapo2fkycADtU7DUFqV7zHcY
        Aashsx1TX3qrRoxv9/Png5Ls6
X-Received: by 2002:a37:5c1:: with SMTP id 184mr4440853qkf.99.1600784885581;
        Tue, 22 Sep 2020 07:28:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylHcnqrRD1BI8HRprNv69q7Oj4TDomf93YpD0/nIEvv8cyk8WrP0pxxrObzx/B0MHlffDvEA==
X-Received: by 2002:a37:5c1:: with SMTP id 184mr4440815qkf.99.1600784885209;
        Tue, 22 Sep 2020 07:28:05 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id m196sm12167980qke.87.2020.09.22.07.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 07:28:04 -0700 (PDT)
Date:   Tue, 22 Sep 2020 10:28:02 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jann Horn <jannh@google.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Message-ID: <20200922142802.GC19098@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-2-peterx@redhat.com>
 <CAG48ez0o+yBpYdzR_-bU3A0nrpzXyM+c+Yk=ZtOZ92qe5x0izA@mail.gmail.com>
 <20200921223004.GB19098@xz-x1>
 <CAG48ez25krKvd5hWqn0R3w5_AAPVWtWKofiOHEfKaB2+YoDoPw@mail.gmail.com>
 <20200922115436.GG8409@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922115436.GG8409@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 08:54:36AM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 22, 2020 at 12:47:11AM +0200, Jann Horn wrote:
> > On Tue, Sep 22, 2020 at 12:30 AM Peter Xu <peterx@redhat.com> wrote:
> > > On Mon, Sep 21, 2020 at 11:43:38PM +0200, Jann Horn wrote:
> > > > On Mon, Sep 21, 2020 at 11:17 PM Peter Xu <peterx@redhat.com> wrote:
> > > > > (Commit message collected from Jason Gunthorpe)
> > > > >
> > > > > Reduce the chance of false positive from page_maybe_dma_pinned() by keeping
> > > > > track if the mm_struct has ever been used with pin_user_pages(). mm_structs
> > > > > that have never been passed to pin_user_pages() cannot have a positive
> > > > > page_maybe_dma_pinned() by definition.
> > > >
> > > > There are some caveats here, right? E.g. this isn't necessarily true
> > > > for pagecache pages, I think?
> > >
> > > Sorry I didn't follow here.  Could you help explain with some details?
> > 
> > The commit message says "mm_structs that have never been passed to
> > pin_user_pages() cannot have a positive page_maybe_dma_pinned() by
> > definition"; but that is not true for pages which may also be mapped
> > in a second mm and may have been passed to pin_user_pages() through
> > that second mm (meaning they must be writable over there and not
> > shared with us via CoW).
> 
> The message does need a few more words to explain this trick can only
> be used with COW'able pages.
>  
> > Process A:
> > 
> > fd_a = open("/foo/bar", O_RDWR);
> > mapping_a = mmap(NULL, 0x1000, PROT_READ|PROT_WRITE, MAP_SHARED, fd_a, 0);
> > pin_user_pages(mapping_a, 1, ...);
> > 
> > Process B:
> > 
> > fd_b = open("/foo/bar", O_RDONLY);
> > mapping_b = mmap(NULL, 0x1000, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd_b, 0);
> > *(volatile char *)mapping_b;
> > 
> > At this point, process B has never called pin_user_pages(), but
> > page_maybe_dma_pinned() on the page at mapping_b would return true.
> 
> My expectation is the pin_user_pages() should have already broken the
> COW for the MAP_PRIVATE, so process B should not have a
> page_maybe_dma_pinned()

When process B maps with PROT_READ only (w/o PROT_WRITE) then it seems the same
page will be mapped.

I think I get the point from Jann now.  Maybe it's easier I just remove the
whole "mm_structs that have never been passed to pin_user_pages() cannot have a
positive page_maybe_dma_pinned() by definition" sentence if that's misleading,
because the rest seem to be clear enough on what this new field is used for.

Thanks,

-- 
Peter Xu

