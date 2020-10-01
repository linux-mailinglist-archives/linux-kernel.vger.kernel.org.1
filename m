Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82818280438
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 18:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732801AbgJAQrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 12:47:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:54524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732778AbgJAQrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 12:47:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1ED28B17E;
        Thu,  1 Oct 2020 16:47:18 +0000 (UTC)
Message-ID: <8bc3f2b0d1b5ae59996bc9316a401a68c92ebac7.camel@suse.de>
Subject: Re: [PATCH v5 80/80] ARM: dts: bcm2711: Enable the display pipeline
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Tim Gover <tim.gover@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 01 Oct 2020 18:47:13 +0200
In-Reply-To: <CAAvKZ65WqQqH-9JVdb5M6HcKbR3yQdvZha8n9UXXCfciYRq4aA@mail.gmail.com>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
         <cfce2276d172d3d9c4d34d966b58fd47f77c4e46.1599120059.git-series.maxime@cerno.tech>
         <20200929221526.GA1370981@ubuntu-m3-large-x86>
         <20200930140758.gummt3umouva3wyu@gilmour.lan>
         <20200930163823.GA237050@ubuntu-m3-large-x86>
         <cacbaef2-4221-50d8-3c5d-efab9f1a9c04@i2se.com>
         <20201001064843.dlewcu3b7dvqanyy@gilmour.lan>
         <20201001085402.t6mzzwzplviunhoc@gilmour.lan>
         <CAAvKZ65WqQqH-9JVdb5M6HcKbR3yQdvZha8n9UXXCfciYRq4aA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-l+ZiDYkuyn4YRFrpqm4U"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-l+ZiDYkuyn4YRFrpqm4U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tim, thanks for the info!

On Thu, 2020-10-01 at 11:15 +0100, Tim Gover wrote:
> hdmi_enable_4k60=3D1 causes the firmware to select 3.3 GHz for the PLLC
> VCO to support a core-frequency of 550 MHz which is the minimum
> frequency required by the HVS at 4Kp60. The side effect is that if the
> display clock requirements are lower than 4Kp60 then you will see
> different core frequencies selected by DVFS.
>=20
> If enable_uart=3D1 and the mini-uart is selected (default unless

What is the actual test made to check if mini-uart is selected? I can't get
firmware to trigger this behaviour with 64-bit upstream kernel/dts. Note th=
at I
see the core clk setup at 200MHz just before having VC4 set it to 500MHz.

The only thing I've got on my config.txt is:

enable_uart=3D1
arm_64bit=3D1

Maybe we're missing some kind of DT alias upstream?

Regards,
Nicolas

> bluetooth is disabled) then the firmware will pin the core-frequency
> to either core_freq max (500 or 550). Although, I think there is a way
> of pinning it to a lower fixed frequency.
>=20
> The table in overclocking.md defines options for setting the maximum
> core frequency but unless core_freq_min is specified DVFS will
> automatically pick the lowest idle frequency required by the display
> resolution.


--=-l+ZiDYkuyn4YRFrpqm4U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl92CBEACgkQlfZmHno8
x/6Fhgf+K45CVMk1ERaruIYgmRB2UNbRccC5JFlbwPuxX9BJ5by+WUgicZ1aESej
v3EgZJ3c23NBQYWZM/rlGym3699PzjNagEq1+Q0X9HPaxveWDc4icOIK25hxC2ek
16LeBHAkuPNsm0UKIpdz5aVWmJ6sEaFvPVRU5cUJw1c/HdzNbmtXUCEc8t3N1jV4
0TxNvPb3SD2bCUq2GrReGwkO6uTK2Bpa4Ze0X3GLDbxHbDre7DgXz5yUCzAFOTLi
yWKzAkiyKkVWlXxzAkL+IkNonS9eDaWfeuI/qnjuUEFhSrD1yAarIJDtJZBFjGYg
swhYvJDXlfCINUxL5yo+22YAOvv8Xw==
=jRxj
-----END PGP SIGNATURE-----

--=-l+ZiDYkuyn4YRFrpqm4U--

