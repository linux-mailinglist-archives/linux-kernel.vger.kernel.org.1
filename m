Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2617F2C0729
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 13:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbgKWMiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 07:38:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:50426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732025AbgKWMhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 07:37:55 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6852E20857;
        Mon, 23 Nov 2020 12:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606135074;
        bh=E3ZUW9YZtx9seOajOdKsI9RWDaX+VTD1RTCK4Pn1HfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jc82OpxINzA6CJC9QtsMQkXto1eCPNnZVLgaTuBLQMU+4un/Bq3CEFIdc3tvJj5+y
         xOF+W3AvJAS9M+8vhlLng4yZg7iD6iu+b/BXl6rumt0EpEVCzAdCtkXDYId/R49ydg
         TOVDcovB+saJUfi2WEa59QeB8Leu9AgDvQl2avEY=
Date:   Mon, 23 Nov 2020 12:37:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 01/38] ASoC: ak5558: drop of_match_ptr from of_device_id
 table
Message-ID: <20201123123731.GA6322@sirena.org.uk>
References: <20201120161653.445521-1-krzk@kernel.org>
 <20201120165202.GG6751@sirena.org.uk>
 <20201120194245.GA2925@kozik-lap>
 <20201120200429.GJ6751@sirena.org.uk>
 <20201122105813.GA3780@kozik-lap>
 <20201123104832.GY4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20201123104832.GY4077@smile.fi.intel.com>
X-Cookie: Dry clean only.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 23, 2020 at 12:48:32PM +0200, Andy Shevchenko wrote:
> On Sun, Nov 22, 2020 at 11:59:20AM +0100, Krzysztof Kozlowski wrote:
> > On Fri, Nov 20, 2020 at 08:04:29PM +0000, Mark Brown wrote:

> > > Surely if that's the desired outcome the fix is to change the definition
> > > of of_match_ptr() such that it leaves the reference with CONFIG_ACPI,
> > > perhaps hidden behind a config option for PRP0001?  That seems better
> > > than going through the entire tree like this.

> > That could be indeed an easier way to achieve this.

> ...easier and wrong in my opinion. Not all drivers need that.
> What the point to touch it in the driver which is OF-only?
> (For IP which will quite unlikely to be present in ACPI world)
> Or if the device will get the correct ACPI ID?

That feels like something that should be done with Kconfig dependencies
like a direct OF dependency (possibly a !PRP0001 dependency?) for the
driver or possibly with having a variant of_match_ptr() for things that
really don't want to support PRP0001.  Just removing all the use of
of_match_ptr() is both noisy and confusing in that it looks like it's
creating issues to fix, it makes it hard to understand when and why one
should use the macro.

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+7rQoACgkQJNaLcl1U
h9Ab8Af/d/f50Mie+21uU7IEYil1gbm/kfHMT4a3x03IfjU4EMbn9cWpgxbYJZeF
Ji7PrF9Pz6/uLhc3c92BFVw3CQFz5xm4VupqS4TCaQym5WU8sFjQtknzWYDkW91N
/IfkuCjG70Kg5Gp9Waa/wY50tF8c6WdnxJJ6XnNjTpwGBTrTZpcQF9sxo3Xp4ZbW
7KOc49fYkdlcjn1q7qTYv2s0RTGyOxOlBvKyu/hjNbYy3jWifeH2BJ4SOk38FtPS
FwoSIIR3GdrDqPjaG4seE6rdts4eIoFKzpt/Jhzas5m27n6Gojjs5c6fJ4ch6hrV
Ms7NDaWTa0cI4iSxV8YUL59UAerGpQ==
=BTCH
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
