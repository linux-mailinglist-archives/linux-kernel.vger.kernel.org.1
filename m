Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23EA2C0C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388430AbgKWNub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 08:50:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387728AbgKWNua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 08:50:30 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84CC520729;
        Mon, 23 Nov 2020 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606139430;
        bh=0/IHxMdwzZirfFUEDtxYhKAxBqnvOfBcXnmhGHLZwE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KidfIMQVoIvcZVCdv8NPn4bJAaldX8rRH154qtqRm8yuUbNji3PZla9WdPLrOlm3h
         F1mDMPCM5axhytJBPc4EjO1N/K8MQxJargxBN2Wv+1d+7ngs9BrQjj6UdHBebEuxSb
         5Ysex+lthxVAeCqAhX7FXksR4WsNPBDOw4BZZyF8=
Date:   Mon, 23 Nov 2020 13:50:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 01/38] ASoC: ak5558: drop of_match_ptr from of_device_id
 table
Message-ID: <20201123135006.GE6322@sirena.org.uk>
References: <20201120161653.445521-1-krzk@kernel.org>
 <20201120165202.GG6751@sirena.org.uk>
 <20201120194245.GA2925@kozik-lap>
 <20201120200429.GJ6751@sirena.org.uk>
 <20201122105813.GA3780@kozik-lap>
 <20201123104832.GY4077@smile.fi.intel.com>
 <20201123123731.GA6322@sirena.org.uk>
 <20201123124129.GA170000@kozik-lap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FN+gV9K+162wdwwF"
Content-Disposition: inline
In-Reply-To: <20201123124129.GA170000@kozik-lap>
X-Cookie: Dry clean only.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 23, 2020 at 01:41:29PM +0100, Krzysztof Kozlowski wrote:
> On Mon, Nov 23, 2020 at 12:37:31PM +0000, Mark Brown wrote:

> > That feels like something that should be done with Kconfig dependencies
> > like a direct OF dependency (possibly a !PRP0001 dependency?) for the
> > driver or possibly with having a variant of_match_ptr() for things that
> > really don't want to support PRP0001.  Just removing all the use of
> > of_match_ptr() is both noisy and confusing in that it looks like it's
> > creating issues to fix, it makes it hard to understand when and why one
> > should use the macro.

> For the OF-only drivers (without other ID table), there is no point to
> use the macro. Driver can bind only with DT, so what is the point of
> of_match_ptr? To skip the OF table when building without OF? Driver
> won't be usable at all in such case. So maybe for compile testing?
> There is no need to remove OF table for simple build tests.

If nothing else it means you don't have to check if the driver is OF
only or not.  I can see not bothering to add it but actively going round
removing some instances of it doesn't seem great, and it seems like
people will constantly be adding new uses on the basis that it's just
such an obviously correct thing to do.

--FN+gV9K+162wdwwF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+7vg0ACgkQJNaLcl1U
h9Cg2AgAgW1CZvFTYqc5Dxt0wi6xknuc2q+AJ8IrulpzeW3y6wYvug/gq0UKnGe0
RhSfcXLgfzBLImnU7WdT72POVxtH3NahdaxVuRUy8yLpaEjq9HJMfw4FH+gTvQAP
qfb/mcZMdXxAG8iXe6RuxOFXAd/CvMSnVvsSNPIX/wZxKDls6jK37ZbhAAJ/GQfT
swW+LkfyQoT+f2ydE9CPZmZJyBrNsfVPNaWPbWS+Ifa+abSI8gyuj6yvy+6Fwire
/dMRJ1mjJ3ge0TZ++pDKRIi4VOLH6xays9NNMdJh1ioJwmGvR8JkBcJEvmmxk1V5
5ZCPCtoZpqkr8kw4+tevTm0Xz849KA==
=1/dD
-----END PGP SIGNATURE-----

--FN+gV9K+162wdwwF--
