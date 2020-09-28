Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E52F27B88A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgI1X5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgI1X5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:57:42 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C8DC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 16:57:42 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id n10so2256440qtv.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 16:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jr289Sb1LowRnJCbwbwIDCYxSQ64x8Enfs9iqwh+h9U=;
        b=YWHwPdmVv40s6TS/bg6Gd0qcM1kga54SKTXTa0doxtZ8oSlAWBebc6gcZ4f2FgsC+r
         WfJOwambFCHZut+6E+BwrQdk3wO9Jg7F8u9bOBa00F+/b4pGN62J1FFPDd0V+BcM0BjJ
         z0jCoD9tSujWyOgFJHnH/2o5fP3E7ItHzYPwO8DM1PNj+E73bX3U+h/L4OV2PzeYRdhO
         v4ZJzoUdh3r97iBBqWovHiu9SpJQFZMDZ8zUycLugaZOB01JSiw2WU8PAWSqSfIz31Ip
         8jmYkELq2Hh3rP9rBeg7esrTmOuzyJAn9levkoWMGcF73V3lPmC511TPOCr/YJWdjOPz
         /UWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jr289Sb1LowRnJCbwbwIDCYxSQ64x8Enfs9iqwh+h9U=;
        b=knsEk6jluxIKCE0rAIkwUSs58UUOOnr0uXt+QVD3Zzw6aVSbaqFDusX5mflN2OINO4
         uGjuwDIJcp9Wza6EmGuojiOyzz9Otxjuny13iSSmHuZilfa/S3i857xlcZEhJho14Rrj
         l1xKP21aWWZEuhCyFkrNY5mBC4RhPb3b7EnsQMA2BdzRwt+RW6LjedYi52XaBM3ImHA1
         8DJJjasU47dzgylxRQFBTXPGoOTq1MHwr1Y842uBUHT95eyDVOgMFS2fIr0MolctXHJh
         Pb9M4UGEUZQhvQK0zgCKHNHB6ZirREUbseWCdKQoaGKG9W1rkryqT/FQf5k8c39mW+6N
         cWpw==
X-Gm-Message-State: AOAM531xtz4d2Y6fznVZgMhlc6q91XLU6/LxjmQReeeEg9drnFZS1Jhw
        WAXXv3xiDBqUykPtjmPXFMUdHA==
X-Google-Smtp-Source: ABdhPJwKkSTWsdg8TEwhFijWvMsfDsLOlaz4M0kLaunzGu267STOwjT0NPIjZ0foGkitWmFygEvzMw==
X-Received: by 2002:ac8:192b:: with SMTP id t40mr678472qtj.60.1601337461606;
        Mon, 28 Sep 2020 16:57:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id r21sm3163199qtj.80.2020.09.28.16.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 16:57:40 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kN31Y-002bVC-0Q; Mon, 28 Sep 2020 20:57:40 -0300
Date:   Mon, 28 Sep 2020 20:57:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Leon Romanovsky <leonro@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Message-ID: <20200928235739.GU9916@ziepe.ca>
References: <CAHk-=wi_gd+JWj-8t8tc8cy3WZ7NMj-_1hATfH3Rt0ytUxtMpQ@mail.gmail.com>
 <20200927062337.GE2280698@unreal>
 <CAHk-=winqSOFsdn1ntYL13s2UuhpQQ9+GRvjWth3sA5APY4Wwg@mail.gmail.com>
 <CAHk-=wj61s30pt8POVtKYVamYTh6h=7-_ser2Hx9sEjqeACkDA@mail.gmail.com>
 <20200928124937.GN9916@ziepe.ca>
 <CAHk-=wj6aTsqq6BAUci-NYJ3b-EkDwVgz_NvW_kW8KBqGocouQ@mail.gmail.com>
 <20200928172256.GB59869@xz-x1>
 <CAHk-=wi=iCnYCARbPGjkVJu9eyYeZ13N64tZYLdOB8CP5Q_PLw@mail.gmail.com>
 <20200928183928.GR9916@ziepe.ca>
 <CAHk-=wiRHLVK7Usrfdbh0MF7b86NLZ7gBWHV-Y89K_p3GU4KQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiRHLVK7Usrfdbh0MF7b86NLZ7gBWHV-Y89K_p3GU4KQg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 12:29:55PM -0700, Linus Torvalds wrote:
> So a read pin action would basically never work for the fast-path for
> a few cases, notably a shared read-only mapping - because we could
> never mark it in the page tables as "fast pin accessible"

Agree, I was assuming we'd loose more of the fast path to create this
thing. It would only still be fast if the pages are already writable.

I strongly suspect the case of DMA'ing actual read-only data is the
minority here, the usual case is probably filling a writable buffer
with something interesting and then triggering the DMA. The DMA just
happens to be read from the driver view so the driver doesn't set
FOLL_WRITE.

Looking at the FOLL_LONGTERM users, which should be the banner usecase
for this, there are very few that do a read pin and use fast.

> And it would basically have no advantages over a writable FOLL_PIN. It
> would break the association with any backing store for private pages,
> because otherwise it can't follow future writes.

Yes, I wasn't clear enough, I'm looking at this from a driver API
perspective. We have this API

  pin_user_pages(FOLL_LONGTERM | FOLL_WRITE)

Which now has no decoherence issues with the MM. If the driver
naturally wants to do read-only access it might be tempted to do:

  pin_user_pages(FOLL_LONGTERM)

Which is now NOT the same thing and brings all these really surprising
mm coherence issues back.

The driver author might discover this in testing, then be tempted to
hardwire 'FOLL_LONGTERM | FOLL_WRITE'. Now their uAPI is broken for
things that are actually read-only like .rodata.

If they discover this then they add a FOLL_FORCE to the mix.

When someone comes along to read this later it is a big leap to see
  pin_user_pages(FOLL_LONGTERM | FOLL_FORCE | FOLL_WRITE)

and realize this is code for "read only mapping". At least it took me
a while to decipher it the first time I saw it.

I think this is really hard to use and ugly. My thinking has been to
just stick:

   if (flags & FOLL_LONGTERM)
       flags |= FOLL_FORCE | FOLL_WRITE

In pin_user_pages(). It would make the driver API cleaner. If we can
do a bit better somehow by not COW'ing for certain VMA's as you
explained then all the better, but not my primary goal..

Basically, I think if a driver is using FOLL_LONGTERM | FOLL_PIN we
should guarentee that driver a consistent MM and take the gup_fast
performance hit to do it.

AFAICT the giant wack of other cases not using FOLL_LONGTERM really
shouldn't care about read-decoherence. For those cases the user should
really not be racing write's with data under read-only pin, and the
new COW logic looks like it solves the other issues with this.

I know Jann/John have been careful to not have special behaviors for
the DMA case, but I think it makes sense here. It is actually different.

Jason
