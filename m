Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A9628F027
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 12:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbgJOKZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 06:25:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:35470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbgJOKZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 06:25:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF2B5AC83;
        Thu, 15 Oct 2020 10:25:50 +0000 (UTC)
Message-ID: <e9db1a11519dce0938cef867179160a818ec4143.camel@suse.de>
Subject: Re: [PATCH 6/7] ARM: dts: Add dts for Raspberry Pi 4 + Cirrus Logic
 Lochnagar2
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Date:   Thu, 15 Oct 2020 12:25:49 +0200
In-Reply-To: <20201014145418.31838-7-rf@opensource.cirrus.com>
References: <20201014145418.31838-1-rf@opensource.cirrus.com>
         <20201014145418.31838-7-rf@opensource.cirrus.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-rg1Z1psyHTidcmcRlxsR"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rg1Z1psyHTidcmcRlxsR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,
your series is very welcome, upstream support for audio codecs on the RPi4 =
has
always been lackluster.

Could you provide more information on the actual products? Are there custom
made hats for the RPi4 or this wired into a generic development board.

On Wed, 2020-10-14 at 15:54 +0100, Richard Fitzgerald wrote:
> This is based on the default bcm2711-rpi-4-b.dts.

Note that you could've included bcm2711-rpi-4.dts (as if it was a .dtsi).

> Configurations are provided for Cirrus Logic codecs CS42L92, CS47L15,
> CS47L24, CS47L35, CS47L90 and WM8998.
>=20
> For each codec there is a sound node and a codec device node and both
> default to disabled. Enable the pair for the codec in use.
>=20
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

Sadly I don't think creating a new device tree is a good solution here. If =
we
were to do so for every RPi hat/usage it'd become unmanageable very fast. T=
here
is a way to maintain this in the open nonetheless. I suggest you build a DT
overlay and submit it to https://github.com/raspberrypi/linux, see
'arch/arm/boot/dts/overlays.' The Raspberry Pi engineers have a kernel bran=
ch
that tracks of the latest kernel release, so once you get the rest of patch=
es
sorted out and they are included in a release it'll make sense to do so.

I can't tell for other distros, but opensuse packages overlays, so the effo=
rt
will ultimately be useful to users.

Regards,
Nicolas



--=-rg1Z1psyHTidcmcRlxsR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+II60ACgkQlfZmHno8
x/4U9wgAsWhm4/aDqQO9wUk6ramYK5rUch1Csrbbalv3FNu6rXMMkEmpue5N6A1F
4paxIRqGcyBoG8/h2v0ZwR9vtxQsfVjowhMT8Zg7I18Q5NyY8BLnpcgAVnwHaJPK
8mDXlnNW7z7lDW4iPquUynmKIXWxoEiBVU5jRiZG/z7q7Q6y6sWw0jxA9RDdW6Tb
sEqixk28Ood4n0o/F01/o3CLyiw1wc+PR/0F93eDsTrfzRhrqokO/8oAhpS9ka6S
5QdcQfiLNtmgw+pC7of84rmMxQq/cLkzz1hpy0UVUTFwrB1gns3fIPJF8DBYcoP5
xz5IwG+98djRhcojk1ncD+uTqoHi3g==
=iBXI
-----END PGP SIGNATURE-----

--=-rg1Z1psyHTidcmcRlxsR--

