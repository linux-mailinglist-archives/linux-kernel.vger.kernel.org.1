Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061B326A49D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgIOMEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgIOLvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:51:40 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F9A620732;
        Tue, 15 Sep 2020 11:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600170682;
        bh=4AdVvb9OpJlCLAFzmltxBUT5yXR5yQZ90HPJkguTE/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6Oi9kNO6jEJRVa0oQ7wJE9zm2k9LSZ8fHzXrkc2iG9HPQCC/RL9evS85vQ0UuNqa
         j0mC1xGz7Qh2AnPRsfQMYXHpoEL0Ai0tYEKoFtleucmMt7+LFODhK4cqpKchawBdTE
         EkHzNEW5D1KsyGkYeHyF3nW60lzX0wZVECcvkhSw=
Date:   Tue, 15 Sep 2020 12:50:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/3] ASoC: tlv320aic32x4: Enable fast charge
Message-ID: <20200915115034.GA5576@sirena.org.uk>
References: <20200911173140.29984-1-miquel.raynal@bootlin.com>
 <20200911173140.29984-4-miquel.raynal@bootlin.com>
 <20200915082602.GH4230@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20200915082602.GH4230@piout.net>
X-Cookie: Where am I?  Who am I?  Am I?  I
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 10:26:02AM +0200, Alexandre Belloni wrote:
> On 11/09/2020 19:31:40+0200, Miquel Raynal wrote:

> > +	/*
> > +	 * Enable the fast charging feature and ensure the needed 40ms ellaps=
ed
> > +	 * before using the analog circuits.
> > +	 */
> > +	snd_soc_component_write(component, AIC32X4_REFPOWERUP,
> > +				AIC32X4_REFPOWERUP_40MS);
> > +	msleep(40);
> > +

> Maybe the actual REFPOWERUP value could be exposed as a control so
> userspace has a way to set the policy?=20

We very rarely do this, there's not usially anything=20

> I'm not sure it make sense to have the delay in probe because it is not
> enable the analog part of the codec. The delay should probable be after
> the clocks have been set up because the datasheet says that it is mdac
> and madc that is starting the analog circuitry.

Deferring the delay to a workqueue is the usual thing where there's
concerns about slowing down boot.

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9gqokACgkQJNaLcl1U
h9BxmAf/UcMuAW76u6rLlk8ONETf/rGaWtTY69AB4XXcR3C5KFDbnlRR+se+WUaZ
jaaNRa0HzZQIRqTCHz6SaGc2hXvR1Ua6uFT6KEroJkRtfyxVdNS70PEyykyNPe09
u12QaUYrzpQ3PVGZ3ngEXk3jFnb+8NziK5riqM8S8GqD8bwl9H47rDBReMNDY2Lq
UKP52Nv0qFYzK0cj7dBtPLYozZSXDNi+Vyve6jxnmE1iRHIc+VZvGZFBNBMb+vfY
RS9ojAe/BNibV+4sT/2SBQAyIc/AKjYn8crR9m43onChyuuryn0sS9Dn2Qkh1/25
+RYK+VVmlF/4DjcJSUjfcS9l/H4Q9g==
=5ecU
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
