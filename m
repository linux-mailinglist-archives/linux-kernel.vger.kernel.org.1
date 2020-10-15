Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367EA28F598
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 17:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389549AbgJOPMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 11:12:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:48028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388086AbgJOPMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 11:12:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C0DDAB215;
        Thu, 15 Oct 2020 15:12:43 +0000 (UTC)
Message-ID: <5d2587193f0e99996445d5fa507a8acf7854fed3.camel@suse.de>
Subject: Re: [PATCH 6/7] ARM: dts: Add dts for Raspberry Pi 4 + Cirrus Logic
 Lochnagar2
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Date:   Thu, 15 Oct 2020 17:12:42 +0200
In-Reply-To: <89913f8b-fe92-1a31-77ff-49ea3f3d3294@opensource.cirrus.com>
References: <20201014145418.31838-1-rf@opensource.cirrus.com>
         <20201014145418.31838-7-rf@opensource.cirrus.com>
         <e9db1a11519dce0938cef867179160a818ec4143.camel@suse.de>
         <89913f8b-fe92-1a31-77ff-49ea3f3d3294@opensource.cirrus.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-wR3GXQKBq2t5YgGG69As"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wR3GXQKBq2t5YgGG69As
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-15 at 12:14 +0100, Richard Fitzgerald wrote:
> > Sadly I don't think creating a new device tree is a good solution here.=
 If we
> > were to do so for every RPi hat/usage it'd become unmanageable very fas=
t. There
> > is a way to maintain this in the open nonetheless. I suggest you build =
a DT
> > overlay and submit it to https://github.com/raspberrypi/linux, see
> > 'arch/arm/boot/dts/overlays.' The Raspberry Pi engineers have a kernel =
branch
>=20
> We want something in mainline so that it can be used by people
> developing on mainline and taken as a starting point for configuring
> the codecs for other host platforms. The RPi is a convenient platform to
> use as the base because it is widely available and low-cost.

If what you want to convey is the proper way of configuring your specific
device the way to go is writing a devicetree binding. See
Documentation/devicetree. It's even possible to validate a given devicetree
against the bindings (given they are written in yaml format).

Regards,
Nicolas


--=-wR3GXQKBq2t5YgGG69As
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+IZuoACgkQlfZmHno8
x/6UGggAt9GsMB6HXXU+ftt+RxftKWleDKPspOiHmcX1jY7Xjr1MPqY/uGNypAHI
OeFqKdZgPo0/F7K6BRmpgOOkbrQ4yr09nbVSWafOur/q/FVa+zQiw6aqMoD8U2Ni
Q0aMoSKC086s6UG4bKw5KmoP9OVIuqGxFU+yqHS9ujotBHitTx0GHNY7IPpQvHwp
Mu8rvSyTrvYmG84IuF3SZs7mrIUltxGK1t3nqwkGr+XAFDKAQwQKFD2FWtduPYeA
0Ii/t4Fdf85iplTGIrgWh+qm25+hB6hWZkS/zbgVkdrj3Crfx/Wwq0a7P5DiPb18
qInpkyS6QUxic82H6FOQ9HTy/M/Kog==
=L34X
-----END PGP SIGNATURE-----

--=-wR3GXQKBq2t5YgGG69As--

