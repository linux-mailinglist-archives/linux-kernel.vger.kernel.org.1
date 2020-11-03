Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7AE2A48B2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 15:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgKCOyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 09:54:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:53048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbgKCOxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:53:42 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77BE620757;
        Tue,  3 Nov 2020 14:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604415222;
        bh=GVewwPMeCjAxDalOCCOf46CmJoqqIh23iYK56tZAfQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IgGH85FrWT7zXFS6P4u2q+HG2JtNzvLUQSa2ajV+G7JKbeQBbuxoqwaGSe/1sjcOF
         UZYUiR09pGaGOQ8zAomcm8ACk8K9UVixl4pOeBAUHcqnhuRoSPxhO80a7KLiIke40K
         gn+LYgpGFQvVGuuRQWxT+Ksg/1pslaPlzt/A8yd4=
Date:   Tue, 3 Nov 2020 14:53:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Olivier MOYSAN <olivier.moysan@st.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] ASoC: stm32: i2s: add master clock provider
Message-ID: <20201103145332.GC5545@sirena.org.uk>
References: <20200911091952.14696-1-olivier.moysan@st.com>
 <20ed825b-10b6-e71f-9da4-91df38a950de@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
In-Reply-To: <20ed825b-10b6-e71f-9da4-91df38a950de@st.com>
X-Cookie: I don't get no respect.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2020 at 01:38:27PM +0000, Olivier MOYSAN wrote:
> Hi Mark,
>=20
> Gentle reminder on this series, as it seems that there was no update=20
> since Rob's "reviewed-by" for dt bindings, on 11/09.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+hbusACgkQJNaLcl1U
h9Dm9Qf+JPb2goRZsdbee0uFj53fh/s4jI5jzfiqEEX5flUTcLaxnRR27AcGii7B
9lcpaOHDzg/6oPwTXmQUWN8GMq/QNU+YDiAE+3PeafsCoi+0SZqqYu+UlignrFOy
mRygNLL8OocnwrwtUTFhQpcqs6MJXiLYAvwo5fw+zNpG42C1xnkvH83ZUglhmK3C
ph7kV5Ez7b4/kK1yMqsHBvnftPIPMyZeyauf5xpTGftvzyxMWRqwk9D/Pp4vQkYM
e0/AoIFpz/o3RE62XbLW9Y2+v7vqSXuQr31GcKZwF5lmeVzHJpDOfxdtsHExzTGv
S6xL8vxHCBwnRNrL9lEzduzWwk9Teg==
=3wTy
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
