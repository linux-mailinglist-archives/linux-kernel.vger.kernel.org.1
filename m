Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFC42F46B5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbhAMImZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:42:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:41406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbhAMImY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:42:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9B6320719;
        Wed, 13 Jan 2021 08:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610527303;
        bh=UBeEHhwjMpwzR8qlGgYmu/wtrE8922DVkLRWwf8BFBs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=q0F7p1MGDgVvK6VWJZdT4LYYAyH6r3/82yBp1wXxsedktWDP7ZMQo6UqW68Smu1AV
         PRDsrtxja1L+Vb/aZq8pm72UUPA6A2F7jOeuP6N9l/2G9BTq4EZ4BpkLEp7g8hY8TQ
         3P2m8zS2YXJh5BGOLZGTehICK+22Y0gRlKILZ7VgNk27t+AV01FXcg11HvBweKWoxj
         uvtG3UVxuIGnSXAnmt6OZvaSlIjjWgShbjxf51A+g+W0lIAuU3D07we7I83lI7avSv
         unW+OnDkSNUEGcjxClk6L/Y1ZJ4cSG+OVIkNwkblslWiukkFnj9HbbiCc4TML8wzXG
         ymg/oo/oNnVdw==
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
Subject: Re: [PATCH RESEND v4 02/11] usb: gadget: bdc: remove
 bdc_ep_set_halt() declaration
In-Reply-To: <1610505748-30616-2-git-send-email-chunfeng.yun@mediatek.com>
References: <1610505748-30616-1-git-send-email-chunfeng.yun@mediatek.com>
 <1610505748-30616-2-git-send-email-chunfeng.yun@mediatek.com>
Date:   Wed, 13 Jan 2021 10:41:35 +0200
Message-ID: <87mtxd44ao.fsf@kernel.org>
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

> No definition for bdc_ep_set_halt(), so remove it.
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

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl/+sj8RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQYMchAAjJXRHz+hDcN8OKrC5mKHu4MzFsCCvMC5
Hm2JbtVgh3iQyGjTQvxJh+AW9vTxeBv1UNhhSmjZHkvhk/L5pmf5ZNbout9qOa8C
Dh283lheX1/qi8AwwUE12k27KkBeXSKHO6hS/ycsnYWJsMEd55bhN0U3KpKmCPPr
UL8hRWcPNZL+O9auzcfHJjJxIqf4Hmgx3X8/7K+i+Qu8wkylQQ8bK83yxixHlrRH
bqhZf51X7qvigqCfhriIoMaobK7+/VTHfDXkeO2dbVsVbz7/vCLudvGB3nnq9Ubu
4t5f6pt+dnebBIsWpqsvGpZeJcMWPYQ3RTbzLDjfWkRtDKi66eQQWR5nc1P05in3
CCx2t/t3cpqOx4T65mfQF6M2NMr5mifKCARfITLC+mpyaN+oovVtwIdTZwOj2pqG
2oOAGqt4bXJwY//WAfsz6JaYOs6SiW7/BaH0x5HRP0AMZRowd9ajMbs9pPCih+o1
k/xIGWacB5msXnxrJJC5CSOOEWfGhlD9YFkzkRpPmW33BylgLQesitiUNuQf9QxY
4mq8+yGTXSBBon3kvF5cNjEDeQ7BtWNIWIjQR9f7Iul+GD0PEl0deUmA4QU0oWhy
o0pOhbT1LtPFEkjCgkbWPk1FUyq0RxKU/gUFFGIo9zPHgFOmPZKQZpUy3kuuwIwy
VPfL0dfWLsI=
=+7SS
-----END PGP SIGNATURE-----
--=-=-=--
