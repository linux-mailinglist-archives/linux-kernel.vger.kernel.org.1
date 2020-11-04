Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B832A68FE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgKDQEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:04:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbgKDQEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:04:07 -0500
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B66420825;
        Wed,  4 Nov 2020 16:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604505846;
        bh=klujtJzoAVLGeYfBOBO4813dr7WdQLbjskQZ2NSHj3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QaFTc11yiA3U8bPPwrgKRnbwnuScfUtM5Z24GLXsz/cZi1Gm1ENLCiwBV6d0vvKPw
         RFkQHU99fsZKJ/SyqdV/LhBgxf3UKRSvLT66HWgxRq0FElpkY1mw/ICglV9FoxHK2Z
         QLlTQcsgJdN7e59d/mttzoAMb2xe18OzkHlBvnWI=
Received: by mail-lf1-f53.google.com with SMTP id i6so27848899lfd.1;
        Wed, 04 Nov 2020 08:04:06 -0800 (PST)
X-Gm-Message-State: AOAM5310XOjxNi9EzCIQqJDeFPnYxDSGzhMVEmw1KgWL/7HprFootb3a
        z1CSnqYKilDPkruR70q7EzapksQut8GxfXBFj+8=
X-Google-Smtp-Source: ABdhPJx0L1STVkLnDpZqex5+MrAPhy2B7AEicH4fxVDlqcsdu3VIoCKFnepTQq3TSjtMNeySUtaDJ17dVHRT6sRVjhY=
X-Received: by 2002:a19:4281:: with SMTP id p123mr9303368lfa.398.1604505844386;
 Wed, 04 Nov 2020 08:04:04 -0800 (PST)
MIME-Version: 1.0
References: <20201104094950.2096-1-m.reichl@fivetechno.de> <4984701.vSXMUKeAfh@diego>
 <CAD=FV=V2Vv0bv-exiZ6VrOtfMM5TVpjATO04qaXeGWDRu+6vyw@mail.gmail.com> <10029979.JCShpOL5JR@diego>
In-Reply-To: <10029979.JCShpOL5JR@diego>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Thu, 5 Nov 2020 00:03:54 +0800
X-Gmail-Original-Message-ID: <CAGb2v65_uxjRWygd=ACr0KTCF7yqqk5crvkeKkNp28+qk_cByA@mail.gmail.com>
Message-ID: <CAGb2v65_uxjRWygd=ACr0KTCF7yqqk5crvkeKkNp28+qk_cByA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Assign a fixed index to mmc devices
 on rk3399-roc-pc boards.
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 4, 2020 at 11:55 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Mittwoch, 4. November 2020, 16:42:01 CET schrieb Doug Anderson:
> > Hi,
> >
> > On Wed, Nov 4, 2020 at 2:51 AM Heiko St=C3=BCbner <heiko@sntech.de> wro=
te:
> > >
> > > Hi Markus,
> > >
> > > Am Mittwoch, 4. November 2020, 10:49:45 CET schrieb Markus Reichl:
> > > > Recently introduced async probe on mmc devices can shuffle block ID=
s.
> > > > Pin them to fixed values to ease booting in evironments where UUIDs
> > > > are not practical. Use newly introduced aliases for mmcblk devices =
from [1].
> > > >
> > > > [1]
> > > > https://patchwork.kernel.org/patch/11747669/
> > > >
> > > > Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> > > > ---
> > > >  arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch=
/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> > > > index e7a459fa4322..bc9482b59428 100644
> > > > --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> > > > +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> > > > @@ -13,6 +13,11 @@ / {
> > > >       model =3D "Firefly ROC-RK3399-PC Board";
> > > >       compatible =3D "firefly,roc-rk3399-pc", "rockchip,rk3399";
> > > >
> > > > +     aliases {
> > > > +             mmc0 =3D &sdmmc;
> > > > +             mmc1 =3D &sdhci;
> > > > +     };
> > > > +
> > >
> > > Any reason for this odering?
> > >
> > > I.e. some previous incarnations had it ordered as (emmc, mmc, sdio).
> > > This is also true for the ChromeOS out-of-tree usage of those, the
> > > rk3399 dts in the chromeos-4.4 tree also orders this as sdhci, sdmmc,=
 sdio.
> > >
> > > And I guess a further question would be when we're doing arbitary ord=
erings
> > > anyway, why is this not in rk3399.dtsi ;-) ?
> >
> > Though I personally like the idea of eMMC, which is typically
> > built-in, as being the "0" number, I'm personally happy with any
> > numbering scheme that's consistent.  Ordering them by base address is
> > OK w/ me and seems less controversial.  That seems like it could go in
> > rk3399.dtsi and then if a particular board wanted a different order
> > they could override it in their board file.
>
> Yep that sounds sensible and ordering by base address at least is one
> "simple" type of order without too much explanation needed.
>
> So I guess we'd get a sdio + sdmmc + sdhci ordering
>
>
> @Markus: if nobody else complains, can you do a "simple" rk3399.dtsi
> change with that please?

Please also fix the LED triggers. :)

> > The downside of putting
> > in rk3399 is that boards that don't have all SD/MMC interfaces enabled
> > would definitely get a new number compared to old kernels, but
> > hopefully this is the last time?
>
> With that new asynchronous mmc-probe-thingy in 5.10 that "caused" this,
> it sounds like everything gets a new number anyway ;-) .

Yup.
