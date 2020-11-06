Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A771E2A920A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgKFJDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgKFJDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:03:34 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7737C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 01:03:33 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id h62so619982oth.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 01:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXXvxPLeZ0ZgicbNMUP+ayy35qo6/4lRgD84ddHygf8=;
        b=dllwsNe+675HsXKQuBe0cCmuH+q/b2r+ekFaL7oZ0A5HUg7OEjDg/RLUYexOcbASBD
         8pV4JqvCL86fFOR4Gnxo9lu5ZJdncJvDUCqYUjfFpBs6vT13XZK2dYMRxL/tt/i5vRxz
         DMS/Zlakx50hvra67t4XusA8zTB+Jv+OnBBYgxW+eDbxKPGVPQepiWbVAx2vF/sH4bVf
         QB7hlEAUtMHcFvBaVxkrkflcuaiLflUfW2cpQcy9t6FuFWwp94A/v6dq7h6MwBTCSXX0
         8Uk2G6B4uAOkS/DqOonOTfVthI+D6LRYgA77Gl5C80NGHawV44eiXvK7Z4bAm5fD8QaR
         fDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXXvxPLeZ0ZgicbNMUP+ayy35qo6/4lRgD84ddHygf8=;
        b=ojUwgigkIgZsX7twZvZaVYVNBzPXDW9ty/HEJ4ADvgBXOV8eO5yHADNKNtIO9ZRM1c
         SKYrk+mVheqjLjsboZIR/RDDoTaC1yacA25HcWpMhcggD9/IY+mNdSwtXOMXg2OsvzTr
         RqmS8Zv5aIQ1xglUTO2qP6Cpl3Lbc6lOgKdxxjYa2rjGskRjdfAxqOK26cqLjlsvpbjy
         Dc5oO8qv77YpoeSg4P0JLd8uBf4oYc8sim4LoKe7j47BDXylBB/jngv1FOu5l5m+UjzJ
         5wbyAsF8LBKu6GZdbWmbQS8r6NSxsC+LgKmou3W2pqI3o8CksNO8rCNMjZI9DoHnblIF
         nThg==
X-Gm-Message-State: AOAM5303EhSeU7ItkRXaovH+z1dqdThQ+wA1vy7DPK1stcssSc5YoJGx
        ky/0QYRTn2q+C0Yk0Ua8FnnWx1mgnVLOxxjS6DMMKA==
X-Google-Smtp-Source: ABdhPJwLec9uPAkkHvc+ZZ/XmFfIogSf4M0RSuwlFIPtKL08BK5KdDgIfwUUJ4YAn/xcGnAg9RNoy2kwd6L5CGiKzbA=
X-Received: by 2002:a9d:65d5:: with SMTP id z21mr446676oth.251.1604653412954;
 Fri, 06 Nov 2020 01:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20201105220302.GA15733@paulmck-ThinkPad-P72> <20201105220324.15808-3-paulmck@kernel.org>
 <20201106012335.GA3025@boqun-archlinux>
In-Reply-To: <20201106012335.GA3025@boqun-archlinux>
From:   Marco Elver <elver@google.com>
Date:   Fri, 6 Nov 2020 10:03:21 +0100
Message-ID: <CANpmjNNj1cc2LUrLdbYy1QkVv80HUPztPXmLfscYB=pU_nffaA@mail.gmail.com>
Subject: Re: [PATCH kcsan 3/3] kcsan: Fix encoding masks and regain address bit
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, kernel-team@fb.com,
        Ingo Molnar <mingo@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Nov 2020 at 02:23, Boqun Feng <boqun.feng@gmail.com> wrote:
