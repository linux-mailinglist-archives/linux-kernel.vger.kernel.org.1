Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB9D2F46B0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbhAMIli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:41:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbhAMIlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:41:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A37C920719;
        Wed, 13 Jan 2021 08:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610527257;
        bh=dTsZF39Nf+fdYEmRGhq+1JcvfbZkxUZaN7AXNb0cDq8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BUMPVgEIMWDBzxMgixEtxCeyXcF8mm07/unBODK4XWYvCjkwC+6sLX7eyVMqubxtu
         YIz+gT+mTIIFvHBCpW64FyoHvm74b5k5UTh8igGAASfXRGQB4GfKFOMG/fSoecZ+zc
         HIObSvnuv4n+juU+2JeiYkiRqeXLPz5K5etgBi1ONq/2G0PHJoDlT28u0U6k0xdTQq
         BJbfupr6BfIhwmXsep5T3XhLuPxQcOUPtm7T3/4k4fYOQPXXACgjaRu+E5ePsMSja+
         ZFr6lAG3W/nR7n5iwuE+dOVGPhMqJrGLKjIHFu86Wb0vo0wOvKdw8yW+HE9NBSOG6z
         /0zhW1/GJtxSQ==
From:   Felipe Balbi <balbi@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: [PATCH RESEND v4 01/11] usb: gadget: bdc: fix improper SPDX
 comment style for header file
In-Reply-To: <1610505748-30616-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1610505748-30616-1-git-send-email-chunfeng.yun@mediatek.com>
Date:   Wed, 13 Jan 2021 10:40:48 +0200
Message-ID: <87pn2944bz.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Chunfeng Yun <chunfeng.yun@mediatek.com> writes:

> For C header files Documentation/process/license-rules.rst
> mandates C-like comments (opposed to C source files where
> C++ style should be used).
>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl/+shARHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQavuBAAg30ZpKD5auMw0mLPTT1xg4DL63rJ4KVr
CW8ln8OQVGoj6mXYlJmALMw0UPGGYMT5RPzL7Cnu8NTl5Ft8UH9rAjmO1kTM1fN/
RxZXmbuei4n08W0BvkLCIaPk8aBjYHCh853ckseV1yPk1v2ihRga9FVKa67ZbNBd
OyuYlxjflMdZ1ZAcB1Sda1FQI7sIw2VPxti6NAC/g0jYME6GrQQGyEdo2T7PnKup
tEl9d2geaIGbgC87du+S9ojB/lqhFoasecZj/p62OF7UMYohyEfwr9H4GSSko6kg
pWf5DHf8PSFTiH/vWzCiNRIVRSZ3VRbXDp6osacPPEZ2vUAhScI17MZw0r1zFDrS
xWZn8y1Kzkty5UKOt9S1p/cfsluub+wUIE4pYtik47Swb4iPbpusDKfAMN75QQ/K
4uiILFoALlZqavJsBpXF0bhct91iG/JvoSiqUpy6TsXHnwTcHy7uTSgh9o6rE5FE
cQvVARSkGS8GEiDH2mnOutrcCdKKwee2/yk5uYRW/2SsMC5/Wd6mxxzX62Vjx2UM
l76HxnweYziy1OvT4sDgz3aHd6B0Wk7jyx5gBWVACmwC+QjvP9Woww5wqGlV4iXI
cARf1BgOXH1v0Hk0bzLjasE9GYpolu8fqlKMQtKYGG7IKM9XUDUk0OUbC0HaGAfV
rToxNkIfQNA=
=QIEo
-----END PGP SIGNATURE-----
--=-=-=--
