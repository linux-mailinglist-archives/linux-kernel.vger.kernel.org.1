Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BF21B0911
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 14:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgDTMPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 08:15:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgDTMPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:15:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FB68206F4;
        Mon, 20 Apr 2020 12:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587384945;
        bh=KAzqVOiBIS81KFOL/ZJs57J/pOhM6Nz0EdO47rpBahQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OVUZ0vT+MNyDotB/kUL/W1MHKii0VS0DFhwEdJP7CHIsDu0nylLuynDiVl0iiwoEh
         cHbidcQkS2iffAT+AwZoAp6T87FYHO8WISJi1GWOuDjbYy3Yt2etqfMVgx3tOIAZ7A
         VUXIId2MSpkDjtMF3oZHnoLkBlWI79V1qjGjWQSY=
Date:   Mon, 20 Apr 2020 13:15:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: sound: add Microsemi ZL38060 binding
Message-ID: <20200420121542.GB6507@sirena.org.uk>
References: <20200417221341.31428-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <20200417221341.31428-1-TheSven73@gmail.com>
X-Cookie: Can you MAIL a BEAN CAKE?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 17, 2020 at 06:13:40PM -0400, Sven Van Asbroeck wrote:

> +maintainers:
> +  - Jaroslav Kysela <perex@perex.cz>
> +  - Takashi Iwai <tiwai@suse.com>

This is supposed to be people maintianing this specific binding, not the
subsystem.

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6dkm0ACgkQJNaLcl1U
h9AdMAf8DV+bgCiPRbrXjlrtlD8glMuBmPvbGRJ0CEppUWue177NY94iTrmvkN4X
uFP01XKCX0l4HavAVFxf4ODnSGuwmQBuyEQKYF+DMqRexq0CZlOM3Z8BH11kJTnj
PZJoAXRziDJ1kEGBFttHLJRMyBCCKHRpTj0kq8WS5kh1OKCka/XXqKrPmm1m1nbM
xFRR6Efn4Ksensm5ddQSNNMjcdbjkXfmVSRtJAqNk94cogGULnKFqxUs4ca87aYp
P7h4YRWpNFXjDXV7FAssqSjcqksfpp8IMuD1uxwrnCM02P3L8Fz6Etucs8WdHjws
JQuDggV5UbMJzC1QNOCg2O1y6S4lKA==
=VMQX
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
