Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B17928B5D6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388822AbgJLNQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:16:11 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34562 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388813AbgJLNQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:16:10 -0400
Received: by mail-oi1-f193.google.com with SMTP id w204so3487215oiw.1;
        Mon, 12 Oct 2020 06:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSubvuvsRqa9Us4jIiX4BQlzCXkcEfFKaZCMlzTTvKk=;
        b=j6tWp4Bdy7tcC/2fno9oBWheSYrIc09YUV9Q5qyVICuR8Se+dXOzNS66d+EcXiawip
         z9rwPtcBkza4trcTwBGyttivmpgYOhar4NSAG7ONq6HykfphbWR5W4VrcBXJJXicMl5Q
         2mKIhUIltYe7L+1eW7WFRZ47VQ/lmGIfDqhKqZ3D0jKWiYdmK4T/ChBYUm/vB8HWp3X9
         rhuQS8CEQRJ9woE9WegmIdUubeseKVvQ/g0ZROO9jLcAKYHH4QmaUwcUcVWk+NK9szk0
         EH+WXFVI7wwx44wGyrMoi+ahV9y/FE5wEfdDn93OC9twZrpqdAJXmnL8BM4aQzK2Wkzk
         D1yQ==
X-Gm-Message-State: AOAM531u6hG68dqTA4yx9mQVSPAqGKrsNQlMaerlN2UFoLyWlLP1TXu7
        thzq1UUvrW3LJ1MxS3hE51jdmcThGZ5xaQgc8lc=
X-Google-Smtp-Source: ABdhPJxQjws2mloxhrfVwndzh+qyK0VtTyyW1Ebe38OYBVK7LU+s7UXVE4pdXujubm9vT9JX1He1wqHhh6JroodbfYI=
X-Received: by 2002:aca:4441:: with SMTP id r62mr10155966oia.153.1602508568842;
 Mon, 12 Oct 2020 06:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201008154651.1901126-1-arnd@arndb.de> <20201008154651.1901126-13-arnd@arndb.de>
In-Reply-To: <20201008154651.1901126-13-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Oct 2020 15:15:57 +0200
Message-ID: <CAMuHMdWS5JoXho97oxcavE_OFdv+tnr+da1WV_D7sOE_YbxQxA@mail.gmail.com>
Subject: Re: [PATCH 12/13] timekeeping: default GENERIC_CLOCKEVENTS to enabled
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
> Almost all machines use GENERIC_CLOCKEVENTS, so it feels wrong to
> require each one to select that symbol manually.
>
> Instead, enable it whenever CONFIG_LEGACY_TIMER_TICK is disabled as
> a simplification. It should be possible to select both
> GENERIC_CLOCKEVENTS and LEGACY_TIMER_TICK from an architecture now
> and decide at runtime between the two.
>
> For the clockevents arch-support.txt file, this means that additional
> architectures are marked as TODO when they have at least one machine
> that still uses LEGACY_TIMER_TICK, rather than being marked 'ok' when
> at least one machine has been converted. This means that both m68k and
> arm (for riscpc) revert to TODO.
>
> At this point, we could just always enable CONFIG_GENERIC_CLOCKEVENTS
> rather than leaving it off when not needed. I built an m68k
> defconfig kernel (using gcc-10.1.0) and found that this would add
> around 5.5KB in kernel image size:
>
>    text    data     bss     dec     hex filename
> 3861936 1092236  196656 5150828  4e986c obj-m68k/vmlinux-no-clockevent
> 3866201 1093832  196184 5156217  4ead79 obj-m68k/vmlinux-clockevent
>
> On Arm (MACH_RPC), that difference appears to be twice as large,
> around 11KB on top of an 6MB vmlinux.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

>  arch/m68k/Kconfig.cpu                                |  1 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
