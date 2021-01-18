Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7422FA055
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391864AbhARMtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:49:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:53236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404249AbhARMnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:43:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D1BA2231F;
        Mon, 18 Jan 2021 12:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610973771;
        bh=eaO5XiWMd2o14D/KT45xtToniuCAGvBrM87TlDONKNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SMe0QLuu6ftBARof6wxbM6LchfytEAZBkTqH27ssk9YgvHi86PScWYeywA6tPXdBP
         +JOP5VTLibPqIwEoEEyIgJLe4vLPG3T7/Q34rs2RIox4aB9+0lKMdZzS2R/tf/WOoB
         bpIvjSbVqWMZQznQPFUQQwamR7+PPA5fcFUe5hDinVr+loxocdLz/PMPHVj8Gl2Ern
         AtysbYjs8oN1/NrQW5yIORcbzJBjxyknQqYpLShDWy2tCNU0aEzjHpPyCWWwwBhss/
         p/mNOIA37XMpvh4zxe2d5GM5NOROHx3W9Pnsv35JQGlbPX4hMEN/KNXVWHEI5NJNDK
         JXgw/RtL2nHPw==
Date:   Mon, 18 Jan 2021 12:42:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH 3/6] devicetree/bindings: Initial commit of
 silergy,sy7636a-regulator.yaml
Message-ID: <20210118124213.GA10975@sirena.org.uk>
References: <20210117042539.1609-1-alistair@alistair23.me>
 <20210117042539.1609-3-alistair@alistair23.me>
 <20210118123519.GF4455@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20210118123519.GF4455@sirena.org.uk>
X-Cookie: You are fairminded, just and loving.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 18, 2021 at 12:35:19PM +0000, Mark Brown wrote:
> On Sat, Jan 16, 2021 at 08:25:36PM -0800, Alistair Francis wrote:

> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sy7636a-regulator

> Compatible strings should be in the form vendor,device. =20

You should not have separate binding documents for MFD subfunctions that
don't have separate compatible strings in DT, include the documentation
for the properties used by those subfunctions in the main MFD binding
document.

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAFgiQACgkQJNaLcl1U
h9BwBAf/TLHdutsMfoOF57BhiiW20KH5yPC9rsTkGnPpkJv9NBsUlRTTyMt5/ZRw
/ZKIIwpACzKhoO41XC2XOe1yx6lyxn3G/Axs4bCkuNvjJvRXyfl0ZK2DXDfHWHKs
wzgsR12Qc+yNNdcZnzmt8CdJBEazyytcheX9PTZIQLQg0e8e3AcflO8Kfzdunek1
GY+bra+NgT5o9BCBW30uEON+vMtUWOkfWtWjFTqOp+wTGeWPRDvOkrCmlc0LlOj3
Yz3I8M+Xx78CEgVtE3T94RnVbEXjlldtDWXly+NHdFBn+4gZOpsmQ/v6D/Tuc5KV
BWZA7aByxN+AFSzpXHKb9Hg+WCnIZQ==
=GLRO
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
