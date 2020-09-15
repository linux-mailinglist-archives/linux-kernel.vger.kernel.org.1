Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E755926AD49
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgIOTOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:14:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55183 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727960AbgIOTNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600197232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZWaM8lK4E+JgpTzBkYVyMmwKV2oNtb0ZHbYSY0G1m3c=;
        b=dFUbelPIhzRHeqerstnrrTTbDKdFmZ/zct1eiVC6K6c+bppPdB7XqAv1hmjmN/3qfb0OGi
        U0S1KSfKC6mLrk7EbCooHjGft2X6KOujZaOABFHwSts7b0bZd6xokyj4jiq7yLbByuvfka
        Ni+P1JVWCXnSSVUnK2s9pNst/B7jOMg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-AzLY14kcPIyYu4ZK7Ls9dw-1; Tue, 15 Sep 2020 15:13:50 -0400
X-MC-Unique: AzLY14kcPIyYu4ZK7Ls9dw-1
Received: by mail-qk1-f197.google.com with SMTP id q131so3720204qke.22
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZWaM8lK4E+JgpTzBkYVyMmwKV2oNtb0ZHbYSY0G1m3c=;
        b=kZAkQmdLq7IInMNOhrIDzgFyVTnG7s74c2/ZxdMDTnnEPxREuGSlI1lxheYAX3YnHF
         UDRWqaHs9Mfgp1Tu6WvqEEq49MNqQ+mfi83uhQ7GVCjrIWb/NYrFSQ7gDoqxERK10HcG
         X/tEGxRCMmixHcIomE0uozL7xx6rbenYx73w0PaTnvtgyk79EFnHoLh0ZJ+xEZjiKX3q
         l7hHFrlt+jFcdV1fvHiXDuMRrMwu/w9fV05nR9lHnAEBj1v0Z+sAbMjWIpZQ8+oc3ySl
         xr5YzWqMpfbi9qFl/ztPLHRN30WygZ66YShIwuH4rgJrMC8PgBOls05upRlDPPmXxvZr
         ytOA==
X-Gm-Message-State: AOAM532zwVieXA4jTzmdZeMN9WkxRCqcEoTUT9b0OXsBTeKr8iA8+FMR
        /V2aWi9hRY6O070X8O36nbTdncW/tUzZ9as7TLDHlRtKX7mT9omFZqsuLUnFISfXaW01Qgz5Idu
        zSKm7OIdQzqM19iA/iRUxQv+l
X-Received: by 2002:a0c:8f02:: with SMTP id z2mr20132525qvd.21.1600197230003;
        Tue, 15 Sep 2020 12:13:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxrXKCE5/KIwcV94++sTnuK0HWS7T+vCs5eQrem8OZqmgstUi1ZfdeyXHn8mZnLCVDAkBY1g==
X-Received: by 2002:a0c:8f02:: with SMTP id z2mr20132499qvd.21.1600197229558;
        Tue, 15 Sep 2020 12:13:49 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id s15sm17787207qke.134.2020.09.15.12.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:13:48 -0700 (PDT)
Date:   Tue, 15 Sep 2020 15:13:46 -0400
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
Message-ID: <20200915191346.GD2949@xz-x1>
References: <20200914143829.GA1424636@nvidia.com>
 <CAHk-=wj1EDd3dUGz_992_oRqvsy3LGDvxvyQBvutLhBqkYqgcQ@mail.gmail.com>
 <20200914183436.GD30881@xz-x1>
 <20200914211515.GA5901@xz-x1>
 <20200914225542.GO904879@nvidia.com>
 <CAHk-=wgdn5sJ0UEVZRQvj6r5kqOkU24jA_V6cPkqb9tqoAKBJg@mail.gmail.com>
 <20200914232851.GH1221970@ziepe.ca>
 <20200915145040.GA2949@xz-x1>
 <20200915160553.GJ1221970@ziepe.ca>
 <20200915182933.GM1221970@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915182933.GM1221970@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 03:29:33PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 15, 2020 at 01:05:53PM -0300, Jason Gunthorpe wrote:
> > On Tue, Sep 15, 2020 at 10:50:40AM -0400, Peter Xu wrote:
> > > On Mon, Sep 14, 2020 at 08:28:51PM -0300, Jason Gunthorpe wrote:
> > > > Yes, this stuff does pin_user_pages_fast() and MADV_DONTFORK
> > > > together. It sets FOLL_FORCE and FOLL_WRITE to get an exclusive copy
> > > > of the page and MADV_DONTFORK was needed to ensure that a future fork
> > > > doesn't establish a COW that would break the DMA by moving the
> > > > physical page over to the fork. DMA should stay with the process that
> > > > called pin_user_pages_fast() (Is MADV_DONTFORK still needed with
> > > > recent years work to GUP/etc? It is a pretty terrible ancient thing)
> > > 
> > > ... Now I'm more confused on what has happened.
> > 
> > I'm going to try to confirm that the MADV_DONTFORK is actually being
> > done by userspace properly, more later.
> 
> It turns out the test is broken and does not call MADV_DONTFORK when
> doing forks - it is an opt-in it didn't do.
> 
> It looks to me like this patch makes it much more likely that the COW
> break after page pinning will end up moving the pinned physical page
> to the fork while before it was not very common. Does that make sense?

My understanding is that the fix should not matter much with current failing
test case, as long as it's with FOLL_FORCE & FOLL_WRITE.  However what I'm not
sure is what if the RDMA/DMA buffers are designed for pure read from userspace.

E.g. for vfio I'm looking at vaddr_get_pfn() where I believe such pure read
buffers will be a GUP with FOLL_PIN and !FOLL_WRITE which will finally pass to
pin_user_pages_remote().  So what I'm worrying is something like this:

  1. Proc A gets a private anon page X for DMA, mapcount==refcount==1.

  2. Proc A fork()s and gives birth to proc B, page X will now have
     mapcount==refcount==2, write-protected.  proc B quits.  Page X goes back
     to mapcount==refcount==1 (note! without WRITE bits set in the PTE).

  3. pin_user_pages(write=false) for page X.  Since it's with !FORCE & !WRITE,
     no COW needed.  Refcount==2 after that.

  4. Pass these pages to device.  We either setup IOMMU page table or just use
     the PFNs, which is not important imho - the most important thing is the
     device will DMA into page X no matter what.

  5. Some thread of proc A writes to page X, trigger COW since it's
     write-protected with mapcount==1 && refcount==2.  The HVA that pointing to
     page X will be changed to point to another page Y after the COW.

  6. Device DMA happens, data resides on X.  Proc A can never get the data,
     though, because it's looking at page Y now.

If this is a problem, we may still need the fix patch (maybe not as urgent as
before at least).  But I'd like to double confirm, just in case I miss some
obvious facts above.

> 
> Given that the tests are wrong it seems like broken userspace,
> however, it also worked reliably for a fairly long time.

IMHO it worked because the page to do RDMA has mapcount==1, so it was reused
previously just as-is even after the fork without MADV_DONTFORK and after the
child quits.  However logically it should really be protected by MADV_DONTFORK
rather than being reused.

Thanks,

-- 
Peter Xu

