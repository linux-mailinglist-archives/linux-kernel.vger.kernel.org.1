Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0BB2981B5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 13:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416042AbgJYMqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 08:46:07 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43796 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416032AbgJYMqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 08:46:05 -0400
Received: by mail-ot1-f65.google.com with SMTP id k68so5661269otk.10;
        Sun, 25 Oct 2020 05:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PAyOG8KXMj9ahjjZJ9yihvyoTqK3oGi3EPsVzO3w7LQ=;
        b=HnwpLr2iNCxLKz9YTClU1tHIDxAVM/PwG6G3RQxwN1COK/AiiNZ860mgs6v/CjW2N0
         Y1M2U64hPsMRQL+o0LgIVvElAGo2ouGfnQRkcZjzPyp7iZbmqELop5W63zGsyvA3RUP2
         WjXAuI+tIxs0F7diShTkyTvLVRun+qonx/gul56HOgIRB2bJwK+bHO+mFhCOMu8v6q2b
         liWqqloGvvfTNOkLsv6tVd9qEGzOFMaH5zpneQ+2efhpaFzAV+J+cGDqmEa50VoFm3xd
         LaoyYNmF9CBbBxBkVXUg++xlAGQhTGLuZuw/5ZlJannmF3SUhRnkhE7TsV/JQoHVadxI
         thSw==
X-Gm-Message-State: AOAM531x/M2rdqq770Ceg5cqnm8q/goqRt0Wq0eW21lzzrE+ooADJcR3
        8Se3gt7zeh7zrKcKbgsZMkEWRkuvHDxLrQsO+KU=
X-Google-Smtp-Source: ABdhPJxmuJG9PiQLG7l7qXiiCf5qWuorNhHHI+33KuLXsmEcEeKy++gzWYlRrLP40TyqIRaiVJ/NQmicYDtPSM5CGc4=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr9252914otc.145.1603629963765;
 Sun, 25 Oct 2020 05:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201008154651.1901126-1-arnd@arndb.de> <20201008154651.1901126-14-arnd@arndb.de>
 <alpine.LNX.2.23.453.2010091900150.12@nippy.intranet> <CAK8P3a3rM7gJjdTtcKzr6yi15n6xs-yhEpmSOf3QHfahQwxqkw@mail.gmail.com>
 <alpine.LNX.2.23.453.2010150937430.16@nippy.intranet> <CAK8P3a3i6cum_9xGgsbxjXXvbRsP8Po5qLZ0Agb3c4gZTKC9GQ@mail.gmail.com>
 <CAMuHMdUyGH=ORa4yHivMeJZaGQ3kEXi1kr9=P+u1y3QQnC+-4g@mail.gmail.com>
In-Reply-To: <CAMuHMdUyGH=ORa4yHivMeJZaGQ3kEXi1kr9=P+u1y3QQnC+-4g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 25 Oct 2020 13:45:52 +0100
Message-ID: <CAMuHMdWoxWGkq_=AbGZxU=UFASBH3qT0ANqgTzLOZxjjjmYqQA@mail.gmail.com>
Subject: Re: [RFC 13/13] m68k: mac: convert to generic clockevent
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 11:24 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Oct 23, 2020 at 9:52 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > On Sun, Oct 18, 2020 at 2:55 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > > On Thu, 15 Oct 2020, Arnd Bergmann wrote:
> > > > On Thu, Oct 15, 2020 at 3:19 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > > > > On Sat, 10 Oct 2020, Arnd Bergmann wrote:
> > >
> > > That configuration still produces the same 5 KiB of bloat. I see that
> > > kernel/time/Kconfig has this --
> > >
> > > # Core internal switch. Selected by NO_HZ_COMMON / HIGH_RES_TIMERS. This is
> > > # only related to the tick functionality. Oneshot clockevent devices
> > > # are supported independent of this.
> > > config TICK_ONESHOT
> > >         bool
> > >
> > > But my question was really about both kinds of dead code (oneshot device
> > > support and oneshot tick support). Anyway, after playing with the code for
> > > a bit I don't see any easy way to reduce the growth in text size.
> >
> > Did you look more deeply into where those 5KB are? Is this just
> > the code in kernel/time/{clockevents,tick-common}.c and the
> > added platform specific bits, or is there something more?
> > I suppose the sysfs interface and the clockevents_update_freq()
> > logic are not really needed on m68k, but it wouldn't make much
> > sense to split those out either.
> >
> > How does the 5KB bloat compare to the average bloat we get
> > from one release to the next? Geert has been collecting statistics
> > for this.
>
> It would be a fair share of the typical increase of ca. 30 KiB per
> kernel release. Still, it would be lost in the noise of the increase for
> v5.10-rc1:
>
>     add/remove: 1200/455 grow/shrink: 1419/821 up/down: 468970/-93714 (375256)
>     Function                                     old     new   delta
>     _printk_rb_static_infos                        -  180224 +180224
>     write_buf                                   8192   32768  +24576
>     _printk_rb_static_descs                        -   24576  +24576
>     HUF_decompress4X4_usingDTable_internal         -    5664   +5664
>     HUF_decompress4X2_usingDTable_internal         -    5006   +5006
>     __ext4_ioctl                                   -    4774   +4774
>     sock_ops_convert_ctx_access                 3840    8462   +4622
>     ZSTD_decompressSequences                       -    3100   +3100

FTR, 3.9 KiB reclaimed by upgrading from gcc 8.4.0 in Ubuntu 18.04LTS to
gcc 9.3.0 in Ubuntu 20.04LTS.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
