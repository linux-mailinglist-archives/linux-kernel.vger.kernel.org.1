Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3835278EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgIYQmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbgIYQmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:42:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB53A2075F;
        Fri, 25 Sep 2020 16:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601052144;
        bh=c2rgj1TrFsx3rd7S+ls7DxSAVWsEziKWugveJnbh7kQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nefj7iINudouOnBVczHq0yRaRFAX3LLVlPa9t1Dh3TEwpgDSCalLiOGeQADo7qjQL
         HZNAxK6TRR8mZtf4CaynVgxNpRebRR0dMp7FLvAKRYzgQuFC+EBjCPqvWIJII3T0SV
         8p9EtjNCfIHQ9iGeluJREcYmSk89R0R8yE0I7Vl4=
Date:   Fri, 25 Sep 2020 17:41:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     robh+dt@kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 2/3] ASoC: cs4234: Add support for Cirrus Logic CS4234
 codec
Message-ID: <20200925164129.GG4841@sirena.org.uk>
References: <20200925105908.20640-1-rf@opensource.cirrus.com>
 <20200925105908.20640-2-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LiQwW4YX+w4axhAx"
Content-Disposition: inline
In-Reply-To: <20200925105908.20640-2-rf@opensource.cirrus.com>
X-Cookie: Onward through the fog.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LiQwW4YX+w4axhAx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2020 at 11:59:07AM +0100, Richard Fitzgerald wrote:

This looks very good, a couple of small nits below which should be easy
to address:

> @@ -282,7 +283,6 @@ config SND_SOC_ALL_CODECS
>  	  uses them is also built since they are only usable with a machine
>  	  driver.  Selecting this option will allow these drivers to be built
>  	  without an explicit machine driver for test and development purposes.
> -
>  	  Support for the bus types used to access the codecs to be built must
>  	  be selected separately.
> =20

Unrelated whitespace change.

> +static int cs4234_i2c_remove(struct i2c_client *i2c_client)
> +{
> +	struct cs4234 *cs4234 =3D i2c_get_clientdata(i2c_client);
> +
> +	pm_runtime_disable(&i2c_client->dev);
> +	cs4234_shutdown(cs4234);

You used devm_snd_soc_register_component() which means that you won't
unregister utill after this force powered down the device which isn't
great - you should use snd_soc_register_component() and manually
unregister here before force powering the device down.

--LiQwW4YX+w4axhAx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9uHbgACgkQJNaLcl1U
h9BwAgf/cvrCRNPtVmQZoCMjhnRTU3sG6jDhpuGmfUrnOdGyu8jSiZLkPqX/tWRI
BXpR19icljIVCFyLzA/Y1W77ry9U8oGrywn6hVNLxp6cYntlPzTNiY+ZXHhZTv2i
SNYxq6g1Bx3CRIg42QPO79PRQ6rxZgiuuXPieN1+m4mfdCTDdgYt9hhhMyYLpkDu
9oAXiUlcvyWmVyPmlwq3MebWms77Mo7/9qH6TruQXZDXGAnAH7UcMdxrejFF481i
6Cv9Ym39lubA20QU0w/AALqPvIxHyvme2ERSxXWBpTnYkotdC5X3dd2K1ewKwQ/+
H8J6WqhPI3hSArB0Xr7yTMtdqpRYvA==
=j4b0
-----END PGP SIGNATURE-----

--LiQwW4YX+w4axhAx--
