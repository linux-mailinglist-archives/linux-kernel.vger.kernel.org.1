Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891C029BBDB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1809811AbgJ0Q2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:28:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1809624AbgJ0Q1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:27:01 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 385F121655;
        Tue, 27 Oct 2020 16:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603816020;
        bh=kM+q5a/4CSozUbBt556ksVRBHVXOCmkxyQA/MctuzVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J0pkkZf0nkd5hT9kQnPgSGqY293gEZG5Qc5BHBXrcbnsjmpn7NKuFW75bGu28c4a/
         EeqnOK5o8KAPYd5pBFQmUXT4YcTrGa19RXW64meYpoXNSnooTYR5sgm17RtcwuREzK
         bdrStVPco0ZHfBJlJZTfCPNBx1yXpBkD0ZP8f7/o=
Date:   Tue, 27 Oct 2020 16:26:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] drm/vc4: hdmi: Avoid sleeping in atomic context
Message-ID: <20201027162655.GB4895@sirena.org.uk>
References: <20201027101558.427256-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <20201027101558.427256-1-maxime@cerno.tech>
X-Cookie: That's no moon...
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2020 at 11:15:58AM +0100, Maxime Ripard wrote:
> When running the trigger hook, ALSA by default will take a spinlock, and
> thus will run the trigger hook in atomic context.

Reviewed-by: Mark Brown <broonie@kernel.org>

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+YSk4ACgkQJNaLcl1U
h9Cr7AgAhRoOc4Gjttyj+tM4Dayl68xyuva+089cuxgC2SZpu4kBZCMfygj42A1b
XyU1mHn4CDblQ9xUZWdn5nhjNlxwhFLswRxz/f42ZiwsKk/GmYkiPEUM8gi31jBh
VyoWXXcDVeb+sUZi6wo7Oqca3PBC6xhUsdIVUh+zAksbJ6nTPKv5H+x3JnSY+l1A
Uk8k8xz9k00PdUJ08F6yLDFgWOIpurIRfrgcoSw69XXlcc2EOn55rf5k6ahS2jox
xw4p3amLaWmdna+zkFZEgorUskjjxO5tfcZenKZMTgXqvEjYo0h0Hl1d9qYwTxM0
P6XTxa6tghfpUovKg2IG87FZ1BZV2g==
=DS6+
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
