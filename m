Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB22828D62D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 23:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgJMVWY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Oct 2020 17:22:24 -0400
Received: from mailoutvs18.siol.net ([185.57.226.209]:40435 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726652AbgJMVWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 17:22:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id CF05C526150;
        Tue, 13 Oct 2020 23:22:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id prebWZDhw8fy; Tue, 13 Oct 2020 23:22:18 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id EABF2526102;
        Tue, 13 Oct 2020 23:22:17 +0200 (CEST)
Received: from kista.localnet (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 2179552615A;
        Tue, 13 Oct 2020 23:22:16 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: Re: [PATCH v2] arm64: dts: allwinner: h6: add eMMC voltage property for Beelink GS1
Date:   Tue, 13 Oct 2020 23:27:33 +0200
Message-ID: <2745255.UFgyrzHpml@kista>
In-Reply-To: <20201009073651.izvvjpqiqiivhknl@gilmour.lan>
References: <20201003092001.405238-1-peron.clem@gmail.com> <CAJiuCcf8rk4t2GrS3+ANEuCtRmXoCMyzP+-x_rKrAfR-FaMaWA@mail.gmail.com> <20201009073651.izvvjpqiqiivhknl@gilmour.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 09. oktober 2020 ob 09:36:51 CEST je Maxime Ripard napisal(a):
> On Thu, Oct 08, 2020 at 10:00:06PM +0200, Clément Péron wrote:
> > Hi Maxime,
> > 
> > Adding linux-sunxi and Jernej Skrabec to this discussion.
> > 
> > On Thu, 8 Oct 2020 at 17:10, Maxime Ripard <maxime@cerno.tech> wrote:
> > >
> > > Hi Clément,
> > >
> > > On Mon, Oct 05, 2020 at 08:47:19PM +0200, Clément Péron wrote:
> > > > On Mon, 5 Oct 2020 at 11:21, Maxime Ripard <maxime@cerno.tech> wrote:
> > > > >
> > > > > Hi Clément,
> > > > >
> > > > > On Sat, Oct 03, 2020 at 11:20:01AM +0200, Clément Péron wrote:
> > > > > > Sunxi MMC driver can't distinguish at runtime what's the I/O 
voltage
> > > > > > for HS200 mode.
> > > > >
> > > > > Unfortunately, that's not true (or at least, that's not related to 
your patch).
> > > > >
> > > > > > Add a property in the device-tree to notify MMC core about this
> > > > > > configuration.
> > > > > >
> > > > > > Fixes: 089bee8dd119 ("arm64: dts: allwinner: h6: Introduce Beelink 
GS1 board")
> > > > > > Signed-off-by: Clément Péron <peron.clem@gmail.com>
> > > > > > ---
> > > > > >  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >
> > > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-
gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > > > > index 049c21718846..3f20d2c9bbbb 100644
> > > > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > > > > @@ -145,6 +145,7 @@ &mmc2 {
> > > > > >       vqmmc-supply = <&reg_bldo2>;
> > > > > >       non-removable;
> > > > > >       cap-mmc-hw-reset;
> > > > > > +     mmc-hs200-1_8v;
> > > > > >       bus-width = <8>;
> > > > > >       status = "okay";
> > > > > >  };
> > > > >
> > > > > I'm not really sure what you're trying to fix here, but as far as MMC
> > > > > goes, eMMC's can support io voltage of 3.3, 1.8 and 1.2V. Modes up 
until
> > > > > HS DDR (50MHz in DDR) will use an IO voltage of 3.3V, higher speed 
modes
> > > > > (HS200 and HS400) supporting 1.8V and 1.2V.
> > > >
> > > > Some users report that the eMMC is not working properly on their
> > > > Beelink GS1 boards.
> > > >
> > > > > The mmc-hs200-1_8v property states that the MMC controller supports 
the
> > > > > HS200 mode at 1.8V. Now, I can only assume that since BLDO2 is set 
up at
> > > > > 1.8V then otherwise, the MMC core will rightfully decide to use the
> > > > > highest supported mode. In this case, since the driver sets it, it 
would
> > > > > be HS-DDR at 3.3V, which won't work with that fixed regulator.
> > > > >
> > > > > I can only assume that enabling HS200 at 1.8V only fixes the issue 
you
> > > > > have because otherwise it would use HS-DDR at 3.3V, ie not actually
> > > > > fixing the issue but sweeping it under the rug.
> > > > >
> > > > > Trying to add mmc-ddr-1_8v would be a good idea
> > > >
> > > > Thanks for the explanation, this is indeed the correct one.
> > > > So It looks like the SDIO controller has an issue on some boards when
> > > > using HS-DDR mode.
> > > >
> > > > Is this patch acceptable with the proper commit log?
> > >
> > > If HS-DDR works, yes, but I assume it doesn't?
> > 
> > After discussing with Jernej about this issue, I understood that:
> > - Automatic delay calibration is not implemented
> > - We also miss some handling of DDR related bits in control register
> > 
> > So none of H5/H6 boards should actually work.
> > (Some 'lucky' boards seem to work enough to switch to HS200 mode...)
> > 
> > To "fix" this the H5 disable the HS-DDR mode in sunxi mmc driver :
> > https://github.com/torvalds/linux/blob/master/drivers/mmc/host/sunxi-mmc.c#L1409
> 
> I find it suspicious that some boards would have traces not good enough
> for HS-DDR (50MHz in DDR) but would work fine in HS200 (200MHz in SDR).
> If there's some mismatch on the traces, it will only be worse in HS200.

FYI, similar situation is also with Tanix TX6 board. Mine works well in HS-DDR 
mode, but some people reported that it doesn't work for them. The only 
possible difference could be different eMMC IC. I'll try to confirm that.

Anyway, I did some tests on OrangePi 3 board which also have eMMC. Both modes 
(HS-DDR and HS200) are supported and work well. Interesting observation is 
that speed test (hdparm -t) reported 80.58 MB/sec for HS-DDR mode and 43.40 
MB/sec for HS200. As it can be seen here, HS-DDR is quicker by a factor of 2, 
but it should be the other way around. Reason for this is that both modes use 
same base clock and thus HS-DDR produces higher speed.
If I change f_max to 150 MHz (max. per datasheet for SDR @ 1.8 V) then 
naturally HS200 mode is faster (124.63 MB/sec) as HS-DDR as it should be. This 
would be actually correct test for problematic boards but unfortunately I 
don't have it. I also hacked in support for HS400 (~143 MB/s) and this mode is 
the only one which really needs calibration on my board. 

Two observations from BSP driver:
1. Module clock is disabled before adjusting DDR bit and afterwards it's re-
enabled . That could fix some kind of glitches.
2. SDMMC peripheral runs on higher clock than on mainline.

> 
> And for the delay calibration, iirc, that's only necessary for HS400
> that we don't support?

According to BSP driver and its DT, HS200 also needs calibration. However, it 
seems that using it on lower speed it isn't needed.

Best regards,
Jernej

> 
> > I'm not sure about A64 but it looks like the property "mmc-hs200-1_8v"
> > for the PineBook shows the same issue.
> > 
> > The proper way would of course be to implement the missing feature
> > mentioned above.
> > But this could take some time and as the eMMC driver is actually
> > broken wouldn't it be better to disable the HS-DDR for H6 in the mmc
> > driver like it's done for H5 ?
> 
> Have you tested with only the mmc-ddr-1_8v property?
> 
> Maxime
> 


