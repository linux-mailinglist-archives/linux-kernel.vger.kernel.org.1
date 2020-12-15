Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077C42DAA74
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 10:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgLOJyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 04:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgLOJyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 04:54:22 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28E2C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 01:53:41 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id z16so10636747vsp.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 01:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OI5+AJWSwdA8qVAOofTdmeYq5WpDo/US6jBkWpa07uc=;
        b=RIcgqj1D8rLIpMYChvvIIzfyUjk/FOJnn5jA+EldpSezdMOf3jjoNPIEzmvdWDeT1q
         aPOw5fQHgEzCST11jORDRfH6g53jMARVGIq8xRkmFjFBSidkYVsw6S/GzwZbkUl6pbCo
         F4YLJYud76eS21IMHPRN+0ZlkcA3lcmVRyUzewleK1Q59tqSBKh8vEXy8rTGg41wv5Kp
         jL+Uwh1RpdEfb+wOQ/vTTXB4uWktHCEGjXMeS0qKTcVbbQfvCzzpGFzsqMbJPVTQPrK7
         WQSpyiVzwpfBXLSkZy5kQyhQB1brXnLpcCgiANnkThCEZ1oNqnLJn0fPqQ8d7YD59GEa
         6S3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OI5+AJWSwdA8qVAOofTdmeYq5WpDo/US6jBkWpa07uc=;
        b=D8y248TisYRqIClMZlv8L/Xof7jbwCFIDH5fvk1JiJvo23QJO9/0m4KkFmg7LXihY2
         EmX45yn49rvFmO/ea1uA6FSx9XBuv5NTnENAIdmb/ni31lndkixIxNHF+OPkw9TVClei
         5HNQ6SmpM0qKrRaFRxk1gfZpCW0LsADDvEr7tv0epZQDNhgSsXixx7y9cvzccWEOSrhh
         gcVqaodhTakOzxSRpQ8KWsACtG11i0dyLE8I609CeSgbITBr1DWMDWkAPt+Cpn0IcqIm
         y+AW0sdQ326xhyoR9OyxG/+A89rbbOrdaS7Qb/ykPmz+h1MyGlE+2vF3Pys4EjV6+yNg
         HvUg==
X-Gm-Message-State: AOAM532W5CwFXZxYoSAIsbwGssbZTdlfUnWZH+PN7HMMw33ynHyoTNnd
        EoJsmxAp/QusaK+lwh/BCBo3jr7sby3UGhB3VbezFw==
X-Google-Smtp-Source: ABdhPJzfIj1qnq7tCCnnbUDL2YFGisHI7QMHjJKeJz9nnU70YzQ2UI23tkePA2bkS4ZhZE8tY+yJkYF3Aii2l+3kI0g=
X-Received: by 2002:a67:e286:: with SMTP id g6mr28189547vsf.42.1608026020738;
 Tue, 15 Dec 2020 01:53:40 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2Habmz95y+J+-4NiT5SGYhO_Fia-SHhapX-3NYRbEMmw@mail.gmail.com>
 <CAHk-=wjA2Der39e_SWZ6S-DoVCJTu-Zwf6jn2wxmGTKzNPV1Dw@mail.gmail.com>
 <CAD=FV=Vow5_jv=-O=f2v4_5Nb4DiOUB1sQUx6r=-y5A-6rP4hw@mail.gmail.com>
 <CAHk-=whtySEgkH+VFy9oW8Q-+iuivGBo0hOUcee3DvrsBAQUrA@mail.gmail.com>
 <CAD=FV=Up-JW8RtMLQ_pAG3e0d8NnpT+rDiguxcz3DnVUz_7Jbw@mail.gmail.com>
 <CAHk-=wi2CQwAnKucLwE8vNZgXxyRy6L+DcgjGqxKHwbacKgaMQ@mail.gmail.com>
 <CAPDyKFp9L+L9VeUD038G3mBTLBuPJsMtv7JhxCcSGb3iY=eq5A@mail.gmail.com>
 <CAK8P3a1Va_xJzk8qqJM1VBWfSKpomKbQh_NpPO20aoORoe0SWQ@mail.gmail.com>
 <CAMuHMdUT83EkE-phUX2Z431AtGPfZvXeKwQriDKEHJKfr2R40A@mail.gmail.com>
 <CAK8P3a3xqqT7mcroY+-fg4T39msw72SB0NbbVKfBghmOFTNZqw@mail.gmail.com>
 <CAD=FV=WXcSBkN2y97xNma0P9C6DEPfwkprZe=+0+0iuKYNwwZA@mail.gmail.com>
 <CAMuHMdWEuzUTg+f_SBqvT1zFYVFL=odgMLz68DjcvaTrbtd94g@mail.gmail.com>
 <CAPDyKFpG2JZ6riZo=fFJa7q16bvhFyx2kR1K-s3aSfwZ9NDo6A@mail.gmail.com> <CAMuHMdVOxdYQD6qTF08NFiw4bRg3xscX=rRW1m9ix1AGEm3DGQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVOxdYQD6qTF08NFiw4bRg3xscX=rRW1m9ix1AGEm3DGQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Dec 2020 10:53:03 +0100
