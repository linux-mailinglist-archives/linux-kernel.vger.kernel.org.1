Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA88F2A7CDB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgKELYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbgKELYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:24:30 -0500
Received: from leonov.paulk.fr (vpn-0-22.aquilenet.fr [IPv6:2a0c:e300:4:22::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832EAC0613CF;
        Thu,  5 Nov 2020 03:24:30 -0800 (PST)
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 6F049C013D;
        Thu,  5 Nov 2020 12:24:26 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 9254FC1D5B; Thu,  5 Nov 2020 12:24:25 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        autolearn=disabled version=3.4.2
Received: from collins (unknown [192.168.1.1])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id A4BFBC1D4F;
        Thu,  5 Nov 2020 12:24:18 +0100 (CET)
Date:   Thu, 5 Nov 2020 12:24:18 +0100
From:   Paul Kocialkowski <contact@paulk.fr>
To:     Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: Re: [PATCH v2 2/6] irqchip/sunxi-nmi: Add support for the V3s NMI
Message-ID: <20201105112418.GA1237@collins>
References: <20201103205058.435207-1-contact@paulk.fr>
 <20201103205058.435207-3-contact@paulk.fr>
 <85d40081-2dd1-3a0c-15ad-a58ce866700f@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <85d40081-2dd1-3a0c-15ad-a58ce866700f@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Wed 04 Nov 20, 22:14, Samuel Holland wrote:
> On 11/3/20 2:50 PM, Paul Kocialkowski wrote:
> > The V3s/V3 has a NMI IRQ controller, which is mainly used for the AXP209
> > interrupt. In great wisdom, Allwinner decided to invert the enable and
> > pending register offsets, compared to the A20.
> >=20
> > As a result, a specific compatible and register description is required
> > for the V3s. This was tested with an AXP209 on a V3 board.
> >=20
> > Acked-by: Maxime Ripard <mripard@kernel.org>
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >  drivers/irqchip/irq-sunxi-nmi.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunx=
i-nmi.c
> > index a412b5d5d0fa..59e0e4612ef7 100644
> > --- a/drivers/irqchip/irq-sunxi-nmi.c
> > +++ b/drivers/irqchip/irq-sunxi-nmi.c
> > @@ -44,6 +44,10 @@
> >  #define SUN7I_NMI_PENDING	0x04
> >  #define SUN7I_NMI_ENABLE	0x08
> > =20
> > +#define SUN8I_V3S_NMI_CTRL	0x00
> > +#define SUN8I_V3S_NMI_ENABLE	0x04
> > +#define SUN8I_V3S_NMI_PENDING	0x08
> > +
> >  #define SUN9I_NMI_CTRL		0x00
> >  #define SUN9I_NMI_ENABLE	0x04
> >  #define SUN9I_NMI_PENDING	0x08
>=20
> These two sets of definitions are the same. So it would make sense for
> V3S and sun9i to share a configuration, instead of creating a copy.

Oh but that's true! I initially though it was the same as sun7i, found that=
 it
wasn't but didn't notice about sun9i.

So I think we can just use the sun9i compatible after all.

Thanks!

Paul

> > @@ -79,6 +83,12 @@ static const struct sunxi_sc_nmi_reg_offs sun7i_reg_=
offs __initconst =3D {
> >  	.enable	=3D SUN7I_NMI_ENABLE,
> >  };
> > =20
> > +static const struct sunxi_sc_nmi_reg_offs sun8i_v3s_reg_offs __initcon=
st =3D {
> > +	.ctrl	=3D SUN8I_V3S_NMI_CTRL,
> > +	.pend	=3D SUN8I_V3S_NMI_PENDING,
> > +	.enable	=3D SUN8I_V3S_NMI_ENABLE,
> > +};
> > +
> >  static const struct sunxi_sc_nmi_reg_offs sun9i_reg_offs __initconst =
=3D {
> >  	.ctrl	=3D SUN9I_NMI_CTRL,
> >  	.pend	=3D SUN9I_NMI_PENDING,
> > @@ -165,7 +175,6 @@ static int __init sunxi_sc_nmi_irq_init(struct devi=
ce_node *node,
> >  	unsigned int clr =3D IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
> >  	int ret;
> > =20
> > -
> >  	domain =3D irq_domain_add_linear(node, 1, &irq_generic_chip_ops, NULL=
);
> >  	if (!domain) {
> >  		pr_err("Could not register interrupt domain.\n");
> > @@ -254,6 +263,13 @@ static int __init sun7i_sc_nmi_irq_init(struct dev=
ice_node *node,
> >  }
> >  IRQCHIP_DECLARE(sun7i_sc_nmi, "allwinner,sun7i-a20-sc-nmi", sun7i_sc_n=
mi_irq_init);
> > =20
> > +static int __init sun8i_v3s_sc_nmi_irq_init(struct device_node *node,
> > +					    struct device_node *parent)
> > +{
> > +	return sunxi_sc_nmi_irq_init(node, &sun8i_v3s_reg_offs);
> > +}
> > +IRQCHIP_DECLARE(sun8i_v3s_sc_nmi, "allwinner,sun8i-v3s-sc-nmi", sun8i_=
v3s_sc_nmi_irq_init);
> > +
> >  static int __init sun9i_nmi_irq_init(struct device_node *node,
> >  				     struct device_node *parent)
> >  {
> >=20
>=20

--=20
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAl+j4OEACgkQhP3B6o/u
lQw5vA//e0p7YbREoh7LicyYYBO8wpOJt0sgRwKDy5Xhg2DtHvrcUu9BZfA7gmIM
gJzogwi3r1dc9s6d4rhD1ZGWf2jXM7T7IUL0OnbQagVhwmTEyrSHC9S60CqibU4w
zt0aqN7XmVDM+9bGEsdJ3pLDk9lt2SiJ9vIJq/rsy0CXn7B7EYjTOEenOzUDlWxv
W1iS2v/WjIutWCCZkOBlaTKSsadij4piKkyKWc7DkAY9rDOCMb6zLxrdy98fom5c
l2Pmi7XAUk04NRMA/fKO6x7rLH2Nh6xlVQPOI6gE8gFs/dRl4GuTJcm/2gZAGd+C
zxDwxAT5bgrsBo8HygK0dcN8Ub2Ea7J/x/m4k1BnQbN6VDWFojh6TvxHNYJ86bux
PovslJ4tJJmMSxgnCKXs/8JkEMI5hrvoG7j8RH4O8g9mrqGldAcYMVtYAio6Oq+d
19pXfXzxMM8QPliapyDFTEgqRYQeQWwAjC/JHylXI3Dor7yDjKANh6VhkNDhJB/6
29c46CByRCVOXH7oxPa2G/4px8bAYXeZV8LBlNfDq4cOi7AaC5HES0MZhgOMXwYO
/3GvfNnGBh2sOXkrZMWJuJdxU9IEd9KWgmEMAX9FA9Mwm1bSM1E8HpbkAhAETfi8
zyh2PB/XZGTOcC2gRmHD53j74QIvKH1qIshmknZVpwl7moKETJs=
=USdf
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
