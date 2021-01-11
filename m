Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2412F1A36
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 16:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388590AbhAKPxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 10:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbhAKPx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:53:28 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA475C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 07:52:47 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id h16so7575067qvu.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 07:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DTtX5CQ79mvCElDxODO77cVTuyuq22GdoAJZjW803s4=;
        b=PP5P9Js+hVVOM2eTY6pAKi4aMnJ/nRqExT3Coc1R4TFDgp6o81GIvIAF45yGnE5EdU
         n/S/92pNpsBAj2aX5b/s4lAozrka3jVUmUIGgnoqI+ZX9dCIfwYhxNHy4b5vtKSKsAE0
         mgMRxsb5f2T4K+xe2zmXwStNx17ucbYwtLOZxxPNl00kCpj5n15TLGNq0J8QrCyIuOaK
         btbXvNMhsVa1pl6NvWQwlaq4KuScx/2dlraYITujsK5duvl9f8itQxUw8TDMmwMGOeBE
         xEU0jAEkUHuScctGS4ZMweae+n8CLHQ+VgnGf4j3jJWZEe5QbyyhAva/ECM9vKEUyfns
         e3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DTtX5CQ79mvCElDxODO77cVTuyuq22GdoAJZjW803s4=;
        b=jCFk68BjvLyZ8wrabmjReEuJg4+YbUJc81+LfZQcFmEtgBprP8l9j1mBxJQNYlZsEw
         JIwhhZ7XEeyuzWadutdpWi63Y4BNagFhXKkvOM/3MPp8ef8e+au+2/atSulPYgSwHG84
         7SJ/WhLj/kVGAk0Gm9E2gax56/YGWwOUTQJZ8EBK7WObz4Re3N76aR9sa7dDRnmI5KtU
         VrHm7jGgeliE634gE6KDtIRrr5oKAjGNRth97lAdCDuyjJ9CFEk0aI5rSFM2joWhaZ6b
         BzkDcqf3IdrXDIePanmTViX+IZb5uWgSu3ptHVJx9y/DZEVjKd7s1JnPdwwlRbBPa3md
         6Jzg==
X-Gm-Message-State: AOAM5315AGUJU/3CVP0EtL9qPB75dyotItCx1PmjiMqqnH6bhgjbBat8
        s+RlA9xroapRfqmzldRjNtMMaA==
X-Google-Smtp-Source: ABdhPJyKYjAT3LmoVbBTtIHwrAxf+Io6skqOJi1oDcms79ORoN0cLhj8cmluyb8xaWTDdeJLBNsZAw==
X-Received: by 2002:a05:6214:14af:: with SMTP id bo15mr249528qvb.19.1610380367039;
        Mon, 11 Jan 2021 07:52:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id r6sm67695qkk.127.2021.01.11.07.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 07:52:46 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kyzUr-005YBj-Kq; Mon, 11 Jan 2021 11:52:45 -0400
Date:   Mon, 11 Jan 2021 11:52:45 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
Message-ID: <20210111155245.GM504133@ziepe.ca>
References: <20210110004435.26382-1-aarcange@redhat.com>
 <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
 <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
 <X/prosulFrEoNnoF@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/prosulFrEoNnoF@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 09, 2021 at 09:51:14PM -0500, Andrea Arcangeli wrote:

> Are we spending 32bit in mm_struct atomic_t just to call atomic_set(1)
> on it? Why isn't it a MMF_HAS_PINNED that already can be set
> atomically under mmap_read_lock too? There's bit left free there, we
> didn't run out yet to justify wasting another 31 bits. I hope I'm
> overlooking something.

It needs to be atomic because it is set under gup fast, no mmap
lock. Peter and myself did not find another place to put this that was
already atomic

> The existence of FOLL_LONGTERM is good and makes a difference at times
> for writeback if it's on a MAP_SHARED, or it makes difference during
> GUP to do a page_migrate before taking the pin, but for the whole rest
> of the VM it's irrelevant if it's long or short term, so I'm also
> concerned from what Jason mentioned about long term pins being treated
> differently within the VM. 

Why? They are different. write protect doesn't stop modification of
the data. How is that not a relavent and real difference?

Jason
