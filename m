Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFDF265E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 12:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgIKKlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 06:41:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgIKKl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 06:41:29 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 042FB208FE;
        Fri, 11 Sep 2020 10:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599820889;
        bh=o4iT0OGz+KU6cUzw5o+rXotFzwfpp2zNezX1E5M8nVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0KbcUO5TxttHkb5NcOnbxmLKEXh0D2bj5JDgMIVW/rXr+naF82XnhFlm6jtCg9ieg
         crAUbKofM8zbTHFvZyVHSiRv99A3yUBWOFejSE6jDZmBlFAs38y6/RfKta73E0lFar
         uGTxSzljHXm4vTP5SB9qNataW9byEDRgrTi6Busw=
Date:   Fri, 11 Sep 2020 11:40:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: ak4458: Add DSD support for ak4458 and ak4497
Message-ID: <20200911104042.GC4895@sirena.org.uk>
References: <20200911083048.29055-1-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
In-Reply-To: <20200911083048.29055-1-shengjiu.wang@nxp.com>
X-Cookie: Only God can make random selections.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 11, 2020 at 04:30:48PM +0800, Shengjiu Wang wrote:

> Add a new kcontrol for ak4497 codec for ak4497 has a specific
> pin selection.

What exactly is this pin selection about - is it something that will
change at runtime or should it be configured by the board in the DT?

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9bVCoACgkQJNaLcl1U
h9AnuAf/Wo+SWWpKso1LHcylf5Ds4Qlw8dHZhBAgb7IOBySG5m5Ls1ivvqhfrryx
+wr844cdInVpsnQcdBIc1LDnAO0t7T6dtTuvgzhI2FalnR+1hjtYJorai6J4J34D
O3fD6fzsJmjbtE9yeh2/kntEMYeqXTW01g5/knxSkrqPJbhG2U5V7U9UtUJU42hX
fQjdMWZfeOwB4pzr8IPmW7l1wcqX849+HYDM64K2JMl6pPyIS/r/wEgWq2O/juNi
IX95paqCHhA4JGl8bAv6ORr0zV/ozW92rjEbvq0VDiUdlhmLUOpPk+61ikYUtK9Z
WnWuiL+qOHpylWp9mNbsHik5i8WuFg==
=Fsq/
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
