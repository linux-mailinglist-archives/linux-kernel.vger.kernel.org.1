Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421AE2F1857
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbhAKOb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729869AbhAKObY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:31:24 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3526C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:30:43 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id y13so10607702ilm.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KMF8Z4FWkjNeZljl8WD2NdixP/23YL2yC6tkyI8SqoM=;
        b=fB3ODE+P38k+rxpwzuWHcrxJ3NGma2vpXW+RePxBICF1ySjkFRi+HDqfENHHdUUxXu
         5/W0YM0RUxgcjOCJpK6o7vHAZh99xLsK9/5VApHbf1rYHP2ed3vV2CHw9Mx5raouv8k6
         7KEOPJruEadjnWd+ngnafRaaDZ4Gaoedm0YEgV6wNLoVtjpoV+i6y1UC2hbqTSDq5iTl
         j9PsTPR+jeqbPHKdd3BaTkPjUaliLFrAQRtNwawQseTOj2f4w4BYVSIyvVAeoxWfG8j1
         84NxuB1aWa4DCv7+zxuAu3wheOYhngp69+BNvawrn8bDym20dQBkO/VpTDFlZimLwbMi
         4nkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KMF8Z4FWkjNeZljl8WD2NdixP/23YL2yC6tkyI8SqoM=;
        b=uaTE67J4Gz78Z8B/YPEWXD16iKNWRlXaK76GWia9Qcnpy0sQbBMStVr+IIHi8LWUIw
         VDO5IH//ekJaCUwSGndtxhTZ/eBLBXYKzngEUHXgCPRsM1N6P6+G8Xy/+sximK2Iz/4V
         q5mlx4GmTxpdALNJ2ew5S+NOacxorPBSDp5c+k8/obDcOAsxjvx3wkggAX0TUwYHgNQR
         tfdj6kaYvRd0bVIK2P9PEBdGG8Qz2Ip8Nf8YW4YPxAypnGIJhegJQff9W3wDcx9e1s3/
         Msuj6fAzXB8jqvoFf1ZSLfU7L5oniXwL1OZ8rDZq6y+C3W2tUuvHcDUt8aUCu71RyGoU
         G3TA==
X-Gm-Message-State: AOAM531N6qH+sIHwtK0aoYMD7B7EDeWAccXhP3p/1U1lnE448PvV0DIm
        4BGxTjDlCOWaBUbXXk8RS2/EAg==
X-Google-Smtp-Source: ABdhPJzqdEDH3WPfRNU/XsnpU8jeOuA8kd5tFyq5xCR+hHYuQb5mo0xFb8H4iIUDd1JPA9p2Ol+row==
X-Received: by 2002:a92:d40a:: with SMTP id q10mr15882339ilm.20.1610375443138;
        Mon, 11 Jan 2021 06:30:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id j65sm16018698ilg.53.2021.01.11.06.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:30:42 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kyyDR-005WFX-K9; Mon, 11 Jan 2021 10:30:41 -0400
Date:   Mon, 11 Jan 2021 10:30:41 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 0/2] page_count can't be used to decide when wp_page_copy
Message-ID: <20210111143041.GI504133@ziepe.ca>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
 <20210107202525.GD504133@ziepe.ca>
 <X/eA/f1r5GXvcRWH@redhat.com>
 <20210108133649.GE504133@ziepe.ca>
 <X/iPtCktcQHwuK5T@redhat.com>
 <20210108181945.GF504133@ziepe.ca>
 <X/jgLGPgPb+Xms1t@redhat.com>
 <20210109004255.GG504133@ziepe.ca>
 <X/kZ4ETE6LR8jpug@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/kZ4ETE6LR8jpug@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 09:50:08PM -0500, Andrea Arcangeli wrote:

> For all those that aren't using mmu notifier and that rely solely on
> page pins, they still require privilege, except they do through /dev/
> permissions.

It is normal that the dev nodes are a+rw so it doesn't really require
privilege in any real sense.

> Actually the mmu notifier doesn't strictly require pins, it only
> requires GUP. All users tend to use FOLL_GET just as a safety
> precaution (I already tried to optimize away the two atomics per GUP,
> but we were naked by the KVM maintainer that didn't want to take the
> risk, I would have, but it's a fair point indeed, obviously it's safer
> with the pin plus the mmu notifier, two is safer than one).

