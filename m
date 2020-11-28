Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC252C7151
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391274AbgK1V43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387771AbgK1VI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 16:08:26 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B901C0613D1;
        Sat, 28 Nov 2020 13:07:40 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id g1so7685302ilk.7;
        Sat, 28 Nov 2020 13:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xgTU/AQfBLAhgL/L35xo0cEqhACBRAiUDqmEo1ROo94=;
        b=DJ7fstxZWlAA7n+PzHydmq1XIT/kR0l77GOBXjnxJPuwV8+w7Im353K9Wgz/v/FBII
         SLSfS+ii0gs/kFHpntALIRGPwylG51B47197ycEmsxI/ANgFriG7z5xLPav2789ceNGF
         IRsb6/Iy6maIds6Lkz3hwJlGsIhxtakpBpxq2mQe/7r8acV/6eVTsMpQA+/uxcu2+F5I
         e7PFOzMvY0OTAvEbXaKGKZJG7VHlN61u6qEBcs6N5mwGdttsdwb3fFf00ChdZRaCsaVP
         CuTsuiQV0SdX/HxoAyfOhY/b5zSwOkM3KNjd3IrSJEapMSaRNlKBR8iKo6+0bmqlm8bG
         xctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xgTU/AQfBLAhgL/L35xo0cEqhACBRAiUDqmEo1ROo94=;
        b=EoWoXHB8ZGskRG/7bbBCkCA+wQ94cU1VtHzucago2gCxMcVpanFTEqMjppp1WI2bJ0
         eNxpenuxqvgW5tCNhRto94csCLj6oPdPRvvAQtVCTQ2h60YeqQk3L0e+LryMQMvL26+1
         vxAFlpryr+hTsUYVdRz7HR5wCLcO2NE5iyQIxKuD9YbDiqc4UUonSOW/DAuV4weKbSna
         jBbZKhZg5VR2aTQqQUjydEi5QDMZ0R9XxpF7zz5eXS++xPIXlbaWCm0+PhmUDYJ7H+EG
         irjc8qtUBPnMym6pp8k8UTcEfiQQYtsnq5pn7Rb+3KMFf8P55C3sM84O3IfL7U5ItrtN
         8Ajg==
X-Gm-Message-State: AOAM531UfF0Tk/ytSOG3vZ/9HOJzKll3MoU+SH6qCjr7RiqQDbO6xLYc
        17vf/xHTRsEi6wZHrf86FIxBAjagJl4IwIYKUUI=
X-Google-Smtp-Source: ABdhPJyzE7cChO9e74gcQRyK1+2QtClnHW66ySiec0lq01tlZnONWf39S59BXuiHptNrcM7AXiXtqiu6ByJ7K6zecW8=
X-Received: by 2002:a92:d38e:: with SMTP id o14mr11894928ilo.59.1606597659200;
 Sat, 28 Nov 2020 13:07:39 -0800 (PST)
MIME-Version: 1.0
References: <6175E674-E8BC-4199-8BE8-A983065C32D5@aosc.io> <20201116155508.364dg6ycklwylswe@gilmour.lan>
 <8FFC1A6C-9CA4-4F94-91C4-F111A7519979@aosc.io> <20201120155939.3ajmbny2pka2vsnf@gilmour>
 <A8E91BA0-22FD-47F4-A5B2-A80A38FE9A0E@aosc.io> <38ee5feb-e35d-801f-99a1-65e23618e73b@sholland.org>
 <20201123111512.y7lbwsipbkcpuleb@gilmour> <97E2037C-3C3C-4B0B-8462-39B9E38CB3BB@aosc.io>
 <20201123125332.2p5z3ew7svszvyfs@gilmour> <009A22D9-AF20-45C4-9674-13334B3EFFBA@aosc.io>
 <20201128103827.d6sfc2eumli2betx@gilmour> <1666a61f6ea3e7d573795f9000a0b096c7b7dee0.camel@aosc.io>
 <CAJiuCcfEcM+Dksm4uoRPCiRepDSnEmp7pr8Qk5EsFSH_zEOTYA@mail.gmail.com> <C8F86F90-14BF-4857-9DB8-7968A34E4656@aosc.io>
