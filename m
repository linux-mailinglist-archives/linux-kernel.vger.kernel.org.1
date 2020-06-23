Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4814A2063C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 23:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390850AbgFWVLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 17:11:10 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:53408 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389684AbgFWVLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:11:05 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 56CED1C0C0A; Tue, 23 Jun 2020 23:11:03 +0200 (CEST)
Date:   Tue, 23 Jun 2020 23:11:03 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 066/206] soundwire: slave: dont init debugfs on
 device registration error
Message-ID: <20200623211102.GB4401@amd>
References: <20200623195316.864547658@linuxfoundation.org>
 <20200623195320.204985936@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <20200623195320.204985936@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 8893ab5e8ee5d7c12e0fc1dca4a309475064473d ]
>=20
> The error handling flow seems incorrect, there is no reason to try and
> add debugfs support if the device registration did not
> succeed. Return on error.

> +++ b/drivers/soundwire/slave.c
> @@ -55,6 +55,8 @@ static int sdw_slave_add(struct sdw_bus *bus,
>  		list_del(&slave->node);
>  		mutex_unlock(&bus->bus_lock);
>  		put_device(&slave->dev);
> +
> +		return ret;
>  	}
> =20
>  	return ret;

Mainline is significantly different here; this patch does not make
sense in v4.19 -- as it does not do anything.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7yb+YACgkQMOfwapXb+vIpBgCguXIYBDydvxHF/VrSJvIq1C6u
CrEAn3RXvz12D0iGQtA1lz2By4y491LE
=qSV3
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
