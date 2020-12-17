Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387392DCDE8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 09:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgLQIym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 03:54:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:59754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbgLQIyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 03:54:41 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608195240;
        bh=N4iCRKQ5T+IdPgDG6/JntbvuDR/5Iy5t84sQRrpsDaM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OCohtkSGSmeckU3Jeo5YvNxdiDuc1KLDnm8UnKF5jSs7pnTbMH6Upz6XoiX6Y9684
         bYIigips4cN0YKeQAfSMELNPVCGtG8/03MRdTQsNKh+FRuAJwxp+eVnFTRizuBLy5K
         /NZWtl+0hBYR7PecKHEb2Lts4lG3SOFzpa8nBLW4grG3DROVvCKfLqAfYy0i63VvdA
         UPxM6VzMnDX45pIZvckUyF60NluB5vHsj6dPAKXwL1Gr+TfeL3UeXnturfna1ew6bC
         gPtDc6XB8YL3LEdio1m7XtrALo7D3ml7TWXSDiSKwz/YkhD3Pjv8rnOpMLk1Rv0teQ
         oceMcokGDP+ZQ==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201123040237.GA3013347@chromium.org>
References: <1604887429-29445-1-git-send-email-weiyi.lu@mediatek.com> <1604887429-29445-24-git-send-email-weiyi.lu@mediatek.com> <20201123040237.GA3013347@chromium.org>
Subject: Re: [PATCH v5 23/24] arm64: dts: mediatek: Add mt8192 clock controllers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To:     Ikjoon Jang <ikjn@chromium.org>, Weiyi Lu <weiyi.lu@mediatek.com>
Date:   Thu, 17 Dec 2020 00:53:59 -0800
Message-ID: <160819523908.1580929.4609336150609889474@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ikjoon Jang (2020-11-22 20:02:37)
> On Mon, Nov 09, 2020 at 10:03:48AM +0800, Weiyi Lu wrote:
> > Add clock controller nodes for SoC mt8192
> >=20
> > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 163 +++++++++++++++++++++++=
++++++++
> >  1 file changed, 163 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot=
/dts/mediatek/mt8192.dtsi
> > index e12e024..92dcfbd 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > @@ -5,6 +5,7 @@
> >   */
> > =20
> >  /dts-v1/;
> > +#include <dt-bindings/clock/mt8192-clk.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
> > @@ -213,6 +214,24 @@
> >                       };
> >               };
> > =20
> > +             topckgen: syscon@10000000 {
> > +                     compatible =3D "mediatek,mt8192-topckgen", "sysco=
n";
> > +                     reg =3D <0 0x10000000 0 0x1000>;
> > +                     #clock-cells =3D <1>;
> > +             };
> > +
> > +             infracfg: syscon@10001000 {
> > +                     compatible =3D "mediatek,mt8192-infracfg", "sysco=
n";
> > +                     reg =3D <0 0x10001000 0 0x1000>;
> > +                     #clock-cells =3D <1>;
> > +             };
> > +
> > +             pericfg: syscon@10003000 {
> > +                     compatible =3D "mediatek,mt8192-pericfg", "syscon=
";
> > +                     reg =3D <0 0x10003000 0 0x1000>;
> > +                     #clock-cells =3D <1>;
> > +             };
> > +
>=20
> There are 26 new bindings for mt8192 clock providers, "mediatek,mt8192-*'.
> I guess the one reason of doing this is that those mmio blocks are
> just scattered all around over different memory regions.

Yeah it seems that Mediatek likes to scatter the clks into basically
every IP block. The alternate approach would be to create virtual
platform device children of those IP blocks to register the clks.

>=20
> I wonder if there could be a simpler way of merging them into one
> binding of "mediatek,mt8192-clocks" and converting all new bindings
> into generic syscon:
>=20
>         mt8192-clocks: mt8192_clocks {
>                 compatible =3D "mediatek,mt8192-clocks";
>                 #clock-cells =3D <1>;
>=20
>                 infracfg: clk_infracfg {
>                         syscon =3D <&syscon_infracfg>;
>                 };
>                 pericfg: clk_pericfg {
>                         syscon =3D <&syscon_pericfg>:
>                 };
>         };
>=20
>         syscon_pericfg: syscon@10003000 {
>                 compatible =3D "syscon";
>                 reg =3D <0 0x10003000 0 0x1000>;
>         };

Is the syscon used for anything besides a clk provider? Having a
mt8192_clocks node is wrong. The syscon is the clk provider and it
should have a #clock-cells property. Making up a node that doesn't have
a reg property is usually a sign that something is wrong.
