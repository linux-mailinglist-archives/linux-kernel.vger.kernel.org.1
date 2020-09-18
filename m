Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DE026FB43
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgIRLTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:19:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgIRLTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:19:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BA3721D42;
        Fri, 18 Sep 2020 11:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600427954;
        bh=MsHAcHW7aH++paDGdWzrEb54PdjaLyqzMLktk5Kc1cU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=myX2BtAEzZUSkE8tvtPHDRXahOOD8k9Ubiolzed8AKc/hHGVuKVAsGjT/WNYJjgNZ
         9tT3n/BA9VOH3NnDLVwarGinaahFaCHdcG9fWKGuENAxsnyWwU+iwvQIfUjmIpzwp3
         LLQojBsHk5QMRst7AbU5sXHk3zNx7SPuJrsIV/IU=
Date:   Fri, 18 Sep 2020 12:18:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Camel Guo <camel.guo@axis.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, dmurphy@ti.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@axis.com, Camel Guo <camelg@axis.com>
Subject: Re: [PATCH v4] ASoC: tlv320adcx140: Add support for configuring GPIO
 pin
Message-ID: <20200918111823.GE5703@sirena.org.uk>
References: <20200918073229.27348-1-camel.guo@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Content-Disposition: inline
In-Reply-To: <20200918073229.27348-1-camel.guo@axis.com>
X-Cookie: Beware of geeks bearing graft.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2020 at 09:32:29AM +0200, Camel Guo wrote:
> From: Camel Guo <camelg@axis.com>
>=20
> Add support to configure the GPIO pin to the specific configuration.
> The GPIO pin can be configured as GPO, IRQ, SDOUT2, PDMCLK, MICBASE_EN,
> GPI, MCLK, SDIN, PDMDIN1, PDMDIN2, PDMDIN3 or PDMDIN4 and the output
> drive can be configured with various configuration.

This needs a DT bindings update for the new property (I thought there
was one in prior versions)?

--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9kl34ACgkQJNaLcl1U
h9Caawf9GXOYrnjVLp87TQZt8xe7Ma3EOFI2Tc7RfEd0fV9GhihVv06LXY61dCC9
vGoDaFvEJ5XJhiN0AXHz8qG7/LhTWP7oM/EWTP7c6SP3HPclcyBet8v4Dnisp1TJ
S41dZp6tDDTM8Cmm45Uk9M+9KBz61XDHnx+VlhPVrUZ/6ta+iUd2huMi2VH41chs
pwzjHmc4Pzle5Yu0SfydG4F0m8X+zsiWIEXiiuwDDP3K8Gj01oZLoVsSY1VUD0m3
DIzPdFyH+3PJrT+aKIfUcYDpVaWr2mx/48X2H6zIRtbgso+3fhocd8e9VAj2PdwN
JO5+gqFHeNjMWH7e5xYPs7y+YBgshw==
=CrlN
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--
