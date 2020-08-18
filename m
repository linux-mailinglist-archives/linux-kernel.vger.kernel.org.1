Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE302484BE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 14:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgHRMau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 08:30:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbgHRMar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:30:47 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BDD72065D;
        Tue, 18 Aug 2020 12:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597753846;
        bh=eHNv9FdwsK7uVxIPYmdOittfWJ5rJzEkrVPozM1SQu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SKcxKtnJrC7cXoPgNbvfatsTcUqQhXRNKGPXtOc0RgH4w9KY00FBZqzp1j8kQ2QZw
         ZzBaqCkEH4QbKmE2zV4HIk0defjdZ64vYVLhewYYIeqY7p994IAwXa/3ppqOTMNNGd
         nMguyU5y+4CN7DYElJUpDnrUftjA7P8DWV1/7Uv4=
Date:   Tue, 18 Aug 2020 13:30:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v1 1/2] ASoC: rockchip-spdif: add description for
 rk3308
Message-ID: <20200818123015.GA5344@sirena.org.uk>
References: <20200815112437.6662-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <20200815112437.6662-1-jbx6244@gmail.com>
X-Cookie: Ma Bell is a mean mother!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2020 at 01:24:36PM +0200, Johan Jonker wrote:
> A test with the command below shows that the compatible string
>=20
> "rockchip,rk3308-spdif", "rockchip,rk3328-spdif"

This doesn't apply against current code, please check and resend.

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl87ydcACgkQJNaLcl1U
h9ATqAf+Kw1JpgjNUlPGU5ePMTxIX88Ulj71aDatZmH8W/yzzfj7Lq5d1Rd2SDTC
e7WeRvDuKmtoPbccucFH0aNFO3ev07yvSzgyQEzjlnvEIWiYO7RTxSQaqWfwGYJJ
NgJ22Gfro6WhWVyOE4Wj6SQ9lGk5AkdmBEIiExWBgudwa+m7rwnzY5zM3oaLWCnO
5zvlTV1yglKX5xuYjO38wOmmq2c1ZyWs8qriuXShJGQr9R96wZEvstrJlExGn/V/
gR5Y0HvcEnAkCGWj8vqoeeq+Ot8vwbIkF4LZoAJpKVSDW5NELwr6IX7aww6k9p7+
jsmCl584BsniWd/wfF6j7sQSETp0DA==
=ZzoW
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
