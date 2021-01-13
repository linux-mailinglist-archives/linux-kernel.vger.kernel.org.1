Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6362F46BB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbhAMInl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:43:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbhAMInl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:43:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD1FB20719;
        Wed, 13 Jan 2021 08:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610527380;
        bh=uzTumP2kvE3BQoDI4dpMIiVnwMO9qMGM6S23cnn4MXw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IdUDLrMYN9YW2dwHiXJ0j0ppskcV4TLXxsA4WwxJ0FvUVxkF1fmmzOkOBO6WPbGIv
         kmnhbMiXdcPQjHCH3WcbAQkrdp+Q4xlBrgDFkeBWLxSJPDuICIFePlcoFKxIRab+Ty
         MEshtE8g1U4FBUz7oLyBa33ex51JOaqDGC7fLqQRwumNiVEpITmgnRSw0K18JcSfMg
         JNTu0CBkkEBFLWlf87NreQBPMM4Cb5xsvKy7C3zRdVzynLn2PfL+NKjju+Yg313pE1
         xpyB/p4aZgRVgluf4nDU8V16zJW7WKX7ZK+nVJeTLAlzsasEGTiauU5rsZFDHRN30e
         cLupFbMwm06cQ==
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
Subject: Re: [PATCH RESEND v4 04/11] usb: gadget: bdc: fix warning of
 embedded function name
In-Reply-To: <1610505748-30616-4-git-send-email-chunfeng.yun@mediatek.com>
References: <1610505748-30616-1-git-send-email-chunfeng.yun@mediatek.com>
 <1610505748-30616-4-git-send-email-chunfeng.yun@mediatek.com>
Date:   Wed, 13 Jan 2021 10:42:52 +0200
Message-ID: <87h7nl448j.fsf@kernel.org>
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

> Use '"%s...", __func__' to replace embedded function name
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

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl/+sowRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQYCbA//RE7VtciEWWUu8xODTD9cXd/EaOpXbw13
xg+/bB0PLm8KBzs2TkS3M9WR7Mx7hSmg7SrfEL3M+RtYp2lcks5bRuryUXYQKjx8
BX4nHtmhj4NIWvmXMW+BiqgLn/9xVJUGOCc7xWePP0cT4cAju3Cnb4YXgtldZHKg
Yy2xTNd0478pOdb7B+24fxdgWAP+jp5Zlzhsrnrpvdw5jCpLEohwPeE2ZxuRD/l/
7Stpug6+PbX/u7abLphP9j4esannZiPKl/ZJPJ46Y3o/NfiN/Caqjw06Ujvwk7Pr
eGOrXVhoKdkQlL2bkMBxvioDgRzLiqkebb/tc9ipaRGQznvdgm8nQdIjZ2MzMnGq
kAgaap049nGkHspbOq/lcqyRfJ9N5lkJqjy/Jea6rY+pfB7A7aEcX6dPkCrw4+Ot
CtDvJQcFc7ZVqCtLKOV0kDZ//u2pjtZZc/SHspicXc6KL5OE5Vp83f6XudxJa4SB
tlhI06yjX6iLqURc9arkL2DUn+LKs6TQEEes5tgPZG4b1jKVtDnDiRISxJJbPx6W
rrIxRg2JYE8E1ZZ2tVHzi3CTMXPaJ7Dme4k+cGQLoSw6TBvs4RFonQek1fY9BKs+
KbTXfQYL4DUwrClsKCmEmA6NUNwzYF6CNR2bjN3zIcL16DCBNRi4RHQhk+tncN6y
jGfXreVDI3I=
=OG05
-----END PGP SIGNATURE-----
--=-=-=--
