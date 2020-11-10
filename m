Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C326A2ADCF2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 18:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgKJRab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 12:30:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgKJRab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:30:31 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2002206B2;
        Tue, 10 Nov 2020 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605029430;
        bh=efBVZOcj5xp7g0xdd/ocr0BdvE5lHsEzg5ahqcxK6js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fsZ3boiJQ7ysPFFQw5V/bR3OwenN/8w6TTGEViUoprcsdyrIv2SkOw0kyMdDXoRMt
         TcsBxTHYIiAnypseOvgeEHDq5EnsTldbG+TAZe6J8CnoKVYt28lqdJ8xtwlUMro5tx
         bjLk5zxXLthbv6L/I0mwXpcmCSj0WrMMRE77F/LA=
Date:   Tue, 10 Nov 2020 17:30:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     lgirdwood@gmail.com, s.hauer@pengutronix.de, ttynkkynen@nvidia.com,
        linus.walleij@linaro.org, axel.lin@ingics.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/6] regulator: core: validate selector against
 linear_min_sel
Message-ID: <20201110173015.GA50375@sirena.org.uk>
References: <1604656384-827-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <1604656384-827-2-git-send-email-claudiu.beznea@microchip.com>
X-Cookie: Paralysis through analysis.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 06, 2020 at 11:52:59AM +0200, Claudiu Beznea wrote:
> There are regulators whose min selector is not zero. Selectors loops
> (looping b/w zero and regulator::desc::n_voltages) might throw errors
> because invalid selectors are used (lower than
> regulator::desc::linear_min_sel). For this situations validate selectors
> against regulator::desc::linear_min_sel.

This doesn't apply against current code, please check and resend:

Applying: regulator: core: do not continue if selector match
error: sha1 information is lacking or useless (drivers/regulator/core.c).
error: could not build fake ancestor
Patch failed at 0001 regulator: core: do not continue if selector match
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+qziYACgkQJNaLcl1U
h9ASJAf+LrxSii7hOt3J8lpayL5EZxa58sSqVbn7a8P9l8WnNhVPCndh9VNFHvUy
uJHW9s4r01YLNWm6PR8wtbxYOCpLcr74BkUX+2puSgibIT6IL8qk6VyMtHNARU9U
vESG/lucORI8TxJoMms982qrdGf+EUUeY6FF1Z7zEW7COiP52fEVl4MSTpQaiIEX
9VFwJVZif8WqGTegbMaI4S4/uAKsaSiUB4L59cor5Dp0Sz6dwuuzymU/qrW4P0DA
a8hZvP8IeukDGBJN7LVdLBctpcXBjaDFCjejBUNSGQBSDyV1Z5g1MFXVSnw13xPc
Qmibg9Mug07ApPDWm5VSvAFxYA1NPA==
=J2JN
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
