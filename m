Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1FD2699AF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 01:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgINX3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 19:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgINX2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 19:28:54 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2ACC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 16:28:54 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d190so2070510iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 16:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6mwCziIgbqCaPfGhbpJclA7zt0zT/DjQfjFbGVV4PrQ=;
        b=mbkthaWgzvywMvbJyHZOeX0puvYOuoc5q0gETR5HzioqXS8ZkYvVEYF3J+yIQjWyUP
         kEqKwkFqykyQK59/mExPj8FoETOqv/t6lNhTWmHz1qjAFMqCoF7jriHIJRmUwiA3GVeo
         VlnTmNl1ZnUsyCfJ6cdAhGnYee4TQEiPK29Maz9zvvqLdNv0IbSUgwMFSuZ8JhvgP78a
         WKaTzspxrQtFYvWoy2K+YX2mmbE8DlshKWu9spLPDSTuo+ks53uTooHvZhVIGm03DSd0
         isDitc2HqrQrd+3JmpckFY0gQaY0TguDoCByCi3dSE31S6/AsPgdGLQLl/jGaYSQQfdk
         NIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6mwCziIgbqCaPfGhbpJclA7zt0zT/DjQfjFbGVV4PrQ=;
        b=B+grGcjjnLNlW/y8VL8La2Fx4ZmYfNPGzpDsU3Wpmr79R14M7BwmgLaaK04iOHmHpg
         ctxXPJuEddudNLqz32gxYriZ10a3kPn1DaZav9Xnx/gkEQlhd6VOrqLZ1hQ80LkIYZ+v
         GzvMukTnldkOPDTS6G86RKdO3DGQvnn0T4SDFa2/1cNguM8ryGj/pGomUQdsITekFrZM
         A84g/QQ5XKxE/eHvqQrBsMaPcfb4lL/S4gP3ax0ZUqBypzcwHZr2mB/nUs7xCNKcoDQZ
         3eRthO5l520vUfQGiRi/WMci+9fHMcYVIgx4oUNEDh29+CJZQ358kTYOLO9Nv4x8r3iz
         qjOw==
X-Gm-Message-State: AOAM5312LsvmtMZGdjFp2jSRwPNgt+QhNw5ajp0bNk/thClZNYzDOjWE
        zvwgI+8tswRSCtEi4215xMFkPw==
X-Google-Smtp-Source: ABdhPJzUNguBOvRQmINN/RQZ6Oz1sZ8VDajcEqKrO2vPt27FjIWG90hIUgcGs0Kzr+zOltr0u22Y9Q==
X-Received: by 2002:a02:a615:: with SMTP id c21mr15063821jam.106.1600126133326;
        Mon, 14 Sep 2020 16:28:53 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id p9sm6756721iov.18.2020.09.14.16.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 16:28:52 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kHxtz-006Hgi-6k; Mon, 14 Sep 2020 20:28:51 -0300
Date:   Mon, 14 Sep 2020 20:28:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Leon Romanovsky <leonro@nvidia.com>,
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
Message-ID: <20200914232851.GH1221970@ziepe.ca>
References: <20200821234958.7896-1-peterx@redhat.com>
 <20200821234958.7896-2-peterx@redhat.com>
 <20200914143829.GA1424636@nvidia.com>
 <CAHk-=wj1EDd3dUGz_992_oRqvsy3LGDvxvyQBvutLhBqkYqgcQ@mail.gmail.com>
 <20200914183436.GD30881@xz-x1>
 <20200914211515.GA5901@xz-x1>
 <20200914225542.GO904879@nvidia.com>
 <CAHk-=wgdn5sJ0UEVZRQvj6r5kqOkU24jA_V6cPkqb9tqoAKBJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgdn5sJ0UEVZRQvj6r5kqOkU24jA_V6cPkqb9tqoAKBJg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 03:59:31PM -0700, Linus Torvalds wrote:
> On Mon, Sep 14, 2020 at 3:55 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > Just as an aside, the RDMA stuff is also supposed to set MADV_DONTFORK
> > on these regions, so I'm a bit puzzled what is happening here.
> 
> Did the fork perhaps happen _before_ , so the pages are shared when
> you do the pin?

Looking at the progam, it seems there are a number of forks for exec
before and after pin_user_pages_fast(), but the parent process always
does waitpid() after the fork.

> MADV_DONTFORK doesn't mean COW doesn't happen. It just means that the
> next fork() won't be copying that memory area.

Yes, this stuff does pin_user_pages_fast() and MADV_DONTFORK
together. It sets FOLL_FORCE and FOLL_WRITE to get an exclusive copy
of the page and MADV_DONTFORK was needed to ensure that a future fork
doesn't establish a COW that would break the DMA by moving the
physical page over to the fork. DMA should stay with the process that
called pin_user_pages_fast() (Is MADV_DONTFORK still needed with
recent years work to GUP/etc? It is a pretty terrible ancient thing)

> That said, it's possible that the test cases do something invalid - or
> maybe we've broken MADV_DONTFORK - and it all just happened to work
> before.

Hmm. If symptoms stop with this patch should we investigate
MADV_DONTFORK?

Thanks,
Jason
