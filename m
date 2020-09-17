Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B074326E6CF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgIQUgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgIQUgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:36:17 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D493C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 13:36:17 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y4so3177889ljk.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 13:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RwZiLc6S8KRXpHX9Z3VeVt6Qzg9ortSMhRW1DWsmxfU=;
        b=Gw4YF1Eo+YJ8TgEJHuR+iXYu0AX9ZB/vRTZi5W6owfBh+Fzo/uWlGdJHJMsfQur04/
         Z12gGwxut2GKxd4MZW/Z8FgdJkaUGpnh+akWrazKSRsVrmkIChvw5UjjR7WQqUy9/mBm
         kEVmmYqN1HhbreponBnTKCuEJjAtHoKKQ8kHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RwZiLc6S8KRXpHX9Z3VeVt6Qzg9ortSMhRW1DWsmxfU=;
        b=I0mFwJhNfeNRnYnddWKyt7iBtDRoEK6PwBkpXlJwtwmHAwrimamEs+VBj25oPhnHmn
         ajDndGFCK1SJCxXd4S0JPyH257HDWOjLDCqxLynfAdshvRGqec81/7hmU6wXdVP3DDZj
         6KOx3ngZ4YksK8PRKVEJysekhg1T2CtJvETVCnB9KNIkJYyUvvBVtFfr54eAhCcW2dIt
         TCFaECcdwIRJ77CiWUXeDzZt9rLfG9EmgVvbqn6AO9ZAH/SPN92O2O9fIPB7D7V639i6
         lx0e9Kpx6+d6x9Og2POvaeSmbD/AzB69JxYf4qnBajPvvHlDqGefkLyeNrFSUyG3czDq
         Z0aw==
X-Gm-Message-State: AOAM5304ZLRDr+/cdtmKjp2ULUugwNlnN7MdyiH9cLDX1UyYhFXYecHg
        LTTatmaD63EnNqusA+4mgMfWUBSlFE4XYw==
X-Google-Smtp-Source: ABdhPJz4Kv1LerkZ1tol0f7e5Lz6zsU7FRD3jIRUSUH/Qmz/4R6/0iCrSNioWsphEId8441jgLiqjA==
X-Received: by 2002:a2e:8ed9:: with SMTP id e25mr10328286ljl.404.1600374975119;
        Thu, 17 Sep 2020 13:36:15 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id h124sm119989lfd.203.2020.09.17.13.36.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 13:36:13 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id z17so3619839lfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 13:36:12 -0700 (PDT)
X-Received: by 2002:ac2:4ec7:: with SMTP id p7mr8748891lfr.352.1600374972561;
 Thu, 17 Sep 2020 13:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200915213330.GE2949@xz-x1> <20200915232238.GO1221970@ziepe.ca>
 <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com> <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1> <20200917112538.GD8409@ziepe.ca>
 <20200917181411.GA133226@xz-x1> <CAHk-=wgMVPAhD7C24ipe03+MScgp6F=zMS-roOznvxJ+hOGfSA@mail.gmail.com>
 <20200917190332.GB133226@xz-x1> <CAHk-=wgw3GNyF_6euymOFxM62Y3B=C=f2iUJn8Py-u5YELJ5JA@mail.gmail.com>
 <20200917200638.GM8409@ziepe.ca>
In-Reply-To: <20200917200638.GM8409@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Sep 2020 13:35:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+qz0oOjyiQFXR_73RYSDUmJwHC8xd=KG0RzELnbS5OA@mail.gmail.com>
Message-ID: <CAHk-=wh+qz0oOjyiQFXR_73RYSDUmJwHC8xd=KG0RzELnbS5OA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Peter Xu <peterx@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 1:06 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> Given that this is a user visible regression, it is nearly rc6, what
> do you prefer for next steps?

Since I had to deal with the page lock performance regression too, and
I think we have a fairly simple way forward, I'd rather do an rc8 and
get this done with, than revert and know we have to deal with it
anyway.

Particularly since I think this would _finally_ make page pinning make
sense. In it's current state, it's just yet another broken GUP that
doesn't actually fix things. But if we have the semantics that page
pinning really fixes things in the page tables, I think we now have a
proper solution to this and a _much_ cleaner model for it.

If it means that page pinning can also stop worrying about
MADV_DONTFORK any more, that would be an added API bonus.

For that to happen, we'd need to have the vma flag so that we wouldn't
have any worry about non-pinners, but as you suggested, I think even
just a mm-wide counter - or flag - to deal with the fast-bup case is
likely perfectly sufficient.

Yes, you'd still take a hit on fork, but only the actual process that
did pinning would take that hit. And *if* that ends up being a big
deal, the MADV_DONTFORK can be used to avoid it, rather than be a
correctness issue.

It really feels like this should be just "tens of lines of fairly
simple code", and it would clarify our GUP/PIN/COW rules enormously.

            Linus
