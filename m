Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8614126AFAE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgIOViW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48051 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727708AbgIOVdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600205617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vUtjGsXiO4aMuU1NJWlF9eBDNUXAFp6DiLlJHWpBbCA=;
        b=YFQUaKtYcXnEhQOr/oxZGPMk1jFIQwcPXg2TfIv+OPx+WrcF/b5xQfqd6Kgk9qc+2IQRe+
        hRm2WRa/gNMIK0vsgLarjBXtsBkWQau17MQKDa4DlRF7jZ8eTJXjZrd4nc2UEzswZQ2olC
        98q2Q+30w6rdLjE9Pi4pgLz4N5pfrco=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-HrjJ8n3ePH-6Nrj6q89GGg-1; Tue, 15 Sep 2020 17:33:34 -0400
X-MC-Unique: HrjJ8n3ePH-6Nrj6q89GGg-1
Received: by mail-qt1-f197.google.com with SMTP id a14so4037020qtp.15
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vUtjGsXiO4aMuU1NJWlF9eBDNUXAFp6DiLlJHWpBbCA=;
        b=uM1j7RgC2UO7k1emgPB4cJoQ1ytIUtQgfox0syN1lnqhqriEUqb2EQ+EQAEIVdnBR0
         dd3aufUhQp6Qzva1lPA6xyvkU3jkVtYbo+rdRtFe38T4wbasthAihnXXEyMh3sGTSZAp
         xmcEI6OhXVeBriocAqcxnFz6Gv3b7EAf0WLPsV2bMdSaY5f/y+FIfKS/skMxyY6TwGsE
         Poq82zXpWwNPth1X1o0cdoDwaId6d+ke4p1wMkm2boS/XDF1YhPqybbDnHQ3Vct6HO20
         bwlleNdoAWEQVXrn5G72pFaZje/Vh9OcyBINoMtg1FAqs1V92/7Xp7+2TZsyD4F9l+78
         +WIw==
X-Gm-Message-State: AOAM5320ITWEAZKc89T/E/WFpU4jePDCjVL8URxWGr5hxciCoaxIZsN+
        9FAZe4P172JdlurR/c/WR2xD8+faNm08hdBDkpDfi2h/xBtn0E4FPjwDVguds8AA+GH9TSfUpiw
        uTFWE6wJ5LU3j3y78LHqcgVsA
X-Received: by 2002:aed:3b95:: with SMTP id r21mr7869635qte.368.1600205613639;
        Tue, 15 Sep 2020 14:33:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9uMbKvP58or9hYfkJing+c5CMvQJnLVzB+V6nbmgQvpvx49e/y4q2wMf8TGQvrL8iG1wbAg==
X-Received: by 2002:aed:3b95:: with SMTP id r21mr7869602qte.368.1600205613303;
        Tue, 15 Sep 2020 14:33:33 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id j6sm16985435qtn.97.2020.09.15.14.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 14:33:32 -0700 (PDT)
Date:   Tue, 15 Sep 2020 17:33:30 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20200915213330.GE2949@xz-x1>
References: <20200914183436.GD30881@xz-x1>
 <20200914211515.GA5901@xz-x1>
 <20200914225542.GO904879@nvidia.com>
 <CAHk-=wgdn5sJ0UEVZRQvj6r5kqOkU24jA_V6cPkqb9tqoAKBJg@mail.gmail.com>
 <20200914232851.GH1221970@ziepe.ca>
 <20200915145040.GA2949@xz-x1>
 <20200915160553.GJ1221970@ziepe.ca>
 <20200915182933.GM1221970@ziepe.ca>
 <20200915191346.GD2949@xz-x1>
 <20200915193838.GN1221970@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915193838.GN1221970@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 04:38:38PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 15, 2020 at 03:13:46PM -0400, Peter Xu wrote:
