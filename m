Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E9121F832
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 19:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgGNRav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 13:30:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42931 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgGNRav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:30:51 -0400
Received: by mail-ot1-f67.google.com with SMTP id g37so13625772otb.9;
        Tue, 14 Jul 2020 10:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/cNHRoFa4ZZjmVaGoyconZpvhXMck6nqNSnofkb4M4=;
        b=nrNtTWExrjtJQTMqOuFC0PAiJU1mI/zJaZ5gl6ioFdR3nAr+sVfZYOg8crKEvKjSXm
         dyVHI8L40O/1VV5iEXwufeH8Uy1WBT5jDCqtjv8SEgLEU/qWYha2Kqq9AbHOOGN+/aQM
         8pnjatAYfL1KJI1pF2e741MZ4Squs58N8rmMlHFYdAW2gGwLk50l6VSKoeqGv9Lr3YLO
         7tdbAXi5B2ozV+GR0VZGUicWeZNhJs+BgX/n6gZPImmD0YqMAwzH27A4qUL/m3Rj1ng5
         cULTWwcxf00Qsq7T0Ffa896lhDZemrI5hxgx/sDsf/0HPr/3l9UZOtZbXBzRWyupUQDK
         0cFg==
X-Gm-Message-State: AOAM531qjhyic5O5654wnIwMrO9mqw55motHZpo07AZe5Whr5i2oaI5U
        IdZDpAorSBMZfloE4lmRdb54Z48sHyNenaQCLyc5BINH
X-Google-Smtp-Source: ABdhPJyjtOKVrskn2k0uotMlFr81PpuggxZ+Bi4Vw/Z+yFlzfzcEe35xF2O5iYz07cLAkDBRX5w969ExRVCIDRcAt/8=
X-Received: by 2002:a9d:1b0d:: with SMTP id l13mr4989325otl.145.1594747850060;
 Tue, 14 Jul 2020 10:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200710062019.28755-1-grandmaster@al2klimov.de>
 <20200713113430.1c1777bb@lwn.net> <CAMuHMdXoUME_dCOZP1N0tXyMv61edfNECM4-n4NPa56YbBCncw@mail.gmail.com>
 <20200714074022.24481c73@lwn.net>
In-Reply-To: <20200714074022.24481c73@lwn.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Jul 2020 19:30:38 +0200
Message-ID: <CAMuHMdXMumw9CnMHOc_GJGO0MNsLowTv-wE399BMJveXgTXbLQ@mail.gmail.com>
Subject: Re: [PATCH] OPENRISC ARCHITECTURE: Replace HTTP links with HTTPS ones
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Openrisc <openrisc@lists.librecores.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 3:40 PM Jonathan Corbet <corbet@lwn.net> wrote:
> On Tue, 14 Jul 2020 09:22:39 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > -     website         http://openrisc.io
> > > > +     website         https://openrisc.io
> > > >       email           openrisc@lists.librecores.org
> > > >       =======         =============================
> > >
> > > Applied, thanks.
> >
> > Is that site accessible for anyone? It times out for me.
>
> Works for me.

Now it indeed does.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
