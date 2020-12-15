Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF782DAC78
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 12:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgLOL5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 06:57:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728615AbgLOL4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 06:56:54 -0500
Date:   Tue, 15 Dec 2020 11:56:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608033374;
        bh=/M1gPHhbjgtFjXVpzyyIzQbBvEuAExjx+HsjBRMWbRY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=c7rf8bArDp8KcpkW78LRNYjcres70AOcyfyBiAt1LyTHsMcbbEq3G6F9xjmvhtHGS
         MEz0xhYqxJ18LRM8eMTKA89SCqie8tLcUQOJowOcyPzWcx+/w54LjsuPQwda4XLnz+
         kgnQ2ExXZj/MyxQzVZJuwIJwbCrskmtubzDQ7jGDLvN8dycKW1AvoPXKcqYvvxgmlk
         vgUaz+/8jt3IB4GxW+a/U8H2fkUutXyKWooHFHHwMeIOiRsc0fC6EfIFKy7ORq1eDc
         1ab818dHRmdXgxHO1NsVp+spshTDJ0udtXJAqpW91YQ8lgu4hIZL6GStoGSBqvUTZl
         oCc+fgF5cNY3Q==
From:   Mark Brown <broonie@kernel.org>
To:     Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, Wen Su <wen.su@mediatek.com>
Subject: Re: [PATCH v3 5/8] regulator: mt6359: Add support for MT6359
 regulator
Message-ID: <20201215115602.GA4738@sirena.org.uk>
References: <1606103290-15034-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1606103290-15034-6-git-send-email-hsin-hsiung.wang@mediatek.com>
 <20201124170732.GI4933@sirena.org.uk>
 <1608024188.29527.2.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <1608024188.29527.2.camel@mtksdaap41>
X-Cookie: In specially marked packages only.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 15, 2020 at 05:23:08PM +0800, Hsin-hsiung Wang wrote:
> On Tue, 2020-11-24 at 17:07 +0000, Mark Brown wrote:

> > This looks like it could just be regmap_get_voltage_sel_regmap()?
> > Otherwise the driver looks good.

> Thanks for the review.
> MT6359 regulator has sel_reg and status_reg, so we use
> mt6359_get_linear_voltage_sel for status_reg instead of
> regmap_get_voltage_sel_regmap() which uses sel_reg.

Is the selector register not readable?  In general the rule is that the
get should be reporting what was configured, the actual status should be
reported separately if it can be read separately.  We don't currently
have a mechanism for doing that with voltage but one could be added.

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/YpFIACgkQJNaLcl1U
h9CjjAf+IDONK3A5Udjly1RqCkRY5souPMpCZoh65EQM8+rD21ybKziHZCzWl7fh
c0Ix4/TdsLHsnruxfg0nBaLrN1xuN+lP0NEHUORKwhrBynNKzWxWBH7wbCsuhE9T
f18VvOA21BLCiEo/KbvcV7PXRo5XqTOMoNKt2cfdLAgVPViPSx5obkgQicMwXBH2
Ye5Rg1C1B13EVTnHmIWaALLEIjxtHkTeYGsBK76H09Rj0xGJqPZ7KJZeHst05eaC
2W4fobgNw046d+jG9SFYahZt8YQDeoa9ADGucwW/C4naZfvIdnwZidEJ4u5VaP+7
IRWhOc4UbbZxwOXJX4OGoAtVpe1NnA==
=HdPK
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
