Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC88528B5CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388781AbgJLNPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:15:41 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:34693 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388767AbgJLNPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:15:37 -0400
Received: by mail-oo1-f66.google.com with SMTP id o20so4054095ook.1;
        Mon, 12 Oct 2020 06:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFhRs7TjS820R6Lv4nnFfwi1wzFa7myuHvQUHpv2Z9o=;
        b=GRHsh95vW2HKE1Tw7PYY4DeAVowMEkIJNAQrU7wVr0cWsc/gYkMfDT2y0zVKrX3ns3
         LK6QI3NbFVzKwEJtPxmzqAysl2M9tUo80BQqdDLzIkw4cvwtLRTYS34xVZdGjBMSpX1v
         AwE7h4TCoWBf8r+Xp3NaO1U7SYj8i3n72wTK9+h8CpzXFqlVoWiE1T4bGc4PamfYMUyA
         SFOHq2gI6anxsTEUfGjFm9z4VJKeIX8MYTgqtz/wSOdlaCfhmUaFhREz0DsSiKY3iCeL
         LQ1kIbNfEX8paR/eG9AdUrAkTaTdQaW/k+weCFgKnePZK4xwUbtFOdozO7y/Bbf6Y7MQ
         1LvA==
X-Gm-Message-State: AOAM5316SSz6Dczi2NcqXzwd+5OyVNleqsTEhOBDOrPA7W4GxIuzWiXi
        n/RIkwznLLeX2RhsYxSEpgs+EcozHG08muNLiic=
X-Google-Smtp-Source: ABdhPJwH87hW/Pgij7RCQUnzcFXjl6OK87/RDvKI1ooIz6IBNHxF4/GrZMi+obXHOEc8W7DIRvqP891GQZlhJ9GHy5c=
X-Received: by 2002:a4a:5d84:: with SMTP id w126mr18415022ooa.1.1602508536062;
 Mon, 12 Oct 2020 06:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201008154651.1901126-1-arnd@arndb.de> <20201008154651.1901126-9-arnd@arndb.de>
In-Reply-To: <20201008154651.1901126-9-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Oct 2020 15:15:25 +0200
Message-ID: <CAMuHMdWtMZaJ8ETb4g+AfaLeSZ1vyi8-POEaRzmdwh3ha=jieA@mail.gmail.com>
Subject: Re: [PATCH 08/13] m68k: m68328: use legacy_timer_tick()
To:     Arnd Bergmann <arnd@arndb.de>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Oct 8, 2020 at 5:48 PM Arnd Bergmann <arnd@arndb.de> wrote:
> A couple of machines share the m68328 timer code that
> is based on calling timer_interrupt(). Change these
> to the new and slightly more generic legacy_timer_tick()
> helper.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> --- a/arch/m68k/Kconfig.machine
> +++ b/arch/m68k/Kconfig.machine
> @@ -146,6 +146,7 @@ config PILOT
>  config PILOT3
>         bool "Pilot 1000/5000, PalmPilot Personal/Pro, or PalmIII support"
>         depends on M68328
> +       select LEGACY_TIMER_TICK
>         select PILOT
>         help
>           Support for the Palm Pilot 1000/5000, Personal/Pro and PalmIII.
> @@ -159,18 +160,21 @@ config XCOPILOT_BUGS
>  config UCSIMM
>         bool "uCsimm module support"
>         depends on M68EZ328
> +       select LEGACY_TIMER_TICK
>         help
>           Support for the Arcturus Networks uCsimm module.
>
>  config UCDIMM
>         bool "uDsimm module support"
>         depends on M68VZ328
> +       select LEGACY_TIMER_TICK
>         help
>           Support for the Arcturus Networks uDsimm module.
>
>  config DRAGEN2
>         bool "DragenEngine II board support"
>         depends on M68VZ328
> +       select LEGACY_TIMER_TICK
>         help
>           Support for the DragenEngine II board.

Given this feature is SoC-specific, not platform-specific, perhaps
it makes sense to move the selects to the M68{,EZ,VZ}328 symbols?

Regardless:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
