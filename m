Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A872D2461
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 08:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgLHHcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 02:32:50 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33959 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgLHHcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 02:32:50 -0500
Received: by mail-ot1-f65.google.com with SMTP id h19so15075539otr.1;
        Mon, 07 Dec 2020 23:32:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ntm5kX2/68W+Rb853G9+JOfMY9ZEj0sbIzeYrRjxZk=;
        b=hCsda1bBwteVeeauBruDUFoBH9WKguL8J3D+VHU2wJk8+YiQDvzNXocIzMI1dy40/d
         d4G2USPZmJM8FJmxGYkJU7SUY0jW3IsgnzHYtOAFdK6Qms9gSTdhcHaDHiGSBNBWdGyh
         XE/Fx97vJrTYvoaCS6yTQKcE+wTFC26zDfSXmuQpefAwl5e3xdFxe/1BzXkjmL+s42lt
         xMBkERKDZT7O+nU1Uf5NjRXj4rwMIOQ5xmXt99SCOe37Ap65UMBuJvqgqk4rhXPHwttj
         KrbRa4wuUG8K7f4sC+eibfy8RKq8+jJWNHe+h9onVVX9OYcrQAG1xlA9z06euTwwjmp4
         w4Wg==
X-Gm-Message-State: AOAM531s4dTf56Thk0Ex5+CHum+zySOpK3VjdGJg06rAO55mrkmHWCiO
        kyUw/5AHPsvF5hR+5nLUDKU9zuyFEorMiuXhGG4=
X-Google-Smtp-Source: ABdhPJzP3zsmCeQZJGI7WUQZGhFTcbnh1RiZSiteZgaVGYQqSLbzhPDTO9A8RxzKoxXx6hYzxTPBjTUhJJRQIgbFnHI=
X-Received: by 2002:a05:6830:1f5a:: with SMTP id u26mr15841607oth.250.1607412729258;
 Mon, 07 Dec 2020 23:32:09 -0800 (PST)
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
 <CAK8P3a3xqqT7mcroY+-fg4T39msw72SB0NbbVKfBghmOFTNZqw@mail.gmail.com> <CAD=FV=WXcSBkN2y97xNma0P9C6DEPfwkprZe=+0+0iuKYNwwZA@mail.gmail.com>
In-Reply-To: <CAD=FV=WXcSBkN2y97xNma0P9C6DEPfwkprZe=+0+0iuKYNwwZA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Dec 2020 08:31:57 +0100
Message-ID: <CAMuHMdWEuzUTg+f_SBqvT1zFYVFL=odgMLz68DjcvaTrbtd94g@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes for v5.10, part 3
To:     Doug Anderson <dianders@chromium.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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

Hi Doug,

On Mon, Dec 7, 2020 at 11:15 PM Doug Anderson <dianders@chromium.org> wrote:
> On Mon, Dec 7, 2020 at 1:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > On Mon, Dec 7, 2020 at 9:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, Dec 1, 2020 at 3:06 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > > On Tue, Dec 1, 2020 at 12:39 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > So, I think we have two options. If people are willing to move to
> > > > > "disk labels" or to patch their DTBs with mmc aliases, things can stay
> > > > > as is. Otherwise, we can revert the async probe parts of the mmc host
> > > > > drivers, but that would still leave us in a fragile situation.
> > > >
> > > > Can you reliably detect whether the mmc aliases in the dt exist?
> > > > If that's possible, maybe the async flag could be masked out to only have
> > > > an effect when the device number is known.
> > >
> > > IMHO DT aliases are not a proper solution for this.
> > >
> > > Yes, you can detect reliably if an alias exists in the DT.
> > > The problems start when having multiple devices, some with aliases,
> > > some without.  And when devices can appear dynamically (without
> > > aliases, as there is no support for dynamically updating the aliases
> > > list).
> >
> > Actually you hit a problem earlier than that: the async probe is a
> > property of the host controller driver, which may be a pci_driver,
> > platform_driver, usb_driver, or anything else really. To figure out
> > whether to probe it asynchronously, it would have to be the driver
> > core, or each bus type that can host these to understand which
> > device driver is responsible for probing an eMMC device attached
> > to the host.
>
> From what I've seen so far, my current thought on this issue is that
> it's up to Ulf as the MMC maintainer what the next steps are.  For me,
> at least, his argument that MMC block numbers have already shuffled
> around several times in the last several years is at least some
> evidence that they weren't exactly stable to begin with.  While we
> could go back to the numbers that happened to be chosen as of kernel
> v5.9, if someone was updating from a much older kernel then they may
> have different expectations of what numbers are good / bad I think.
>
> I will also offer one possible suggestion: what about a KConfig option
> here?  In theory we could add a KConfig option like
> "CONFIG_MMC_LEGACY_PROBE" or something that.  One can argue about what
> the default ought to be, but maybe that would satisfy folks?  If you
> were happy giving up a little bit of boot speed to get the v5.9 block
> numbers then you could set this.

This is not limited to MMC.
The same is true for sdX, ethX (e* these days), ttyS*, i2cX, spiX, ...
The rule has always been to handle it by udev, disklabels, ...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
