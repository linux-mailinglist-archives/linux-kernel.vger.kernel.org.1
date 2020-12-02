Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C982CC1BB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbgLBQI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:08:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:42098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgLBQIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:08:55 -0500
Date:   Wed, 2 Dec 2020 16:07:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606925295;
        bh=hOfFwbDGZXojMmvPoTEr6keNo7+YHxhXWhs4T8YnWgY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=dSPh0xKzS0f8nyxfeKIChWJXvQBmQxzw6ZTwZvUj5JVG3djF2n85TtxxQFiR5fKO1
         DOykDLPa2zyaQa41LtM3vuQzkQOO/lIUExmgN3xio69LoH4N5ZeDFbciXiK7dLudO2
         XDy6fVLrvKEL1tW6EJuNgbJ7aff5HZdEsctHtA8w=
From:   Mark Brown <broonie@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH v2 3/5] ASoC/SoundWire: rt715-sdca: First version of
 rt715 sdw sdca codec driver
Message-ID: <20201202160740.GG5560@sirena.org.uk>
References: <20201130144020.19757-1-yung-chuan.liao@linux.intel.com>
 <20201130144020.19757-4-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hTiIB9CRvBOLTyqY"
Content-Disposition: inline
In-Reply-To: <20201130144020.19757-4-yung-chuan.liao@linux.intel.com>
X-Cookie: Sauron is alive in Argentina!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hTiIB9CRvBOLTyqY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2020 at 10:40:18PM +0800, Bard Liao wrote:
> From: Jack Yu <jack.yu@realtek.com>
>=20
> First version of rt715 sdw sdca codec driver.

This doesn't apply against the ASoC tree, please check and resend.

--hTiIB9CRvBOLTyqY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/Hu8sACgkQJNaLcl1U
h9AI1wf+Mocj13rHR7jKwStrov94tgBi8NYh1GZ10nu7IPGznNB/fwfRf0QiMHJR
DUtsGdQ6Ezgd2kCpEaG1UacBiAG8n10RWd4PGFz7JQmud/S7EvHLyi922Q8web6B
lbHUpjXOF+/7JBXiPG5mDdRMW8yWywXiUlmM9/7wQLAaBzi2NT3092d60fZihj6C
pD1MR5o/j4e2ctvg+AaD2rxxm1KLiEirG8vbcaJM/772htm6x+oQaDvpZmYoj/Dq
KLKEyMoSUgn9TcHlnYkA/rbn5LnDef3taCr0MyeDCAUC52DauZ/yMBv3lOzToMco
y9taEMeO8qfd06h48GM2Hm4JP9aODw==
=0vGc
-----END PGP SIGNATURE-----

--hTiIB9CRvBOLTyqY--
