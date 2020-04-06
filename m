Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7BA19F434
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 13:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgDFLMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 07:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgDFLMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:12:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 711A9206F8;
        Mon,  6 Apr 2020 11:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586171571;
        bh=MtJm1ZXy274Rt4S8/t5pgen0tFyzkY5ae3KXw6x6In4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lNHthtXXVAZNLmOMZ96NGSDiYyfoZhPYjEMJKtUifhay6eh9SXGgyIehffxgM+sxh
         B8Rs4JGbzAnLTxPe1UErYuV9SemkVmkobtrBLQ96RC1+maODilYaeozsPW6/X7gyCb
         dJrTUI2RhDh+0wHqRGtnSahzuWKdo2K5t+GZz32U=
Date:   Mon, 6 Apr 2020 12:12:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: Re: [PATCH] ASoC: qcom: common: Silence EPROBE_DEFER messages
Message-ID: <20200406111248.GB6837@sirena.org.uk>
References: <20200406003656.2383978-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <20200406003656.2383978-1-bjorn.andersson@linaro.org>
X-Cookie: Serfs up!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 05, 2020 at 05:36:56PM -0700, Bjorn Andersson wrote:
> The Qualcomm sound card typically depends on several other drivers,
> resulting in plenty of noise in the kernel log due to probe deferral.
> Silence these errors.

This then means that if something is missing a depdenceny it becomes
impossible to tell what the problem is from the logs.  Please at most
reduce these to a dev_dbg().

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6LDq8ACgkQJNaLcl1U
h9AnqAf/WP5/shM+o0NVDoSTzFDUIwsFx0+zD0HAUSjwRszIvxR7LzYmyk4crsOI
izVV3xQVPYb1Ra+nGtGTEdJbU5UqJ5H7GDAHFCE0D4/eb2VP8qPCWYv+GWt9ipZz
lopYieoo8ws+7qnd6l/DMfSjj2Ik7eSsIPUMmL4YOiUACTF1ypqtAzG0NF5bs0pR
jtgllpDgeOwJwHKel+Lz7edKrHxqaQtPk5LdlxOqGbQU4Mm3isGP6oRAROn0p+iG
P08qGMACi1nUfCe31/lym4z0bTOd9QCy7OXe/oIqJ2DvLdnZ/ASbRweGUWSbnxBU
JljNw+dvdosofc2QP/WFVlg2jC9p+w==
=gEl1
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
