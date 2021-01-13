Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6440C2F46CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbhAMIpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:45:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbhAMIpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:45:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E7EB23340;
        Wed, 13 Jan 2021 08:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610527469;
        bh=IVVjQvmFYaDeWKCjGKkm010SywgHjiWycrGVB5N43Hs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GeXLCWPg+Jk0wZyWjZcM0F5D6Nb8js8LncWjSPOb2SQjH9wmaelXoP6pUfANW4Zfe
         mFenLli+pngIvuG72L/tW+/9I/3H1zEe6YZQXdU3wusD9gZ7Pk/FpLDDvf5GTA2Qxy
         zLzMSceLzKMIgKeDcJaSBWu7uCia+dXR6M+ZugJ+7qNoXUfDzth57/3VE9OeJo3Ah3
         ULER4mt/TpQXpJ1EsLB1M1IfmZEwttTG+mhl2XLtxUuIeFUV+/NvWQeJ2Od2+IPNuh
         G6TFiYqk3JoNX1Puz9ev2mEauZ+nopexAFZBv+bGjeshkArUAbe5OhlmkLk1vbz/yS
         4fl/CNnhE9u7A==
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
Subject: Re: [PATCH RESEND v4 07/11] usb: gadget: bdc: avoid precedence issues
In-Reply-To: <1610505748-30616-7-git-send-email-chunfeng.yun@mediatek.com>
References: <1610505748-30616-1-git-send-email-chunfeng.yun@mediatek.com>
 <1610505748-30616-7-git-send-email-chunfeng.yun@mediatek.com>
Date:   Wed, 13 Jan 2021 10:44:21 +0200
Message-ID: <878s8x4462.fsf@kernel.org>
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

> Add () around macro argument to avoid precedence issues
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

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl/+suURHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQZbEg//fNGDEuEhmNpa3TsrC7fU/9ozE5RfBfRv
4cvQRqRVQSOIJXcAGYgK89xv59Zq5yOWXvp9D2lqcC4Ayrj/07a0FZLKNt2n2w63
mVUN40Cku2ui2pIpvsZxKRo9OYkgqavTTvQ8WJJBVTWTStO7O4fqBTLVYjgspmS2
Grvq/N3rm+z0Lp2czH7xNYwwCaSsZUSAjZq0DyNmaPPYpTqX1aT1N+esMd5fgB6p
YtDy2BhrQyzOVjB3wk7b4BFaAYjjlpGwGjYpggf0bcChtHcXJbv3Pt4sWKabPHJn
uYF13g1crjR3Kxhprm7L3Yo3J0g3RzbGtZtt6h0M2D3dhRKXuTQNVZ/P/vTiwdb8
4UyGW8E5LAkKj/M6a2agj+rtDjOUnMrbotAX6+p3YhJknmI0EXfPW136Zuhj0kaw
KWUOJTRA1ElLZMHIqmVfO2Uiv1o6BmzQ8i894iQA4iVQUPRuZNBC8cqLWqg2Qo1q
bKOeuHZKtDZat3k2QkvIoAn9kkCmKTsrZDf/QeII9FgTf2GK6bUHWfceseO8FKfN
Iw4O3muEzXDaSQBHPJFNV6uKOBoz3/DfOnPG57NDlEDJy0hysO5x8Dk0re3XfYM/
R3XH7IitMer/A+FwbPnbOLqfPyHmezyiw/utBjEGFfhl9mioN31eX2uM8l9e+g+K
Pjn7ZcchyNQ=
=dzQZ
-----END PGP SIGNATURE-----
--=-=-=--
