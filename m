Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B8326A9F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 18:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgIOQec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 12:34:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbgIOPzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:55:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE02E206A1;
        Tue, 15 Sep 2020 15:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600184866;
        bh=J7nP3T7lsrE/sKq6YXt1lyfPigmOJ4Hm7RJIV5FMhgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qMuxCJINcntVKNrVdGyngDXzCMeQz63bTwZO98dhVLsFCc8OVvxRBT1TLF/bDfQ8u
         Os5gE23Fx1Rrn7vjOqzGtZEBRfupVjGHHusecAVc4hmsLfnenLgmoYfNtlirO+AZY7
         9V0bw8u/X/+259WywbhxGrs7VEErZaPGcjtsbksk=
Date:   Tue, 15 Sep 2020 16:46:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/3] ASoC: tlv320aic32x4: Enable fast charge
Message-ID: <20200915154656.GC4913@sirena.org.uk>
References: <20200911173140.29984-1-miquel.raynal@bootlin.com>
 <20200911173140.29984-4-miquel.raynal@bootlin.com>
 <20200915082602.GH4230@piout.net>
 <20200915115034.GA5576@sirena.org.uk>
 <20200915130207.GA9675@piout.net>
 <20200915141025.GB4913@sirena.org.uk>
 <20200915161401.54f6d4f3@xps13>
 <20200915142743.GB9675@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
In-Reply-To: <20200915142743.GB9675@piout.net>
X-Cookie: Linux is obsolete
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 15, 2020 at 04:27:43PM +0200, Alexandre Belloni wrote:
> On 15/09/2020 16:14:01+0200, Miquel Raynal wrote:

> > Indeed, it is just affecting the ramp (peak current is bigger).

> However, forcing powerup at probe time versus at play time means that
> you consume power even when not playing audio.

With older VMID referenced devices like this one seems to be there's
usually not really any good tradeoffs.  You have to balance audible
noise on the outputs when starting audio, idle power consumption and the
time taken to get the device live either on starting a stream or boot.
Generally for a given device there's a fairly clear optimum and trying
to support multiple options makes things more complex and less robust.

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9g4fAACgkQJNaLcl1U
h9DdOAf9EVOfUlhMpdtlwozgCQMUiBstCWWdfsHuYkiaenqDqEclIDYnBhtmN2Cc
MliADocQVfBqlOkfLxmwSgRoCaHaIc76NuTNqgjtqeU09o/sET6wOiBUPH9GN721
SyBQjncjYFYPbbAg0Fph7wouJOFFNz7kG2mhvGZnDHZNJr5h2cgEbo34uoD29e2W
sD2t5jnRUcjnV3u3t25hEcEpAoAhJJ2BZDonislVQTai3qizCU3W0KMFEjKm2jNz
tjL/JCUqp8u+Gg5KMCw8r7BTCEXVsFbu51I7OPLiJnPZtjhOyz9P985lJNtn6N0c
9SMOCPxvAKoxhxjwCbg99BTcb3Difw==
=lTzY
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
