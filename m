Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4044525555A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 09:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgH1HcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 03:32:06 -0400
Received: from charlie.dont.surf ([128.199.63.193]:35360 "EHLO
        charlie.dont.surf" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgH1HcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 03:32:04 -0400
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Aug 2020 03:32:04 EDT
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net [80.167.98.190])
        by charlie.dont.surf (Postfix) with ESMTPSA id 11AADBF554;
        Fri, 28 Aug 2020 07:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
        s=default; t=1598599379;
        bh=0hzAo9FTat39DkkPYrYwGvm52R/0SpyDYrV4O9m/u7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=htl0u7Z35SclLEMyhH4MfeourXPOjtvoZHDyN0JZGfFriXOt+HusIjuIDs54Xsn47
         nOAoe56SQp0EebyeA3msS0A1AdqKuvm3XaOeo2pL8SlltuQBCt1VNBWmD9OLmeuXjP
         AKTJ4aPQeEjvQkgTUEGgiafV+uP+rlGJwbqdU9WloM1zN8IaRmKnmG8zRf/BbT0nfS
         yTwLoSIiIpMxAvbwq0OFoYpqtwMygTn4+k/rLV0zlOuDUf+Ex7NAlZamS7mTLNWDdj
         INEEONODivSphxl2R6JVW6m3abLeQee6xf70FoJioGHuB+bq2bIsuhfpQCvHZqPSWu
         Az6aGy7TyXqDA==
Date:   Fri, 28 Aug 2020 09:22:53 +0200
From:   Klaus Jensen <its@irrelevant.dk>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] null_blk: add support for max open/active zone limit
 for zoned devices
Message-ID: <20200828072253.GA1331347@apples.localdomain>
References: <20200827135018.63644-1-niklas.cassel@wdc.com>
 <CY4PR04MB3751526DC5833902749EBE48E7520@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751526DC5833902749EBE48E7520@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 28 07:06, Damien Le Moal wrote:
> On 2020/08/27 22:50, Niklas Cassel wrote:
> > +static blk_status_t null_finish_zone(struct nullb_device *dev, struct =
blk_zone *zone)
> > +{
> > +	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)
> > +		return BLK_STS_IOERR;
> > +
> > +	switch (zone->cond) {
> > +	case BLK_ZONE_COND_FULL:
> > +		/* finish operation on full is not an error */
> > +		return BLK_STS_OK;
> > +	case BLK_ZONE_COND_EMPTY:
> > +		if (!null_manage_zone_resources(dev, zone))
>=20
> OK. So you are hitting a fuzzy case here that is not actually well descri=
bed in
> the standards. That is, does finishing an empty zone necessarilly imply a
> temporary transition through imp open ? Which you are assuming is a yes h=
ere.
> Personally, I would say that is not necessary, but no strong feeling eith=
er way.
>=20

For ZNS, the spec is pretty clear that ZSE to ZSF is a legal direct
transition. So I don't think the transition should be allowed to fail
due to a lack of resources.

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9IsMgACgkQTeGvMW1P
DekA5Af/SC+I2hGvEBx86dF1Cb0s1pQyVLvhGOADnaCC8Ic1C840NJ/USCBMv7Eo
8h8/2VmjD/DHttLE/eIAbOWzO2ij7PYJg6Dge4joBEZTg+4yYAt8I+TyfrqRGL5j
FsNgtIlmnPSOvvjYkzLYrMQ/KHm9mk5q/gZcJIOiu02O7a3TOAI0jXuFWxfjq0s2
u5v1k936yY01g5Ce4AlR5WSD4cSR4GwkGJNXza9yyu1KjnozCx4ahBVH4acy3xow
H+tUloNIieacv0u9bAmeqPpKMdRhj+USCZkm9kXEP/SUeF/vPY12QBgSnWVxF9AU
qd/zt+tcRzfzTzvulSfcpdgm/UtILQ==
=blqO
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
