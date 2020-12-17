Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574FD2DCF8C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgLQKdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:33:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgLQKdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:33:31 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608201170;
        bh=Zz4IiQ8am45tfhmW1b2/exsoF0+5osn1Yg4Hf+pvegI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kIKPbQXTn+71fFaVOlhcJ+34OCgy2TL+rLW8pFpeIWHRZDdEK7maA/gqbcyDEAIpj
         9oDEQF7dFdD9e3Qt5uO6tGdYRhU3o8pQjbuNg69RX2vwPEx/lsV1UFcQALIF/4Ryvu
         WjX4x7sDvp2cnXXCpdT0aWkKSI7X2TGxtI+1JOL1aJzfDjakQxjFQaO4vDnZfMEX+4
         PaQHYEBvY7KDb1lSsQMg2FRrDsiKK+WB1thld5jVQWBdwmdeQXkoaTZj/Aa5CEhWF5
         QUucacCNWqo9GdiO/TVjncDQNGaa/LS8ApzrD8HNQ9f008EGJ/RyYBcJ6uPxbMDKVr
         UXrraz9vDhjGA==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMhs-H_ixfqMxVFOf+J0O-Tp0Q0ngviMm6jHrHJSgCLwZj+Tvw@mail.gmail.com>
References: <20201122095556.21597-1-sergio.paracuellos@gmail.com> <20201122095556.21597-3-sergio.paracuellos@gmail.com> <160819550615.1580929.14234996916739809712@swboyd.mtv.corp.google.com> <CAMhs-H_EiDot_V4Qj1Q8noAf5RNi9BOyy0WmawE+70wY7=FxDg@mail.gmail.com> <160819962346.1580929.2348154780751858972@swboyd.mtv.corp.google.com> <CAMhs-H_ixfqMxVFOf+J0O-Tp0Q0ngviMm6jHrHJSgCLwZj+Tvw@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] dt: bindings: add mt7621-clk device tree binding documentation
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        Weijie Gao <hackpascal@gmail.com>,
        COMMON CLK FRAMEWORK <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:MIPS <linux-mips@vger.kernel.org>, open list:STAGING 
        SUBSYSTEM <devel@driverdev.osuosl.org>, NeilBrown <neil@brown.name>, 
        open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 17 Dec 2020 02:32:49 -0800
Message-ID: <160820116913.1580929.15821601182796836787@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergio Paracuellos (2020-12-17 02:14:10)
> On Thu, Dec 17, 2020 at 11:07 AM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Sergio Paracuellos (2020-12-17 02:01:39)
> > >
> > > On Thu, Dec 17, 2020 at 9:58 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > > >
> > > > Quoting Sergio Paracuellos (2020-11-22 01:55:52)
> > > >
> > > > > diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7=
621-clk.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7621-clk.=
yaml
> > > > > new file mode 100644
> > > > > index 000000000000..6aca4c1a4a46
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/clock/mediatek,mt7621-clk=
.yaml
> > > >
> > > > > +      compatible =3D "mediatek,mt7621-sysc", "syscon";
> > > > > +      reg =3D <0x0 0x100>;
> > > > > +
> > > > > +      pll {
> > > >
> > > > clock-controller? Why can't the parent device be the clk provider a=
nd
> > > > have #clock-cells?
> > > >
> > >
> > > I don't get your point, sorry. Can you please explain this a bit more
> > > or point to me to an example to understand the real meaning of this?
> >
> > It looks like this is a made up child node of syscon so that a driver
> > can probe in the kernel. It would be more DT friendly to create a
> > platform device from the parent node's driver, or just register the clks
> > with the framework directly in that driver.
>=20
> We cannot create a platform device because we need clocks available in
> 'plat_time_init' before setting up the timer for the GIC.
> The only way I see to avoid this syscon and having this as a child
> node is to use architecture operations in
> 'arch/mips/include/asm/mach-ralink/ralink_regs.h'
> instead of getting a phandle using the regmap is being currently used...

Can that be done with

CLK_OF_DECLARE_DRIVER("mediatek,mt7621-sysc", my_timer_clk_init)

? Is the syscon used anywhere besides by the clk driver?
