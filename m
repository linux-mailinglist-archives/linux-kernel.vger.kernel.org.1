Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4088E1D7776
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 13:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgERLkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 07:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgERLke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:40:34 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C16F3206D4;
        Mon, 18 May 2020 11:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589802034;
        bh=EsqkXVirMeepPaUzWDPC/vsik3Ko8PnNandwaHJKwHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R8T3Rgm1/akFj9U571xqlVn9j2+ZDkuHGjz1fqBr0dgAKf8WvxrovqicH1/W00VpY
         0R/Z5uoLJxl2YDhv4/AnzzG0KLl9LNAs4LVpiPabFb1i0+vl8MnOadP19cWPaAErGs
         brmyzf9O2uDiU18LpoFepsj2YKQp4+R3mpbPVnn8=
Date:   Mon, 18 May 2020 12:40:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [not urgent] ROHM PMIC/Charger IC driver maintenance.
Message-ID: <20200518114031.GE8699@sirena.org.uk>
References: <18838efd9341c953fb6aabe9536786de3f1150ae.camel@fi.rohmeurope.com>
 <20200518102842.GB8699@sirena.org.uk>
 <b08e5796b3d94b1add13e706f7acdc34c3a79e49.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ryJZkp9/svQ58syV"
Content-Disposition: inline
In-Reply-To: <b08e5796b3d94b1add13e706f7acdc34c3a79e49.camel@fi.rohmeurope.com>
X-Cookie: If in doubt, mumble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ryJZkp9/svQ58syV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2020 at 11:36:56AM +0000, Vaittinen, Matti wrote:
> On Mon, 2020-05-18 at 11:28 +0100, Mark Brown wrote:

> While we are at it - Mark, would you consider following to be fully
> inappropriate:

> LINEAR RANGES HELPERS
> M:      Mark Brown <broonie@kernel.org>
> R:      Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> F:      lib/linear_ranges.c
> F:      lib/test_linear_ranges.c
> F:      include/linux/linear_range.h

> I think that regulators being the main user for linear_ranges the
> changes there should go in via your tree - and you should probably be
> watching over them anyways :)

Sure, that's fine.

--ryJZkp9/svQ58syV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7CdC4ACgkQJNaLcl1U
h9CZwwf6Ap2WBWxK2vbOuXkHngbFy4HlUW/+AZ6Zn6lhGMhReN4eB819WalW+BC8
X4pOCZL1+L55h9FE+CNQWaCNTwXXKBRUmQX1ABitEf+VI9O42PSAafU2Q/40Xvhg
zeWryzzK32HBGsVVGx9AwvjWKSQVGcRepeKVytXmHBJ+VkGZVwaUL/1V2Ws2ilgl
ynxgXPGg73wwB4JtxFvnq1+nVhUucvFRwWP8exC2QLRRpIMwW2VVIuSCXC7ZU/oP
8vF4MG6cr8JQY6wZAFCm5Pjb+pxGRogCnZ+jUgxwUKl23pIUrR7TLte1EUraGtSl
0ic9Ag7vtUC2CzVoKyHch256fbCgRA==
=mkjA
-----END PGP SIGNATURE-----

--ryJZkp9/svQ58syV--
