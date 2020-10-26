Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DA3299812
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388359AbgJZUgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 16:36:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388247AbgJZUgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:36:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9722207E8;
        Mon, 26 Oct 2020 20:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603744573;
        bh=O52isSyK67wz7u/WK6c8oDPAtmNSuqkBMdDiqRurhQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TyNgwzHMG3kipk9sEO1r3JgY4RC0iydlCvAz/zgXCSQluq1TXqAWBbaZfBH4HcV1u
         YIyh/VB5f3XoCUDAmciA5GwXT0MUE5LfAy7+nS5e1pYUw5wm3diqPBWLKKovncNyU7
         eoJN/DpPloMredPYPKTO+z24scAZ0scFA3/VggB0=
Date:   Mon, 26 Oct 2020 20:36:08 +0000
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
Message-ID: <20201026203608.GJ7402@sirena.org.uk>
References: <20201024200304.1427864-1-fparent@baylibre.com>
 <20201026121316.GB7402@sirena.org.uk>
 <CAOwMV_w5N0_Qgg3MFph1147cbvFP1Y=mUtNjGbcr-Tca4ZJ3yA@mail.gmail.com>
 <20201026172431.GI7402@sirena.org.uk>
 <CAOwMV_xt=OV6cKqQTZUUSAvYKxUUQZAUywAHtFFHL=E5xVu-Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j+MD90OnwjQyWNYt"
Content-Disposition: inline
In-Reply-To: <CAOwMV_xt=OV6cKqQTZUUSAvYKxUUQZAUywAHtFFHL=E5xVu-Zg@mail.gmail.com>
X-Cookie: Safety Third.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j+MD90OnwjQyWNYt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 26, 2020 at 07:38:14PM +0100, Fabien Parent wrote:
> On Mon, Oct 26, 2020 at 6:24 PM Mark Brown <broonie@kernel.org> wrote:

> > >         .name = "mt6392-regulator",
> > >         .of_compatible = "mediatek,mt6392-regulator"

> > This is still unneeded, it's just a reflection of Linux implementation
> > details and should be removed.   The MFD can just register the child
> > without supplying a compatible and things will continue to work just as
> > well.

> I'm not exactly sure how it is supposed to work. mfd_add_devices seems
> to register devices based on of_compatible or acpi_match from the
> mfd_cell. This platform does not have ACPI so I don't understand how

It should also support unconditionally registering devices, if it no
longer does so that's a regression in the framework which should be
fixed.  Looking at mfd_add_devices() I can't see an issue though, both
ACPI and DT information is optional - the entire DT section in
mfd_add_device() will be skipped if no of_compatible is specified in the
cell.  Are you *sure* that the regulator driver isn't running?

--j+MD90OnwjQyWNYt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+XMzcACgkQJNaLcl1U
h9D8Fgf/aY41lzA2GffEUL92jRQgpryeIR0UjVjAKQ15Q+FNzHhDQDjS62uceDK7
wH/NxVxXJwmheYwxvKDRglhGW0BSlYd2T/ALNzTDrb1HlHaaYmkYftCf3Ijj4EDI
sX7lN0rcEG95Z8uSVgKxOw98sX4tvqItnM+sNrHbkq1aE6Vz8cX7jaxkn7DvC+G7
sayBo3bg1cUj+yWVFzkGhmlm9ihb38yX3UI3dTOKQlh+rjCxw0o+R34whmJPtZe8
BRhcrr+/Zw5slffrzVmjSeklyFaqem839diSUzj7UoG6CuFyP4n9XbCpiaNz01aJ
9jzOgf4SPNSSyceZfdZLoxQgGvAHqg==
=tD5M
-----END PGP SIGNATURE-----

--j+MD90OnwjQyWNYt--
