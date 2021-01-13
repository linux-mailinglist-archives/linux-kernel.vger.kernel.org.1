Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98752F46C0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbhAMIoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:44:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:41948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbhAMIoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:44:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B65C123356;
        Wed, 13 Jan 2021 08:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610527404;
        bh=8+yKvyuxptk1pipmKCR8+8bScEfAZHCFMfMegzhFIRg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PKx4bzbIjdd2A3hiNvX13tAGG2oavr+Diyd3+RRBc6pUL8vcl+MAb+SLzzj/yJD28
         WWuk/5fYLY0vwHwkUJaFrx8pwp1Cbg4PRQa/i/DJio+jjvWCejfspv4+CHw9x7NjZ8
         8yiVJzEPLNXhIqq1xIPDmSh3fJSAAQQynBsKbAxabZ0cWWXW6X4Zy+4lRFAKINWaT6
         +UDxx0zcGx7GMCs/HGFIsnTwAk6U8CvSP3LicMiObJnXV8w7KdSMMHrUia/A4BToMG
         HAg90iyiYHzCVhlaSLC4+5c+BjNw5xsLz7XuQK6yGbj0BGFm2yAhY8PU7KvHummQ3f
         xV798FKKg/jag==
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
Subject: Re: [PATCH RESEND v4 05/11] usb: gadget: bdc: fix check warning of
 block comments alignment
In-Reply-To: <1610505748-30616-5-git-send-email-chunfeng.yun@mediatek.com>
References: <1610505748-30616-1-git-send-email-chunfeng.yun@mediatek.com>
 <1610505748-30616-5-git-send-email-chunfeng.yun@mediatek.com>
Date:   Wed, 13 Jan 2021 10:43:16 +0200
Message-ID: <87eeip447v.fsf@kernel.org>
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

> fix the warning:
>   WARNING:BLOCK_COMMENT_STYLE:
>   Block comments should align the * on each line
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

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl/+sqQRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQa71g/+IXwmgnZqM0ZXbxmaTqE/LVIqJZi+eVDQ
A1FWYn3dGmyOA7pxRD+U3su3ZJa3peAMmVSuJqIT5re1Tew+ie1rjUvoa9AZEBjE
K/5cN8GC9TrDYhqsD3/Z+HRTnnJLxqeBs4qpeCKBB3MRJsHV5fUH0bi1uYFCx/eA
RiSU2t+SKqXhkWgoZd1JRTxejDGXb/gB/4Xrq7l3wkeUJygYNGuy2bZhjLoEsRsR
K53+CxaHrra3knwfrnEF0C/mRneEQLy0iQIkqISADCM31Zn0ddCjQM6KtYrK5eqo
bvquaEsqd8N60fgJE2OWZ/UjQSkkvn5VfgzQnYJw4AKkeb9o6cYOYp5RgySfkF1k
xOklNZNxXgXeXgoOIFlECvjr2TTdSHTVzo8rHFWH8QslwuvpzluQJ457nY19B+iv
Sy5b0eUmf3sBlfkCExZcZUEP93GXV1ipYKNUkxSvXwJlpfAh1N/bAHwOvSl2Z7gW
bgkXWS0o1gV64A/1vUQCOKnvlneyUBDrPr1pkv0ZvvOKNXY1xJyb/YskfzvWL+iG
2lW6Mz2+9SZNGWlCo7b0H8JT7WoHIiyMzZikrR+SEjZUnj+nJEQK+QE7izVyev2H
fFVVoYCYLs61plh5qRGA0WbxBaQhiT2eXYFMmyXfQN01y+DItssGlP1KsgQgWffh
V7nWUTzzAwg=
=B3ks
-----END PGP SIGNATURE-----
--=-=-=--