Message-ID: <CAPDyKFptyEQNJu8cqzMt2WRFZcwEdjDiytMBp96nkoZyprTgmA@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes for v5.10, part 3
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Dec 2020 at 09:19, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Mon, Dec 14, 2020 at 9:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Tue, 8 Dec 2020 at 08:32, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Mon, Dec 7, 2020 at 11:15 PM Doug Anderson <dianders@chromium.org> wrote:
> > > > On Mon, Dec 7, 2020 at 1:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > > > On Mon, Dec 7, 2020 at 9:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > On Tue, Dec 1, 2020 at 3:06 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > > > > > On Tue, Dec 1, 2020 at 12:39 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > > > So, I think we have two options. If people are willing to move to
> > > > > > > > "disk labels" or to patch their DTBs with mmc aliases, things can stay
> > > > > > > > as is. Otherwise, we can revert the async probe parts of the mmc host
> > > > > > > > drivers, but that would still leave us in a fragile situation.
> > > > > > >
> > > > > > > Can you reliably detect whether the mmc aliases in the dt exist?
> > > > > > > If that's possible, maybe the async flag could be masked out to only have
> > > > > > > an effect when the device number is known.
> > > > > >
> > > > > > IMHO DT aliases are not a proper solution for this.
> > > > > >
> > > > > > Yes, you can detect reliably if an alias exists in the DT.
> > > > > > The problems start when having multiple devices, some with aliases,
> > > > > > some without.  And when devices can appear dynamically (without
> > > > > > aliases, as there is no support for dynamically updating the aliases
> > > > > > list).
> > > > >
> > > > > Actually you hit a problem earlier than that: the async probe is a
> > > > > property of the host controller driver, which may be a pci_driver,
> > > > > platform_driver, usb_driver, or anything else really. To figure out
> > > > > whether to probe it asynchronously, it would have to be the driver
> > > > > core, or each bus type that can host these to understand which
> > > > > device driver is responsible for probing an eMMC device attached
> > > > > to the host.
> > > >
> > > > From what I've seen so far, my current thought on this issue is that
> > > > it's up to Ulf as the MMC maintainer what the next steps are.  For me,
> > > > at least, his argument that MMC block numbers have already shuffled
> > > > around several times in the last several years is at least some
> > > > evidence that they weren't exactly stable to begin with.  While we
> > > > could go back to the numbers that happened to be chosen as of kernel
> > > > v5.9, if someone was updating from a much older kernel then they may
> > > > have different expectations of what numbers are good / bad I think.
> > > >
> > > > I will also offer one possible suggestion: what about a KConfig option
> > > > here?  In theory we could add a KConfig option like
> > > > "CONFIG_MMC_LEGACY_PROBE" or something that.  One can argue about what
> > > > the default ought to be, but maybe that would satisfy folks?  If you
> > > > were happy giving up a little bit of boot speed to get the v5.9 block
> > > > numbers then you could set this.
> > >
> > > This is not limited to MMC.
> > > The same is true for sdX, ethX (e* these days), ttyS*, i2cX, spiX, ...
> > > The rule has always been to handle it by udev, disklabels, ...
> >
> > That's right.
> >
> > Although, those rules haven't been sufficient for some cases, which
> > has been discussed many many times by now. I can dig out some of the
> > old threads from the mail archive, just tell me and will help to find
> > them.
> >
> > For mmc we have decided to improve the situation by adding support for
> > aliases in DT. The support seems robust enough to me, but if you think
> > there are problems with it, please tell me and I am happy to help to
> > improve it.
>
> DT rule #1: DT is hardware description (device naming is software
> policy).

I do admit, the use of aliases in DT, for *all* cases including mmc is
a bit of a stretch. Anyway, it's there.

>
> The only generally accepted aliases are "serial0" (the first serial
> port, as such labeled on the board, to be used for the console;  there
> may be more labeled ports, and thus more "serialX" aliases), and
> "ethernet0" (the first Ethernet port, so U-Boot knows to which port to
> add an appropriate "local-mac-address" property, when booting over the
> network).  So yeah, you can claim the first SD card slot is labeled as
> such, and thus deserves an alias.  Then the issue is what you do with
> the remaining slots, which can be added either statically or
> dynamically.  And what if for some reason the labeled MMC slot is not
> probed first...

The probe order shouldn't matter. By pre-parsing all mmc aliases (for
all slots) existing in the DTB we can keep track of reserved ids. In
this way, for the non-alias case, we can dynamically select a
non-reserved id.

Although, perhaps more improvements can be made.

>
> The description of commit 7678f4c20fa7670f ("serial: sh-sci: Add support
> for dynamic instances") mentions some background and remaining
> issues w.r.t. aliases.
>
> > In regards to adding a new Kconfig option for "legacy probe", I am
> > open to this if that's what people think is needed. Although, as
> > pointed out earlier in this thread, it won't move us into a stable
> > situation. The only solution to get to that point, is either to use
> > udev/disklabel rules or the mmc aliases in DT.
>
> IMHO that will be a fragile solution, too: over time, it may become
> harder and harder to maintain the original probe order.
>
> And if it will be an option, it means there will be two code paths to
> maintain, increasing the burden.

Alright, sounds like we can conclude that the Kconfig option doesn't
seem like a good way forward.

Kind regards
Uffe
