Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2E8207467
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 15:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390144AbgFXN0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 09:26:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387687AbgFXNZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:25:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2EA720738;
        Wed, 24 Jun 2020 13:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593005135;
        bh=JmFbJS0PXLoFzco2T3g6Do+UUnsYW2aYLUOdaY8lj+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I0ghPOxMhm6dri4CB1uByEKsnodv/HbTXGlazQSBuzPHznhC5brjUCLVLAYURDLXq
         mRTxA2V01ONTgnjLhHWgAZqqulK4hB0upnbtXvRAMWEVVQngyoaecajufaz5tdIN9I
         YJrOr8x6CBw5QxolcEvBjTCMrqhBA8ziYD7lXAKU=
Date:   Wed, 24 Jun 2020 14:25:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andy.shevchenko@gmail.com,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Subject: Re: [RESEND PATCH v5 4/5] drm/bridge/sii8620: fix resource
 acquisition error handling
Message-ID: <20200624132532.GC5472@sirena.org.uk>
References: <20200624114127.3016-1-a.hajda@samsung.com>
 <CGME20200624114137eucas1p13599d33a0c4a9abf7708bf8c8e77264b@eucas1p1.samsung.com>
 <20200624114127.3016-5-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline
In-Reply-To: <20200624114127.3016-5-a.hajda@samsung.com>
X-Cookie: So this is it.  We're going to die.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2020 at 01:41:26PM +0200, Andrzej Hajda wrote:
> In case of error during resource acquisition driver should print error
> message only in case it is not deferred probe, using probe_err helper
> solves the issue. Moreover it records defer probe reason for debugging.

If we silently ignore all deferred probe errors we make it hard for
anyone who is experiencing issues with deferred probe to figure out what
they're missing.  We should at least be logging problems at debug level
so there's something for people to go on without having to hack the
kernel source.

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7zVEwACgkQJNaLcl1U
h9Adowf/bt19xA4Q3/G5xTijEYnOc63YWxQGFynpEFvnpuQuTYuDRwL2ybQHpXkD
7dZqUsmE//n9XDWNSi6IHolSzWRtBVqD+LpF/gmGHcqGsPCstcSLeQMVM5b4l5KV
x59+x9cTfoYkQ2XoBNZmmWZwGBYqVJvhW+4TysUX+9JCZgxKOG1LXLuMlL7r9qP2
5nI549k1sjQdiC8pevFkysGucfiOGoKIQfcpMqqlIzCFkBCt5pRTYNQ0e4jUh3gT
8qVPKlbm99aJ5+TGjPWtUzndU9VM08psKQNnguznxAbaHhF+ZA11l1AiIPv2qHkn
YtM+Bz+sHfeDkTCKefTLds0G3+8Mmg==
=oY2K
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
