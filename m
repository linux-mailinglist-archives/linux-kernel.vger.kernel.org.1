Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C1A2FBF85
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbhASSxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:53:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729307AbhASS2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:28:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2DFA23138;
        Tue, 19 Jan 2021 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611073229;
        bh=64AjEifXMNBvzlHCnURQuhMqMBw4Vwtflqm/WmV7xqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lQnKmZmHTzUoU3y0IQQczbLSgD41b/i4VaQAl0Q7EADTORfEpLNVAAZnJlK5XXbGJ
         5ZytsC9pjcsoeQC4WbX9PjjXgcHx2DBnt6zE4xXwEk8GWrukCpcMPLlVw02ljRfGaz
         cM8uoD0qwGAfr1TOs8Vnf7sdHi2cWruKJTM6ZKPaFI5kjmve+9wIQl498QeB0C0Di0
         xs/+QdGyxtLIbVppucqHdqZXEmcWXvLf3A/aVhqj2QiA1pLoV+x4BCbS5b5NCb3NDT
         qPcDxw9WD1qWYghoUeT5OdMGXfRCZwn4PumH6KZAI7GloHNN4Su2lWD7wYsXcwNcUr
         amSST/on2GxTQ==
Date:   Tue, 19 Jan 2021 16:19:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 19/21] regulator: hi6421v600-regulator: move it from
 staging
Message-ID: <20210119161950.GC4478@sirena.org.uk>
References: <cover.1611072387.git.mchehab+huawei@kernel.org>
 <8000252dfd10677c5eb52d498e68de9c65304cf4.1611072387.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Content-Disposition: inline
In-Reply-To: <8000252dfd10677c5eb52d498e68de9c65304cf4.1611072387.git.mchehab+huawei@kernel.org>
X-Cookie: Yow!  Am I in Milwaukee?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 19, 2021 at 05:10:45PM +0100, Mauro Carvalho Chehab wrote:

> +static int hi6421_spmi_regulator_get_voltage_sel(struct regulator_dev *rdev)
> +{

> +static int hi6421_spmi_regulator_set_voltage_sel(struct regulator_dev *rdev,
> +						 unsigned int selector)

Now that the driver has been converted to regmap these are just
duplicates of the regmap helpers.  You may also be able to use them for
the disable() and is_enabled() operations, I didn't confirm that that's
OK with the device using multi-bit enable controls for some reason IIRC.

--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAHBqUACgkQJNaLcl1U
h9D3Owf/cbGWiEnDSCjUCkOceFn1nPslHI9p0GCP6typnAUlLJ5ncPcclNGCVhiE
dO8v80ZBl17ZHecxXkObmnjtpTMM0m12onuk+Ack8o/5r+MM8kdl3funGXhgASzc
Ep7bY17fo4a2xUb6l3/usDfK/FTmKXuyKc3ac2Jj1efxgjbMR3qAIBEBvPOyMQRn
UioGpSk2fCnM3Rth6Ds+0Ao5IKHiHQaek5cxcypOpRmjUOCqBZ4Zg3qXMEXgIM4a
OlN3PQFPRG2SfdZgPwUpGJ1VuvVP2PC3PkTTvntwMu08N0m4QFjy/laEfvREc0Nv
U4+mfeyAsATetiwCfC0CPaWqgCF+9w==
=gGRY
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--
