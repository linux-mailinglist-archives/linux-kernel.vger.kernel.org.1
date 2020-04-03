Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D54819D34C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 11:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390315AbgDCJNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 05:13:50 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:41791 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgDCJNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 05:13:49 -0400
X-Originating-IP: 93.29.109.196
Received: from aptenodytes (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 5CA974000D;
        Fri,  3 Apr 2020 09:13:45 +0000 (UTC)
Date:   Fri, 3 Apr 2020 11:13:44 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 2/3] drm: Add support for the LogiCVC display
 controller
Message-ID: <20200403091344.GA720146@aptenodytes>
References: <20191203150606.317062-1-paul.kocialkowski@bootlin.com>
 <20191203150606.317062-3-paul.kocialkowski@bootlin.com>
 <20200104192026.GA21210@ravnborg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20200104192026.GA21210@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sam,

On Sat 04 Jan 20, 20:20, Sam Ravnborg wrote:
> Good looking driver. Well structured in a number of relevant files.
> A few comments in the following.
> Some parts I fail to follow - due to my lack of DRM knowledge.
> So all in all - only trivial comments.

Thanks for the review and the friendly feedback!

> With these fixed you can add:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

I'll take most of your suggestions in for the next version and there's just=
 one
point where I disagree:

> > +struct logicvc_drm {
> > +	const struct logicvc_drm_caps *caps;
> > +	struct logicvc_drm_config config;
> > +	struct drm_device *drm;
> Modern drm drivers are expected to embed drm_device.
> See example in drm_drv.c

Well, I see lots of modern drivers that use drm_dev_alloc, including vc4 th=
at
I took as a reference.=20

My understanding is that embedding the struct is a recommendation but
drm_dev_alloc is still quite valid and that the choice is left open.
Quoting drm_drv.c:

 * It is recommended that drivers embed &struct drm_device into their own d=
evice
 * structure.
 *
 * Drivers that do not want to allocate their own device struct
 * embedding &struct drm_device can call drm_dev_alloc() instead.

In my case, I like the fact that drm_dev_alloc correctly wraps drm_dev_init
and drmm_add_final_kfree (and I'd rather not add & all around unless I'm
obliged to ;)

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAl6G/kgACgkQ3cLmz3+f
v9G3sAgAgKq1ecptnIYD6N1lYm1B5XbgAqGTpKFC1sy6w6tNYtI8NkV15ikcY/Tj
j6XpWwEhri+sOme76KBKqfDOiDpDOAYAOKKOP4dV+x9WqlOqkFmuu/5sqkQNVB+E
kS/DqxfIHWBWGcWJT3hJWRMBm99/8V2IigSWX6oiIZc+EyHy/dwbIns63A6MVF/c
uhoZqBuOuakAZhV+r8KRNPJlOKLLjP4qEUFv5Ka5mh3+80Wy0Bz1f/H8n/bvllM6
kUNHIix5hsKEVKWEwC/L4Pv1t0QYEsuWcHDW5pf2i9s05AWLgrl8vIublkUH0i4W
D7/T/7LMAuS+MMAJGUFxf5/UJQ6+1g==
=s+Sz
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
