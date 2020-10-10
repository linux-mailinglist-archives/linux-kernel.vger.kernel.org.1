Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B7228A1DA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732547AbgJJWde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:33:34 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:51207 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730399AbgJJSwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 14:52:25 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mq2vU-1k4xW42QHy-00nAAc; Sat, 10 Oct 2020 20:52:18 +0200
Received: by mail-qk1-f171.google.com with SMTP id s4so14062039qkf.7;
        Sat, 10 Oct 2020 11:52:18 -0700 (PDT)
X-Gm-Message-State: AOAM531TjP10XUVHyhHvga/GBzubonVntEPI0GTwOJXYLyiQbofMycph
        ulv7lPAq83cDPxrll7sgmbLdIEGaicanWLSCG04=
X-Google-Smtp-Source: ABdhPJyHb97asLXMVebqtlWTvKZgLrTtP/hgQ4nxOJVaC7ZPWU+ccFfq4hg78Uvv2vpNcQYhAbXFOff6pGfcfHymFNw=
X-Received: by 2002:a05:620a:b13:: with SMTP id t19mr3306996qkg.3.1602355937246;
 Sat, 10 Oct 2020 11:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201008154651.1901126-1-arnd@arndb.de> <20201008154651.1901126-14-arnd@arndb.de>
 <alpine.LNX.2.23.453.2010091900150.12@nippy.intranet>
In-Reply-To: <alpine.LNX.2.23.453.2010091900150.12@nippy.intranet>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 10 Oct 2020 20:52:01 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3rM7gJjdTtcKzr6yi15n6xs-yhEpmSOf3QHfahQwxqkw@mail.gmail.com>
Message-ID: <CAK8P3a3rM7gJjdTtcKzr6yi15n6xs-yhEpmSOf3QHfahQwxqkw@mail.gmail.com>
Subject: Re: [RFC 13/13] m68k: mac: convert to generic clockevent
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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
        linux-ia64@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:otRuftNbB3lBySqwtS51xx3yn/t60U7b7y5rmpRvR+Mrfy+Wj+l
 DRYaNPPxivp2vURRNzBwUZYeyUieC6P6mg4LTACfQQgWXaWn4cKcV4PjyalR0KlYarDEukU
 SHmocmeKbLalNUv/mWh+nwh+GbX+XXxdhl0LS94xIqNufD4rlg4VFEY+BPwNgtl2znaCjuo
 Dkh5af7HVd+/VE2bjZGFw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0q4XvGn00f8=:Zejixq+2uSJ3eN+rQC46jy
 Cr09I9ImfBiqPmSSdKuj0GeUejVHklaeu2HyUiRc4F5nN0jKx21L/Uf/3xVdI/Pa0zXHIKoBt
 I8U7nEfGrfTU+bW3s3hehX7zxLMbOiB4Niuc36iuaii0YXTw12PjXDLwlQBzaCqs7eqT+nR/D
 kgZV6SqQq7u0MUVOFyIJbpmAckcckT3d423us+V09bGADbCs+WYsEffSKzM9BmJlqMsGTTowl
 vsN+cU9kpjJRr8j79tlaM/IWfV+6s09plA0en+JgMa9/UXDi/gjJiteufY6Weuf8GDsktCdLg
 a04sqbSQqZuR1NZ8seeq8MKjgjmtZi+rXEh2pstr2fHoeb2jXx+v6ZOO3eA80NrkpzuwIS4le
 /NvSsRuaLD91BEwpeZUQ4y6rTA6U9vOUA6npm4E9ud0fj+/9aLvDYJjdjmdh36i/yXvHDNCSh
 NRmO5AD5ToaOY4483ZR6Q6J6wyecJKaGA8+3vaxEgK+HDC156DMdxtENC119ViQcXus2Zuh4I
 EYo2BfCIX8HtB9XIYDmCMxl8HMagrCiLfhnIRMJ45ku3gkOGT4J4Vl+uwSRklKCbTt4+gWDRm
 SS0ZoNf+BoNvAsnp342Sv2knX5qzw4RuVDzkjUQF4YrFJt+UVWLorYtkoUvwT67ZnORGLxakb
 zc64zAZao8Jisq1weYALu1rB+wKyFFX14vFz/MDIoO0z6Ys8FC04bA8ciR5Ey2gCj3TK3gwYG
 mXQ1jGTMw+0vIdJsrcuFIUGkBM8XBhiJWXBxK3rO7lnOK3VLcgxYTzzUb6ShX62XgvUzrMVXW
 lmKCaiTCCm+crK7wodaXIuswAKEWD0bnQAceO3dz9/l7kD/k044MlADJR7x47TYxaPw625K
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 12:21 AM Finn Thain <fthain@telegraphics.com.au> wrote:
>
> Hi Arnd,
>
> Perhaps patch 13 does not belong in this series (?).
>
> All m68k platforms will need conversion before the TODO can be removed
> from Documentation/features/time/clockevents/arch-support.txt.

Yes, correct. I marked this patch as RFC instead of PATCH, as I'm
just trying to find out where it should be headed. I would hope the
other patches can just get merged.

> On m68k, HZ is fixed at 100. Without addressing that, would there be any
> benefit from adopting GENERIC_CLOCKEVENTS as per this RFC patch?

I don't think so, I mainly did it to see if there is a problem with mixing
the two modes, and I couldn't find any. The behavior seems unchanged
before and after my patch, the main difference being a few extra kilobytes
in kernel .text for the generic clockevents code.

> On Thu, 8 Oct 2020, Arnd Bergmann wrote:
>
> > Now that the infrastructure allows kernels to have both legacy timer
> > ticks and clockevent drivers in the same image, start by moving one
> > platform to generic clockevents.
> >
> > As qemu only supports the q800 platform among the classic m68k, use that
> > as an example.
> >
>
> Correct VIA emulation is suprisingly difficult, so this kind of work
> should be tested on real hardware.
>
> I say that because when I did the clocksource conversion for m68k I ran
> into a bug in QEMU (since fixed) and also because I once worked on some of
> the bugs in the emulated VIA device used in MAME/MESS.

Good point, though I would be surprised if anything went wrong with
this patch on real hardware but not in emulation, as all the register-level
interactions with the timer are the same.

Adding oneshot mode is a completely different matter though, that
clearly needs to be tested on real hardware.

> > I also tried adding oneshot mode, which was successful but broke the
> > clocksource. It's probably not hard to make it work properly, but this
> > is where I've stopped.
> >
>
> I'm not so sure that one timer is able to support both a clocksource
> driver and a clockevent driver. In some cases we may have to drop the
> clocksource driver (i.e. fall back on the jiffies clocksource).
>
> Anyway, even on Macs with only one VIA chip we still have two timers. So I
> think we should try to use Timer 1 as a freerunning clocksource and Timer
> 2 as a oneshot clock event. This may result in better accuracy and simpler
> code. This may require some experimentation though.

Ah, good. This is partly what I had been hoping for, as my patch
can be used as a starting point for that if you want to give it a go.

     Arnd
