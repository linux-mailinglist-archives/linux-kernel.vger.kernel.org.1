Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F40020F7C8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 16:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389197AbgF3O7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 10:59:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389189AbgF3O7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:59:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6841820675;
        Tue, 30 Jun 2020 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593529153;
        bh=No0jbfPqhTvoiKe+ouJqwtalNn8dLUQ7fW45cm50WlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q/cCD2ySzWpV61HZ4clTiGfLrsyF09YTfMDL2HIDWE0842QXOpRFo3IkTukABgkoW
         o4XDPpQ6nqg8KX6qmfaU/AGg4Lm+wLBr2YTU1cA/9r733tbj2tcakD/wGK3kXWf8Ww
         OKVCrDJcyCy19GvhH7pTJHx7G6Adt6iiPCGO+0vg=
Date:   Tue, 30 Jun 2020 15:59:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Juergen Borleis <jbe@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH] regmap: debugfs: really fix memory leak in
 regmap_debugfs_init()
Message-ID: <20200630145911.GK5272@sirena.org.uk>
References: <20200630100650.23052-1-jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+RZeZVNR8VILNfK"
Content-Disposition: inline
In-Reply-To: <20200630100650.23052-1-jbe@pengutronix.de>
X-Cookie: Walk softly and carry a megawatt laser.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+RZeZVNR8VILNfK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 30, 2020 at 12:06:50PM +0200, Juergen Borleis wrote:

>   unreferenced object 0xec548c80 (size 64):
>   comm "swapper/0", pid 1, jiffies 4294937356 (age 3385.690s)
>   hex dump (first 32 bytes):
>     64 75 6d 6d 79 2d 69 6f 6d 75 78 63 2d 67 70 72  dummy-iomuxc-gpr
>     40 32 30 65 30 30 30 30 00 7d cc fa 7c df bf 7d  @20e0000.}..|..}
>   backtrace:
>     [<703904e1>] __kmalloc_track_caller+0x1dc/0x43c
>     [<523053d0>] kvasprintf+0x64/0xd8
>     [<0d94bbe5>] kasprintf+0x38/0x5c

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

> For this specific i.MX device the regmap_debugfs_init() function is called
> twice for the same object:

> - first call: with name = "iomuxc-gpr@20e0000", but the underlying device
>   has no name yet. So, regmap_debugfs_init() allocates the string
>   "dummy-iomuxc-gpr@20e0000" into 'map->debugfs_name' (and this string is
>   the one 'kmemleak' reports in its output).

> - second call: with name = "gpr" and the underlying device now has the
>   name "20e0000.iomuxc". So, regmap_debugfs_init() again allocates
>   a string "20e0000.iomuxc-gpr" into 'map->debugfs_name'.

This sounds like an issue in and of itself - why are we initializing the
same regmap twice without first destroying it?

--x+RZeZVNR8VILNfK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl77Uz4ACgkQJNaLcl1U
h9CXOwgAhrUOF7f+iGWY5IKBDg1k2+D6dbhraw7i9AHekl6tVKgAzEZ5a471pWin
XenMdLXRTMUh49k1zVBNwCRVfYGUoVFlA90JmtslQvZhSG6PFzG664YU2wAyIOoJ
aKrTZsWiMORN/9VjtM5bJ933H2vUal9wtT+dfPMEfkDb2UDtpIEzF6bu+TJtmaJ9
pXrxyAdb6qgwiF0VnMIuVnT29FkJ0FW0lvuvRSYAffmFs96+Y3p8zQevQeGX5qRP
RKkELGtjesN+uYx/jUy4IavERQznC5hkMIObKovr87iushSUCbhUubfotiK9OwMI
AJCYatyr3rP0aRv41McP7MAHmg1bfQ==
=G9Fk
-----END PGP SIGNATURE-----

--x+RZeZVNR8VILNfK--
