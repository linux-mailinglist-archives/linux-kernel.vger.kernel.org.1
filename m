Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4B52B73E2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 02:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgKRBtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 20:49:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:37614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgKRBtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 20:49:33 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44ECA241A7;
        Wed, 18 Nov 2020 01:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605664172;
        bh=M6DfrIdy95Ghs9mCFBL8Ngh2V0KHo7z65Isd9IgYS3s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=GFbG78XCZWOi7mQ937XcvONvdNNLDydGM450RdgNzpN3caAYSRmfTf1XerRwsaW4v
         /Dq4pOCMsDsgx6QaqwNie1Vh5xT3xu/K5iXqy4/kNzP3h9O6j7MiQ10Rd/fbCJ/XCm
         WxDk55uYFKWryDlqwJqlGunKSUMUCm0OLHbiZZSk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <24d975ca-1942-5f7f-ae89-7b572f48812c@microchip.com>
References: <1604655988-353-1-git-send-email-claudiu.beznea@microchip.com> <1604655988-353-7-git-send-email-claudiu.beznea@microchip.com> <160538849947.60232.12002724470272520124@swboyd.mtv.corp.google.com> <24d975ca-1942-5f7f-ae89-7b572f48812c@microchip.com>
Subject: Re: [PATCH v4 06/11] clk: at91: clk-sam9x60-pll: allow runtime changes for pll
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Eugen.Hristev@microchip.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Claudiu.Beznea@microchip.com, Ludovic.Desroches@microchip.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Tue, 17 Nov 2020 17:49:30 -0800
Message-ID: <160566417078.60232.18106288530854376790@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu.Beznea@microchip.com (2020-11-16 03:24:54)
>=20
>=20
> On 14.11.2020 23:14, Stephen Boyd wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > Quoting Claudiu Beznea (2020-11-06 01:46:23)
> >> diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk=
-sam9x60-pll.c
> >> index 78f458a7b2ef..6fe5d8530a0c 100644
> >> --- a/drivers/clk/at91/clk-sam9x60-pll.c
> >> +++ b/drivers/clk/at91/clk-sam9x60-pll.c
> >> @@ -225,8 +225,51 @@ static int sam9x60_frac_pll_set_rate(struct clk_h=
w *hw, unsigned long rate,
> >>                                      unsigned long parent_rate)
> >>  {
> >>         struct sam9x60_pll_core *core =3D to_sam9x60_pll_core(hw);
> >> +       struct sam9x60_frac *frac =3D to_sam9x60_frac(core);
> >> +       struct regmap *regmap =3D core->regmap;
> >> +       unsigned long irqflags, clkflags =3D clk_hw_get_flags(hw);
> >> +       unsigned int val, cfrac, cmul;
> >> +       long ret;
> >> +
> >> +       ret =3D sam9x60_frac_pll_compute_mul_frac(core, rate, parent_r=
ate, true);
> >> +       if (ret <=3D 0 || (clkflags & CLK_SET_RATE_GATE))
> >=20
> > Is this function being called when the clk is enabled and it has the
> > CLK_SET_RATE_GATE flag set?
>=20
> Yes, this function could be called when CLK_SET_RATE_GATE is set.
> On SAMA7G5 there are multiple PLL blocks of the same type. All these PLLs
> are controlled by clk-sam9x60-pll.c driver. One of this PLL block fed the
> CPU who's frequency could be changed at run time. At the same time there
> are PLLs that fed hardware block not glitch free aware or that we don't
> want to allow the rate change (this is the case of SAM9X60's CPU PLL, or
> the DDR PLL on SAMA7G5).
>=20
> I'm confused why this driver needs to check
> > this flag.
>=20
> Because we have multiple PLLs of the same type, some of them feed hardware
> blocks that are glitch free aware of these PLLs' frequencies changes, some
> feed hardware blocks that are not glitch free aware of PLLs' frequencies
> changes or for some of them we don't want the frequency changes at all.

Can we have different clk_ops for the different types of PLLs? It looks
like the flag is being used to overload this function to do different
things depending on how the flags are set. What happens if we decide to
change the semantics of this clk flag? How does it map to this driver?
Ideally this driver shouldn't need to worry about this flag, at least
not in this function, except to figure out if it should do something
different like not write the value to the hardware or something like
that.

The flag indicates to the clk framework that this clk should be gated
when clk_set_rate() is called on it. The driver should be able to figure
out that the clk is disabled by reading the hardware here and checking
the enable state, or it could just have different clk_ops for the
different type of PLL and do something different without checking the
flag. Either way, checking the flag looks wrong.

> >> -                 .c =3D 1,
> >> +                 .f =3D CLK_IS_CRITICAL | CLK_SET_RATE_GATE,
> >=20
> > Please indicate why clks are critical.
>=20
> Sure! I'll do it in next version. I chose it like this because they are
> feeding critical parts of the system like CPU or memory.
>=20
> > Whenever the CLK_IS_CRITICAL flag
> > is used we should have a comment indicating why.
>=20
> I was not aware of this rule. I'll update the code accordingly.

Sorry. I should put a document comment next to the flag.
