Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4878428BBE8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389540AbgJLPbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:31:10 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:42081 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388527AbgJLPbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:31:09 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M5PRT-1kRARb1wLF-001QUy; Mon, 12 Oct 2020 17:31:06 +0200
Received: by mail-qk1-f182.google.com with SMTP id q63so18080040qkf.3;
        Mon, 12 Oct 2020 08:31:06 -0700 (PDT)
X-Gm-Message-State: AOAM530XcP7wb8zAcjMY7SPnyaM1gM3y1r1kgv3/mAG9zNvp2uYk3VgI
        ZUWvozBqOR+GpDY02cOfMoEU0Cdpq6sCrfikNZo=
X-Google-Smtp-Source: ABdhPJwvsy1oYnuUy5ljPB75evT7Pa/tyuqSvAbw5I5mVYvqU4g4l8zWrAr5hU7svLQBi/0OorEm0EPGvxy5dZlnbs0=
X-Received: by 2002:a05:620a:2ee:: with SMTP id a14mr5630220qko.286.1602516665130;
 Mon, 12 Oct 2020 08:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201008154651.1901126-1-arnd@arndb.de> <20201008154651.1901126-9-arnd@arndb.de>
 <CAMuHMdWtMZaJ8ETb4g+AfaLeSZ1vyi8-POEaRzmdwh3ha=jieA@mail.gmail.com>
In-Reply-To: <CAMuHMdWtMZaJ8ETb4g+AfaLeSZ1vyi8-POEaRzmdwh3ha=jieA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 12 Oct 2020 17:30:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1nDZYYwtuniUGxmy=H8LHbOEGSU=Pmi2=LMrLw09x8+w@mail.gmail.com>
Message-ID: <CAK8P3a1nDZYYwtuniUGxmy=H8LHbOEGSU=Pmi2=LMrLw09x8+w@mail.gmail.com>
Subject: Re: [PATCH 08/13] m68k: m68328: use legacy_timer_tick()
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
X-Provags-ID: V03:K1:DJJD98gQfMORp0800O7Ew01mrOIiBaWtMDU5TgDNGrJZmMB1AqZ
 NqPQk/mwzxVPcHmEjj6zegLLQNVhCmGchJktO77E/kRqQwwAQc7nVdyPFjLExbBQtfO21nv
 sL8xXmEEuCOKG6g967og41FVYdyYLmlP8qsBNcIJyepNG+zBALDzlOb73dbyrDBXnLvPa0v
 56lM8ztGjzBoTBYeF30Ow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ggoW9tp1yI4=:Rjwwz7JmODT6i2Ujg+riPF
 EDSaovwE46D4knVSyExkaQiy7me2/AZD89AKQlZGgv1b/07YvCkvVAzzM2S2/0qhNCnd3wg+E
 Gwe8FyelBilvrjEDDJxpOoUwKqhfGK/WWyy3NtR+qAVO23UWiCTP5VXFW/IconwKYAiuVjPiu
 gugS7X6MSJ/e/VVR0KIVIhUh0rPeljjjT2pBC3+AxPEkifadT7jvR7IhrZaJcMHu0w5/MClA8
 XRCH0mYZiPJ+54QIYwY3pHTzUozak4HooOrdMkXB9q/mTpmgfCfw8Ys3mk4UTsLkARDx8mZgX
 MJiSLF3jALBa8I3fc1sF+P9LXSAQVmTFtZKX5iCDXaI5JGPMHZox4FrfFissjjUX3PDujrvfX
 m/pCbu7SYJfk1BbnDFhI+qY94v6jvlFDsm8zNrRIMh+76gMekTdaC0442i3WWQ4ZUvzztu0AP
 uJq+PK6yCOma555JDOewlGWmclTp/S+LTDfRLazR0r+ey4YWa8wNUmXoN9HsTNPT1PkBvd91L
 3ZU+VzcMRBkb2NKP1PDpSOywicC0FeA1ftd4tlg3F1/1HAiize86c7OJJevXTouaeICmTktHS
 S708f3Eb0NNHVfrjXYaCsNLiNUFaYq47vP5GF34nyjjecb6vjuS+PuDE/OK6ISSqTTlypajzd
 Cfqv198bKjP9frkk2mH6e/ICk8c7zH+htH6YXE3mj2JK+6gw6/MmXBkF0O0poyXcsgigiK2+2
 pe/pnqbreffCQMIy+8ov/Ns47zTYrmfW4MR0lf+Aksh903IAABIcB8hpqEZ2AwXvXKF+yg1KY
 dXaKVgLHvtc/uQp/v7/w9RcFZXrnfk/LtZDV8BTyAa3ohsnJnMChpxXzc+GEhW36ms3q+XdJi
 0qjk7GfEinH+0ug6vdbOPM7ssfLa31kAXskhiyCNui6Z1OZnQKow5162GleqtG3VDMqp8q64o
 ls6bi2zpB3ds4N6pXoMRgSMZIjdybd7Ovd8cCJLYNyrpa7mwYJEFa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 3:15 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Given this feature is SoC-specific, not platform-specific, perhaps
> it makes sense to move the selects to the M68{,EZ,VZ}328 symbols?
>
> Regardless:
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Ok, folded in the change blow, using one less line. I couldn't figure
out whether
it should just be part of the CONFIG_M68000 instead, which doesn't appear
to have any machine support by itself. The dragonball CPU configuration
looks really odd, because you have to build exactly one of M68{,EZ,VZ}328
into the kernel to get a successful compilation, while Kconfig allows
many other combinations.

     Arnd

diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
index 322a35ef14c6..648054d4f860 100644
--- a/arch/m68k/Kconfig.cpu
+++ b/arch/m68k/Kconfig.cpu
@@ -104,6 +104,7 @@ config M68060
 config M68328
        bool "MC68328"
        depends on !MMU
+       select LEGACY_TIMER_TICK
        select M68000
        help
          Motorola 68328 processor support.
@@ -111,6 +112,7 @@ config M68328
 config M68EZ328
        bool "MC68EZ328"
        depends on !MMU
+       select LEGACY_TIMER_TICK
        select M68000
        help
          Motorola 68EX328 processor support.
@@ -118,6 +120,7 @@ config M68EZ328
 config M68VZ328
        bool "MC68VZ328"
        depends on !MMU
+       select LEGACY_TIMER_TICK
        select M68000
        help
          Motorola 68VZ328 processor support.
diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index 0ff9338b958e..e3c835440d9a 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -146,7 +146,6 @@ config PILOT
 config PILOT3
        bool "Pilot 1000/5000, PalmPilot Personal/Pro, or PalmIII support"
        depends on M68328
-       select LEGACY_TIMER_TICK
        select PILOT
        help
          Support for the Palm Pilot 1000/5000, Personal/Pro and PalmIII.
@@ -160,21 +159,18 @@ config XCOPILOT_BUGS
 config UCSIMM
        bool "uCsimm module support"
        depends on M68EZ328
-       select LEGACY_TIMER_TICK
        help
          Support for the Arcturus Networks uCsimm module.

 config UCDIMM
        bool "uDsimm module support"
        depends on M68VZ328
-       select LEGACY_TIMER_TICK
        help
          Support for the Arcturus Networks uDsimm module.

 config DRAGEN2
        bool "DragenEngine II board support"
        depends on M68VZ328
-       select LEGACY_TIMER_TICK
        help
          Support for the DragenEngine II board.
