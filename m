Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C93D26ADC2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgIOTjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgIOTin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:38:43 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FA8C061797
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:38:41 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id j2so5447034ioj.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CyPGvYlFTvbDl1yaLgwszCttimlpryVjdUsodPbl8v4=;
        b=RiGSfIMcB6eKVH7/V7GO7moWC9zz0ElHNyb1FDgM2Dyfo/3hoQstMSTP4Qqd6Ca1GP
         5MxgzVnSBgyGuDs5sQUJKISZWThpgendemBZxWGUEpFZVk21qgJtvG46SbYkXX5HPXdo
         zrmCw/kDf4btFJvAOHyMA3XV6T7aiqI/gVXGl0mtqoyjQ+urF7BxcchM3lPLQ4HeRIV/
         xBqbFkt0n2mMom8OqWAh+j+LhbKtGMe0jJ1Qiuw7tvPivv70cotmFAdEZeuqKI203Wqc
         JY28N3Va9+C14Z/N1mrDmasbeOjlVvTQ/oUuZdBM8VWbhC89oEXcoUmMoea/8BaVlwiK
         rcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CyPGvYlFTvbDl1yaLgwszCttimlpryVjdUsodPbl8v4=;
        b=lnPMy2PE9KpB5cLCE8VrddLVcCbkVSjDUhbagcNBwQAYuJXjCuJfZca9U2i5EqcQ/V
         g0QNGxZClWljjHNCDOYggepYvntOk4qErPVS00f6kp56bTt0r1SdNzQAodcFX4bBVhWu
         2Wqv+GWYNJqcYaI9XCzFVXHsc291eIS40swLEPtFcWbtioUm8aB1Hka1Bk3hJMSqfTfR
         C8fkWxYSjOzTA1b1hvL5OtEInTZN09O+Vp3Wb2vj9n7B/4fwtCYjibiMMCic+0qfwWJ9
         HLa3sB83EVodLAmtSflS0JSCfR5DUXf98ZGYfxlTswxmlrQ6OD/MvKpveiTtlYymjaTb
         Vv8A==
X-Gm-Message-State: AOAM532EWD9oCbD+r1iAGY8H2sFj3qcaxbSV+OEU23Ee9FOYmMlL/BDL
        sbw8wrAaJmVdNZP1MNdcBu1+Ng==
X-Google-Smtp-Source: ABdhPJyacgw0BIL2rXH5xG6PMmWKXA7Lc1d15q3vyqnBiuEM536YsqCIBi6Ivw+5/fpuMTVsPZtZ6Q==
X-Received: by 2002:a05:6602:2f0e:: with SMTP id q14mr16543404iow.110.1600198720528;
        Tue, 15 Sep 2020 12:38:40 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id c85sm9363947ilg.10.2020.09.15.12.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:38:39 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kIGmk-006fp8-HA; Tue, 15 Sep 2020 16:38:38 -0300
Date:   Tue, 15 Sep 2020 16:38:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
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
Message-ID: <20200915193838.GN1221970@ziepe.ca>
References: <CAHk-=wj1EDd3dUGz_992_oRqvsy3LGDvxvyQBvutLhBqkYqgcQ@mail.gmail.com>
 <20200914183436.GD30881@xz-x1>
 <20200914211515.GA5901@xz-x1>
 <20200914225542.GO904879@nvidia.com>
 <CAHk-=wgdn5sJ0UEVZRQvj6r5kqOkU24jA_V6cPkqb9tqoAKBJg@mail.gmail.com>
 <20200914232851.GH1221970@ziepe.ca>
 <20200915145040.GA2949@xz-x1>
 <20200915160553.GJ1221970@ziepe.ca>
 <20200915182933.GM1221970@ziepe.ca>
 <20200915191346.GD2949@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915191346.GD2949@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 03:13:46PM -0400, Peter Xu wrote:
