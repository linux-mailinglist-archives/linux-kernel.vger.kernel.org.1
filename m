Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D5A2A0E4F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgJ3TGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:06:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbgJ3TGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:06:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A7132072C;
        Fri, 30 Oct 2020 19:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604084775;
        bh=cLuY4+pqu7qemA9DepWaK6vSoiSey/aqsPpojwM9+mc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gSpylZJsGAkBjSqfpZCRFX1Br4mAEVRphYbhARtQNTOFUJcJOKCxnOw2jr9Ja0tbu
         EAdViwYRQf9cEMqRK7rqkqAr/Fhjoqs2ZBTxkVIfc+lfgyewkiTT43TUJ626XP12Z/
         PutVmvskRX7ehG17d/Li+wlWorqK5YKSaYJUyFYI=
Date:   Fri, 30 Oct 2020 19:06:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, sudeep.holla@arm.com,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, satyakim@qti.qualcomm.com,
        etienne.carriere@linaro.org, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v3 4/4] dt-bindings: arm: add support for SCMI Regulators
Message-ID: <20201030190606.GL4405@sirena.org.uk>
References: <20201026203148.47416-1-cristian.marussi@arm.com>
 <20201026203148.47416-5-cristian.marussi@arm.com>
 <20201030185514.GA4129214@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hdW7zL/qDS6RXdAL"
Content-Disposition: inline
In-Reply-To: <20201030185514.GA4129214@bogus>
X-Cookie: Blow it out your ear.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hdW7zL/qDS6RXdAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 01:55:14PM -0500, Rob Herring wrote:

> I'm a bit worried that now we're changing CPUs (at least?) from clocks=20
> to 'performance domains' while at the same time here we're adding=20
> low level, virtual regulators. Are we going to end up wanting something=
=20
> more abstract here too?

My understanding is that this is aimed at systems which have done the
more abstract thing where regulators just aren't visible at all to the
kernel but then find that they actually need to control some of the
regulators explicitly for things like MMC so need a mechanism for the
firmware to expose select regulators.

--hdW7zL/qDS6RXdAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+cZB4ACgkQJNaLcl1U
h9A8HAf9FZOxqN5ztXXzcyFqMRvV48KvQcWBFInAxMlUCJVE8zRVBmveMouOUnif
Je2UEMsyHoeVepGn0avc9cn6ipwGQgFWNcuRZS8FdcB2ZeWW/9oelsDX9LIL0bnm
2+dyVc5NPIm/Z4qxzyxp/FdBc+AZN5D/B4xMkDnkteOhtgkDQii6+xswCL5axMV6
LC2K5wpzTfoOYKBq0CA4KteSaXh9hMLyPVLr2nGfz3pzoc6mGAJKzZxiByrv0if4
ofeg10w8IKt7YAX4w7EX8eAhPffRPikb4lc8R3gjFkksZhL0g4y/g4Al854qir0r
QxogLi/LrLhqQJ9yJdM3Cqk3Gtj2gw==
=25Cj
-----END PGP SIGNATURE-----

--hdW7zL/qDS6RXdAL--
