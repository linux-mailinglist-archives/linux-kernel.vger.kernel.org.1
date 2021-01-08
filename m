Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E642EF289
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbhAHM2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:28:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbhAHM2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:28:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 990FD239EB;
        Fri,  8 Jan 2021 12:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610108878;
        bh=7Xo7mSbLPZgJ0KB4zSspcHTOUBO4KZLNffBMqGNo2/8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jKI8wGewQbd7KOMctKJswhxv+ll820IcTzmFrqTn4wwm+LeD/nLU/7XvHnEngK+bv
         XBnt0OtSDsKF3CxgbJAxVbqn2sEj5cC9kaTQ/jA8ZB19HHZUPyyp28qwt5FYRM60sr
         Xd6tY1I69xXo2dUktyGPQOyekwxe2/ZT4elRTt6T8KL4n5BSMkPIar7dGqXR63cp9r
         nJSMNjLqEKE3NeEpTabZuC2Nf33xeaiYEK2mSzawC7zKTD1NawrwZkf0QgrnyiOPPB
         CW3qEaq6lpkfg2S39UFpSNsKLmI3bucFDCrmSdZH5n91da+rDGJUa2aD9mFwXk+vd3
         E/kV0ruKuF1Wg==
From:   Felipe Balbi <balbi@kernel.org>
To:     Yejune Deng <yejune.deng@gmail.com>, gregkh@linuxfoundation.org,
        p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        yejune.deng@gmail.com
Subject: Re: [PATCH] usb: dwc3: core: Replace devm_reset_control_array_get()
In-Reply-To: <1604375863-6649-1-git-send-email-yejune.deng@gmail.com>
References: <1604375863-6649-1-git-send-email-yejune.deng@gmail.com>
Date:   Fri, 08 Jan 2021 14:27:50 +0200
Message-ID: <878s93wr3t.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Yejune Deng <yejune.deng@gmail.com> writes:

> devm_reset_control_array_get_optional_shared() looks more readable
>
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl/4T8cRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQZLfg/+OBXk3NrhzwjQIr6AI6W3nD8PBgpk4cFs
yjIB72TCEe4w1DuzQxt8C4f+JUoJ8U8BVgixQoDyKRK1DYkWhc3R+Pn111hPZXST
jlOtG4+L+d/l2wlevV4fzQLtAA1gWWvvdLPgl5hoBYAcbeQDLPclMFdNkSt0S/Xi
tglYtwpxWTM/7X4VxAhvI9w9A9v7gxZB+l/UTxeAxI6vUsrVaytiZGVrHS7zGRkt
DgEkFWelROeN9BisRByZUe8Fzb4t67rBuy80ai1oBqKubWy9SxRE3JnUoqD54+3a
UgHBQEK5+VtoZaf0Tul6knixErYT696y7IL2TxryYZGaVjByqWfvo4hSr8qaC8O+
M3eLpYSJz2S3A4ecX6ojEZuy5LAHn8pISbrOkIMcw0lNO9UkOrsWdP0EZS3swmZk
KVkDq9i8yj9Y/MRLok/vjv78gjzbL9itawgnH8sHBhnpfrzt0QHjYjLcyDl84fKU
WO2JpZa2K/Xc/N3quvwJnO4br8h4Uv9VMp2SeD5BhUTH/MPPbZEE09AxUurgKHW8
zXH6mWQqZs5SRjYqjameA2G7VCknRb6NtoYQoH7qtBE8VaDIWtBoDNNmF8YnWzKI
ico44s3g6SlN4vcvSlLS7mBFx04HYoDXyiwxreaiHaN7DAZMrjJEIImj3dczl6L3
7sjmIdFiL4s=
=25Oe
-----END PGP SIGNATURE-----
--=-=-=--
