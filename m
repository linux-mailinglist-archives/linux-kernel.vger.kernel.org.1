Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B7026E4F8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgIQTEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36396 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726598AbgIQTDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 15:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600369419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=werZBEA6aQYY57n+G7CDD2kpsyT+DQ1TWdsoiO3KsTk=;
        b=aRxotHNlZRv+xdPlVocKzzxCi3mkgvhN5XkEeaJp2/Kts+BMTZ5EMJRO6lTt8BcD7DxiGj
        yPJaueqRLvx2agZgjY4OY0Y2ODOJgAYI6xM9gCJL171KiOL6Iby0m1oSSGhwPQWCx90xAq
        I97erkXaHGp8VUkeVtMXIw3d2Je3gRw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-VgTHY9PnOpuSrGqjNwpciA-1; Thu, 17 Sep 2020 15:03:35 -0400
X-MC-Unique: VgTHY9PnOpuSrGqjNwpciA-1
Received: by mail-qv1-f70.google.com with SMTP id dj20so2120553qvb.23
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 12:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=werZBEA6aQYY57n+G7CDD2kpsyT+DQ1TWdsoiO3KsTk=;
        b=onaXMrT5WTDm/zgxAFp3g87Akl1uc2mDYMl9TfxsH4MSXCB3BdZ+EjjUc2pU/CDbGr
         Fi3MOR6CyoUcnxhMVFDwWQjQK9stgktcfPXamYZ9S+kpvApUySsEBEaaxSCw3vxsMUir
         B1BDcMOnhD/DzwDRrBBM+fpi6HFr1bTI9YBH+hshr9qbLcflICWUHpTWq9XVV600QwoH
         X/NeAsPbxQn4neZDwJvTGp09g5T/e+8/y11VYcVdAL9BNp6zESFStp27dT6e7vr5K819
         sdc2T8b7JoJbj/Neg+b0HUIDjMYDiH+zoj9qA37ALP/oddGs21J4Wd/CCrg8EtlZfJ+K
         aTlQ==
X-Gm-Message-State: AOAM5305YWFNs+EeuOZVjTaLg//imPXj8TNoalsSfJSg9bCnFkgLjrt/
        79QCsawxSkYe5tLbGXpXyt4GrS2KCKA2I88FBMbnIhZp67J5pUFV1Md3jpT7Ouy26OeKkXT07KX
        AjrycToe0zRBFoJkcPcMjwrf0
X-Received: by 2002:ac8:3261:: with SMTP id y30mr29831090qta.242.1600369415120;
        Thu, 17 Sep 2020 12:03:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMcFp/ZC2dSEfUBEXD6VSFje71VAmHUeXv1Bo/4H1yZr0fGe/3WGTbE9mhvRnP9pBE7wVyLw==
X-Received: by 2002:ac8:3261:: with SMTP id y30mr29831049qta.242.1600369414812;
        Thu, 17 Sep 2020 12:03:34 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id g25sm423162qto.47.2020.09.17.12.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 12:03:33 -0700 (PDT)
Date:   Thu, 17 Sep 2020 15:03:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <20200917190332.GB133226@xz-x1>
References: <20200915191346.GD2949@xz-x1>
 <20200915193838.GN1221970@ziepe.ca>
 <20200915213330.GE2949@xz-x1>
 <20200915232238.GO1221970@ziepe.ca>
 <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <20200917181411.GA133226@xz-x1>
 <CAHk-=wgMVPAhD7C24ipe03+MScgp6F=zMS-roOznvxJ+hOGfSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgMVPAhD7C24ipe03+MScgp6F=zMS-roOznvxJ+hOGfSA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:26:01AM -0700, Linus Torvalds wrote:
> On Thu, Sep 17, 2020 at 11:14 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > In my humble opinion, the real solution is still to use MADV_DONTFORK properly
> > so we should never share the DMA pages with others when we know the fact.
> 
> Is this all just because somebody does a fork() after doing page pinning?
> 
> If so, I feel this should be trivially fixed in  copy_one_pte().
> That's where we currently do
> 
>         /*
>          * If it's a COW mapping, write protect it both
>          * in the parent and the child
>          */
>         if (is_cow_mapping(vm_flags) && pte_write(pte)) {
>                 ptep_set_wrprotect(src_mm, addr, src_pte);
>                 pte = pte_wrprotect(pte);
>         }
> 
> and I feel that that is where we could just change the code to do a
> COW event for pinned pages (and *not* mark the parent write protected,
> since the parent page now isn't a COW page).
> 
> Because if that's the case that Jason is hitting, then I feel that
> really is the correct fix: make sure that the pinning action is
> meaningful.
> 
> As mentioned, I really think the whole (and only) point of page
> pinning is that it should keep the page locked in the page tables. And
> by "locked" I mean exactly that: not just present, but writable.
> 
> And then the "we never COW a pinned page" comes not from the COW code
> doing magic, but by it simply never becoming non-writable - because
> the page table entry is locked!

Looks reasonable to me.

The fork() should be slightly slower though, since we'll need to copy the data
for all the DMA buffers for each of the child processes, even if we should be
pretty sure those processes won't use these pages at all. But it seems a good
approach anyway if we care about the potential breakages in the userspace so
the breakage is turned into perf degrades, and if any userspace noticed such
perf degrade on fork() then people will probably remember to use MADV_DONTFORK
properly since afaict MADV_DONTFORK can remove this extra overhead..

Another side effect I can think of is that we'll bring some uncertainty to
fork() starting from when page_maybe_dma_pinned() is used, since it's sometimes
bogus (hpage_pincount_available()==false) so some COWs might be triggered
during fork() even when not necessary if we've got some normal pages with too
many refcounts (over GUP_PIN_COUNTING_BIAS).  But assuming that's not a big
deal since it should be extremely rare, or is it?..

-- 
Peter Xu

