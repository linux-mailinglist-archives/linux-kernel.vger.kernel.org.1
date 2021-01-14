Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA7C2F5D63
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbhANJ1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:27:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:58488 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbhANJ1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:27:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 39E03AB7A;
        Thu, 14 Jan 2021 09:26:28 +0000 (UTC)
Message-ID: <9a8d9a57a1837fb7e0b17f19f089c55f955c98fc.camel@suse.de>
Subject: Re: [PATCH 0/3] usb: dwc2: Fixes and improvements
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Guenter Roeck <linux@roeck-us.net>,
        Doug Anderson <dianders@chromium.org>
Cc:     Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
        Felipe Balbi <balbi@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Hudson <skrll@netbsd.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 14 Jan 2021 10:26:25 +0100
In-Reply-To: <20210114030715.GA102157@roeck-us.net>
References: <20210113112052.17063-1-nsaenzjulienne@suse.de>
         <CAD=FV=VnsVgTGTkr9VYQHCkBSVVksT1UGfsmk+dqTyQ1sqF=Qw@mail.gmail.com>
         <20210114030715.GA102157@roeck-us.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-E4/aw+LDBvAEHrn4g2Fu"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-E4/aw+LDBvAEHrn4g2Fu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter, Doug, thanks for having a look at this.

On Wed, 2021-01-13 at 19:07 -0800, Guenter Roeck wrote:
> On Wed, Jan 13, 2021 at 03:20:55PM -0800, Doug Anderson wrote:
> > Hi,
> >=20
> [ ... ]
> >=20
> > It's been long enough ago that I've forgotten where this was left off,
> > but IIRC the 3 patches that you have here are all fine to land (and
> > have my Reviewed-by tag).  However, I think Guenter was still tracking
> > down additional problems.  Guenter: does that match your recollection?
> >=20
> > It looks like there are still bugs open for this on our public bug trac=
ker:
> >=20
> > https://issuetracker.google.com/issues/172208170
> > https://issuetracker.google.com/issues/172216241
> >=20
> > ...but, as Guenter said, I don't think there's anyone actively working =
on them.
> >=20
> > I'm not really doing too much with dwc2 these days either and don't
> > currently have good HW setup for testing, so for the most part I'll
> > leave it to you.  I wanted to at least summarize what I remembered,
> > though!  :-)
> >=20
>=20
> The patches in this series still match what I had in my latest test code,
> so it makes sense to move forward with them. I don't think I ever found
> an acceptable version of the DMA alignment code.

As for the alignment code rework, can you recall the underlying issue that
warranted it?

Regards,
Nicolas


--=-E4/aw+LDBvAEHrn4g2Fu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmAADkIACgkQlfZmHno8
x/6lhgf/aLYEr1NNy/j/1kCMGm3ZQ0fUj2UouvGMACD6xO1/6Tmj62vq4aUO62f0
+RiSLkwYCe1gxXaZB9KQ2bYko/9s+D5i8O12Ha/oUfypARXx/ebXR4m3TGa8H1Eg
36U7pdEVvWKCLZ8pDqFVvFdiq5ApnoIuI24xF0mUPJIZLEhdMqafT5sSzrmuTXkF
y1JMjVYC/3lMPlGcnm6vfWU7iLfyh2aDBq7K9okOjEG+JB0ZYKH7qCD2mL3vZzFU
m0bngWMsFfKJWPxtwo0mpQnDY1gaTar5nanXiLXNFD34yNwtYgEeQdIjT2edg9oT
1w+CaKBIM8VAkDipHlttQP3TWcRokg==
=tmhn
-----END PGP SIGNATURE-----

--=-E4/aw+LDBvAEHrn4g2Fu--