I'm not sure what holding the pin will do to reduce risk?

If you get into a situation where you are stuffing a page into the
SMMU that is not in the CPU's MMU then everything is lost. Holding a
pin while carrying a page from the CPU page table to the SMMU just
ensures that page isn't freed until it is installed, but once
installed you are back to being broken.
 
> I'm not sure how any copy-user could obviate a secondary MMU mapping,
> mappings and copies are mutually exclusive. Any copy would be breaking
> memory coherency in this environment.

Because most places need to copy from user to stable kernel memory
before processing data under user control. You can't just cast a user
controlled pointer to a kstruct and use it - that is very likely a
security bug.

Still, the general version is something like kmap:

  map = user_map_setup(user_ptr, length)
  kptr = user_map_enter(map)
  [use kptr]
  user_map_leave(map, kptr)

And inside it could use mmu notifiers, or gup, or whatever.

user_map_setup() would register the notifier and user_map_enter()
would validate the cache'd page pointer and block cached invalidation
until user_map_leave().

> The primary concern with the mmu notifier in io_uring is the
> take_all_locks latency.

Just enabling mmu_notifier takes a performance hit on the entire
process too, it is not such a simple decision.. We'd need benchmarks
against a database or scientific application to see how negative the
notifier actually becomes.

> The problem with the mmu notifier as an universal solution, for
> example is that it can't wait for I/O completion of O_DIRECT since it
> has no clue where the put_page is to wait for it, otherwise we could
> avoid even the FOLL_GET for O_DIRECT and guarantee the I/O has to be
> completed before paging or anything can unmap the page under I/O from
> the pagetable.

GPU is already doing something like this, waiting in a notifier
invalidate callback for DMA to finish before allowing invalidate to
complete.

It is horrendously complicated and I'm not sure blocking invalidate
for a long time is actually much better for the MM..

> I see the incompatibility you describe as problem we have today, in
> the present, and that will fade with time.
> 
> Reminds me when we had >4G of RAM and 32bit devices doing DMA. How
> many 32bit devices are there now?

I'm not so sure anymore. A few years ago OpenCAPI and PCI PRI seemed
like good things, but now with experience they carry pretty bad
performance hits to use them. Lots of places are skipping them.

CXL offers another chance at this, so we'll see again in another 5
years or so if it works out. It is not any easy problem to solve from
a HW perspective.

> We're not talking here about any random PCI device, we're talking here
> about very special and very advanced devices that need to have "long
> term" GUP pins in order to operate, not the usual nvme/gigabit device
> where GUP pins are never long term.

Beyond RDMA, netdev's XDP uses FOLL_LONGTERM, so do various video
devices, lots of things related to virtualization like vfio, vdpa and
vhost. I think this is a bit defeatist to say it doesn't matter. If
anything as time goes on it seems to be growing, not shrinking
currently.

> The point is that if you do echo ... >/proc/self/clear_refs on your
> pid, that has any FOLL_LONGTERM on its mm, it'll just cause your
> device driver to go out of sync with the mm. It'll see the old pages,
> before the spurious COWs. The CPU will use new pages (the spurious
> COWs).

But if you do that then clear-refs isn't going to work they way it
thought either - this first needs some explanation for how clear_refs
is supposed to work when DMA WRITE is active on the page.

I'd certainly say causing a loss of synchrony is not acceptable, so if
we keep Linus's version of COW then clear_refs has to not write
protect pages under DMA.

> > secondary-mmu drivers using mmu notifier should not trigger this logic
> > and should not restrict write protect.
> 
> That's a great point. I didn't think the mmu notifier will invalidate
> the secondary MMU and ultimately issue a GUP after the wp_copy_page to
> keep it in sync.

It had better, or mmu notifiers are broken, right?

> The funny thing that doesn't make sense is that wp_copy_page will only
> be invoked because the PIN was left by KVM on the page for that extra
> safety I was talking about earlier.

Yes, with the COW change if kvm cares about this inefficiency it
should not have the unnecessary pin.

> You clearly contemplate the existance of a read mode, long term. That
> is also completely compatible with wrprotection. 

We talked about a read mode, but we didn't flesh it out. It is not
unconditionally compatible with wrprotect - most likely you still
can't write protect a page under READ DMA because when you eventually
take the COW there will be ambiguous situations that will break the
synchrony.

Jason
