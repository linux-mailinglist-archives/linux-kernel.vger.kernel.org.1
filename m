Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C202A6883
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 16:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbgKDPym convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Nov 2020 10:54:42 -0500
Received: from gloria.sntech.de ([185.11.138.130]:43498 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730429AbgKDPyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 10:54:41 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kaL7K-0000Fl-3J; Wed, 04 Nov 2020 16:54:34 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Doug Anderson <dianders@chromium.org>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Rob Herring <robh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Assign a fixed index to mmc devices on rk3399-roc-pc boards.
Date:   Wed, 04 Nov 2020 16:54:33 +0100
Message-ID: <10029979.JCShpOL5JR@diego>
In-Reply-To: <CAD=FV=V2Vv0bv-exiZ6VrOtfMM5TVpjATO04qaXeGWDRu+6vyw@mail.gmail.com>
References: <20201104094950.2096-1-m.reichl@fivetechno.de> <4984701.vSXMUKeAfh@diego> <CAD=FV=V2Vv0bv-exiZ6VrOtfMM5TVpjATO04qaXeGWDRu+6vyw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 4. November 2020, 16:42:01 CET schrieb Doug Anderson:
> Hi,
> 
> On Wed, Nov 4, 2020 at 2:51 AM Heiko Stübner <heiko@sntech.de> wrote:
> >
> > Hi Markus,
> >
> > Am Mittwoch, 4. November 2020, 10:49:45 CET schrieb Markus Reichl:
> > > Recently introduced async probe on mmc devices can shuffle block IDs.
> > > Pin them to fixed values to ease booting in evironments where UUIDs
> > > are not practical. Use newly introduced aliases for mmcblk devices from [1].
> > >
> > > [1]
> > > https://patchwork.kernel.org/patch/11747669/
> > >
> > > Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> > > ---
> > >  arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> > > index e7a459fa4322..bc9482b59428 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> > > @@ -13,6 +13,11 @@ / {
> > >       model = "Firefly ROC-RK3399-PC Board";
> > >       compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
> > >
> > > +     aliases {
> > > +             mmc0 = &sdmmc;
> > > +             mmc1 = &sdhci;
> > > +     };
> > > +
> >
> > Any reason for this odering?
> >
> > I.e. some previous incarnations had it ordered as (emmc, mmc, sdio).
> > This is also true for the ChromeOS out-of-tree usage of those, the
> > rk3399 dts in the chromeos-4.4 tree also orders this as sdhci, sdmmc, sdio.
> >
> > And I guess a further question would be when we're doing arbitary orderings
> > anyway, why is this not in rk3399.dtsi ;-) ?
> 
> Though I personally like the idea of eMMC, which is typically
> built-in, as being the "0" number, I'm personally happy with any
> numbering scheme that's consistent.  Ordering them by base address is
> OK w/ me and seems less controversial.  That seems like it could go in
> rk3399.dtsi and then if a particular board wanted a different order
> they could override it in their board file. 

Yep that sounds sensible and ordering by base address at least is one
"simple" type of order without too much explanation needed.

So I guess we'd get a sdio + sdmmc + sdhci ordering


@Markus: if nobody else complains, can you do a "simple" rk3399.dtsi
change with that please?


> The downside of putting
> in rk3399 is that boards that don't have all SD/MMC interfaces enabled
> would definitely get a new number compared to old kernels, but
> hopefully this is the last time?

With that new asynchronous mmc-probe-thingy in 5.10 that "caused" this,
it sounds like everything gets a new number anyway ;-) .


Heiko


