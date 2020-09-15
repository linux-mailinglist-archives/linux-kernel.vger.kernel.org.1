Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5DC26B11E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgIOWZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbgIOQWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:22:52 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC61C0611C2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 09:05:56 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id u6so4647406iow.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 09:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+a5NFihdkcuOmZsUsCh8QwUNs+nWQ0s/6KK3dY3Krbw=;
        b=GSQ3sEbX697YRpg9CR2VlGc9+xfZ7fD+HMnmCgWxGr8y26h7AIYMdFiC5L67kEG3Qr
         zo3aojd+RHgDTXqiDB/BQbcFLRwLETAOLTDJVWhaWtCwVa0JNhIvcohuUiYH8R7CUu95
         Nt53Cd8til24T0tg2ON7Gb1FM8we+nJBGx/Sc7MULK9Am2b0EPlwyrl6bOTtMLzT4xf6
         qJ0JTST6QVfKgHY7AqX7VdI7KJ4LzlLt/DX4QTTXkjFpH32zVwHquqXc0+l5yTedosKj
         laaJ6/nmAZHETdQBJKhVuQ1b3fdq4xJqAy8dsnyu4x+jIxS+lZQrQR0Ywl6zgmjBYour
         U2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+a5NFihdkcuOmZsUsCh8QwUNs+nWQ0s/6KK3dY3Krbw=;
        b=bUfv4Xltf1dN87FUGcXLH0i1y2BcJaAI/5PHNow9T+hiUkv2tI/Jg7BvOjem4nlV3z
         Gyl74C/xHoh3nt84is9pJmMpiB1pivnzEHhVFw2sE/y86nklcDAYP3Pl4oxfHXMXGVqH
         K+uDkpu69xhTlruQ34hl2p3CyuM2Qp6bfaBYgQm/9QLgGcIavhEdIj64uMCIyRzLGm3M
         oMTTAO++W1pfbGoSDDOcpu9JPFzUrW8Lw0FmVGBloz7jzadPGqPSv6O0IDJMVfYFwgUb
         ggIG8t09SDVJUofQ7C97euCfkRYklF20XjY5vgGfWVWXsU7KVUEdKFHux/imYJ0h/j3v
         QxzA==
X-Gm-Message-State: AOAM53233jmlyR8TAIvT1BG2gWx1aJ2NAp24omEhlRha7ekOdazggM7p
        JUDYS1zp4LfysMHB2PLfXK4N08MLuG6Anp8D
X-Google-Smtp-Source: ABdhPJwATFo46SJSoq0UDVdvowEpZdaKacMf18zCy3iPw2KHtIxWNhiYVraqVhi8N0+dWtAdnkopCg==
X-Received: by 2002:a5e:8a08:: with SMTP id d8mr15385257iok.95.1600185955222;
        Tue, 15 Sep 2020 09:05:55 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id m19sm9155980ila.40.2020.09.15.09.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 09:05:54 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kIDSr-006UEB-Ha; Tue, 15 Sep 2020 13:05:53 -0300
Date:   Tue, 15 Sep 2020 13:05:53 -0300
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
Message-ID: <20200915160553.GJ1221970@ziepe.ca>
References: <20200821234958.7896-1-peterx@redhat.com>
 <20200821234958.7896-2-peterx@redhat.com>
 <20200914143829.GA1424636@nvidia.com>
 <CAHk-=wj1EDd3dUGz_992_oRqvsy3LGDvxvyQBvutLhBqkYqgcQ@mail.gmail.com>
 <20200914183436.GD30881@xz-x1>
 <20200914211515.GA5901@xz-x1>
 <20200914225542.GO904879@nvidia.com>
 <CAHk-=wgdn5sJ0UEVZRQvj6r5kqOkU24jA_V6cPkqb9tqoAKBJg@mail.gmail.com>
 <20200914232851.GH1221970@ziepe.ca>
 <20200915145040.GA2949@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915145040.GA2949@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 10:50:40AM -0400, Peter Xu wrote:
> On Mon, Sep 14, 2020 at 08:28:51PM -0300, Jason Gunthorpe wrote:
> > Yes, this stuff does pin_user_pages_fast() and MADV_DONTFORK
> > together. It sets FOLL_FORCE and FOLL_WRITE to get an exclusive copy
> > of the page and MADV_DONTFORK was needed to ensure that a future fork
> > doesn't establish a COW that would break the DMA by moving the
> > physical page over to the fork. DMA should stay with the process that
> > called pin_user_pages_fast() (Is MADV_DONTFORK still needed with
> > recent years work to GUP/etc? It is a pretty terrible ancient thing)
> 
> ... Now I'm more confused on what has happened.

I'm going to try to confirm that the MADV_DONTFORK is actually being
done by userspace properly, more later.

> It means, as long as the rdma region has VM_WRITE set (which I think of no
> reason on why it shouldn't...), then it should have the write bit in the COWed
> page entry.  If so, the page should be stable and I don't undersdand why
> another COW could even trigger and how the code path in the "trial cow" patch
> is triggered.

All the regions the test are doing DMA to will be simple process
writable anonymous VMA's from malloc()
 
> Or, the VMA is without VM_WRITE due to some reason?  Sorry I probably know
> nothing about RDMA, more information on that side might help too. E.g., is the
> hardware going to walk the software process page table too when doing RDMA (or
> is IOMMU page table used, or none)?

It does pin_user_pages_fast(), gets a list of DMA addresses for the
pages and then programs the hardware. The pin remains for a very long
time and the HW does DMA to those pages independently.

Userspace will write to the memory and trigger DMA reads and HW will
do DMA writes and trigger something close to an eventfd to let
userspace know to check the DMA'd data.

Very similar to how an in-kernel driver works. It is similar to VFIO
in how it uses pin_user_pages_fast().

Symptoms look to be like the DMA's are not arriving.

As before, the requirement is that once a process as done
pin_user_pages() the physical page stays with the process. If there is
a fork() and a COW then the current memory stays with the original
process and the fork'd child gets the copy. MADV_DONTFORK is expected
to ensure this..

We haven't been able to narrow to a reproduction that doesn't require
alot of hardware unfortunately. It seems oddly sensitive, maybe due to
memory layout triggering a COW..

Jason