> On Tue, Sep 15, 2020 at 03:29:33PM -0300, Jason Gunthorpe wrote:
> > On Tue, Sep 15, 2020 at 01:05:53PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Sep 15, 2020 at 10:50:40AM -0400, Peter Xu wrote:
> > > > On Mon, Sep 14, 2020 at 08:28:51PM -0300, Jason Gunthorpe wrote:
> > > > > Yes, this stuff does pin_user_pages_fast() and MADV_DONTFORK
> > > > > together. It sets FOLL_FORCE and FOLL_WRITE to get an exclusive copy
> > > > > of the page and MADV_DONTFORK was needed to ensure that a future fork
> > > > > doesn't establish a COW that would break the DMA by moving the
> > > > > physical page over to the fork. DMA should stay with the process that
> > > > > called pin_user_pages_fast() (Is MADV_DONTFORK still needed with
> > > > > recent years work to GUP/etc? It is a pretty terrible ancient thing)
> > > > 
> > > > ... Now I'm more confused on what has happened.
> > > 
> > > I'm going to try to confirm that the MADV_DONTFORK is actually being
> > > done by userspace properly, more later.
> > 
> > It turns out the test is broken and does not call MADV_DONTFORK when
> > doing forks - it is an opt-in it didn't do.
> > 
> > It looks to me like this patch makes it much more likely that the COW
> > break after page pinning will end up moving the pinned physical page
> > to the fork while before it was not very common. Does that make sense?
> 
> My understanding is that the fix should not matter much with current failing
> test case, as long as it's with FOLL_FORCE & FOLL_WRITE.  However what I'm not
> sure is what if the RDMA/DMA buffers are designed for pure read from userspace.

No, they are write. Always FOLL_WRITE.

> E.g. for vfio I'm looking at vaddr_get_pfn() where I believe such pure read
> buffers will be a GUP with FOLL_PIN and !FOLL_WRITE which will finally pass to
> pin_user_pages_remote().  So what I'm worrying is something like this:

I think the !(prot & IOMMU_WRITE) case is probably very rare for
VFIO. I'm also not sure it will work reliably, in RDMA we had this as
a more common case and long ago found bugs. The COW had to be broken
for the pin anyhow.

>   1. Proc A gets a private anon page X for DMA, mapcount==refcount==1.
> 
>   2. Proc A fork()s and gives birth to proc B, page X will now have
>      mapcount==refcount==2, write-protected.  proc B quits.  Page X goes back
>      to mapcount==refcount==1 (note! without WRITE bits set in the PTE).

>   3. pin_user_pages(write=false) for page X.  Since it's with !FORCE & !WRITE,
>      no COW needed.  Refcount==2 after that.
> 
>   4. Pass these pages to device.  We either setup IOMMU page table or just use
>      the PFNs, which is not important imho - the most important thing is the
>      device will DMA into page X no matter what.
> 
>   5. Some thread of proc A writes to page X, trigger COW since it's
>      write-protected with mapcount==1 && refcount==2.  The HVA that pointing to
>      page X will be changed to point to another page Y after the COW.
> 
>   6. Device DMA happens, data resides on X.  Proc A can never get the data,
>      though, because it's looking at page Y now.

RDMA doesn't ever use !WRITE

I'm guessing #5 is the issue, just with a different ordering. If the
#3 pin_user_pages() preceeds the #2 fork, don't we get to the same #5?

> If this is a problem, we may still need the fix patch (maybe not as urgent as
> before at least).  But I'd like to double confirm, just in case I miss some
> obvious facts above.

I'm worred that the sudden need to have MAD_DONTFORK is going to be a
turn into a huge regression. It already blew up our first level of
synthetic test cases. I'm worried what we will see when the
application suite is run in a few months :\

> > Given that the tests are wrong it seems like broken userspace,
> > however, it also worked reliably for a fairly long time.
> 
> IMHO it worked because the page to do RDMA has mapcount==1, so it was reused
> previously just as-is even after the fork without MADV_DONTFORK and after the
> child quits.

That would match the results we see.. So this patch changes things so
it is not re-used as-is, but replaced with Y?

This basically means any driver using pin_user_pages() can no longer
have fork() in userspace, when before fork() only failed in fairly
narrow cases. Unfortunately I think this will break things broadly
beyond RDMA.

Jason
