Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8C028B5D2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388803AbgJLNQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:16:05 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:38272 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388742AbgJLNQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:16:04 -0400
Received: by mail-oo1-f68.google.com with SMTP id y127so4045128ooa.5;
        Mon, 12 Oct 2020 06:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLQ9YunWIKqoe+aYDnxj7j3vxwL9TZbVGnFl2iqFMpI=;
        b=NpjIR/iZybLHx/CieghYqNaBJr7oudEL4SFHc3ly/UoyrpYXJ0uxJzbUxbe/O7xLf+
         Dc1K0C/UZjrdiPwm7UOEC4O5O/dpTZA91WOTNzPJQkEpSffbXqxrzEt9mkEcvP3XTYqg
         dF4I3osTi5LDlWMgA0dvSYv1Zt5kiqhQjpeO1TGxK9IUIYqjOU/mf3dfM/hJRsJzrwb7
         JdLIGDbW6lCDpxJuFwpANZxXGVZ0Vn9iTqd0o/p0mNItJAWDkPTkj3Ye/tQLGqAzZyju
         4BEzRvHQkdNO64k4vw1sgJLuR6VnEPE+w6Djw0HhIFSYltIiaztIlpCpYwJVp8VIZC16
         esEQ==
X-Gm-Message-State: AOAM530siNM/Zc441/abqbn50mggFxxpoGNK+gi19rIYwZDDkZOmk6qh
        6xcXqU9DBAqm2HcK9YeXs3jHgRHLBm4OOPltIjg=
X-Google-Smtp-Source: ABdhPJy4En79gxB2k+49ecp+szepSXrwDIHHt78jsB5/HEmEcFlQC2kZ28isWhIx+lbYv7co1E5K8qggiNkVoAFaKzc=
X-Received: by 2002:a4a:4f17:: with SMTP id c23mr18858278oob.11.1602508562529;
 Mon, 12 Oct 2020 06:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201008154651.1901126-1-arnd@arndb.de> <20201008154651.1901126-12-arnd@arndb.de>
In-Reply-To: <20201008154651.1901126-12-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Oct 2020 15:15:51 +0200
Message-ID: <CAMuHMdU7bn7rzG-0xzr4St1uArGoOhw6dy7HCkrHRvYqM38Wxg@mail.gmail.com>
Subject: Re: [PATCH 11/13] timekeeping: remove xtime_update
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
> There are no more users of xtime_update aside from legacy_timer_tick(),
> so fold it into that function and remove the declaration.
>
> update_process_times() is now only called inside of the kernel/time/
> code, so the declaration can be moved there.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

The comment about xtime_update() in arch/ia64/kernel/time.c needs
an update.
Does the comment about update_process_times() in
arch/openrisc/kernel/time.c needs an update, too?

For Amiga and Atari/ARAnyM:
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
