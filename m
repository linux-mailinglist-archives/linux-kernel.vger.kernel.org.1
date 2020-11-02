Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DD02A289E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgKBLA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:00:28 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45575 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbgKBLA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:00:28 -0500
Received: by mail-ot1-f65.google.com with SMTP id k3so336984otp.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:00:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Est9z1fD3Li8EgxUfKLKw9jqrC1ujvYEuzVL+Qvht4A=;
        b=fdcK3y5sKE2r0iTzk78VmtiEGWvmhWRk6TY8KAvsHvWHPNQqgoA66QvIegKujjT8Ca
         Gk+AxJ7XZ+wNICng2DSSQ26L/+Y09ADV2TkuRubM4UOQwjLK+tJGECqKqUstJxAjjhlT
         2/lEGIi+yFFT8sQlcU3mxhYW8uelclVp7sbBpnM9wSBm7cXsFEeeMl07xOPU5Qmu5Tbc
         s4De7eon9N+95lhxn08PLG0Otho3dogAMF25N6TVRR5sHOVA+EZYi0R4VC7GkhFbMI+u
         Jd/SG5Ex0SDIIPjBNvx4d1laexfh+MbO+zjuee8xyhcC8rS24c+pYS/8ekYl3g2Oe9Ty
         TBgA==
X-Gm-Message-State: AOAM532naoAyK68anu50udTaQ/EWTkbUB3rWpPZtMnf8OquXnShhL7Pr
        bnBSHk0lIKOweowmcmKX58NSMUwxTV97B17gPoA=
X-Google-Smtp-Source: ABdhPJyBpL+PeeLUEXiVaPZCo+Jvm31VUCsN3zE+dXDJ1eFI4W9tfAA3CcQBA6aMvyEvrPeYxISX9Ot8L7tpC9vlADo=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr11484382otc.145.1604314825756;
 Mon, 02 Nov 2020 03:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20201031093823.GA453843@infradead.org> <CAHk-=wgetKKWar8M0VW4mXBY4p5_oCMH=nvU001pkozEgsMEKg@mail.gmail.com>
In-Reply-To: <CAHk-=wgetKKWar8M0VW4mXBY4p5_oCMH=nvU001pkozEgsMEKg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Nov 2020 12:00:14 +0100
Message-ID: <CAMuHMdVyL7_VaqfVPxESmPBe=pntcRdB3_PEArU4JQasX0EBfA@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping fix for 5.10
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sat, Oct 31, 2020 at 8:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, Oct 31, 2020 at 2:40 AM Christoph Hellwig <hch@infradead.org> wrote:
> > dma-mapping fix for 5.10:
> >
> >  - fix an integer overflow on 32-bit platforms in the new DMA range code
> >    (Geert Uytterhoeven)
>
> So this is just a stylistic nit, and has no impact on this pull (which
> I've done). But looking at the patch, it triggers one of my "this is
> wrong" patterns.
>
> In particular, this:
>
>         u64 dma_start = 0;
>         ...
>         for (dma_start = ~0ULL; r->size; r++) {
>
> is actually completely bogus in theory, and it's a horribly horribly
> bad pattern to have.
>
> The thing that I hate about that parttern is "~0ULL", which is simply wrong.
>
> The correct pattern for "all bits set" is ~0. NOTHING ELSE. No extra
> letters at the end.
>
> Why? Because using an unsigned type is wrong, and will not extend the
> bits up to a potentially bigger size.
>
> So adding that "ULL" is not just three extra characters to type, it
> actually _detracts_ from the code and makes it more fragile and
> potentially wrong.
>
> It so happens, that yes, in the kernel, "ull" us 64-bit, and you get
> the right results. So the code _works_. But it's wrong, and it now
> requires that the types match exactly (ie it would not be broken if
> somebody ever were to say "I want to use use 128-bit dma addresses and
> u128").

Thanks, you're right, the "ULL" suffix is not needed, and could cause
future issues.

> Another example is using "~0ul", which would give different results on
> a 32-bit kernel and a 64-bit kernel. Again: DON'T DO THAT.

Definitely.

> I repeat: the right thing to do for "all bits set" is just a plain ~0
> or -1. Either of those are fine (technically assumes a 2's complement
> machine, but let's just be honest: that's a perfectly fine assumption,
> and -1 might be preferred by some because it makes that sign extension
> behavior of the integer constant more obvious).

"-1" definitely causes warnings, depending on your compiler (not with
the gcc 9.3.0 I'm currently using, though).

> Don't try to do anything clever or anything else, because it's going
> to be strictly worse.
>
> The old code that that patch removed was "technically correct", but
> just pointless, and actually shows the problem:
>
>         for (dma_start = ~(dma_addr_t)0; r->size; r++) {
>
> the above is indeed a correct way to say "I want all bits set in a
> dma_addr_t", but while correct, it is - once again - strictly inferior
> to just using "~0".

Obviously I was misled by the old code, and instead of changing
the cast, I replaced the cast ("casts are evil") by a suffix. Doh.

Any, I've just sent a patch. Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
