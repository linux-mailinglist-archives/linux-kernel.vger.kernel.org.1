Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F8F2F46B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbhAMImt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:42:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:41564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbhAMIms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:42:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF85923340;
        Wed, 13 Jan 2021 08:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610527327;
        bh=+o6TzP0nndi2fNSkUToIVPdHCEVZXxgMvHv50ZLtAbU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=P9W0F+gMnvNMnIOg4TAHS+/fodhMja/o4R00hQCZI4YSF3QJFVDz8oT/pZj0Jw5K6
         ckU85NNJ6oprSQLGYjjZnZ8xxzPDkVIAZceOwtG6qm5Az4l37khA/mwL/DYFMQJCZS
         rJAh6xZpUHAmEKvIA63hPSEb7jbOIe3oaMQqqCUNPMGYaLlaDeJ3MytiuE78K5z22R
         UcH/jM+C4DYVV60cevfzGZ53hHDGLgOvdJeY4OYY4WbwEjVShjaL050/fGQnMMd1DG
         tWaBO8X4H5GyQEqBCITa5vMhr//mwl57KzLwcwgJQxBp9BTtzUU9lltXY50ZgkUiK+
         kRu3o9N6mH1VQ==
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
Subject: Re: [PATCH RESEND v4 03/11] usb: gadget: bdc: prefer pointer
 dereference to pointer type
In-Reply-To: <1610505748-30616-3-git-send-email-chunfeng.yun@mediatek.com>
References: <1610505748-30616-1-git-send-email-chunfeng.yun@mediatek.com>
 <1610505748-30616-3-git-send-email-chunfeng.yun@mediatek.com>
Date:   Wed, 13 Jan 2021 10:41:59 +0200
Message-ID: <87k0sh44a0.fsf@kernel.org>
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

> Prefer kzalloc(sizeof(*bd_table)...) over
> kzalloc(sizeof(struct bd_table)
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

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl/+slcRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQaK8hAA1BEVKIDixWHvpuNPU54brKOvFJpMwHVP
RDJko1UeJ3Ol2ndhplwKE8JkoJxZpSN0WGjOa9ESzOGDT937iE1MFWgFh04ypBtr
TLeOEbKVV/6pe5eod6KXtbg24SguepmiZuhnxubQKgqdszST86zlK+qcAZfI0yrc
/jFGFwpopcXCWRJu1dgUceaj4a/eBYGRsgIs4+el6rYAlSDRCxb/VaVBSy1dE7Xd
1wVTwfZyKZ/Vf7HVPh/b9ALBwkxosJIDGS9HTOcKsRg+msAMpNDH0GwDAuLR7AnI
zC6fx3MMsaSdvhONaD4S9+4Uq3n6Les33MEckgyUPWKoBSNGDuANzHBBSqvSWKI7
253W1D1KBN2GnI6Qu1Qe3pMKMh+sy2Qpqe1Jvw2ePHumklt9ieeTqi7ox5vtbDAn
lqOoYfotlWN7+JnGpnB1TmnQJa7ReHvCRYMeRdowt6lS9vJAj6cnGurRbRLJ0L/J
mPbSrwzOjLz4pbjpb1hU7cJrwfHLO7RlSoJ+pNnfL4e51UhMCr1LjOWZNFfCDf0e
AEvH7Yi560ZMZXLRYXH6g1oRAn6QiJ5XxF+H7TP5PZF0ZvITVOBlHpS5lhSFQa9q
YDTd06aJZYpB6+NhFBfRkMXpxsfU8dChvWVniEZEKrJV/vq8kcT15x/LklCP7oCM
JTq7C3DztGM=
=lIKo
-----END PGP SIGNATURE-----
--=-=-=--
