Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F572FA062
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404337AbhARMul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:50:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391856AbhARMtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:49:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12A4B22286;
        Mon, 18 Jan 2021 12:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610974104;
        bh=q0FH4FunpIzIAVQK8v4yM3g5TtdkKMgOk5kdtyHxQ/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vR7Q2xtf3xWcFlY1axP6Oa7VeqZiURML4gqOREJ+FYznmnRlvZvzNenSq8UlWnEKc
         EZuV84FpaVypn8QMaLxmaFnu6l01ydC6x4MkV0aQsasBgwSFCeEUz6m0y3X4lVk4mO
         dPlglUQWKoIXn26qGZqgwT474lYmKksg+jGM4T5az15k5poNjEfN+Ps5bSMo1J/GEX
         MBqGkC3gllNPYrklHYfB5BHcTBV3Pni7wd87dN9l9WvwnHMwJo9nhvAa6GCsRdIXjd
         N5kt7vlIFrcuFpeRu2K93JLuSQnRQTeoq8ccm3acHYlfaFBndgp5sXYjFhhYlHF+jV
         swU2Ii4BG7WSw==
Date:   Mon, 18 Jan 2021 12:47:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 03/12] ASoC: arizona-jack: Fix some issues when HPDET
 IRQ fires after the jack has been unplugged
Message-ID: <20210118124747.GH4455@sirena.org.uk>
References: <20210117160555.78376-1-hdegoede@redhat.com>
 <20210117160555.78376-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X1xGqyAVbSpAWs5A"
Content-Disposition: inline
In-Reply-To: <20210117160555.78376-4-hdegoede@redhat.com>
X-Cookie: Huh?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1xGqyAVbSpAWs5A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 17, 2021 at 05:05:46PM +0100, Hans de Goede wrote:
> When the jack is partially inserted and then removed again it may be
> removed while the hpdet code is running. In this case the following
> may happen:

Fixes like this should be sent at the start of the series (prior to
things like the move) so they can go to stable as bug fixes.

--X1xGqyAVbSpAWs5A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAFg3IACgkQJNaLcl1U
h9AIhgf+M++EG4ZowJPSdgTXzjQZ5XKVxiSCsCPaQVSYZETswc7j/jtwajvwFP2z
tOsloeQSInfvPYa/MPjAsZG8Xtg5m6GbVdZPaVZeynjZUMi1sCWgyhbXGZTQoQ0C
nbaQcdM7cCVi6vqF6Ehf4cgECmHubN7Rc8D66XdN4NDpKLFfgk5tWvo/5XoGyZNo
srsv5x2hrg1zPhf0/0/abLtpR49dgLsai0wwHbW5dM7vTQPs3ZwViIPPpMM3G1ek
F28wNcC9xBfuahVDvfdBCJFnHdoPBQ10GCCs8BdOCdmEgWSCwI79H5p1i6p27t73
KLy5NcqJTQOFoK+D54xJlYB7dajKYw==
=Xw3f
-----END PGP SIGNATURE-----

--X1xGqyAVbSpAWs5A--
