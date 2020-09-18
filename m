Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEDE26FB86
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgIRLeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:34:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgIRLd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:33:57 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37D5D21D92;
        Fri, 18 Sep 2020 11:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600428836;
        bh=vM9m8zMv8skQhP1SU9+eBixGXC0EckzK9yvz6NaUPos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WqJF40Tmbbcu+C86lBB7op3aPDfPdDDNQHgJduS0lK7NV0+/M2mK5VtUKFsq1DlaY
         n2vKuezl/0GFAbDez20C6P+qIKNoogzhinJEn7/cFAK/8PPJMdyIhzIVSAuT7RdhII
         R4nGgHAha7ASK+jT6y9v54+fR5nJhOnvr7rLRKn0=
Date:   Fri, 18 Sep 2020 12:33:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Camel Guo <camelg@axis.com>
Cc:     Camel Guo <camel.guo@axis.com>, lgirdwood@gmail.com,
        tiwai@suse.com, dmurphy@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v4] ASoC: tlv320adcx140: Add support for configuring GPIO
 pin
Message-ID: <20200918113305.GF5703@sirena.org.uk>
References: <20200918073229.27348-1-camel.guo@axis.com>
 <20200918111823.GE5703@sirena.org.uk>
 <b5cc9041-62ea-d578-db28-c1ab8ec50842@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+jhVVhN62yS6hEJ8"
Content-Disposition: inline
In-Reply-To: <b5cc9041-62ea-d578-db28-c1ab8ec50842@axis.com>
X-Cookie: Beware of geeks bearing graft.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+jhVVhN62yS6hEJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 18, 2020 at 01:27:50PM +0200, Camel Guo wrote:
> On 9/18/20 1:18 PM, Mark Brown wrote:

> > This needs a DT bindings update for the new property (I thought there
> > was one in prior versions)?

> That patch for DT bindings has no change at all. Now I resent it anyway.

Any patch series you send should be self-contained, if some patches from
a previous version of the series are unchanged you should still resend
them.  Picking some patches out of different versions of a series makes
everything less clear and more error prone.

--+jhVVhN62yS6hEJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9kmvAACgkQJNaLcl1U
h9BZXAf5AWFad5ytUdPcfO1yq+1w7pPVigXPZmUPIlAbUtoJZj8aKGqd7s70o3sg
/kVqkaqO7VglpPveiJ5cI0KrJR/tyeWVgUxxJD6nrxoCpSy9Jkv/V/NKTd2TN8QP
AyMszQLMadRdzOqi7W96k93AuWrlIpU1ZmzW5Ud+RXrvHtSizBbuK/TtYSBsPOVP
7uqOPI+sUVRChPDVPflMa6XoaOvfRDdtUZibhVWhDWkaeathOpn6AnN+mJwKd9PP
jila+Bcx2NPVKmUMu4nVS9bWhkszwMRa1vSVCXfJa6fiBHI7LynKkrEaZIfNs+1Y
4LXZzgYnJv7ARd5iB4AnW5dJuJvTow==
=1OzC
-----END PGP SIGNATURE-----

--+jhVVhN62yS6hEJ8--
