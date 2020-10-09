Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40E32889B0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 15:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388390AbgJINYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 09:24:21 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:46603 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbgJINYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 09:24:19 -0400
X-Greylist: delayed 77759 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Oct 2020 09:24:18 EDT
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MMWcT-1kkKXf3tId-00JexZ; Fri, 09 Oct 2020 15:24:17 +0200
Received: by mail-qt1-f172.google.com with SMTP id a9so7859533qto.11;
        Fri, 09 Oct 2020 06:24:16 -0700 (PDT)
X-Gm-Message-State: AOAM530WHgGrxL6ntwhqIOGGembKg7p1QaNkgVRkRHMEDuuijyjQgYSh
        u/bud+xqkGchs77OqAcoI/ljAp5i1u5V7exW/7w=
X-Google-Smtp-Source: ABdhPJwGWpnh6YXeCGHXzt9gF5qvqtLcAd925kccJGJ5ZmJZWEn/UPjGcEgDedqfjgtQvXwD6o8XYMv1z/4WvobnVTM=
X-Received: by 2002:ac8:7cba:: with SMTP id z26mr11806879qtv.7.1602249855606;
 Fri, 09 Oct 2020 06:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201008154651.1901126-1-arnd@arndb.de> <20201008154651.1901126-6-arnd@arndb.de>
 <0bf8d0e5-5792-a2dd-884a-c82693b64b19@linux-m68k.org>
In-Reply-To: <0bf8d0e5-5792-a2dd-884a-c82693b64b19@linux-m68k.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 9 Oct 2020 15:23:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3E1x_T29Az_d-A+wTpqCWj6Z40TaOjcsX-kc+xfpBrRA@mail.gmail.com>
Message-ID: <CAK8P3a3E1x_T29Az_d-A+wTpqCWj6Z40TaOjcsX-kc+xfpBrRA@mail.gmail.com>
Subject: Re: [PATCH 05/13] m68k: coldfire: use legacy_timer_tick()
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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
        linux-ia64@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:JQvpWcu5Jl6BcKmr/8ZVI76SSQVrnUeCc35OS4bkOopkV0+zmNP
 p7ZLkN+6c5YtWJNw2pQ5qowJO1v9d+nb6Lcy5Cg/NHpCiSk/kwPHF+euecNL/wUe6+vCrgD
 gjvohbjZZsWnNrNVbha+w6YUTIub42e/aFGTW5Cl9hBAK37VeNsb7bYiwkQrCeXRNGHd9bT
 vA3dVZ5nGBxP6e61VzmRw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qj1hkf71bCk=:yjSMWwLaj6e9pAScIgdV9V
 mlqTqlo5/vFQVpDrkHUq9igfmJ+uGnfDv73xoBmjSdQr4B10SpinjrnahKky4skVux0byowah
 +rqj6oaj6h3DPirrq38PHcsmblzvnxaO+sK2VWDUNIa5D1U15ijSqI1E0DwJ6Si72hME7Adzd
 E7BJ5hYBeLgNe8S9aRIWUm8Y8v0UaDNnlkARhhT7jJQLU6Ok2fr8N0i078sAgGjSYopMzbbAc
 eFVVU1MsEzW/YHTWCU10OMG+0f1CHFo1Os3eHhUenp9WtC7z8r36oGzbErPZ8msjjdV5SQKYU
 +rumUjJiDN+zDi2xusb4RcHCz20Kj47Ul48Xy78QPwl5bAu5u1sMjRpsUWpV8hF7GWgvAuLdZ
 HlF/Inj40sWAibMi0PsnkU/xxgGcvPHoWzoRACDwPF9NaVGkE/J5nZqOXlrBv86x7jArcq9TY
 GoQkM/ct+xt6P14SBTD0SLetXvRunXLVihhcN+jJp35tvQ/lBCMBL8yPXIWeLKvnI0CcBGNeg
 PLSEGBhvuun9BpV6a9EIDVIYZCBlxMtin76oPehygd7o4m5Li4vQQj0h17xFxnY34WNgHD3TO
 UOj3Ka3h52hbK3sP1Y+3RhL2jsG81CDLSUqyH4gz/WQlNwFAqrcC742iPaKsb1J6G1BQCs5pc
 p7wZEUXyLU+BNsJga+datGlT0YUauY5uWgqH9fZ0RebtZgRqZ2DgjDe57tYt0RsZLeey/6kb8
 epx5bCcrIHzQw779DKOQHpZg8EBO8BL1FtE79gyiMalolK5A+dA7pi24Ya5UFtbq/fvwvxPsv
 DxgDHVV7iy9UYeHfxeoWt/PJN48QKmtlLM88vrFitFzDyKrTgXeDpnlklMpqgFqB+Nroy0c
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 9, 2020 at 2:53 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
>
> Hi Arnd,
>
> On 9/10/20 1:46 am, Arnd Bergmann wrote:
> > Replace the indirect function calls in the timer code
> > with direct calls to the newly added legacy_timer_tick()
> > helper for those that have not yet been converted to
> > generic clockevents.
> >
> > This makes the timer code a little more self-contained.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I tested this series on a couple of different ColdFire parts
> (5208 and 5475) and under QEMU emulating the 5208. All checked
> out good, all worked as expected. So for the ColdFire changes:
>
> Tested-by: Greg Ungerer <gerg@linux-m68k.org>

Awesome, thanks for testing!

        Arnd
