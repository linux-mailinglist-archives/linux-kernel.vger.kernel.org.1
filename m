Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E91E2993B6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787656AbgJZRYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392010AbgJZRYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:24:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E99421D7B;
        Mon, 26 Oct 2020 17:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603733076;
        bh=r/Go5g+ydHtLSDBV/2d++cEZQyCVyOlKmRWTE3d43fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zwf/0tJl1quToYepFt/MPzsgGsdO5FaYPLfzE+8gEOZfjiUfR9dZzBgh9BURNBWpu
         Slw6cxiIesxUFz9QC4IegdrLQMV4MVMAxR1d0vymwb2GBBvhcNjXZjcvQGekX/IXNK
         ySzjSlRToGvxUmo97SbK+l9nPBlHKhN7UN/Ac2hc=
Date:   Mon, 26 Oct 2020 17:24:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: regulator: add support for MT6392
Message-ID: <20201026172431.GI7402@sirena.org.uk>
References: <20201024200304.1427864-1-fparent@baylibre.com>
 <20201026121316.GB7402@sirena.org.uk>
 <CAOwMV_w5N0_Qgg3MFph1147cbvFP1Y=mUtNjGbcr-Tca4ZJ3yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JIpyCmsTxyPLrmrM"
Content-Disposition: inline
In-Reply-To: <CAOwMV_w5N0_Qgg3MFph1147cbvFP1Y=mUtNjGbcr-Tca4ZJ3yA@mail.gmail.com>
X-Cookie: Safety Third.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JIpyCmsTxyPLrmrM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 26, 2020 at 06:18:35PM +0100, Fabien Parent wrote:
> On Mon, Oct 26, 2020 at 1:13 PM Mark Brown <broonie@kernel.org> wrote:

> > On Sat, Oct 24, 2020 at 10:03:03PM +0200, Fabien Parent wrote:

> > > +Required properties:
> > > +- compatible: "mediatek,mt6392-regulator"

> > This is no longer used by the driver, should be unneeded and therefore
> > should be removed.

> It is not used by the driver but it will be used by the MFD driver [0]
> like this:
> static const struct mfd_cell mt6392_devs[] = {
>     {
>         [snip]
>     }, {
>         [snip]
>     }, {
>         .name = "mt6392-regulator",
>         .of_compatible = "mediatek,mt6392-regulator"

This is still unneeded, it's just a reflection of Linux implementation
details and should be removed.   The MFD can just register the child
without supplying a compatible and things will continue to work just as
well.

--JIpyCmsTxyPLrmrM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+XBk4ACgkQJNaLcl1U
h9Dn3Af/Va1AtyHzsa7Z0W0FedjMRq9j7LCJX+Kg8oMfDfIwuzNAYDW21SnhicJR
JkaVl7kRqXWcx4LtXAIQp2hpiNBLr2SmVhvUxnHmsVqk/THfKWUXRAGMEfAIyl6x
tkwzYaqeYSPGV8kYpy9oNnA3R27BhsqReot+ImqdmTIcDvUAIkPSsTEl/W6Ixr91
M4LG0s8lzMiTN69LPhKokDUI5fKiulX+/WdXwRuuKBS7augVcN5YJJI0bdAOlelL
twQ4mb7hkrCLwg/ag2cZZagfuvPTGqol8WTuBs+6NmKkvzwBvrCiH97eu3bwO4i7
DawzoJr9YUM7MMdssy04Ui9GaICqgg==
=BCjn
-----END PGP SIGNATURE-----

--JIpyCmsTxyPLrmrM--
