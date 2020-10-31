Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A46F2A1A4D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 20:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgJaTvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 15:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgJaTvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 15:51:05 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95392C0617A6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 12:51:05 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id l28so12198356lfp.10
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 12:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LiakrPlGp3igHM/6fphDsdHN4n1+gIPlYP0eHS2J38c=;
        b=SFd38h0YaAG3EVDBMFA8YIEBKo1Whx1Fuoqa5Z1RwOcinbEUBfuT5ib+oz2EUbWXQt
         SPktpQcp30PqY2Ni8wgEZYWrGyBja5NxjglfpeIAdx6NpxhOJXtSOHlPEu5RfT1OAG7r
         /VitCVlOWSEFQRU/6GHFAOb2b6dy1k04HEDuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LiakrPlGp3igHM/6fphDsdHN4n1+gIPlYP0eHS2J38c=;
        b=jWKjOI07VXzrzj8fmU46NftpXT2imCC4cJI+rBw1/8rABekZEA5wdjj3/pXdb1PRGk
         /AB8oai/aLJZyirTNW2q3GITytX/FrSW2OgNlDnyyjAm4o6D9oSbwrWDJyJygpxRyEXQ
         Qd1gxl74dhODSm+ku9+1LcWvcfC1Yuh2/A01JX8yoGDfEdGDzpogppWIV5VOqttjPOEx
         fcrapSU0FkcvwSxaglahlPCsOKqZAB4csXFTm/wMpOF5lmI8WUiJCrQriQ4RAsRnWwu5
         R6//A1r7LN4091cu0tfK6F/0i/YGAb30hFGKPfLGnyHApZOWvw59D4a7SG4lPgewojIS
         glpQ==
X-Gm-Message-State: AOAM530u2CI7w7UNq5s5OtxeGawwIqsNidZhQONOxIHGqblAuGjfhNLi
        7IJ2Ftke67qsq8stfSWBeFI+o6rl0PUyww==
X-Google-Smtp-Source: ABdhPJwkmC4VNvelXP1XWvTMYWkTt10V+YGQMQfnHvqNZEseOMtiwxjgDKCL6sxh1XD0f+6rJjZo3Q==
X-Received: by 2002:a05:6512:3495:: with SMTP id v21mr2842479lfr.134.1604173862193;
        Sat, 31 Oct 2020 12:51:02 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id g14sm1199113ljn.67.2020.10.31.12.51.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2020 12:51:01 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id m8so4581989ljj.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 12:51:00 -0700 (PDT)
X-Received: by 2002:a2e:3e1a:: with SMTP id l26mr3610904lja.285.1604173860298;
 Sat, 31 Oct 2020 12:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201031093823.GA453843@infradead.org>
In-Reply-To: <20201031093823.GA453843@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 31 Oct 2020 12:50:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgetKKWar8M0VW4mXBY4p5_oCMH=nvU001pkozEgsMEKg@mail.gmail.com>
Message-ID: <CAHk-=wgetKKWar8M0VW4mXBY4p5_oCMH=nvU001pkozEgsMEKg@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping fix for 5.10
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 2:40 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> dma-mapping fix for 5.10:
>
>  - fix an integer overflow on 32-bit platforms in the new DMA range code
>    (Geert Uytterhoeven)

So this is just a stylistic nit, and has no impact on this pull (which
I've done). But looking at the patch, it triggers one of my "this is
wrong" patterns.

In particular, this:

        u64 dma_start = 0;
        ...
        for (dma_start = ~0ULL; r->size; r++) {

is actually completely bogus in theory, and it's a horribly horribly
bad pattern to have.

The thing that I hate about that parttern is "~0ULL", which is simply wrong.

The correct pattern for "all bits set" is ~0. NOTHING ELSE. No extra
letters at the end.

Why? Because using an unsigned type is wrong, and will not extend the
bits up to a potentially bigger size.

So adding that "ULL" is not just three extra characters to type, it
actually _detracts_ from the code and makes it more fragile and
potentially wrong.

It so happens, that yes, in the kernel, "ull" us 64-bit, and you get
the right results. So the code _works_. But it's wrong, and it now
requires that the types match exactly (ie it would not be broken if
somebody ever were to say "I want to use use 128-bit dma addresses and
u128").

Another example is using "~0ul", which would give different results on
a 32-bit kernel and a 64-bit kernel. Again: DON'T DO THAT.

I repeat: the right thing to do for "all bits set" is just a plain ~0
or -1. Either of those are fine (technically assumes a 2's complement
machine, but let's just be honest: that's a perfectly fine assumption,
and -1 might be preferred by some because it makes that sign extension
behavior of the integer constant more obvious).

Don't try to do anything clever or anything else, because it's going
to be strictly worse.

The old code that that patch removed was "technically correct", but
just pointless, and actually shows the problem:

        for (dma_start = ~(dma_addr_t)0; r->size; r++) {

the above is indeed a correct way to say "I want all bits set in a
dma_addr_t", but while correct, it is - once again - strictly inferior
to just using "~0".

Why? Because "~0" works regardless of type. IOW, exactly *because*
people used the wrong pattern for "all bits set", that patch was now
(a) bigger than necessary and (b) much more ilkely to cause bugs (ie I
could have imagined people changing just the type of the variable
without changing the initialization).

So in that tiny three-line patch there were actually several examples
of why "~0" is the right pattern to use for "all bits set". Because it
JustWorks(tm) in ways other patterns do not.

And if you have a compiler that complains about assigning -1 or ~0 to
an unsigned variable, get rid of that piece of garbage. You're almost
certainly either using some warning flag that you shouldn't be using,
or the compiler writer didn't know what they were doing.

            Linus
