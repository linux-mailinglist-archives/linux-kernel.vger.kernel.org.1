Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF24E2A0F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 21:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgJ3Uhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 16:37:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbgJ3Uhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 16:37:53 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3CDC22202;
        Fri, 30 Oct 2020 20:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604090272;
        bh=KMeucbRcvCAihtlPektQKjQQmEbPkfEfXwxxqluaaUQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n0aOfPqikD2DqyDNtRdaMMz7zhgr2XFWvlOW8+szCciZ5IZ8WuBMCbDXaTreNOhYd
         drDknWEy+B/EaXYzq5iB3C7eEB5kYGx8pLc4oN9CU7d1t1kT1X64Yy9dWE2pXXHTOA
         G8RJawjTEvYxNFoGoVoK9qn4pWo9Mc5PTx0Qdo+w=
Received: by mail-qk1-f176.google.com with SMTP id a64so2754066qkc.5;
        Fri, 30 Oct 2020 13:37:51 -0700 (PDT)
X-Gm-Message-State: AOAM532yFFpy7QyyLX+gbCSHHioLAcA4NL7gZ0NaQvbkgAJLMOyyXuSr
        Cj8izF7fDS/91wYsBh0mTe+Wg3ElKglIr0B/DAM=
X-Google-Smtp-Source: ABdhPJw19dZY4Xih4GL4dANiN8uMa27xGqxcu4F9ebbgd48VSQ+Qm0ZF3KNUOEKXfjfqBfqrvnQ2vDND7Ej01f3sHHE=
X-Received: by 2002:a05:620a:22c9:: with SMTP id o9mr4110937qki.286.1604090270867;
 Fri, 30 Oct 2020 13:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201030151758.1241164-1-arnd@kernel.org> <20201030151758.1241164-8-arnd@kernel.org>
 <2e2d7b65-0aa8-55aa-d395-52cfb048adef@gmx.de> <CAK8P3a0dPxWu6obX6jca8TsDQw6xsBmrihu8oH0TxR-BxYV3vw@mail.gmail.com>
 <b4779fce-5218-8aea-a416-b2806c9d062d@gmx.de>
In-Reply-To: <b4779fce-5218-8aea-a416-b2806c9d062d@gmx.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 30 Oct 2020 21:37:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3F9Dx5fnE1nsEQqNH-fBM3-tFK7Kj3CECmNF8U4n8mug@mail.gmail.com>
Message-ID: <CAK8P3a3F9Dx5fnE1nsEQqNH-fBM3-tFK7Kj3CECmNF8U4n8mug@mail.gmail.com>
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

On Fri, Oct 30, 2020 at 8:48 PM Helge Deller <deller@gmx.de> wrote:
> On 10/30/20 8:33 PM, Arnd Bergmann wrote:
> > On Fri, Oct 30, 2020 at 6:13 PM Helge Deller <deller@gmx.de> wrote:
> >>
> >> On 10/30/20 4:17 PM, Arnd Bergmann wrote:
> >>> From: Arnd Bergmann <arnd@arndb.de>
> >>>
> >>> parisc has selected CONFIG_GENERIC_CLOCKEVENTS since commit 43b1f6abd590
> >>> ("parisc: Switch to generic sched_clock implementation"), but does not
> >>> appear to actually be using it, and instead calls the low-level
> >>> timekeeping functions directly.
> >>
> >> Arnd, thank you for this patch!
> >> It reminded me that I really missed to fully implement the clockevents on parisc!
> >>
> >> Your other patch ("RFC: m68k: mac: convert to generic clockevent")
> >> was a big help too, as it showed how it might work on parisc as well.
> >>
> >> Here is now a current version of the clockevents-enabling-patch for parisc:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?h=for-next&id=3b7ab4a74a2d1972dbeb33285d85f1500b2ff96a
> >
> > Ah, nice!
> >
> >>> Remove the GENERIC_CLOCKEVENTS select again, and instead convert to
> >>> the newly added legacy_timer_tick() helper.
> >>
> >> My patch still needs more testing, but if it turns to work
> >> out right, would you mind to drop your patch for parisc?
> >
> > I think it would be easier if you could base your patch on top of
> > my series, as they would otherwise inevitably conflict. I could either
> > add it to my tree, or you could merge my branch into your tree.
>
> Couldn't you drop your patch and include mine in your tree instead?
> That way nothing conflicts, and they get merged together?

That only works if nobody merges this branch into another one,
otherwise we end up with multiple copies of the later commits.

       Arnd
