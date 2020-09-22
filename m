Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F702741A3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 13:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgIVLyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 07:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgIVLyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:54:38 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D9CC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 04:54:38 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o5so18601426qke.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 04:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nmyfYbTxASalyuC4ipdAUYFHF4U9gSVwG5N7T0tPGkw=;
        b=M8M2c/P5kA3kctisYfatlJSTe3yNJfvr/qJcqyp8WWIgUO8Iaevb9o+QyPCWN0ocd+
         a7PMpwCvVNKDpZD6hm/COdKdM2J73m8cGhP72vfX/lw4++ryqH2Sv02dJap6C0NzDK0y
         4P33uJfGqwaUWYclQREZnwrK1FGz3z1EFFFbEv6tYN9QLm09kvMMmLcUOP5MhzeUoAI5
         WLq1czQUCz8a2MiqOxjJbPtxNjU66E6kWCTGE9jx42KzpRi8zm7WeCdvwrKS9SJ7gdrK
         sKvKmP290SCSRtc/dLoAglzH+MiCdMnG6nWSn99BFVdDtKtZxkurV7zdGbhm9OHOeECr
         tq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nmyfYbTxASalyuC4ipdAUYFHF4U9gSVwG5N7T0tPGkw=;
        b=IfWVNoWeNe+Ceglo0OEbQDKWGF8stnBZQTYXfA/LM9VK+2KkJnJBLCyaiLm+7ckfPj
         dIHMrdRgWEUYLMwBG8lE3BdjSVN50Gf8T5eyMkjXSh1edoFGs6/IoQWD7oEWDvAMdULb
         x3CfH7ZBgGKPrfZHp27XySaIM8aRY3fzhVEPTG/JH4U+RuiKlXDw+CnQdVOcGvqURrRq
         sYJ7Dvn6MuifeoHb1RUr+ogBsLejlDN862CsGEH7KZQ1isqoQz0qGf8aj6rEjCNliD84
         IB0YYXLOYjlZOfN/Fj2uj7k63Aizmj7Gpr2Czd50GO3FNfLLh4zI3P7/FGC4Bp4hwz5S
         /VMA==
X-Gm-Message-State: AOAM530zU6o/2juUsdP4rA5NHXFaD+HHxA0ldGR+4KJUG700w7QYN15B
        EP47rMSJdmRV3OKGF8obSOlZqQ==
X-Google-Smtp-Source: ABdhPJyBI6tbzANIZBC4sRXyAIkxkM/AIH7Z52WGQkODT5CFUJRzxXkZquA1Zt5/2T0sAuJsIk2vpw==
X-Received: by 2002:a05:620a:64b:: with SMTP id a11mr4286993qka.313.1600775677699;
        Tue, 22 Sep 2020 04:54:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id q7sm12738125qte.95.2020.09.22.04.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 04:54:37 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kKgsW-0030cN-BO; Tue, 22 Sep 2020 08:54:36 -0300
Date:   Tue, 22 Sep 2020 08:54:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jann Horn <jannh@google.com>
Cc:     Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
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
Message-ID: <20200922115436.GG8409@ziepe.ca>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-2-peterx@redhat.com>
 <CAG48ez0o+yBpYdzR_-bU3A0nrpzXyM+c+Yk=ZtOZ92qe5x0izA@mail.gmail.com>
 <20200921223004.GB19098@xz-x1>
 <CAG48ez25krKvd5hWqn0R3w5_AAPVWtWKofiOHEfKaB2+YoDoPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez25krKvd5hWqn0R3w5_AAPVWtWKofiOHEfKaB2+YoDoPw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 12:47:11AM +0200, Jann Horn wrote:
> On Tue, Sep 22, 2020 at 12:30 AM Peter Xu <peterx@redhat.com> wrote:
> > On Mon, Sep 21, 2020 at 11:43:38PM +0200, Jann Horn wrote:
> > > On Mon, Sep 21, 2020 at 11:17 PM Peter Xu <peterx@redhat.com> wrote:
> > > > (Commit message collected from Jason Gunthorpe)
> > > >
> > > > Reduce the chance of false positive from page_maybe_dma_pinned() by keeping
> > > > track if the mm_struct has ever been used with pin_user_pages(). mm_structs
> > > > that have never been passed to pin_user_pages() cannot have a positive
> > > > page_maybe_dma_pinned() by definition.
> > >
> > > There are some caveats here, right? E.g. this isn't necessarily true
> > > for pagecache pages, I think?
> >
> > Sorry I didn't follow here.  Could you help explain with some details?
> 
> The commit message says "mm_structs that have never been passed to
> pin_user_pages() cannot have a positive page_maybe_dma_pinned() by
> definition"; but that is not true for pages which may also be mapped
> in a second mm and may have been passed to pin_user_pages() through
> that second mm (meaning they must be writable over there and not
> shared with us via CoW).

The message does need a few more words to explain this trick can only
be used with COW'able pages.
 
> Process A:
> 
> fd_a = open("/foo/bar", O_RDWR);
> mapping_a = mmap(NULL, 0x1000, PROT_READ|PROT_WRITE, MAP_SHARED, fd_a, 0);
> pin_user_pages(mapping_a, 1, ...);
> 
> Process B:
> 
> fd_b = open("/foo/bar", O_RDONLY);
> mapping_b = mmap(NULL, 0x1000, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd_b, 0);
> *(volatile char *)mapping_b;
> 
> At this point, process B has never called pin_user_pages(), but
> page_maybe_dma_pinned() on the page at mapping_b would return true.

My expectation is the pin_user_pages() should have already broken the
COW for the MAP_PRIVATE, so process B should not have a
page_maybe_dma_pinned()

Jason
