Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5F72BB63A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 21:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgKTUEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 15:04:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729484AbgKTUEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 15:04:52 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C45742225B;
        Fri, 20 Nov 2020 20:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605902691;
        bh=O6QlgpPZWJ0ZFa0Oit5xMmDdgPSwTCGSd8OW7gqJhYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z8SAy73jokhL1rD6RinyEXwIklNEbYMURVKsRlpggkmyDXr5PBXW+52WKiLcnsuO0
         vWsgTOJKVDxHkdTWsWxZ3hKryWwnjYPoDC3kX7eufWyQGipH/slnOu+p2EbAyfbfs/
         zkyRBYRiHv+8TW0qcgxXpZoWr1+j8Dc1XWNUgpwA=
Date:   Fri, 20 Nov 2020 20:04:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 01/38] ASoC: ak5558: drop of_match_ptr from of_device_id
 table
Message-ID: <20201120200429.GJ6751@sirena.org.uk>
References: <20201120161653.445521-1-krzk@kernel.org>
 <20201120165202.GG6751@sirena.org.uk>
 <20201120194245.GA2925@kozik-lap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oYAXToTM8kn9Ra/9"
Content-Disposition: inline
In-Reply-To: <20201120194245.GA2925@kozik-lap>
X-Cookie: Have at you!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oYAXToTM8kn9Ra/9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 20, 2020 at 08:42:45PM +0100, Krzysztof Kozlowski wrote:
> On Fri, Nov 20, 2020 at 04:56:34PM +0000, Mark Brown wrote:

> > It would be better to fix these by annotating the table as potentially
> > unused, if nothing else it means if someone wants to add ACPI support
> > (or it just works on their ACPI system with the plain old I2C ID) then
> > they don't need to revert this change.

> The point is after this patch - removal of of_match_ptr() - they will
> already support the ACPI matching through the PRP0001.

> Keeping of_match_ptr() and maybe_unused will prevent any ACPI re-usage
> unless explicit ACPI table is added

Surely if that's the desired outcome the fix is to change the definition
of of_match_ptr() such that it leaves the reference with CONFIG_ACPI,
perhaps hidden behind a config option for PRP0001?  That seems better
than going through the entire tree like this.

--oYAXToTM8kn9Ra/9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+4IUwACgkQJNaLcl1U
h9C90Qf+I61ttAwAIZE/4fiWa7BmkBv4D00kqcaq3pu9eccMg7mleU/2IEA+WLuX
IXI3xrY2EvAn6BerMQQOCpY7h5QDpqYpk37MlaB1/VznoqMV3kN2OVTt0iigmZZ3
15xRwAW89OXYkZfnm2obupwURLm389fYcTFZpD6M90GYiUUFZ+uIENUT1vShaXDE
5Wq6yxBpRgmq3BlKxQFfD2fhZKqeWgrJwtgc7ChHfjYk1b6Il22K2RMiBVwv4Ax3
zpkY4Gbe79sa5yTYk1dRcUd9hnLMK8Sm/lIUTLuTtgMuKmKD8Aubv6x1qi6d4Cvb
/hqYpBit+g3Cr1zBlcEAdK/u/NUhVA==
=sv4Y
-----END PGP SIGNATURE-----

--oYAXToTM8kn9Ra/9--
