Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D152A0C07
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 18:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgJ3RCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 13:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbgJ3RCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 13:02:04 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D6BD2075E;
        Fri, 30 Oct 2020 17:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604077324;
        bh=thwyGLEm4QiHSUYxEzQuu9UgKpF/qQOjUSxHK4o2wTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2ZEhx0g09DBf1d8fdkG/MFXgVasXBurxJ7QkWWlv89l7Fe4GB+iaF/3bmw42X49Bx
         Kul72KIfFdo099hGDKsz/86Z+lK0C9GzMbGAREk0BNicTwp6bkfw34B7+Vzac+aTmF
         FbmLceXnbVquFqk86Vm1StP/qG+Z4mtM42pWVXLw=
Date:   Fri, 30 Oct 2020 17:01:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Lu, Brent" <brent.lu@intel.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jason Yan <yanaijie@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        "Nujella, Sathyanarayana" <sathyanarayana.nujella@intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        "Wang, Rander" <rander.wang@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>
Subject: Re: [PATCH 2/2] ASoC: intel: sof_rt5682: Add quirk for Dooly
Message-ID: <20201030170156.GH4405@sirena.org.uk>
References: <20201030063654.25877-1-brent.lu@intel.com>
 <20201030063654.25877-3-brent.lu@intel.com>
 <c83b3f20-2afd-12da-c349-31f35f8f6aa5@linux.intel.com>
 <DM6PR11MB3642F7AB13991ACF8A32B1DE97150@DM6PR11MB3642.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gTtJ75FAzB1T2CN6"
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3642F7AB13991ACF8A32B1DE97150@DM6PR11MB3642.namprd11.prod.outlook.com>
X-Cookie: Blow it out your ear.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gTtJ75FAzB1T2CN6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 30, 2020 at 04:44:17PM +0000, Lu, Brent wrote:
> , Brent Lu wrote:

> > Wondering if patch1 would be enough?

> Dooly has DMI family string " Google_Hatch" so the DMI quirk will overwrite the
> driver_data. I asked google but they prefer not removing this string so it seems to
> me that one extra DMI quirk is needed.

I think this needs at least a comment otherwise someone might come along
later and clean it up.

> The other way is using acpi_dev_present() in probe to update the quirk with correct
> codec setting. Which one do you think is better?

I don't have a strong opinion either way.

--gTtJ75FAzB1T2CN6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+cRwMACgkQJNaLcl1U
h9DcZgf/Qof6PGRurGnpQ2XocAW1wp2HhEjd7S7B/IAYbKmBkwbI06mg6nhYV49v
38OE3/ESsSQ7+9T0rdFp6SAfYXMBb0vvfXVeYh9eF7v8m4g9fnWmC4UUHc6d022B
qQ+mboj7lpV54GTPr+5Y2xlpQ7azr/e33gz2TOh8cio7LGO2cbWyMLOlWBmtRrvg
9dxsKUXYFfIDd+D7chU5idKR/YQFgH2mSiQo6xiiuIzpjTPnC51BUP3w94iXdLfm
1Dohd/zMFnieeAilSo1rTmPMzkDBvGt6hHliXTo6hNlecNVldek4ucgVWv771sRb
OhCdZhVvfNdOLN4YEc7M/iEoQFwymg==
=NzJb
-----END PGP SIGNATURE-----

--gTtJ75FAzB1T2CN6--
