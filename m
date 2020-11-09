Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355292AC1DB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbgKIRJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:09:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:32808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730208AbgKIRJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:09:37 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8128A216C4;
        Mon,  9 Nov 2020 17:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604941777;
        bh=jZGDyUOUHmw3l8ExwgsjkrQToJuUWt5nfwOgw9+3AF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6l876Kd/GZdNqWlf6aP9aaBromRqacslQ/JvqihgLLQuyQLLfgsBs8zJrbI97FJW
         jhTuydss4LZJEb8I0gyYX2zJ1W907XWbq4qgt99G8cnEIREgUVcrVacR9KNjQc5VoW
         aFNa04YqyXho4esJPj8rD3HVk3Ga74ZyT+y8et+s=
Date:   Mon, 9 Nov 2020 17:09:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, kernel@axis.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: regulator: da9121: Use additionalProperties
Message-ID: <20201109170923.GI6380@sirena.org.uk>
References: <20201109085438.16230-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YrQNB5Deg1WGKZi3"
Content-Disposition: inline
In-Reply-To: <20201109085438.16230-1-vincent.whitchurch@axis.com>
X-Cookie: This fortune is false.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YrQNB5Deg1WGKZi3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 09, 2020 at 09:54:37AM +0100, Vincent Whitchurch wrote:
> There's no $ref at the top level so use additionalProperties instead of
> unevaluatedProperties.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--YrQNB5Deg1WGKZi3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+pd8IACgkQJNaLcl1U
h9DMPQf/YPnpnHwXAcWUZXBQMLLFsZ+62tiKUc5AZZpQ+BqSweH5UqMoSj4ENiOS
fWE1FWu5k/FrztxE6UR18A7G4Oo/jM4vNI6n+ztRmS8jwNkMNFChGxEoG8PpBSQg
hVXHhU1Z2FHFeiHx6dJTSi7iGkerA2Ae0pqDj0X92/r6Aig2ZcryKrXsiOq/EMXE
XQdkT06iJcZXtNfedd35ygWvvKqdHusDjmPejuSVJNarUMsqh3NA2ax4eWyvoYHl
CXgtQwO3qoqQL+ngzAOVEfgHh22oiMtMAj72usi/sBGRzpbhM+wIRSjGyEGU/nmT
wzunRUdh+peLTtBkBAU5He9xXczIbA==
=je81
-----END PGP SIGNATURE-----

--YrQNB5Deg1WGKZi3--
