Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA9928397D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgJEP0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgJEP0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:26:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF67920637;
        Mon,  5 Oct 2020 15:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601911594;
        bh=1DFlxAOneU1Q7X7FCOfNZN0wL4ZzNAHWNDg5k6DPbvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LKTs78TRI/ttvaaeCdTLErmQurihH/lZPa2pf/cRUYJ/NoWFTXpoeqenTFihjHDjw
         cDcWWlcfcDiaXxdXS0+mmlbURBNIbho4R6fXjY6Wtgl2QcGyAKywRKhLJas6BExYVe
         13K6pesTw94jy7i2ZnJvW5SrtsyYgk+c6alMbo58=
Date:   Mon, 5 Oct 2020 16:25:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Olivier MOYSAN <olivier.moysan@st.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "arnaud.patard@rtp-net.org" <arnaud.patard@rtp-net.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] ASoC: cs42l51: add soft dependency declaration
Message-ID: <20201005152531.GE5139@sirena.org.uk>
References: <20201002152904.16448-1-olivier.moysan@st.com>
 <20201002154107.GC5527@sirena.org.uk>
 <4e7fb9c0-84ea-ba01-cea8-8044d6ff60de@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
Content-Disposition: inline
In-Reply-To: <4e7fb9c0-84ea-ba01-cea8-8044d6ff60de@st.com>
X-Cookie: Most of your faults are not your fault.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2020 at 03:01:23PM +0000, Olivier MOYSAN wrote:
> On 10/2/20 5:41 PM, Mark Brown wrote:
>=20
> On Fri, Oct 02, 2020 at 05:29:04PM +0200, Olivier Moysan wrote:
>=20
>=20
> When configured as module, CS42L51 codec driver uses two modules
> snd-soc-cs42l51 and snd-soc-cs42l51-i2c.
> Add soft dependency on snd-soc-cs42l51-i2c in snd-soc-cs42l51,
> to allow smart module dependency solving.

Please fix your mail client, the formatting is completely broken -
there's nothing distinguishing quoted and new text and you've got lines
well over 80 columns.

> Doesn't the userspace tooling usually manage to figure this out from
> symbol usage?

> cs42l51.c does not use symbols from cs42l51-i2c.c, so cs42l51-i2c does no=
t appear
> as a software dependency of cs42l51, for tools such as depmod.
> (cs42l51-i2c.c uses symbols from cs42l51.c,
> so there is a dependency in this way, but this does not help here)

But that's the dependency that exists and we want - the I2C driver is
what has the bus bindings in it and will be what we decide to load to
instantiate the device, that will then pull in the core code that it
needs.

> When enabling a sound card based on cs42l51, all required modules are loa=
ded automatically,
> excepted snd-soc-cs42l51-i2c module. This one has to be inserted explicit=
ely.

Whatever is going on here this patch is not addressing it.  Most likely
some ID tables are in the wrong file.

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl97OuoACgkQJNaLcl1U
h9C2zQf+I6U/7Ee6oL1ZwLeSOSKeU3K681e5iVm0pg2A50BBNhVRhyzrxhdUeHvs
zKwL+iBsoTqtW1U1iy8atRxhgWr37zShQox1w4JCpiNxN0SdqLdtACtaHM5V5/3O
YlbH254TyscAiUEKyU4cmx3ncjyZ660doyFbdXtRGP0yJCDdLqGfC0avHkhcuRi7
hNwpL+zleSMQ4K9hDh2AC2OD+XCeEJEaW707sSrBZVBk+ZeXT3sgIk8TaUOu+vMf
vxVrOdcxo5EEVE40ZcF3KM7mlgBZ47TKgdSTIXQ12HDTiykM0MORQcElsjudCnQ8
GzkgSwHvDBwdRjhQIDKZO3VJMoLqtw==
=A6ZW
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--
