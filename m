Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4922CA729
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391753AbgLAPey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:34:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388042AbgLAPex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:34:53 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 203482080A;
        Tue,  1 Dec 2020 15:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606836852;
        bh=0JgRCXc/QawQKq5cv7nppLQvoSkACwkWRkFs2PCBTSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tW+cnTddz3cGs0rUQyFZKYez70AkdRCr1l49PKUWLE/20e5IwOmTwpUt+vvabwqsP
         X5UzqOQ3x2Smk4xU68l5MesR9hoQk7+uewoMdjzKHzCABxD8R1Tf6f6Abwy5xzuugy
         N1Z1xSuMl3OVkQeIxTl5jYr7R9pbfFapppQH35EQ=
Date:   Tue, 1 Dec 2020 15:33:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [BUG] SPI broken for SPI based panel drivers
Message-ID: <20201201153343.GJ5239@sirena.org.uk>
Mail-Followup-To: Sven Van Asbroeck <thesven73@gmail.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
 <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
 <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com>
 <CAGngYiVoj4Gpid5W10pJfiE1FWY=294TJ4fE=CDG4=HwH0WrJw@mail.gmail.com>
 <460191B6-EDD3-46DE-A1ED-47F758F111E8@goldelico.com>
 <CAGngYiVU5Udm6zUzrJPNF-V+uchhiv0-tWbUzb+_aSYVF=Dpug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LG0Ll82vYr46+VA1"
Content-Disposition: inline
In-Reply-To: <CAGngYiVU5Udm6zUzrJPNF-V+uchhiv0-tWbUzb+_aSYVF=Dpug@mail.gmail.com>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LG0Ll82vYr46+VA1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 01, 2020 at 09:08:34AM -0500, Sven Van Asbroeck wrote:
> On Tue, Dec 1, 2020 at 8:36 AM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> > Well I only complain because you wrote that you knew that it may
> > break something else. So it is known to induces a regression.

> We knew that it would fix an important, common problem, but
> we also knew that there is always a possibility of breaking
> something else when making a change to the core.

It's worth pointing out that this is an exceptionally fragile area of
the code thanks to some regrettable historical decisions with regard to
how GPIOs are managed so this assessment is based on repeated past
experiences with changes that look sensible, fix real problems for real
systems and yet cause problems to crop up elsewhere due to unforseen
interactions elsewhere.  Eventually we'll shake out all these issues and
end up with something that's more understandable and hence managable but
clearly we aren't there yet.

--LG0Ll82vYr46+VA1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/GYlYACgkQJNaLcl1U
h9B3lgf+Nl7sjsF3jULBaN5rZYpuc1c5AFOu4nZQRuajcnuBwYAOCUNUGjqSL1wb
l1X3s4osRwHAKbbE/ePnZoxeSqDcUpE+QmIvJAx3AwQRFSChSk+QoKlr8TPpD0pS
4aCE1MPkMVTJtB2k8ZAmZO2ii4hSRmp8PMYLNldc8m9F509xzMSnU7x0jvlz+zwD
8KqDSjQCEn2Db40iDGdC6xxb5in5HbMdOelg5zRuW60PEUgmNcGna9LYFBJEhH3c
XmRZgj4FXDj6gVUF9lY3R21XExZo+uAvOwMGQxBGCSwpBHfLsDp7Qd0d1u2GQd5C
aV01u0LXmnYwiCC4OmRKxfkqEeEqWw==
=0eSG
-----END PGP SIGNATURE-----

--LG0Ll82vYr46+VA1--
