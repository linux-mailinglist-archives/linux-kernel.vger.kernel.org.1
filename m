Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738CF28B5C9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388765AbgJLNPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:15:34 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37094 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388742AbgJLNPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:15:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id m22so4364341ots.4;
        Mon, 12 Oct 2020 06:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32prFsUImi2et0wD1nInyNzJbwFsAz7pM2lg+OwfdA8=;
        b=k5B/3XX4aXddOZ3ydgyOcsgtaLGx0eYx3x6UosGECa7MGfmUc1XIGOIfoNlVuMYCmT
         djf6y6A34HlKc5EG2JBItl1/94U6eRGjXs11LBWympMBL+uiB/uHXp4G6pwVEMunZlWD
         KvCbnMNFGBFrz/aMI7UWKc9Dc9wPNwROXfbugwdSzwLfrRLvEsVVenoerK8GfM30a0A4
         IOJjkd2NL0oyGs8JHcNsBFv4Ql9f5Qler/3/WECqA0uVsiL3b/uioAVyxdzm9WTkEvM/
         jwlXT9QwK2etzy3eVR88GRUVilJY/ic9HZH7qG6nHCTpELhx2hQv7skfIdEV88vFwS9F
         6Ing==
X-Gm-Message-State: AOAM533bnDfYg4MC07JPUgYx4UotU1lfDoBu3qS4wTz+LXcv53QqciKb
        dDERTd0ZXBDCeh4wTyIyko0ufJGATAZR2c9aN/U=
X-Google-Smtp-Source: ABdhPJxtX+V6nlzREBpZnHfCCWLCLBZEkIJ6fKRmhts0E87Q/NkdkOCqC2URIeU4xfs9RBjZ1sZArftZVEwo7jtjoJU=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr18308270otc.145.1602508524639;
 Mon, 12 Oct 2020 06:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201008154651.1901126-1-arnd@arndb.de> <20201008154651.1901126-11-arnd@arndb.de>
In-Reply-To: <20201008154651.1901126-11-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Oct 2020 15:15:13 +0200
Message-ID: <CAMuHMdUQMgE2ny-nuUeYjn-gcpvav2rp-11oTQp-GZ5TX9Z8Pw@mail.gmail.com>
Subject: Re: [PATCH 10/13] m68k: remove timer_interrupt() function
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
> This gets passed to a number of init functions, but is
> ignored everywhere, so remove the function and change the
> mach_sched_init callback to take no arguments.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

And finally (for Amiga and Atari/ARAnyM):
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/arch/m68k/include/asm/machdep.h
> +++ b/arch/m68k/include/asm/machdep.h
> @@ -33,8 +33,7 @@ extern void (*mach_l2_flush) (int);
>  extern void (*mach_beep) (unsigned int, unsigned int);
>
>  /* Hardware clock functions */
> -extern void hw_timer_init(irq_handler_t handler);
> -extern unsigned long hw_timer_offset(void);

Yeah, this never-used prototype, which entered through the nommu merge,
can go.  But that's not really related to this patch.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
