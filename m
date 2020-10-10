Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F8028A2CB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390899AbgJJW73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:59:29 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:46769 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730537AbgJJUcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 16:32:19 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MX00X-1kyhJq071V-00XMKB; Sat, 10 Oct 2020 22:31:31 +0200
Received: by mail-qt1-f180.google.com with SMTP id h12so9264033qtu.1;
        Sat, 10 Oct 2020 13:31:30 -0700 (PDT)
X-Gm-Message-State: AOAM533eN2eySj5rRpvevKWxYmzN6dCTRGLbyc+GD48GX5lgS6NHkLOz
        5n1jkDXwvyGsvaH501YfP/vZCesNPvRAcgcICF4=
X-Google-Smtp-Source: ABdhPJzxmcGED0Ih/YBu2mHf0R3P6/nMSvbjeQBBLgW8fw7gYjKUZesdCzOPFtlYkIUUYLLkZBj1PG5Q6+okNjhwAiM=
X-Received: by 2002:ac8:4808:: with SMTP id g8mr3749519qtq.18.1602361889612;
 Sat, 10 Oct 2020 13:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201008154651.1901126-1-arnd@arndb.de> <20201008154651.1901126-2-arnd@arndb.de>
 <alpine.LNX.2.23.453.2010100820110.12@nippy.intranet>
In-Reply-To: <alpine.LNX.2.23.453.2010100820110.12@nippy.intranet>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 10 Oct 2020 22:31:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3ZBHJag7MUDNL+hrZQLiJfc8JyZzOtAuarOVwo_GcmmA@mail.gmail.com>
Message-ID: <CAK8P3a3ZBHJag7MUDNL+hrZQLiJfc8JyZzOtAuarOVwo_GcmmA@mail.gmail.com>
Subject: Re: [PATCH 01/13] timekeeping: add CONFIG_LEGACY_TIMER_TICK
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
X-Provags-ID: V03:K1:bx+MU4rriWLgVvyWeRF64JfoyzOmlLz74UO8fNe+f7WeGaMedgw
 A2fua+Q6ChbYhr0tJ/sWLFiwuAr4PRD/R8ZJ2St8O8ySRYKgV1BXuWx6OKjJD6j8KZEqGBU
 QuH8zzQYnK/OjnsRUDmt8rWmqalpr/81DhoIikWERTEjUzBK8GcaAf7w3RSTV5Zpo8jwnTL
 7syRLbsW6/Oin/66wt9eA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nOXGlKZwRYw=:AC+ita+16+XxGmd2+XJ1BI
 3idAHYIAH8vIGOvA/79i+6F888Rg8kHgRybXRYz8zNlUlQXNZooA1W6VcXezU+uLHTtHKjk32
 H0ehwPOS7rORqKj4Mx8m5D3I1NOJ1ksSIVE2akPSNPkrQBVbBNrG5IxmLCFYzJnzUZ04qDuq2
 MrYtl5RCDIwJjqIRRu1RCJ7V5iBuPWdei47LR3r+Hyc3RRDsaCz6+qjbfwtU7ci950eYC0fb3
 2rGKKBQJ7djJYBOyltlnpf5keqxs85dKVLCE7LktJbLjh1F5XieXlHGAq9F/wtRGD7RJ4F468
 clcynRkHVtcVG79A935S+pziNDIyCMtjjpy0U4CXteyUUnzWyI/A1IPMEKLXyt0jG1fPaTibY
 Ee8FjDNuoHrV8rX9gTRlCGuP5cR8AWzX32nMdSF2Bb3+cUKaudRZGldnRA3BWkFXKDRfGKDxz
 jesceABs2cIY27lvm5mss3P9gvHaGbcvgkmRCo0Z4bTEevmrugNvbTMRmJteLqOdhRvs6UI2u
 oj9daWcyQuv3G/Sz/aN2LXpc2UcuI/XqvByoxMDxQaA6NTdePtIgz2JnjwLy1o2CSc8gM1nUb
 ygIsBiDmDjrW9AibqvfMz06Jumnf6WKJH0FzKDULoSSUaUTPGl/onUTqRizcVbUqySALejOVm
 mhGAnZGwv89ct/Bv2Ld83yC+uLQpKJiwMn1hCJL4oeD6qzs6MWqJsiP0+ftXzvC+ntQzCRas4
 22/2TUCul/x/6D52jDxd/+33HbIyr0QE5cE9JSqYy0yFpluTY6dy9CbooZnPTsc72CN+ZWQ9i
 3cKftU9gDMdreer2/rYwid0uaUbz+4/KxTL9nnF4mIloWRdSUC/UNtMe3SNJX6yq0en5GDYsy
 efncQnKJTIXTu278KV1LVpVcxdo7eWuuo7urhlM6vQPgQdl5NLNH7GdvszkDmYXCvvr8o7gn1
 USOQXDloNjAfsp/yd/6vejqZQfB752rr0lPMbz/TprlTPAYoMj4uL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 12:18 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Thu, 8 Oct 2020, Arnd Bergmann wrote:
>
> It's good to see this code refactored in this way because, as well as
> de-duplication, it reveals the logic that's common to the relevant
> platforms and may shed some light on the need for that logic.
>
> Yet it's not clear to me that the clockevents framework is able to replace
> that logic on all of the affected hardware. I suppose it remains to be
> seen.

I suspect that the change I did for one platform in patch 13/13 could be
duplicated for all 16 platforms, adding lots of trivial clockevent drivers that
only support periodic ticks, but any platform that can instead support
oneshot timers should probably do that, or it won't provide any better
behavior.

What do others think we should do here?

> As a corollary, cutting edge ("non-legacy") code is often kept out of open
> source projects by the owners of the intellectual property rights.

I'm happy to change the name in any way if you have a suggestion
that the clock event maintainers (Daniel and Thomas) like.

      Arnd
