Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBDE1B094A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 14:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgDTMZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 08:25:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgDTMZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:25:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FABA206D9;
        Mon, 20 Apr 2020 12:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587385537;
        bh=CB1cs2u7sCQVW6VgECnDyk16dVAwP9xS4baH8lRPRVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LF8Y3OArgCWn7DFuv9/bZeEiSa6eZPi9IKIUIONwU2K/JXT+GJQ2617xXVajSIUvB
         Mq3bJZEP+TPPKlkBSO9Uc/15eIFutv4+DUEeKZfts1vRMOw30LbCYY13l665R2gwm1
         PPX+ncsMs/xCd0v+sJyZDPJzB5CLsOsDxVLKEVNw=
Date:   Mon, 20 Apr 2020 13:25:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: sound: add Microsemi ZL38060 binding
Message-ID: <20200420122534.GC6507@sirena.org.uk>
References: <20200417221341.31428-1-TheSven73@gmail.com>
 <20200420121542.GB6507@sirena.org.uk>
 <CAGngYiWauBTnXDcP9UC1S7U5Ogy0B=bUZSdGs1Z9aKZ2+sB=Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
In-Reply-To: <CAGngYiWauBTnXDcP9UC1S7U5Ogy0B=bUZSdGs1Z9aKZ2+sB=Qw@mail.gmail.com>
X-Cookie: Can you MAIL a BEAN CAKE?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2020 at 08:22:57AM -0400, Sven Van Asbroeck wrote:
> On Mon, Apr 20, 2020 at 8:15 AM Mark Brown <broonie@kernel.org> wrote:

> > > +maintainers:
> > > +  - Jaroslav Kysela <perex@perex.cz>
> > > +  - Takashi Iwai <tiwai@suse.com>

> > This is supposed to be people maintianing this specific binding, not the
> > subsystem.

> That would be Liam and yourself?

I'd expect someone with knowledge of the hardware such as yourself.

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6dlL0ACgkQJNaLcl1U
h9D7Kwf+LC7/wtTT8Lua9SOMuqkJuV567Z2K+6WPBqGKZrXRPVgC6pof6F73yYHO
Khls/BtqPP5xrju44AZtEtwekL7nQc+cZ6OIOCjSBo5VzbFJH0PnBDfpXHHnptOS
DERuomhtelfPclJ5g1NKeeUxxo6yigRjy5PGtBslUB8l2orgGgA5K8oYJ3NYzX6K
PiJPjeSoaISIpeSBA4i68usuHBWWB3u4ys5gVEW0WceMjSUcUuacBQgCczV27Gnn
iwQ73fzp/q1TybKKnGJwbvgVpvsknh6l4T/Py603UBADklq7SMZIgawQFIoXkgUn
mYRYeBFdzoEiWpLgvH7C6iYNya9hug==
=rHE+
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
