Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E62C26E01C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 17:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgIQP5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 11:57:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbgIQPuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:50:55 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE91022208;
        Thu, 17 Sep 2020 15:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600357161;
        bh=foIc7Z858N2p4XZA330YvH1DcfvYDxEcLkBk7zkfsCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=APBHbryybIPEnTDquUs9mdmt/sgejwNywahLxDGrCmjMdcrkA39jjU82n5w1c+Vyq
         xlJ63C8Ct/yMGxOgqqrLjhY7KinvOqat6u7G0hBgQi91bTa+uI4XgyQfzw892sSjjw
         ZZk4z7NyHBMB+SBw6zxJ4ZwbMgsQ00viF9tRu8tE=
Date:   Thu, 17 Sep 2020 16:38:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Camel Guo <camel.guo@axis.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, dmurphy@ti.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, kernel@axis.com,
        linux-kernel@vger.kernel.org, Camel Guo <camelg@axis.com>
Subject: Re: [PATCH v3 2/2] ASoC: tlv320adcx140: Add support for configuring
 GPIO pin
Message-ID: <20200917153831.GA18737@sirena.org.uk>
References: <20200916075949.28479-1-camel.guo@axis.com>
 <20200916075949.28479-2-camel.guo@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20200916075949.28479-2-camel.guo@axis.com>
X-Cookie: Is death legally binding?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 09:59:49AM +0200, Camel Guo wrote:
> From: Camel Guo <camelg@axis.com>
>=20
> Add support to configure the GPIO pin to the specific configuration.
> The GPIO pin can be configured as GPO, IRQ, SDOUT2, PDMCLK, MICBASE_EN,
> GPI, MCLK, SDIN, PDMDIN1, PDMDIN2, PDMDIN3 or PDMDIN4 and the output
> drive can be configured with various configuration.

This doesn't apply against current code, please check and resend.

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9jgvYACgkQJNaLcl1U
h9AyLwf9EH7X0DHtsQ7448LbugWVzhYsAZhE7+gdgpJHOOyKf2f6t7uhAgl6ed6u
o+rFZVGSrUzOZu2cmttfGl57bhRLmqQkClvQERhBghtlRPWOUezGXBUwUSGqat+W
UrTjwI2iewYY0dsJ45lFCYzYkcy0JaIfGLUSDSF5gWBXmN+76jFYGg2n3J4rCdUD
COUOOoyek00/nwyKAa/4K+HxAu94OgdvMWJ4dStWFfr7Fqkb2GD8nlDSW2jDo/W7
ixvN7qlrPNptfcpcQ39EczEAWEyAGKLs3usR3xoyGCea3hP8wrqxy8C2OwwAEYJt
WjgKpgEky87IzA6wUfyJsQF9ev+OOA==
=eqoB
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
