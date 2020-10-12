Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A6628B5CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388797AbgJLNPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:15:50 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:40946 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388784AbgJLNPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:15:49 -0400
Received: by mail-oo1-f65.google.com with SMTP id w7so4052957oow.7;
        Mon, 12 Oct 2020 06:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IaAtROGTENgKEPOO1Q4DxIoQzzqOoFc9nfud5UvDGR0=;
        b=FCb5cZ9OzmXO1P2uUh7S0mErtP+uMwm6J4WM5GofyvcumRu2NvTFplRtTwZLIhi5x/
         ZrWPrHoPmtHUdNZQCv+ur22HC2yv9vSPNweRD9HWrKPOjQDrbH3+OIoJrhEFQjt8/wOA
         aFugaPDm4FZI+ntsfmvSXoB1J3E2hUtIzivBXYfE03RyoB9QN95sEwXol3rci8m1e1m2
         JF7hLyDDhXIgzEl/fctey8BqtHQGyy/OBqOAjQv2arZXU6Q3ssd5zV0FoiFn/S3gh81g
         r5sNRq9G4X4Eh/3xjNRaUFvcC6TdUyc1hWICNC6lBb80hqB7FIb/jAxvkA07d1eB+RE7
         f+9g==
X-Gm-Message-State: AOAM5317PC6gF2sapdGuWXLpCql6EBeR+s+KFHfiHTH9wf+p94ubjpvy
        vW39Xlfl29l96Jlv7veiUqTbhr8sHvXWtD2Vy4k=
X-Google-Smtp-Source: ABdhPJxchKns3slAZrfyy4YUUOoGaa31rGDaKwMNk0XJqkoWaiHnxGSNKIXlCj3XYAqY439edA8VMCwt9dsV88NjCGg=
X-Received: by 2002:a4a:dbd3:: with SMTP id t19mr18526635oou.40.1602508547896;
 Mon, 12 Oct 2020 06:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201008154651.1901126-1-arnd@arndb.de> <20201008154651.1901126-10-arnd@arndb.de>
In-Reply-To: <20201008154651.1901126-10-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Oct 2020 15:15:36 +0200
Message-ID: <CAMuHMdXDRG5mOVPWiMAUuNuzKJnTjy3vQeUYhdzfsJ3_Vechwg@mail.gmail.com>
Subject: Re: [PATCH 09/13] m68k: change remaining timers to legacy_timer_tick
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

On Thu, Oct 8, 2020 at 5:48 PM Arnd Bergmann <arnd@arndb.de> wrote:
> There are nine more machines that each have their own timer interrupt
> calling the m68k timer_interrupt() function through an indirect pointer.
>
> This function is now the same as legacy_timer_tick, so just call that
> directly and select the corresponding Kconfig symbol.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

And finally (for Amiga and Atari/ARAnyM):
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
