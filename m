Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B795B1C023A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 18:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgD3QTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 12:19:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:56094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbgD3QTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:19:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 68804ACC4;
        Thu, 30 Apr 2020 16:19:43 +0000 (UTC)
Message-ID: <0f7f2350cebdbd6904274e6a4e8da6e0a6c72102.camel@suse.de>
Subject: Re: [PATCH v2 05/91] clk: bcm: rpi: Allow the driver to be probed
 by DT
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>, Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Date:   Thu, 30 Apr 2020 18:19:41 +0200
In-Reply-To: <0f5319caa4d1b9ba8a83a094abcb681d4be6eb1c.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
         <0f5319caa4d1b9ba8a83a094abcb681d4be6eb1c.1587742492.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-q7dZwA3wemW7oWhPS4wd"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-q7dZwA3wemW7oWhPS4wd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-04-24 at 17:33 +0200, Maxime Ripard wrote:
> The current firmware clock driver for the RaspberryPi can only be probed =
by
> manually registering an associated platform_device.
>=20
> While this works fine for cpufreq where the device gets attached a clkdev
> lookup, it would be tedious to maintain a table of all the devices using
> one of the clocks exposed by the firmware.
>=20
> Since the DT on the other hand is the perfect place to store those
> associations, make the firmware clocks driver probe-able through the devi=
ce
> tree so that we can represent it as a node.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/clk/bcm/clk-raspberrypi.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-
> raspberrypi.c
> index 1654fd0eedc9..aedeaaf2f66b 100644
> --- a/drivers/clk/bcm/clk-raspberrypi.c
> +++ b/drivers/clk/bcm/clk-raspberrypi.c
> @@ -255,15 +255,22 @@ static int raspberrypi_clk_probe(struct platform_de=
vice
> *pdev)
>  	struct raspberrypi_clk *rpi;
>  	int ret;
> =20
> -	firmware_node =3D of_find_compatible_node(NULL, NULL,
> -					"raspberrypi,bcm2835-firmware");
> +	/*
> +	 * We can be probed either through the an old-fashioned
> +	 * platform device registration or through a DT node that is a
> +	 * child of the firmware node. Handle both cases.
> +	 */
> +	if (dev->of_node)
> +		firmware_node =3D of_get_parent(dev->of_node);
> +	else
> +		firmware_node =3D of_find_compatible_node(NULL, NULL,
> +							"raspberrypi,bcm2835-
> firmware");
>  	if (!firmware_node) {
>  		dev_err(dev, "Missing firmware node\n");
>  		return -ENOENT;
>  	}
> =20
>  	firmware =3D rpi_firmware_get(firmware_node);
> -	of_node_put(firmware_node);

Why remove this? I think it's still needed after your changes.

Regards,
Nicolas


--=-q7dZwA3wemW7oWhPS4wd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6q+p0ACgkQlfZmHno8
x/5Aewf/fIRt353bQjRQPXHvnCWvme3juReNuol1emq3w4qxjIbYk/3z6mE5Xqik
N6cAGO+Hf35L5nhpW9qXpVTT3vbylYXIZ/OW5weQzIN+oKmUvJh+7FUwzl790OiU
y2LJVs53mnmGErmkoTOkyoJNmDeft+FMuQ+105YbheOsgDY3XKDscjlwQgsk/Vx7
/ELAtNxaNwm0lU2V6TfIgDaIDysRbkao9DtA1c97wG1O6lZAanouAfuIFR+8+xrz
AYKm8KnHJXi4wRSh2BAjm0e3qX+/RaI9RNeT7Xq68tsLl4jbz673IXTuyETjVc0s
Csb4+I6CCUbczBNHzKUO2UntZvTpdQ==
=fDu0
-----END PGP SIGNATURE-----

--=-q7dZwA3wemW7oWhPS4wd--

