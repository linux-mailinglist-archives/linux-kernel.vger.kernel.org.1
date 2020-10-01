Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082D527FC5B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 11:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbgJAJWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 05:22:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:56120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgJAJWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 05:22:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6073FAD49;
        Thu,  1 Oct 2020 09:22:06 +0000 (UTC)
Message-ID: <eb0c0edaf22404fd69440a85bb78397a14d49ddc.camel@suse.de>
Subject: Re: [PATCH v5 80/80] ARM: dts: bcm2711: Enable the display pipeline
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 01 Oct 2020 11:22:03 +0200
In-Reply-To: <20200930163823.GA237050@ubuntu-m3-large-x86>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
         <cfce2276d172d3d9c4d34d966b58fd47f77c4e46.1599120059.git-series.maxime@cerno.tech>
         <20200929221526.GA1370981@ubuntu-m3-large-x86>
         <20200930140758.gummt3umouva3wyu@gilmour.lan>
         <20200930163823.GA237050@ubuntu-m3-large-x86>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-xeOzVywA1Zb9Rs2smcOD"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xeOzVywA1Zb9Rs2smcOD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-09-30 at 09:38 -0700, Nathan Chancellor wrote:
> On Wed, Sep 30, 2020 at 04:07:58PM +0200, Maxime Ripard wrote:
> > Hi Nathan,
> >=20
> > On Tue, Sep 29, 2020 at 03:15:26PM -0700, Nathan Chancellor wrote:
> > > On Thu, Sep 03, 2020 at 10:01:52AM +0200, Maxime Ripard wrote:
> > > > Now that all the drivers have been adjusted for it, let's bring in =
the
> > > > necessary device tree changes.
> > > >=20
> > > > The VEC and PV3 are left out for now, since it will require a more =
specific
> > > > clock setup.
> > > >=20
> > > > Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > > > Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> > > > Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> > > > Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
> > > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > >=20
> > > Apologies if this has already been reported or have a solution but th=
is
> > > patch (and presumably series) breaks output to the serial console aft=
er
> > > a certain point during init. On Raspbian, I see systemd startup messa=
ges
> > > then the output just turns into complete garbage. It looks like this
> > > patch is merged first in linux-next, which is why my bisect fell on t=
he
> > > DRM merge. I am happy to provide whatever information could be helpfu=
l
> > > for debugging this. I am on the latest version of the firmware
> > > (currently 26620cc9a63c6cb9965374d509479b4ee2c30241).
> >=20
> > Unfortunately, the miniUART is in the same clock tree than the core
> > clock and will thus have those kind of issues when the core clock is
> > changed (which is also something that one should expect when using the
> > DRM or other drivers).
> >=20
> > The only real workaround there would be to switch to one of the PL011
> > UARTs. I guess we can also somehow make the UART react to the core cloc=
k
> > frequency changes, but that's going to require some effort
> >=20
> > Maxime
>=20
> Ack, thank you for the reply! There does not really seem to be a whole
> ton of documentation around using one of the other PL011 UARTs so for
> now, I will just revert this commit locally.

Nathan, a less intrusive solution would be to add 'core_freq_min=3D500' int=
o your
config.txt.

Funnily enough core_freq=3D500 doesn't seem to work in that regard. It migh=
t be
related with what Maxime is commenting.

Regards,
Nicolas


--=-xeOzVywA1Zb9Rs2smcOD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl91n7sACgkQlfZmHno8
x/6QOQf/cx8IX0E/La/BOt0djC9PTcTaBmAMhBO2AfyXGlNq5oGKHYiP6n5O7ISG
f7xgS02IcmsV5D4IdU/b16t9/6MwrFRTqf1OY/ba15HU0kgsLQMRNa3VA7GSbDUo
cesVEbufcrEm7Xb92OfM/2aC4sVjnaGCA18RzyVEpD2SBvtpjqUoZtvH0ecscizT
O41ZlDVLyWZnEklG1e98RhBJWghm2H6h7C+0cI6zxNSeSOh/JUx9BPYK5RBpGqCV
BMN+zbPH9JP19kk+64U2+mvJSxCE77FryfY3LA2EQ9tCbZZdF/4+7mkc3hbpP0B5
rWZrlZMSnjYPX6sFfsv9edR2V1XrcQ==
=Ivvl
-----END PGP SIGNATURE-----

--=-xeOzVywA1Zb9Rs2smcOD--

