Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE45213D0A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 17:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgGCPzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 11:55:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgGCPzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 11:55:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B17420737;
        Fri,  3 Jul 2020 15:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593791751;
        bh=Fwb0iJ6mVcp04VHQWexbTvxsCiVNKg6ZNoMpsYLJboA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jOpysPRuDr3Z2qxjIAg0GOpIqxyWnWgUf0RMwvW1KzR2P5YGytArk+3MuuzkBzn7V
         K5GnEQbu7HtJyloD8PkOJblpECREXxZCqBOIKRKkoR5wO2Mss1R8FEZciWW1JP9LFI
         YIHC8WSRmM5QyPtfDyl3yqFeaNn4DbY2RqWt8Vjc=
Date:   Fri, 3 Jul 2020 16:55:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: fsl_asrc: Add an option to select internal
 ratio mode
Message-ID: <20200703155548.GA17656@sirena.org.uk>
References: <1593506876-14599-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <1593506876-14599-1-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Sin boldly.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 30, 2020 at 04:47:56PM +0800, Shengjiu Wang wrote:
> The ASRC not only supports ideal ratio mode, but also supports
> internal ratio mode.

This doesn't apply against current code, please check and resend.

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7/VQQACgkQJNaLcl1U
h9Ba6Qf+Pt9/pqEBOEoCDH8/qYlQD3h2YcW8V7LV+bs0lwfMFzHxLPRt7AEt8s33
2CXRTYZvxM4yEcF39OVz1tcKlhk9xzxMhI9OeVspxsaGmImHDDWpwBeIJLze+Tj2
xiUVftkSpVsWvgbDzG+l6CraB0KEmH7T7/t9/OEbetNyc6r/w9wkkQ32TGtvUPFY
PfP4CL5O3K0LpRPyF60C7pMGALCa/ktqrfRVN+6h8M0HQ7/JNejLc302JqjvGCAO
0jACiNqj5u8/3UgMCB+r7iUPNkjDxwheTQw3Y+PWMisQbtcnVq5Qyn5jVoJXLRjk
MzyJtIbWTBUnEVoWiifcNPVUerGMvw==
=vKxS
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
