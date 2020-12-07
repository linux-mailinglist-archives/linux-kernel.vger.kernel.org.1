Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33A92D1D19
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgLGWQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgLGWQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:16:15 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB023C061793
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 14:15:29 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id i62so3491064vkb.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 14:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zba0muHnPBIN4bYfIYdIe1tLp1gTKybFphRm3inPByQ=;
        b=Zsvt8tU15EATRR7AKIJauxr8QEVxEngkzOadeW/cbN4n9/N90HtGVaq+XnpsCLmI1Z
         pmn7ElCa48hfbaohINYuFiwl5MbpaIUumSbS61WsFxjxTvIPqp8ca1zo75WkzJvmWwhX
         QT5ZssyLUem0TcgNsrlSGsa17X9INYF0SvvxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zba0muHnPBIN4bYfIYdIe1tLp1gTKybFphRm3inPByQ=;
        b=rx0vxdTwidRvwAXSuOhQx3PhypKa5k3eOCo3wu3XjmD2gf7fLZl1UdBH3WgtDmejFq
         mUnm3SXVGm6VmvsBnnvX5tBluuHUXWtnbgrJWND99rUe5S+tORY2q70A0SiKaqUC/qe2
         q3fyLAt/vH0cBoPRzsHwDhtbb7JRA7XqlDLiRZSTSbLmmHAx6f0YVbAgsAsgUz86uJKs
         7BRmr7EoGp8+1YDCNIBkTgNbbLWDO0TVO17LvqUxErXHn79014EIlFkr4DqZIiGpKeXc
         3C90S1/FKooF261wMQqAjFYIYRRWk18nDCp/tc1VQqrpXY0PioxGBXW+WQWBsdzWIPES
         xh0g==
X-Gm-Message-State: AOAM531oGoSOSbZbiU27L33yGNHSou6LEqVGotn1Vx/zJUvpbX+yRz2g
        YMFyx6PegVfXixjkHT7BUHHDkwXsO7BgbQ==
X-Google-Smtp-Source: ABdhPJzT7NaCO4bDbgjqyBI8biZJiZ8wPAuvlt3pTyiDHDgRH+P3Dmd0lrkyqNadou1mRRJvpXoNnw==
X-Received: by 2002:a1f:78cf:: with SMTP id t198mr3387716vkc.15.1607379328614;
        Mon, 07 Dec 2020 14:15:28 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id d204sm1576395vka.45.2020.12.07.14.15.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 14:15:27 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id f29so2742962uab.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 14:15:27 -0800 (PST)
X-Received: by 2002:ab0:227:: with SMTP id 36mr458027uas.64.1607379327280;
 Mon, 07 Dec 2020 14:15:27 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2Habmz95y+J+-4NiT5SGYhO_Fia-SHhapX-3NYRbEMmw@mail.gmail.com>
 <CAHk-=wjA2Der39e_SWZ6S-DoVCJTu-Zwf6jn2wxmGTKzNPV1Dw@mail.gmail.com>
 <CAD=FV=Vow5_jv=-O=f2v4_5Nb4DiOUB1sQUx6r=-y5A-6rP4hw@mail.gmail.com>
 <CAHk-=whtySEgkH+VFy9oW8Q-+iuivGBo0hOUcee3DvrsBAQUrA@mail.gmail.com>
 <CAD=FV=Up-JW8RtMLQ_pAG3e0d8NnpT+rDiguxcz3DnVUz_7Jbw@mail.gmail.com>
 <CAHk-=wi2CQwAnKucLwE8vNZgXxyRy6L+DcgjGqxKHwbacKgaMQ@mail.gmail.com>
 <CAPDyKFp9L+L9VeUD038G3mBTLBuPJsMtv7JhxCcSGb3iY=eq5A@mail.gmail.com>
 <CAK8P3a1Va_xJzk8qqJM1VBWfSKpomKbQh_NpPO20aoORoe0SWQ@mail.gmail.com>
 <CAMuHMdUT83EkE-phUX2Z431AtGPfZvXeKwQriDKEHJKfr2R40A@mail.gmail.com> <CAK8P3a3xqqT7mcroY+-fg4T39msw72SB0NbbVKfBghmOFTNZqw@mail.gmail.com>
In-Reply-To: <CAK8P3a3xqqT7mcroY+-fg4T39msw72SB0NbbVKfBghmOFTNZqw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 7 Dec 2020 14:15:15 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WXcSBkN2y97xNma0P9C6DEPfwkprZe=+0+0iuKYNwwZA@mail.gmail.com>
Message-ID: <CAD=FV=WXcSBkN2y97xNma0P9C6DEPfwkprZe=+0+0iuKYNwwZA@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes for v5.10, part 3
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
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

Hi,

On Mon, Dec 7, 2020 at 1:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Mon, Dec 7, 2020 at 9:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Dec 1, 2020 at 3:06 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > On Tue, Dec 1, 2020 at 12:39 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > So, I think we have two options. If people are willing to move to
> > > > "disk labels" or to patch their DTBs with mmc aliases, things can stay
> > > > as is. Otherwise, we can revert the async probe parts of the mmc host
> > > > drivers, but that would still leave us in a fragile situation.
> > >
> > > Can you reliably detect whether the mmc aliases in the dt exist?
> > > If that's possible, maybe the async flag could be masked out to only have
> > > an effect when the device number is known.
> >
> > IMHO DT aliases are not a proper solution for this.
> >
> > Yes, you can detect reliably if an alias exists in the DT.
> > The problems start when having multiple devices, some with aliases,
> > some without.  And when devices can appear dynamically (without
> > aliases, as there is no support for dynamically updating the aliases
> > list).
>
> Actually you hit a problem earlier than that: the async probe is a
> property of the host controller driver, which may be a pci_driver,
> platform_driver, usb_driver, or anything else really. To figure out
> whether to probe it asynchronously, it would have to be the driver
> core, or each bus type that can host these to understand which
> device driver is responsible for probing an eMMC device attached
> to the host.

From what I've seen so far, my current thought on this issue is that
it's up to Ulf as the MMC maintainer what the next steps are.  For me,
at least, his argument that MMC block numbers have already shuffled
around several times in the last several years is at least some
evidence that they weren't exactly stable to begin with.  While we
could go back to the numbers that happened to be chosen as of kernel
v5.9, if someone was updating from a much older kernel then they may
have different expectations of what numbers are good / bad I think.

I will also offer one possible suggestion: what about a KConfig option
here?  In theory we could add a KConfig option like
"CONFIG_MMC_LEGACY_PROBE" or something that.  One can argue about what
the default ought to be, but maybe that would satisfy folks?  If you
were happy giving up a little bit of boot speed to get the v5.9 block
numbers then you could set this.


-Doug
