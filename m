Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F75292929
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 16:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgJSOU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 10:20:27 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40798 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbgJSOU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:20:27 -0400
Received: by mail-ot1-f67.google.com with SMTP id l4so10589192ota.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSZD68KgH6J8n0TsKEj3FYbh8TtU9mDRru3UCK5I58M=;
        b=ELriHr7a3RvVK48P5aXIlm7cksmShYK3j8Dn9auDt9F/laDdMkEY2DjtGe/WuW0phP
         PdXNKvJfbPPY3qPLqGWO+8BGo36qdzvv9j5wxRQnAROe3XqjxNrj/9g35cO17yxwnbzW
         QSVYANA/3HxGd9JD2wsmhJwBrDRhlGma+hG1ZUM+zSP1Ym7AXY7dGax61FqWhx8H15Gf
         T/Ftqfl0FMwHCG8SsifelZ8ZF1td1XBwGjukRZEmFqJaA0/T+jAnPYL1RKoSvceD0Wzw
         IrR00OgOCSiHnMXZ08RrEm7maDgDzJYKvWST6+Yclx2wUDHV0CTq67GVitsytPrw2F8Z
         ZYrw==
X-Gm-Message-State: AOAM530MakxtxmMxaEPi+Lpah261njCc7kIyBs+MdrrclKCixF7g4GVO
        xwJ9d6vif3CIAVi36jq+2RdmDN3I6AXOes2jnIg=
X-Google-Smtp-Source: ABdhPJyqkv29FCQrwAmvYlk+y7XfRJqtjA+pksFqxK/61n8WnaPLKwSUzNmW0fMZo3krbo3ooOiAhjGfkZitmoyDSXY=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr149588otc.145.1603117226046;
 Mon, 19 Oct 2020 07:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201018140445.20972-1-geert@linux-m68k.org> <20201018142508.GJ20115@casper.infradead.org>
 <CAMuHMdVcTx0wVTSh-YaJxXqCMpCxGRe3QH36O5i+McinfdRwDg@mail.gmail.com>
 <20201018150146.GK20115@casper.infradead.org> <20201018171252.GA392079@kernel.org>
 <20201019140505.GR20115@casper.infradead.org>
In-Reply-To: <20201019140505.GR20115@casper.infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Oct 2020 16:20:14 +0200
Message-ID: <CAMuHMdUD0n=xEK3rG4PqmZ5fjKPtWJGKTu-DEdNPDfc=GR9g4Q@mail.gmail.com>
Subject: Re: [PATCH] lib/test_free_pages: Add basic progress indicators
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Mon, Oct 19, 2020 at 4:05 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Sun, Oct 18, 2020 at 08:12:52PM +0300, Mike Rapoport wrote:
> > On Sun, Oct 18, 2020 at 04:01:46PM +0100, Matthew Wilcox wrote:
> > > On Sun, Oct 18, 2020 at 04:39:27PM +0200, Geert Uytterhoeven wrote:
> > > > On Sun, Oct 18, 2020 at 4:25 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > On Sun, Oct 18, 2020 at 04:04:45PM +0200, Geert Uytterhoeven wrote:
> > > > > > The test module to check that free_pages() does not leak memory does not
> > > > > > provide any feedback whatsoever its state or progress, but may take some
> > > > > > time on slow machines.  Add the printing of messages upon starting each
> > > > > > phase of the test, and upon completion.
> > > > >
> > > > > It's not supposed to take a long time.  Can you crank down that 1000 *
> > > >
> > > > It took 1m11s on ARAnyM, running on an i7-8700K.
> > > > Real hardware may even take longer.
> > >
> > > 71 seconds is clearly too long.  0.7 seconds would be fine, so 10 * 1000
> > > would be appropriate, but then that's only 320MB which might not be
> > > enough to notice on a modern machine.
> > >
> > > > > 1000 to something more appropriate?
> > > >
> > > > What would be a suitable value? You do want to see it "leak gigabytes
> > > > of memory and probably OOM your system" if something's wrong,
> > > > so decreasing the value a lot may not be a good idea?
> > > >
> > > > Regardless, if it OOMs, I think you do want to see this happens
> > > > while running this test.
> > >
> > > How about scaling with the amount of memory on the machine?
> > >
> > > This might cause problems on machines with terabytes of memory.
> > > Maybe we should cap it at a terabyte?
> >
> > On ARAnyM wih 782 MBytes of RAM running on i7-8650U it takes ~1.75
> > seconds.
>
> That seems like a somewhat unusual configuration.  I think it's pretty
> strange to find an actual m68k with more than 128MB of memory.  I mean,
> I can set up my laptop to believe it has 64TB of memory, and this will
> run slowly, but I don't think it's any real problem.

Have you tried it on one of your parisc boxes? They tend to have quite
some RAM, compared to CPU speed.

I gave the unmodified test a try on a 1.5 GHz Cortex-A15, which is still
a decent arm32 system, and it took 4.25s.

> > Still, I think adding some verbosity to the test wouldn't hurt ;-)
>
> I prefer the unix philosophy of only emitting messages if something's
> wrong.

This is not a normal program, but a test.
Alternatively, convert it to kunit, so we'll at least be aware when
it starts running, and when it has completed ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
