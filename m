Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D882F4286
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 04:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbhAMDcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 22:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbhAMDcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 22:32:06 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CCEC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 19:31:26 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id s26so656494lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 19:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CH+xsIRM+IV0uinVWZZSPxYmWLGJmAD6nwl0cbAWTi4=;
        b=Vgjl7SKuukjWFtnm7i3ijVQrIXWvFzxtoe/B4OnSHO3sGSWu7IPVs4gEMtptVVrJH9
         rGL5Gzd9pD0dU+kkbFRXafvsqm107Yx5JFtNWGTnl6xau+f57pdALjQESjacpWyhmt57
         e8wmN5OnfVL4Iv/iOEQ9nCjD9Yb7schG5pB+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CH+xsIRM+IV0uinVWZZSPxYmWLGJmAD6nwl0cbAWTi4=;
        b=laLJga+UbZ5jHznzeMuJn38qNAqYqHVSgl5efIl03KRKTrKS5Rr+i+jJIJpabJe8Yk
         sYxg/GYhyvyasoe+TIJMyqoeONqxQ3sO6Q0toNwn092inJRsj0FmrQknGaW8g/OfAzGl
         PqyFMQAn9vFUozIXJah8NlsBtX911eiZOl6Xzf2Gbj8S5BH/iECnIqVrv5PGDzkkSgmf
         3009P0q+DEK3bURdJW66pbb4seXug793tXD7QCDTKHuXGZq1SM3GH3LLu43PNqH857+X
         NlG+ZE9w0gX3IxOD6porY2G626G8ZeLMEZWIE98UgGAjMC3XB6O2w7MVdhlo6g3j6Bye
         uNDA==
X-Gm-Message-State: AOAM532ZllvJbDUso2TBaFZOwei01Kt95mYBg0wZKe3iy85bU6sx5vM2
        EwYeeTPjoNdnVu3CHaVEWrGHvPb54Kex3w==
X-Google-Smtp-Source: ABdhPJwpk8fV8jqtSAP3aUzp4dDvGuoMAf5c124EsTzXBAw6XXTaGk7g/aNZ0z+9lJD0n1oxBEq0DA==
X-Received: by 2002:ac2:4d28:: with SMTP id h8mr913805lfk.263.1610508684480;
        Tue, 12 Jan 2021 19:31:24 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id a7sm64879lfb.78.2021.01.12.19.31.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 19:31:24 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id m13so916668ljo.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 19:31:23 -0800 (PST)
X-Received: by 2002:a2e:b4af:: with SMTP id q15mr1030700ljm.507.1610508683314;
 Tue, 12 Jan 2021 19:31:23 -0800 (PST)
MIME-Version: 1.0
References: <20210110004435.26382-1-aarcange@redhat.com> <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
 <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
 <X/prosulFrEoNnoF@redhat.com> <CAHk-=wjZTMsv0_GOyQpLRk_5U1r5W8e21f8sV0jykK=z47hjGQ@mail.gmail.com>
 <CAHk-=wgi31FKc9AL6m87+pb2B79V2g_QjdhmtJNW8Pnq2ERQ-Q@mail.gmail.com>
 <45806a5a-65c2-67ce-fc92-dc8c2144d766@nvidia.com> <CAHk-=wipa-9wEuWHBjourmXAVHdeqDa59UxW6ZJ_Oqg6-Dwvdw@mail.gmail.com>
 <CAHk-=wje9r3fREBdZcOu=NihGczBtkqkhXRPDhY-ZkNVv=thiQ@mail.gmail.com> <20210113021619.GL35215@casper.infradead.org>
In-Reply-To: <20210113021619.GL35215@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jan 2021 19:31:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjWMieNV3nAJgoG5prEHBEcOZiREmLUr499tA9NMttEqQ@mail.gmail.com>
Message-ID: <CAHk-=wjWMieNV3nAJgoG5prEHBEcOZiREmLUr499tA9NMttEqQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
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
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 6:16 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> The thing about the speculative page cache references is that they can
> temporarily bump a refcount on a page which _used_ to be in the page
> cache and has now been reallocated as some other kind of page.

Oh, and thinking about this made me think we might actually have a
serious bug here, and it has nothing what-so-ever to do with COW, GUP,
or even the page count itself.

It's unlikely enough that I think it's mostly theoretical, but tell me
I'm wrong.

PLEASE tell me I'm wrong:

CPU1 does page_cache_get_speculative under RCU lock

CPU2 frees and re-uses the page

    CPU1                CPU2
    ----                ----

    page = xas_load(&xas);
    if (!page_cache_get_speculative(page))
            goto repeat;
    .. succeeds ..

                        remove page from XA
                        release page
                        reuse for something else

    .. and then re-check ..
    if (unlikely(page != xas_reload(&xas))) {
            put_page(page);
            goto repeat;
    }

ok, the above all looks fine. We got the speculative ref, but then we
noticed that its' not valid any more, so we put it again. All good,
right?

Wrong.

What if that "reuse for something else" was actually really quick, and
both allocated and released it?

That still sounds good, right? Yes, now the "put_page()" will be the
one that _actually_ releases the page, but we're still fine, right?

Very very wrong.

The "reuse for something else" on CPU2 might have gotten not an
order-0 page, but a *high-order* page. So it allocated (and then
immediately free'd) maybe an order-2 allocation with _four_ pages, and
the re-use happened when we had coalesced the buddy pages.

But when we release the page on CPU1, we will release just _one_ page,
and the other three pages will be lost forever.

IOW, we restored the page count perfectly fine, but we screwed up the
page sizes and buddy information.

Ok, so the above is so unlikely from a timing standpoint that I don't
think it ever happens, but I don't see why it couldn't happen in
theory.

Please somebody tell me I'm missing some clever thing we do to make
sure this can actually not happen..

         Linus
