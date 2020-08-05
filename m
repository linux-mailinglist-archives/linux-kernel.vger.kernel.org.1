Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7B123D2B7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 22:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgHEUPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 16:15:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgHEQUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:20:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C74F023406;
        Wed,  5 Aug 2020 16:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596643844;
        bh=WhoFOPfHGPgdx+utmWK9QI3Z+xfTMsThhvg3J1Yw9nw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wdwG1V09WOdsUE6fUOwmBTm3Ztbthxnyna80LJ2nU8oSYmnnsN9HK53ujcyTUdZIP
         UpHFogpal+vQnnVRVSjD0cAGqjZwUEIdvKqS1sYm5+Ccp/rbrrnVYjXW9Bt/hyvZID
         DI11Jnc5yLbZxUHesh6tfBZiYksW3oeg8WSocMyI=
Date:   Wed, 5 Aug 2020 17:10:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     lee.jones@linaro.org, matthias.bgg@gmail.com, rafael@kernel.org,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH 9/9] mfd: mt6360: Merge different sub-devices I2C
 read/write
Message-ID: <20200805161021.GK5556@sirena.org.uk>
References: <1596558782-3415-1-git-send-email-gene.chen.richtek@gmail.com>
 <1596558782-3415-11-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AYsPlKobQGgtCvjI"
Content-Disposition: inline
In-Reply-To: <1596558782-3415-11-git-send-email-gene.chen.richtek@gmail.com>
X-Cookie: Fast, cheap, good: pick two.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AYsPlKobQGgtCvjI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2020 at 12:33:02AM +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
>=20
> Remove unuse register definition.
> Merge different sub-devices I2C read/write functions into one Regmap,
> because PMIC and LDO part need CRC bits for access protection.

It's not clear why this isn't just done in the device regmap, there's
exactly one user?

--AYsPlKobQGgtCvjI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8q2ewACgkQJNaLcl1U
h9BJaQf/e0Lbk/kx2bARen+5ThM7i3n9dmDuHvJ9CvSxiUMx6Hru/VTrxy326CeC
1z7UW97+Jia1/NXuz8Er/QmM2b7d9Fj02CYyVnlD0tbGBmrACsvfDzQaZ0hVVgff
pAn0CcJkqK5W264AMpUYoVcJ6Og8TeUxYSQb+xRCzFDdddddQBwn2w9Y8/bO/onm
MC4uxD/rt46rStAwYxri7jd0YInN328wK0MrE7okiQuWXDtybDf4ud2Xdoi/BJ6w
FqmJaKZBSn4MMg6Ese7xewyegU0WcntH9qg08weIh8REtS/Uad0eOfyNnTk1n+Ah
99pBqYSA/cmvSTGHS48yUtSODT34Qg==
=MD5u
-----END PGP SIGNATURE-----

--AYsPlKobQGgtCvjI--