> Hi Marco,
>
> On Thu, Nov 05, 2020 at 02:03:24PM -0800, paulmck@kernel.org wrote:
> > From: Marco Elver <elver@google.com>
> >
> > The watchpoint encoding masks for size and address were off-by-one bit
> > each, with the size mask using 1 unnecessary bit and the address mask
> > missing 1 bit. However, due to the way the size is shifted into the
> > encoded watchpoint, we were effectively wasting and never using the
> > extra bit.
> >
> > For example, on x86 with PAGE_SIZE==4K, we have 1 bit for the is-write
> > bit, 14 bits for the size bits, and then 49 bits left for the address.
> > Prior to this fix we would end up with this usage:
> >
> >       [ write<1> | size<14> | wasted<1> | address<48> ]
> >
> > Fix it by subtracting 1 bit from the GENMASK() end and start ranges of
> > size and address respectively. The added static_assert()s verify that
> > the masks are as expected. With the fixed version, we get the expected
> > usage:
> >
> >       [ write<1> | size<14> |             address<49> ]
> >
> > Functionally no change is expected, since that extra address bit is
> > insignificant for enabled architectures.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/kcsan/encoding.h | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
> > index 4f73db6..b50bda9 100644
> > --- a/kernel/kcsan/encoding.h
> > +++ b/kernel/kcsan/encoding.h
> > @@ -37,14 +37,12 @@
> >   */
> >  #define WATCHPOINT_ADDR_BITS (BITS_PER_LONG-1 - WATCHPOINT_SIZE_BITS)
> >
> > -/*
> > - * Masks to set/retrieve the encoded data.
> > - */
> > -#define WATCHPOINT_WRITE_MASK BIT(BITS_PER_LONG-1)
> > -#define WATCHPOINT_SIZE_MASK                                                   \
> > -     GENMASK(BITS_PER_LONG-2, BITS_PER_LONG-2 - WATCHPOINT_SIZE_BITS)
> > -#define WATCHPOINT_ADDR_MASK                                                   \
> > -     GENMASK(BITS_PER_LONG-3 - WATCHPOINT_SIZE_BITS, 0)
> > +/* Bitmasks for the encoded watchpoint access information. */
> > +#define WATCHPOINT_WRITE_MASK        BIT(BITS_PER_LONG-1)
> > +#define WATCHPOINT_SIZE_MASK GENMASK(BITS_PER_LONG-2, BITS_PER_LONG-1 - WATCHPOINT_SIZE_BITS)
> > +#define WATCHPOINT_ADDR_MASK GENMASK(BITS_PER_LONG-2 - WATCHPOINT_SIZE_BITS, 0)
> > +static_assert(WATCHPOINT_ADDR_MASK == (1UL << WATCHPOINT_ADDR_BITS) - 1);
>
> Nit:
>
> Since you use the static_assert(), why not define WATCHPOINT_ADDR_MASK
> as:
>
> #define WATCHPOINT_ADDR_MASK (BIT(WATCHPOINT_SIZE_BITS) - 1)

This is incorrect, as the static_assert()s would have indicated. It
should probably be (BIT(WATCHPOINT_ADDR_BITS) - 1)?

As an aside, I explicitly did *not* want to use additional arithmetic
to generate the masks but purely rely on BIT(), and GENMASK(), as it
would be inconsistent otherwise. The static_assert()s then sanity
check everything without BIT+GENMASK (because I've grown slightly
paranoid about off-by-1s here). So I'd rather not start bikeshedding
about which way around things should go.

In general, GENMASK() is safer, because subtracting 1 to get the mask
doesn't always work, specifically e.g. (BIT(BITS_PER_LONG) - 1) does
not work.

> Besides, WATCHPOINT_SIZE_MASK can also be defined as:

No, sorry it cannot.

> #define WATCHPOINT_SIZE_MASK GENMASK(BITS_PER_LONG - 2, WATCHPOINT_SIZE_BITS)

   GENMASK(BITS_PER_LONG - 2, WATCHPOINT_SIZE_BITS)

is not equivalent to the current

  GENMASK(BITS_PER_LONG-2, BITS_PER_LONG-1 - WATCHPOINT_SIZE_BITS)

Did you mean GENMASK(BITS_PER_LONG-2, WATCHPOINT_ADDR_BITS)? I can
send a v2 for this one.

Thanks,
-- Marco
