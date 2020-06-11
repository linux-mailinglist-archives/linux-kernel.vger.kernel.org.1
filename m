Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642B81F6684
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 13:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgFKLVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 07:21:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:33546 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbgFKLVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:21:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 12DD4ABE4;
        Thu, 11 Jun 2020 11:21:13 +0000 (UTC)
Message-ID: <4298d8db6dec26317f591271ee15041e0c12f6fd.camel@suse.de>
Subject: Re: [PATCH v4 00/27] clk: bcm: rpi: Add support for BCM2711
 firmware clocks
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Thu, 11 Jun 2020 13:21:07 +0200
In-Reply-To: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-qp5pvNknzd1S2ihuXchJ"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qp5pvNknzd1S2ihuXchJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-06-11 at 09:31 +0200, Maxime Ripard wrote:
> Hi,
>=20
> Since the whole DRM/HDMI support began to grow fairly big, I've chosen
> to split away the two discussions between the firmware clocks and the
> HDMI support.
>=20
> Let me know what you think,
> Maxime
>=20

With patch #25 manually fixed, the series is:

Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas


--=-qp5pvNknzd1S2ihuXchJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7iE6MACgkQlfZmHno8
x/79PAgAp182wijp2dGoNNw89NchByhUXSoq3HViFvOMpA7tfknoLrvB2AF6YQXX
2ve3ki9iwHaWWKFd58GmLurPDR7RcIVFHAtLT2RPwpbbf9RV8KiYp47xtBHZh8yg
3oK9JGFkqfVh0qzEmbZ8xrOGqoNIRCNtty4tnzz5om+3ZL2xx3qETHIhiKVygxyu
WS4nja+AQEG9wkqOGE+JXvi0kErid/NBN7dOH+QP2SH5GgpIeOjNTW36TPAkAzEv
p5e2Ou504Ryah3il9bWZb/5r0O0njK4O8HJxPhw1k7S9vINYC50ucBTa+dZjYeU/
/bl9Rt12SAtkbpaNEOm7n45tIqGRHA==
=K1r7
-----END PGP SIGNATURE-----

--=-qp5pvNknzd1S2ihuXchJ--