> > On Tue, Sep 15, 2020 at 03:29:33PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Sep 15, 2020 at 01:05:53PM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Sep 15, 2020 at 10:50:40AM -0400, Peter Xu wrote:
> > > > > On Mon, Sep 14, 2020 at 08:28:51PM -0300, Jason Gunthorpe wrote:
> > > > > > Yes, this stuff does pin_user_pages_fast() and MADV_DONTFORK
> > > > > > together. It sets FOLL_FORCE and FOLL_WRITE to get an exclusive copy
> > > > > > of the page and MADV_DONTFORK was needed to ensure that a future fork
> > > > > > doesn't establish a COW that would break the DMA by moving the
> > > > > > physical page over to the fork. DMA should stay with the process that
> > > > > > called pin_user_pages_fast() (Is MADV_DONTFORK still needed with
> > > > > > recent years work to GUP/etc? It is a pretty terrible ancient thing)
> > > > > 
> > > > > ... Now I'm more confused on what has happened.
> > > > 
> > > > I'm going to try to confirm that the MADV_DONTFORK is actually being
> > > > done by userspace properly, more later.
> > > 
> > > It turns out the test is broken and does not call MADV_DONTFORK when
> > > doing forks - it is an opt-in it didn't do.
> > > 
> > > It looks to me like this patch makes it much more likely that the COW
> > > break after page pinning will end up moving the pinned physical page
> > > to the fork while before it was not very common. Does that make sense?
> > 
> > My understanding is that the fix should not matter much with current failing
> > test case, as long as it's with FOLL_FORCE & FOLL_WRITE.  However what I'm not
> > sure is what if the RDMA/DMA buffers are designed for pure read from userspace.
> 
> No, they are write. Always FOLL_WRITE.
> 
> > E.g. for vfio I'm looking at vaddr_get_pfn() where I believe such pure read
> > buffers will be a GUP with FOLL_PIN and !FOLL_WRITE which will finally pass to
> > pin_user_pages_remote().  So what I'm worrying is something like this:
> 
> I think the !(prot & IOMMU_WRITE) case is probably very rare for
> VFIO. I'm also not sure it will work reliably, in RDMA we had this as
> a more common case and long ago found bugs. The COW had to be broken
> for the pin anyhow.

If I'm not wrong.. QEMU/KVM (assuming there's one vIOMMU in the guest) will try
to do VFIO maps in this read-only way if the IOVA mapped in the guest points to
read only buffers (say, allocated with PCI_DMA_FROMDEVICE).

> 
> >   1. Proc A gets a private anon page X for DMA, mapcount==refcount==1.
> > 
> >   2. Proc A fork()s and gives birth to proc B, page X will now have
> >      mapcount==refcount==2, write-protected.  proc B quits.  Page X goes back
> >      to mapcount==refcount==1 (note! without WRITE bits set in the PTE).
> 
> >   3. pin_user_pages(write=false) for page X.  Since it's with !FORCE & !WRITE,
> >      no COW needed.  Refcount==2 after that.
> > 
> >   4. Pass these pages to device.  We either setup IOMMU page table or just use
> >      the PFNs, which is not important imho - the most important thing is the
> >      device will DMA into page X no matter what.
> > 
> >   5. Some thread of proc A writes to page X, trigger COW since it's
> >      write-protected with mapcount==1 && refcount==2.  The HVA that pointing to
> >      page X will be changed to point to another page Y after the COW.
> > 
> >   6. Device DMA happens, data resides on X.  Proc A can never get the data,
> >      though, because it's looking at page Y now.
> 
> RDMA doesn't ever use !WRITE
> 
> I'm guessing #5 is the issue, just with a different ordering. If the
> #3 pin_user_pages() preceeds the #2 fork, don't we get to the same #5?

Right, but only if without MADV_DONTFORK?  When without MADV_DONTFORK I'll
probably still see that as an userspace bug instead of a kernel one when the
userspace decided to fork() after step #3.

> 
> > If this is a problem, we may still need the fix patch (maybe not as urgent as
> > before at least).  But I'd like to double confirm, just in case I miss some
> > obvious facts above.
> 
> I'm worred that the sudden need to have MAD_DONTFORK is going to be a
> turn into a huge regression. It already blew up our first level of
> synthetic test cases. I'm worried what we will see when the
> application suite is run in a few months :\

For my own preference I'll consider changing kernel behavior if the impact is
still under control (the performance report of 30%+ boost is also attractive
after the simplify-cow patch).  The other way is to maintain the old reuse
logic forever, that'll be another kind of burden.  Seems no easy way on either
side...

> 
> > > Given that the tests are wrong it seems like broken userspace,
> > > however, it also worked reliably for a fairly long time.
> > 
> > IMHO it worked because the page to do RDMA has mapcount==1, so it was reused
> > previously just as-is even after the fork without MADV_DONTFORK and after the
> > child quits.
> 
> That would match the results we see.. So this patch changes things so
> it is not re-used as-is, but replaced with Y?

Yes. The patch lets "replaced with Y" (cow) happen earlier at step #3.  Then
with MADV_DONTFORK, reuse should not happen any more.

Thanks,

-- 
Peter Xu

