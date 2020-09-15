Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3BB26AA01
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 18:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbgIOQjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 12:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbgIOP4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:56:08 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E90AC06178A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 08:56:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id z17so2219351pgc.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 08:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gu3jry4B0AmzKkFeYjUaKPbyQDrej3ixHxhQeqH0BLU=;
        b=io1LGxHCa+bzpTsA004NgcNc1/CPR3FyTOIzwxWhYkryYEBxZnX16fd1+ybJ1IqjKt
         JHTA9TnuQzWt8K+BCuyuSXUCv+gmCFfkCrXdpJEKNVjZ6gfh8ZhVcn9SqlTvYpw0pZ1P
         q0MJkdS2mVtbRcn/DRRlERCwlJAhZKyFoABcNJDlNfntWr4nebJ3ry1fwQYQBmy8De9B
         1AWZAbkGyhhg+8v9QzPBCBOgsg8/dvzqzuOOFqvEoLoVmpL0YnA1oBfqcOMK6HddCrZo
         pdwJ32lfd+/AElGAnoxGAFw8+i4ljnn60UPn16TzcdxTSdsOEGLC23dk5COBcgnjhxHU
         peEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gu3jry4B0AmzKkFeYjUaKPbyQDrej3ixHxhQeqH0BLU=;
        b=okq/Ilx+9QGsDbEUXIlxs4EWzhNAn36TnaxhPknbp1ElwIERHT0m5hJSQcyv9AnCiK
         NeOhIlN+NWNb6iusuO0Ne2byAscKisMpr3wLchTpcQ0tL67OgySn9wazhoGCInsq53Tp
         Hogyskjlyw5BrqicZRHbxiLQ5jek5Prkx4/DFnp5GU3h9w/8uwG3bwZ6gHZAlDV6SAge
         ueXvzDtklTUrvP3kzbOnNG33xjRAWDNrFgGTCsHEbNbMl0Q4+Y0f1uYgUJ0xSHZAvXLc
         gfDX/BX6YYHHLOmNEAJ7amFFJGHMMUV5XSD2wnZWCTjv0YS3VsM9CozBGrawmW3vOXrU
         FmIg==
X-Gm-Message-State: AOAM5305rmY8blXAtAmUsf1aU99M6VglFuAgOxr+yg/5mC4ljebBi3AF
        gZqytxX4c4PDQ9Fc1zZErdMINQ==
X-Google-Smtp-Source: ABdhPJxzhG+emjG10bx4k2+p37+o/FSSbscV6LIByFWdsZd55jr6UgNYr33jGE//tnR4R9iVgA0rHA==
X-Received: by 2002:a63:4822:: with SMTP id v34mr14875815pga.342.1600185367654;
        Tue, 15 Sep 2020 08:56:07 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id f5sm13458346pfj.212.2020.09.15.08.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 08:56:06 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kIDJN-006U3b-68; Tue, 15 Sep 2020 12:56:05 -0300
Date:   Tue, 15 Sep 2020 12:56:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <20200915155605.GI1221970@ziepe.ca>
References: <20200821234958.7896-1-peterx@redhat.com>
 <20200821234958.7896-2-peterx@redhat.com>
 <20200914143829.GA1424636@nvidia.com>
 <CAHk-=wj1EDd3dUGz_992_oRqvsy3LGDvxvyQBvutLhBqkYqgcQ@mail.gmail.com>
 <20200914183436.GD30881@xz-x1>
 <20200914211515.GA5901@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914211515.GA5901@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 05:15:15PM -0400, Peter Xu wrote:
> On Mon, Sep 14, 2020 at 02:34:36PM -0400, Peter Xu wrote:
> > On Mon, Sep 14, 2020 at 10:32:11AM -0700, Linus Torvalds wrote:
> > > On Mon, Sep 14, 2020 at 7:38 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >
> > > > I don't have a detailed explanation right now, but this patch appears
> > > > to be causing a regression where RDMA subsystem tests fail. Tests
> > > > return to normal when this patch is reverted.
> > > >
> > > > It kind of looks like the process is not seeing DMA'd data to a
> > > > pin_user_pages()?
> > > 
> > > I'm a nincompoop. I actually _talked_ to Hugh Dickins about this when
> > > he raised concerns, and I dismissed his concerns with "but PAGE_PIN is
> > > special".
> > > 
> > > As usual, Hugh was right. Page pinning certainly _is_ special, but
> > > it's not that different from the regular GUP code.
> > > 
> > > But in the meantime, I have a lovely confirmation from the kernel test
> > > robot, saying that commit 09854ba94c results in a
> > > "vm-scalability.throughput 31.4% improvement", which was what I was
> > > hoping for - the complexity wasn't just complexity, it was active
> > > badness due to the page locking horrors.
> > > 
> > > I think what we want to do is basically do the "early COW", but only
> > > do it for FOLL_PIN (and not turn them into writes for anything but the
> > > COW code). So basically redo the "enforced COW mechanism", but rather
> > > than do it for everything, now do it only for FOLL_PIN, and only in
> > > that COW path.
> > > 
> > > Peter - any chance you can look at this? I'm still looking at the page
> > > lock fairness performance regression, although I now think I have a
> > > test patch for Phoronix to test out.
> > 
> > Sure, I'll try to prepare something like that and share it shortly.
> 
> Jason, would you please try the attached patch to see whether it unbreaks the
> rdma test?  Thanks!

Hi Peter,

My tester says the patch does not help (modified as Leon pointed to
make it compile).

He did another test where all forks were removed and the test program
succeeds. Overall in our test suites we see failurs on tests that
involve fork and success on tests that don't.

So fork and COW seem very likely to be the issue.

Thanks,
Jason
