Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CF62745D3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgIVP4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVP4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:56:14 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D9BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:56:13 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c62so6317858qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IYRTnlo90GNwIVVFhycLDwsrTtG0682e9ZAFQMaySN4=;
        b=l7hoQh1ejgd7aceitowuvAcgWnfb6V3IVadFJbkyLd0RsGpVIZrRAmC4qrxxiLU9mR
         4VjBXw1UoI/QGOkYjE5oY+xdYlhNSs2jybizOpABLiKM6Wy7cuILDhq6W3lVg1HhneDh
         cNQksP8240Cm61ESg3I4jkLAXUjzRpb7wmx05Fk1rofGFheST7e2Fio35+trXpK6RdOZ
         fFPFTXnEYuzAqgdPAKmx+eMDGc0Or6jRk9J+c0FIe4CIRucI+VceaTitnmv58UBTHOrO
         yoAgQnha7oLMAKNQ7vtfmn6xsIejFx6kw4yTRqISvj1iOjfuBLwgtS31BiM74C4BP5Rw
         Ni8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IYRTnlo90GNwIVVFhycLDwsrTtG0682e9ZAFQMaySN4=;
        b=RBEpWLB6z9HrgYX0pz6imm90WkoKbkSmgRVs7MmVSHXAFKew4oKvwnVH7vGtFgL59V
         Uac+cMOjOLJxSIdOIZkKNO5yon8oywPCWO9dfnWlFWhtqxCdbiguGPpo69OmATO1ViyR
         v3xYGa31uYgilX44iqlhWmDTJX47BlQOJl+oN/BtgT/0vLfdQSL04WEUl8VIAyaU3Qor
         S0GTwpTql5Npnv9wiNvGbyTaOWuwNHSMSv9Y6FMDQpVpoGa3A2ZhWEVLYf5ggdyKUZge
         gQTG9mm3NCUZ4+UGNcDwp7/Fz0fSy0yIq30PMPhN/uXXwzl4ZzaQaWwEgmx/J47X51cE
         lQqQ==
X-Gm-Message-State: AOAM532TwZObDWfk1iHGFDZNClNCg115QwK7gY8pQTzQQsAs6K5BQq87
        WJ5LoNzc4/J2dtHMefJ2+m6T4w==
X-Google-Smtp-Source: ABdhPJxiNGLGozHFwhcJgJgUPSubcn3CK125SBHmwyhXN/SmG+epVQJjoF+wjAJP3DRk6zkVVubwOw==
X-Received: by 2002:a37:a414:: with SMTP id n20mr5531835qke.332.1600790166390;
        Tue, 22 Sep 2020 08:56:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 7sm11768068qkc.73.2020.09.22.08.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 08:56:05 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kKkeC-0034WT-Nw; Tue, 22 Sep 2020 12:56:04 -0300
Date:   Tue, 22 Sep 2020 12:56:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
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
Message-ID: <20200922155604.GA731578@ziepe.ca>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-2-peterx@redhat.com>
 <CAG48ez0o+yBpYdzR_-bU3A0nrpzXyM+c+Yk=ZtOZ92qe5x0izA@mail.gmail.com>
 <20200921223004.GB19098@xz-x1>
 <CAG48ez25krKvd5hWqn0R3w5_AAPVWtWKofiOHEfKaB2+YoDoPw@mail.gmail.com>
 <20200922115436.GG8409@ziepe.ca>
 <20200922142802.GC19098@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922142802.GC19098@xz-x1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 10:28:02AM -0400, Peter Xu wrote:
> On Tue, Sep 22, 2020 at 08:54:36AM -0300, Jason Gunthorpe wrote:
> > On Tue, Sep 22, 2020 at 12:47:11AM +0200, Jann Horn wrote:
> > > On Tue, Sep 22, 2020 at 12:30 AM Peter Xu <peterx@redhat.com> wrote:
> > > > On Mon, Sep 21, 2020 at 11:43:38PM +0200, Jann Horn wrote:
> > > > > On Mon, Sep 21, 2020 at 11:17 PM Peter Xu <peterx@redhat.com> wrote:
> > > > > > (Commit message collected from Jason Gunthorpe)
> > > > > >
> > > > > > Reduce the chance of false positive from page_maybe_dma_pinned() by keeping
> > > > > > track if the mm_struct has ever been used with pin_user_pages(). mm_structs
> > > > > > that have never been passed to pin_user_pages() cannot have a positive
> > > > > > page_maybe_dma_pinned() by definition.
> > > > >
> > > > > There are some caveats here, right? E.g. this isn't necessarily true
> > > > > for pagecache pages, I think?
> > > >
> > > > Sorry I didn't follow here.  Could you help explain with some details?
> > > 
> > > The commit message says "mm_structs that have never been passed to
> > > pin_user_pages() cannot have a positive page_maybe_dma_pinned() by
> > > definition"; but that is not true for pages which may also be mapped
> > > in a second mm and may have been passed to pin_user_pages() through
> > > that second mm (meaning they must be writable over there and not
> > > shared with us via CoW).
> > 
> > The message does need a few more words to explain this trick can only
> > be used with COW'able pages.
> >  
> > > Process A:
> > > 
> > > fd_a = open("/foo/bar", O_RDWR);
> > > mapping_a = mmap(NULL, 0x1000, PROT_READ|PROT_WRITE, MAP_SHARED, fd_a, 0);
> > > pin_user_pages(mapping_a, 1, ...);
> > > 
> > > Process B:
> > > 
> > > fd_b = open("/foo/bar", O_RDONLY);
> > > mapping_b = mmap(NULL, 0x1000, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd_b, 0);
> > > *(volatile char *)mapping_b;
> > > 
> > > At this point, process B has never called pin_user_pages(), but
> > > page_maybe_dma_pinned() on the page at mapping_b would return true.
> > 
> > My expectation is the pin_user_pages() should have already broken the
> > COW for the MAP_PRIVATE, so process B should not have a
> > page_maybe_dma_pinned()
> 
> When process B maps with PROT_READ only (w/o PROT_WRITE) then it seems the same
> page will be mapped.

I thought MAP_PRIVATE without PROT_WRITE was nonsensical, it only has
meaning for writes initiated by the mapping. MAP_SHARED/PROT_READ is
the same behavior on Linux, IIRC.

But, yes, you certainly can end up with B having
page_maybe_dma_pinned() pages in shared VMA, just not in COW'able
mappings.

> I think I get the point from Jann now.  Maybe it's easier I just remove the
> whole "mm_structs that have never been passed to pin_user_pages() cannot have a
> positive page_maybe_dma_pinned() by definition" sentence if that's misleading,
> because the rest seem to be clear enough on what this new field is used for.

"for COW" I think is still the important detail here, see for instance
my remark on the PUD/PMD splitting where it is necessary to test for
cow before using this.

Perhaps we should call it "has_pinned_for_cow" to place emphasis on
this detail? Due to the shared pages issue It really doesn't have any
broader utility, eg for file back pages or otherwise.

Jason
