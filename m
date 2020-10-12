Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8E428B6D9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgJLNiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:38:12 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:34045 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731063AbgJLNh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:37:29 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MplHR-1k7UF80lKf-00qCkJ; Mon, 12 Oct 2020 15:37:27 +0200
Received: by mail-qt1-f180.google.com with SMTP id t9so12754153qtp.9;
        Mon, 12 Oct 2020 06:37:26 -0700 (PDT)
X-Gm-Message-State: AOAM531KfO80OiUdKbULvlE7u+ajp17ruQsmKmwWidIxmbypU2fsJxSj
        VRf+hhySJ1jrrndxCl4J4quYUeyoSLC6ZtioMwU=
X-Google-Smtp-Source: ABdhPJw6Xw5QPFz9Hbm4r+y0vTuo5ru8d6HOL66whTmsLJNolGIOqnjXdgx88Su9kNbZVfsNfxwFqVNIjbZi+UQICLY=
X-Received: by 2002:ac8:64a:: with SMTP id e10mr9800808qth.142.1602509845710;
 Mon, 12 Oct 2020 06:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201008154651.1901126-1-arnd@arndb.de> <20201008154651.1901126-12-arnd@arndb.de>
 <CAMuHMdU7bn7rzG-0xzr4St1uArGoOhw6dy7HCkrHRvYqM38Wxg@mail.gmail.com>
In-Reply-To: <CAMuHMdU7bn7rzG-0xzr4St1uArGoOhw6dy7HCkrHRvYqM38Wxg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 12 Oct 2020 15:37:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2hY+Vc3S32KKBJj7gUaUFQb4=rKsRJwCwhAbYP7CakzA@mail.gmail.com>
Message-ID: <CAK8P3a2hY+Vc3S32KKBJj7gUaUFQb4=rKsRJwCwhAbYP7CakzA@mail.gmail.com>
Subject: Re: [PATCH 11/13] timekeeping: remove xtime_update
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>,
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
X-Provags-ID: V03:K1:BsBR49K4r9UqORnUI2CXH8prW1C1pgsCLtwNP9oJZoTdaQ5Mp61
 xb0TEXecnuEb6oz01w7+jTBY2d/0EavRHDItoBlHJIVfqcDpU4stdtGGZW5++LdQY83ej1t
 VpUFQGsDhFBz648k0OEzrPO7frTTuY3i/9ew8y/3T/xxk35vnSYHDYmj5qbLTuCaQa47RIo
 FrPmmcWbLHpeA1d6x9dJA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0Hfyhez933s=:Ra979ud5Mj/4+53raRBR1X
 Santde6uyHWKyZGpYcYs0Rh1/fGxyN7Qcd9H1PsB/ITC0PZGcH6faVz1Edm4WYONmv6S3QaGC
 x2cRhsOcqPdZNiOngQ/bMcHS4nWXcLjSEyywZQbaNXfrhYHCIgzshRTV8tFGqXQlx1aarJkLy
 xpl7PVFGH/gbyP2FEZykcVZoLubpwfiNNoHES7ZAIPgLUrMjGfRyxSo4gF6gtk6r+1CgW82iy
 GmjQ2Bi08cTm83IaS4ijdxUvilSQJrKlRSIA9hew5jIn/BgtoQ3c2RfPkyooXstZ06BX0peV/
 PvyyyeuA/qO9ohS//CbaYXUnLyKhsjSsokiOqdS7L3+u0vowzlR1E7pf3oLeuqu1WpcmM+Vwl
 XaAOI1SbrN00dzkJbrYvy6A2bLpXOxHAgcPj4yV4Ev4TsifkpyJQUNeu4hgoQtQCzbsfiy7Di
 hNEoxoU3TKp7FwmdtlDK5g7lBUCCo4lNMVwYloKptfk36zX2qUF/LxcI7scqtoiKvj+JOT7+n
 ZRXf23YDkGVlpRNSfE/GRvRwjfzXHTJka0NUTY3PCBpi73utda45FN8ODHZ+dKUFOxIwRxC95
 I1rmF1BIFXC9WriyIjO9DRtmvlikyfGOHfXmS9Kzm2VJDa0miiKaTUeCNex3+FBEt2GSMbf7h
 tm/8X7fS/49saP9SWbaETnxtJUG9FjSCeTmFqg0MVZ/5Dc6UcfLauZxsYshjps2lXsdV8yG59
 zs+4Mh8ObXjNw7wxJZzLXnE7i3pFO9m9Lyh5x5ocxaANIA49B4nlFp/4B5oLiTGwrSmAPBDOr
 +QA4bVe4PCZYri9gfrJTBCR23hrtEsWi+RWvLq+CZKwNSmY9o5fVVbzOIwj8gQ5TwxYK9SoDx
 p2XRAHyD+p55aCrB2H232gE5+5law6/U0QnEQoO8ptRKMKEeo4HzQpE6ng3Q74PKU36Tw5F+j
 AqS0kNUDHoWpyAM/nlFEMqKawd+3JVrN13s7TcVRu/3D1OyJ0JWWy
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 3:16 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Oct 8, 2020 at 5:48 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > There are no more users of xtime_update aside from legacy_timer_tick(),
> > so fold it into that function and remove the declaration.
> >
> > update_process_times() is now only called inside of the kernel/time/
> > code, so the declaration can be moved there.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks for your patch!
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> The comment about xtime_update() in arch/ia64/kernel/time.c needs
> an update.

I think the correct action for ia64 would be to make it a
proper clockevent driver with oneshot support, and remove
the rest of this logic.

I could try to rewrite the comment, but I tried not to touch that
part since I don't understand the logic behind it. Maybe the
ia64 maintainers can comment here why it even tries to skip
a timer tick. Is there a danger of ending up with the timer irq
permanently disabled if the timer_interrupt() function returns
with the itm register in the past, or is this simply about not having
too many interrupts in a row?

> Does the comment about update_process_times() in
> arch/openrisc/kernel/time.c needs an update, too?

I think that one is still technically correct.

       Arnd
