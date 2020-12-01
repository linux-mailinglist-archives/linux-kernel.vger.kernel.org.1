Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C87D2C9452
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbgLAAvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730645AbgLAAvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:51:42 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3DFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:50:56 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id u19so402647lfr.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hTzreJVzLotSX8irlBhPZqAylN9milv6wwdHJbswZfM=;
        b=lB69+LPUUaj1ZBcNvsU2p+cK6bIbmBIVipajVEP1yZp7o/DDaeNRl3eYPL1s1ej/pg
         FiFOA4ooV9xJGj8NJADTZOgXw4DcDN8uIWU5cB06U0iENMDdTa68SCxxeIBTmUsyZiHJ
         mBu3AkUks+4/piWuoh/TE1suJPQDRpFvvhdwArUkEOduAfhjZVnNTXR69ks50yPcLIjG
         pb8O+3REqbzJVccxnTHScEGbHria5icsO+3w911yf5oaJ47NNMLC0BILdtNBBmclQWxC
         vm2tn3yDcZ/fRbthPPcI22Fn/aGr+5kJb7oy9go/JwFrJ5qkif6dNaFzTfbZEgwYNTxk
         L1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hTzreJVzLotSX8irlBhPZqAylN9milv6wwdHJbswZfM=;
        b=j5jFZcuZqgAa3TvYOHqeOQ1O39WKcSlr2qp0N/2OfxAeCyuLxfs5k1TxkESwBtAz+N
         sVEH+bIn4MFSsybISVGtI8/VY1nT7Zu//njyoffM7reOrsP695ZUHGIx2CndEkK0d0A7
         /qh3nlzKFZXjeQlFTmwtmcXUqNXy4K4XXRZqGnt6bYlmgFybRx3fb/9A4ULrC1baNtib
         MYnR8+YF7u7sFZKFYHiLz5AB0YWfkFoK2cRDDeS6OoeNib7dFZlu4+lFc0HUoX//pN/C
         Y1W+Y5GFQBx2iZaQ/mrAvV3c3HhjnNEuSI8ocGIMMMnEnlx8MewDu/9FKbOhtno6W4wP
         hOww==
X-Gm-Message-State: AOAM530szIUOULaG0DdIQfAe3WBs4TipF2dGMn8z9U187N6h3+Uj0H2h
        dkNUD12yGiG/spGj5BqkgpOBbjRJRa3xh/k25i54/Q==
X-Google-Smtp-Source: ABdhPJzLDuUoyOaXGvJV7ddixQZrYbkIgtocLcUsFyL1K3QhrUL3QJz7vbX6WUy7OUML2qpgY37GW8Jydd94L3u35SI=
X-Received: by 2002:a19:5015:: with SMTP id e21mr80952lfb.566.1606783854666;
 Mon, 30 Nov 2020 16:50:54 -0800 (PST)
MIME-Version: 1.0
References: <20201127083938.2666770-1-anders.roxell@linaro.org> <CAKwvOdkbPCaJO8c+Zj_BSwfkwcVuMQSFhnxj6PXGo5i86NQ_Zg@mail.gmail.com>
In-Reply-To: <CAKwvOdkbPCaJO8c+Zj_BSwfkwcVuMQSFhnxj6PXGo5i86NQ_Zg@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 1 Dec 2020 01:50:43 +0100
Message-ID: <CADYN=9LRiz8ix9Rb_vMzQsCQs6YmR7CgoVkt8qEbcT=H_NFWHw@mail.gmail.com>
Subject: Re: [PATCH] mips: lib: uncached: fix uninitialized variable 'sp'
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 at 21:22, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Fri, Nov 27, 2020 at 12:39 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > When building mips tinyconfig with clang the following warning show up:
> >
> > /tmp/arch/mips/lib/uncached.c:40:18: note: initialize the variable 'sp' to silence this warning
> >         register long sp __asm__("$sp");
> >                         ^
> >                          = 0
>
> Hi Anders

Hi Nick,

>, thank you for sending the patch. Do you have the full text
> of the warning; it looks like only the note was included?

oops, looks like I missed this:

/srv/src/kernel/next/arch/mips/lib/uncached.c:45:6: warning: variable
'sp' is uninitialized when used here [-Wuninitialized]
        if (sp >= (long)CKSEG0 && sp < (long)CKSEG2)
            ^~
/srv/src/kernel/next/arch/mips/lib/uncached.c:40:18: note: initialize
the variable 'sp' to silence this warning
        register long sp __asm__("$sp");
                        ^
                         = 0
1 warning generated.

Cheers,
Anders

>
> >
> > Rework to make an explicit inline move.
> >
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  arch/mips/lib/uncached.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/mips/lib/uncached.c b/arch/mips/lib/uncached.c
> > index 09d5deea747f..21a4b94a0558 100644
> > --- a/arch/mips/lib/uncached.c
> > +++ b/arch/mips/lib/uncached.c
> > @@ -37,10 +37,11 @@
> >   */
> >  unsigned long run_uncached(void *func)
> >  {
> > -       register long sp __asm__("$sp");
> >         register long ret __asm__("$2");
> >         long lfunc = (long)func, ufunc;
> >         long usp;
> > +       long sp;
> > +       asm ("move %0, $sp" : "=r" (sp));
> >
> >         if (sp >= (long)CKSEG0 && sp < (long)CKSEG2)
> >                 usp = CKSEG1ADDR(sp);
> > --
> > 2.29.2
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
