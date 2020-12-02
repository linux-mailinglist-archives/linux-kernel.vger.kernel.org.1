Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AD52CC1C5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbgLBQJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:09:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727678AbgLBQJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:09:34 -0500
Date:   Wed, 2 Dec 2020 16:08:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606925334;
        bh=SMOZs4KWCFhUFelF2nFn3dSKK/3uWlQNtrXQxM1GSFU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=IIvmcKTCr7A9yv6jcfchaxPeaZqQL9EbWkWuhQjD2SxCqO03A+5lioR7PcLqkCgfP
         ocCptkp9EhuP0tqbWJ3/JIMw2QkXFfQuzH14pJ8s9XbTU6iSBta0alWHuKEpGH0Nva
         5nJowwVcpgoM1VvOpW+4+eR7PYTcC99w2NTQfDgg=
From:   Mark Brown <broonie@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Liao, Bard" <bard.liao@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "hui.wang@canonical.com" <hui.wang@canonical.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "jank@cadence.com" <jank@cadence.com>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "rander.wang@linux.intel.com" <rander.wang@linux.intel.com>
Subject: Re: [PATCH v2 0/5] regmap/SoundWire/ASoC: Add SoundWire SDCA support
Message-ID: <20201202160824.GH5560@sirena.org.uk>
References: <20201130144020.19757-1-yung-chuan.liao@linux.intel.com>
 <DM6PR11MB4074311B4E0B70F24383E754FFF40@DM6PR11MB4074.namprd11.prod.outlook.com>
 <20201201041138.GY8403@vkoul-mobl>
 <e9478e45-2a24-05f9-eb56-5905d54ab6a4@linux.intel.com>
 <20201201145322.GG5239@sirena.org.uk>
 <20201202071405.GG8403@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jRdC2OsRnuV8iIl8"
Content-Disposition: inline
In-Reply-To: <20201202071405.GG8403@vkoul-mobl>
X-Cookie: Sauron is alive in Argentina!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRdC2OsRnuV8iIl8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 02, 2020 at 12:44:05PM +0530, Vinod Koul wrote:

>   Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/=
soundwire-for-asoc-5.11
>=20
> for you to fetch changes up to b7cab9be7c16128a0de21ed7ae67211838813437:
>=20
>   soundwire: SDCA: detect sdca_cascade interrupt (2020-11-24 14:09:31 +05=
30)

Pulled in, thanks.

--jRdC2OsRnuV8iIl8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/Hu/cACgkQJNaLcl1U
h9CZVQf/VyX8InS9fyMv9fL3qL4IplBUxFs3X9fZ0WNOlJCZbvgR7RVTqbPiQ190
eWYCzrj3yJUms/PeITGoTW83BAqPx8v428eEL8H3oRSiw9L/k6fhY90UQKGR4nvm
4vSMD1hZFTI16vKY7Hx+6xymYKKXIMBKqJe11xnbMjyeVQGbuXKouHcBTX3eibCi
IZn4IDBs7PSal//yPj2yzu81DQSbKCleeT/aD5uCAL6UnFcn1IMUZcfeUvcDrp7r
oZH8XYjTlNyfsZ8WglyY6AawbuZe2icL2KbWx2y1O3ebey0bQVsUryFWRz7vNLu9
OuF3gtaVjaypTH+fExmNsxtEYDST1Q==
=KTtm
-----END PGP SIGNATURE-----

--jRdC2OsRnuV8iIl8--
