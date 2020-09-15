Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD3726A703
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 16:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgIOOZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 10:25:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbgIOOOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:14:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72E5F206B5;
        Tue, 15 Sep 2020 14:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600179075;
        bh=C8NUJYTq4dRNf2aWP/bdW7G4qRZkHBy24HW9OqWLbTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a8qs7HANo70P1A8ZGn+5EbMUwqH0CRWb7Xt0tMyvpAwF05F4GcrimKpnmJFjDCO7M
         iApHQWdgWs7rz1G9vFr6cEwDWvj0vq5NMNZZraMoftu9h84ujcqL9LJnOKKE/uWLDW
         VX0rhD2KPGyWeEYSwO9nkmIA2q4dnz2+Vd1MeBfs=
Date:   Tue, 15 Sep 2020 15:10:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/3] ASoC: tlv320aic32x4: Enable fast charge
Message-ID: <20200915141025.GB4913@sirena.org.uk>
References: <20200911173140.29984-1-miquel.raynal@bootlin.com>
 <20200911173140.29984-4-miquel.raynal@bootlin.com>
 <20200915082602.GH4230@piout.net>
 <20200915115034.GA5576@sirena.org.uk>
 <20200915130207.GA9675@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <20200915130207.GA9675@piout.net>
X-Cookie: Linux is obsolete
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 03:02:07PM +0200, Alexandre Belloni wrote:
> On 15/09/2020 12:50:34+0100, Mark Brown wrote:
> > On Tue, Sep 15, 2020 at 10:26:02AM +0200, Alexandre Belloni wrote:
> > > On 11/09/2020 19:31:40+0200, Miquel Raynal wrote:

> > > > +	/*
> > > > +	 * Enable the fast charging feature and ensure the needed 40ms el=
lapsed
> > > > +	 * before using the analog circuits.
> > > > +	 */
> > > > +	snd_soc_component_write(component, AIC32X4_REFPOWERUP,
> > > > +				AIC32X4_REFPOWERUP_40MS);
> > > > +	msleep(40);
> > > > +

> > > Maybe the actual REFPOWERUP value could be exposed as a control so
> > > userspace has a way to set the policy?=20

> > We very rarely do this, there's not usially anything=20

> Could you suggest something then? This mainly changes the power
> codec power consumption. I guess people will want to trade latency
> for less consumption.

Is it increasing steady state power consumption or is it just drawing
more power during the ramp (ie, peak current consumption is bigger)?
Usually this is trading off clean ramps for fast ramps rather than
affecting steady state.  If it's affecting steady state a control seems
sensible.

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9gy1AACgkQJNaLcl1U
h9BXxAf7BnvnW/6Pgxw267h47TcBP7P0aIa2v2dsSOqZeya3Ofc0ZQC1rRsF0dRw
wbpMXxACb8GVNQp2KkdtT2mxV/CDanhKyoZ38iiTTYPjAms5K9Cyf2XxASPvLgXy
wR0B3yMJCBayYHanJajwSHu4uF8IVj0aXlHvgSeyiObN//cXYf17IC15DmUAhFZv
hQMh4ux/JslYg18NsrAvfTdynEJ850tfAAI9VnkYLyF+fte/9LJSYSn7o3QJ9O1Z
5l9qhrBr7ktL96LzzQ/C70uPhPflXdqSx2JlQY/hQaoj4RUxOT7acnCJobERs2D5
vx3wXK4kcyJQzjT0PWOrsocyhCU6GQ==
=6cJo
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