In-Reply-To: <C8F86F90-14BF-4857-9DB8-7968A34E4656@aosc.io>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 28 Nov 2020 22:07:27 +0100
Message-ID: <CAJiuCcc=s6xG7Wzfx6PBU0e3BHz+YRpU=t0Ef3EcTp9k11Dkzg@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 3/3] arm64: allwinner: dts: a64: add DT
 for PineTab developer sample
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Samuel Holland <samuel@sholland.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime, Icenowy,

On Sat, 28 Nov 2020 at 12:59, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
>
> =E4=BA=8E 2020=E5=B9=B411=E6=9C=8828=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=887:54:04, "Cl=C3=A9ment P=C3=A9ron" <peron.clem@gmail.com> =E5=86=99=E5=
=88=B0:
> >Hi Icenowy,
> >
> >On Sat, 28 Nov 2020 at 12:28, Icenowy Zheng <icenowy@aosc.io> wrote:
> >>
> >> =E5=9C=A8 2020-11-28=E6=98=9F=E6=9C=9F=E5=85=AD=E7=9A=84 11:38 +0100=
=EF=BC=8CMaxime Ripard=E5=86=99=E9=81=93=EF=BC=9A
> >> > On Mon, Nov 23, 2020 at 09:10:38PM +0800, Icenowy Zheng wrote:
> >> > > > > > > > Okay. But I'm not satisfied with a non-public sample
> >> > > > > > > > occupies
> >> > > > > > > > the pinetab name. Is rename it to pinetab-dev and add a
> >> > > > > > > > pinetab-retail okay?
> >> > > > > > >
> >> > > > > > > To me, naming the production version anything but
> >"pinetab"
> >> > > > > > > isn't
> >> > > > > > > satisfying either.
> >> > > > > >
> >> > > > > > I understand where you're coming from, but the point I was
> >> > > > > > making my
> >> > > > > > previous mail is precisely that it's not really possible.
> >> > > > > >
> >> > > > > > You want to name the early adopter version _the_ production
> >> > > > > > version. Let's assume the hardware changes again between
> >the
> >> > > > > > early
> >> > > > > > adopter and mass-production version. Which one will be
> >_the_
> >> > > > > > production version? The early-adopter or the mass-produced
> >> > > > > > one?
> >> > > > > >
> >> > > > > > There's really no good answer here, and both would suck in
> >> > > > > > their
> >> > > > > > own way. The only way to deal with this is to simply avoid
> >> > > > > > defining one version as the one true board, and just
> >loading
> >> > > > > > the
> >> > > > > > proper DT in u-boot based on whatever clue we have of the
> >> > > > > > hardware
> >> > > > > > revision.
> >> > > > > Then will it be okay to rename current pinetab DT to
> >> > > > > pinetab-sample and then introduce new DTs all with suffixes?
> >> > > >
> >> > > > No. From my previous mail:
> >> > >
> >> > > It can be seen as dropping the PineTab DT and introduce new DTs
> >> > > with
> >> > > suffix.
> >> > >
> >> > > Do we have rule that we cannot drop boards?
> >> >
> >> > Are you really arguing that removing a DT and then adding an
> >> > identical
> >> > one under a different name is not renaming it?
> >>
> >> Then we can just keep confusing name?
> >
> >Sorry maybe I missed some information
> >But why don't you do like pinephone?
>
> They're the same board revision with different LCD panels.

I just ask Pine64 about this and here is the reply :
"The PineTab LCD panel change was a last minutes before production
starts that vendor advise us switch over to new LCD controller due to
EoL concern".

"Pine64 communication" is not so bad we just need to ask and they reply :)

So the issue is not that the Product was not finalized but that one
component arrives in EoL.
This could also happens during a running production.

Regards,
Clement

>
> And the major problem is that the DT for samples is already submitted
> under the name "PineTab".
>
> >sun50i-a64-pinetab-1.0.dts
> >sun50i-a64-pinetab-1.1.dts
> >
> >-dev is also a confusing name I think, as the board has been already
> >shipped.
> >
> >Regards,
> >Clement
> >
> >
> >>
> >> If we do so, how can we mark the new DT as "the user should use this
> >> one"?
> >>
> >> --
> >> You received this message because you are subscribed to the Google
> >Groups "linux-sunxi" group.
> >> To unsubscribe from this group and stop receiving emails from it,
> >send an email to linux-sunxi+unsubscribe@googlegroups.com.
> >> To view this discussion on the web, visit
> >https://groups.google.com/d/msgid/linux-sunxi/1666a61f6ea3e7d573795f9000=
a0b096c7b7dee0.camel%40aosc.io.
