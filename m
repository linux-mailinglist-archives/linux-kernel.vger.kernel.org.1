Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C9A2DA176
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503133AbgLNUYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502882AbgLNUXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:23:53 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE89C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:23:12 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id e20so2993342vsr.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qemVwS3A1TNGUMdxCtwvfGT3Y17qMtJiy4ra8p4sq1Y=;
        b=lVWkvwBKzHTtPjibBLUe3+b1OsiC3s9T2X27UCHwCMTWzy/shD9mndOiYoc1BNXKM7
         dCJypQpSPnw7SmqPi7VjaCdXpBvhuAJpsDvR+BSmZ/fmPut/kXpBvc52hzes8DQGKgnq
         iw3EFQQMb2FJL/acs5+LcMLX6in5eD3GA9PGN6YLmHR6YJqCMatwxPmRSjVuH8DaKvNO
         jXyKptm7RmvWup5/xyrjNxSyinSNkr/bfW+gxLQ9KGYAeoR9O+0FXBCksDgs6jL4KyS9
         Fc8Eq1/T6ujVQKhJ32GmFJBDe82bO3oLsh/Cc5YUCzzQ6pBc6sF3JAlYjMHDpsI5R4lP
         Uqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qemVwS3A1TNGUMdxCtwvfGT3Y17qMtJiy4ra8p4sq1Y=;
        b=V9t2NE4/wgygIMfO3pRvTpFZR8u32Fy/zQ5Wu/KbQyYoU0yqRS1BPWp+R4Zv+AhnfZ
         BkAya47HWuCuboekz0VhFZlqM2srIQja490v49MPWKyyMh3kVGSXBh/bmd54zdxxcH6/
         U/Pg02tGM0PKCZhb8WDpyF/YQ0MjuJ6smUAumpyRi/FPgah2jTc/cgzmUWYMmDeU1Jcg
         uWbyyZPFLE47BhWbmVS5gH6Mpvnt/2p/4zBww52p0oMf8l0+UeIZBpkd8s4zeX/GrhIB
         9eZUv66rMk5yUEmRFjpRdik5MAPasx1NOtjXinLNwJsHPlRgYg/ms1YPJShrvgBr8maZ
         NC+w==
X-Gm-Message-State: AOAM5331F0XGK6ovrIhIkD6m3ETzJ9+6Ue0k9iNM8vmixZh9UVoyV/s8
        d6cq914FALV8VN/cHh0s5AZ4NPuhupl088Zkq3HpZQ==
X-Google-Smtp-Source: ABdhPJzf6tl7vK/G2uNALFfDiSu3tqFx1Q3ZvfjSeph3O9cndzHePiJ9fRqUV2uTvmfBjtjIqdOZMxZdUcVV3ABpq+g=
X-Received: by 2002:a67:7f41:: with SMTP id a62mr1604403vsd.55.1607977391606;
 Mon, 14 Dec 2020 12:23:11 -0800 (PST)
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
 <CAD=FV=WXcSBkN2y97xNma0P9C6DEPfwkprZe=+0+0iuKYNwwZA@mail.gmail.com> <CAMuHMdWEuzUTg+f_SBqvT1zFYVFL=odgMLz68DjcvaTrbtd94g@mail.gmail.com>
In-Reply-To: <CAMuHMdWEuzUTg+f_SBqvT1zFYVFL=odgMLz68DjcvaTrbtd94g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Dec 2020 21:22:34 +0100
Message-ID: <CAPDyKFpG2JZ6riZo=fFJa7q16bvhFyx2kR1K-s3aSfwZ9NDo6A@mail.gmail.com>
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

On Tue, 8 Dec 2020 at 08:32, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Doug,
>
> On Mon, Dec 7, 2020 at 11:15 PM Doug Anderson <dianders@chromium.org> wrote:
> > On Mon, Dec 7, 2020 at 1:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > On Mon, Dec 7, 2020 at 9:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Tue, Dec 1, 2020 at 3:06 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > > > On Tue, Dec 1, 2020 at 12:39 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > So, I think we have two options. If people are willing to move to
> > > > > > "disk labels" or to patch their DTBs with mmc aliases, things can stay
> > > > > > as is. Otherwise, we can revert the async probe parts of the mmc host
> > > > > > drivers, but that would still leave us in a fragile situation.
> > > > >
> > > > > Can you reliably detect whether the mmc aliases in the dt exist?
> > > > > If that's possible, maybe the async flag could be masked out to only have
> > > > > an effect when the device number is known.
> > > >
> > > > IMHO DT aliases are not a proper solution for this.
> > > >
> > > > Yes, you can detect reliably if an alias exists in the DT.
> > > > The problems start when having multiple devices, some with aliases,
> > > > some without.  And when devices can appear dynamically (without
> > > > aliases, as there is no support for dynamically updating the aliases
> > > > list).
> > >
> > > Actually you hit a problem earlier than that: the async probe is a
> > > property of the host controller driver, which may be a pci_driver,
> > > platform_driver, usb_driver, or anything else really. To figure out
> > > whether to probe it asynchronously, it would have to be the driver
> > > core, or each bus type that can host these to understand which
> > > device driver is responsible for probing an eMMC device attached
> > > to the host.
> >
> > From what I've seen so far, my current thought on this issue is that
> > it's up to Ulf as the MMC maintainer what the next steps are.  For me,
> > at least, his argument that MMC block numbers have already shuffled
> > around several times in the last several years is at least some
> > evidence that they weren't exactly stable to begin with.  While we
> > could go back to the numbers that happened to be chosen as of kernel
> > v5.9, if someone was updating from a much older kernel then they may
> > have different expectations of what numbers are good / bad I think.
> >
> > I will also offer one possible suggestion: what about a KConfig option
> > here?  In theory we could add a KConfig option like
> > "CONFIG_MMC_LEGACY_PROBE" or something that.  One can argue about what
> > the default ought to be, but maybe that would satisfy folks?  If you
> > were happy giving up a little bit of boot speed to get the v5.9 block
> > numbers then you could set this.
>
> This is not limited to MMC.
> The same is true for sdX, ethX (e* these days), ttyS*, i2cX, spiX, ...
> The rule has always been to handle it by udev, disklabels, ...

That's right.

Although, those rules haven't been sufficient for some cases, which
has been discussed many many times by now. I can dig out some of the
old threads from the mail archive, just tell me and will help to find
them.

For mmc we have decided to improve the situation by adding support for
aliases in DT. The support seems robust enough to me, but if you think
there are problems with it, please tell me and I am happy to help to
improve it.

In regards to adding a new Kconfig option for "legacy probe", I am
open to this if that's what people think is needed. Although, as
pointed out earlier in this thread, it won't move us into a stable
situation. The only solution to get to that point, is either to use
udev/disklabel rules or the mmc aliases in DT.

Kind regards
Uffe
