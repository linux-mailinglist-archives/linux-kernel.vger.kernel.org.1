Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27881BE06C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 16:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgD2OOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 10:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgD2OOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:14:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D77BE206B8;
        Wed, 29 Apr 2020 14:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588169690;
        bh=43u72/t/ee5ojO4oVLnLby9cPaSn1J3/cJbGM3NvKqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q/DOOSTbPKc+xKJLH+AfDJ9GyvLsoxLf4W6Jh5vUtR2dTsdFlyiiyHaTTW5M4I3Md
         7K9pEv5tgIEftLbJ7Mv7ISf68HCuyKQWOewny9CHLhftj2OT2aG9GFwjcAJnljkrWw
         86L3hTwWlwWuHU7sQrn2k7Fq5hB2tRfxGeej34a8=
Date:   Wed, 29 Apr 2020 15:14:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_easrc: Check NULL pinter before dereference
Message-ID: <20200429141447.GA7115@sirena.org.uk>
References: <1587731404-29750-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <1587731404-29750-1-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Colors may fade in time.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 24, 2020 at 08:30:04PM +0800, Shengjiu Wang wrote:
> The patch 955ac624058f: "ASoC: fsl_easrc: Add EASRC ASoC CPU DAI
> drivers" from Apr 16, 2020, leads to the following Smatch complaint:

This doesn't apply against current code, please check and resend.

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6pi9cACgkQJNaLcl1U
h9ABhgf/Uk314RG7VeGN0KlDEV4ZB3mUNgKCSP9bX8M2Qvz69PM7MUKLD3rRJf0m
vlTonmGIhCOWSdlO2wv3hGVZpvGBVGEZqVAvhNjR6FhYKGkxwRtorX2ST1YVJtOQ
EwhPHr8mLG9PEpgqKI6AP04IWYb4oMjSnBENXghM5OsN8yo6kcTXGKmghbArxlIN
KXafD8ZgEy+U2roducwWjOZeSfIj9agN5F+so91mH883uymDWGAiWQ/g4AkxdJRx
Qdl0xw10BAwSKTZ+Nc2aJTHEs+ZzCLfxq+d4X7aGSJ4wBk/7ZdtmGsw+yxxFux/L
9HFw4EnfuD5Imx5whPbJd6WJ7yIkzg==
=X07d
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
