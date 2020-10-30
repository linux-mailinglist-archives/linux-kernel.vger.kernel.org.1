Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96AC2A0EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgJ3Tfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:35:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbgJ3TeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:34:00 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45D3422241;
        Fri, 30 Oct 2020 19:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604086439;
        bh=g7SiAGk5A8RixKhQULCkFnrF5K//+bNHA3FaRUTLL4g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C6slcq5aSjS7GS06l+kXiQYG2W3EXfB2fmrH7YQj8KG2y9IairregyAcpkssGyVNr
         sgSGGTESh+J5R4pPzOYzjObGZd01H9u5axqoyPs4uP/+M3XfI8gD6vL8T08AP/Tj9R
         0IJqIlFBRThpfRPkluDah7gUKFh4C+2YMUYIjTtw=
Received: by mail-qk1-f171.google.com with SMTP id s14so5912642qkg.11;
        Fri, 30 Oct 2020 12:33:59 -0700 (PDT)
X-Gm-Message-State: AOAM532TCxmgwxx1r9cZtgEzGIE7P2BkgmR2ePKHU1a8QlN4m1/JBH1I
        UxjQfwua8ca5leuaxXpuo2pow7YHGMqzkL1Li2U=
X-Google-Smtp-Source: ABdhPJwUOlGNfUOxUtaOxwKVaSWXD9jugMxz0WkwSIAGvO22U2svgROU9cpL848Dlq5/v4p6xdvjPr9BpOkt4M07GcA=
X-Received: by 2002:a05:620a:22c9:: with SMTP id o9mr3844436qki.286.1604086438187;
 Fri, 30 Oct 2020 12:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201030151758.1241164-1-arnd@kernel.org> <20201030151758.1241164-8-arnd@kernel.org>
 <2e2d7b65-0aa8-55aa-d395-52cfb048adef@gmx.de>
In-Reply-To: <2e2d7b65-0aa8-55aa-d395-52cfb048adef@gmx.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 30 Oct 2020 20:33:41 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0dPxWu6obX6jca8TsDQw6xsBmrihu8oH0TxR-BxYV3vw@mail.gmail.com>
Message-ID: <CAK8P3a0dPxWu6obX6jca8TsDQw6xsBmrihu8oH0TxR-BxYV3vw@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] parisc: use legacy_timer_tick
To:     Helge Deller <deller@gmx.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-ia64@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 6:13 PM Helge Deller <deller@gmx.de> wrote:
>
> On 10/30/20 4:17 PM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > parisc has selected CONFIG_GENERIC_CLOCKEVENTS since commit 43b1f6abd590
> > ("parisc: Switch to generic sched_clock implementation"), but does not
> > appear to actually be using it, and instead calls the low-level
> > timekeeping functions directly.
>
> Arnd, thank you for this patch!
> It reminded me that I really missed to fully implement the clockevents on parisc!
>
> Your other patch ("RFC: m68k: mac: convert to generic clockevent")
> was a big help too, as it showed how it might work on parisc as well.
>
> Here is now a current version of the clockevents-enabling-patch for parisc:
> https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?h=for-next&id=3b7ab4a74a2d1972dbeb33285d85f1500b2ff96a

Ah, nice!

> > Remove the GENERIC_CLOCKEVENTS select again, and instead convert to
> > the newly added legacy_timer_tick() helper.
>
> My patch still needs more testing, but if it turns to work
> out right, would you mind to drop your patch for parisc?

I think it would be easier if you could base your patch on top of
my series, as they would otherwise inevitably conflict. I could either
add it to my tree, or you could merge my branch into your tree.

      Arnd
