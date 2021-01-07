Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AB12ECCAA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbhAGJZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:25:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:45448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbhAGJZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:25:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58AB12312E;
        Thu,  7 Jan 2021 09:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610011467;
        bh=JcFgsFPjX1rHq14QgqkWDEcoV6IwCLG3Nio7JBB+Oxw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mwOyntZC1Fk2YoUp+lTxXY9upB4c1yW8MIRhtX+vbliFovaVY5GMQ9p6PL8l44aYl
         g5iyasza+dphX9tIHfDji8oSDKrhcnjMo2kc1QhatXGdhb4gtXMZulA7WLaAk3nvtI
         BmH8NG3OsHLUDa46XF7Sx9g6GJFAFgNZdLPVYGYV/m/nTj5NfvPMvWxg0F0LB5CNT7
         o1NtxPfdTn6gIhKoZDD24dBc4SXAYkVcuou4ig5Z96DTH9af0KiZoSSx0xOQNEv7Sw
         AiYSxdBqWV6xbAqsKMreDVxZY6/HmH4ftpfSecHIqMI8YF2TQPSdh0JdViJrQNTg1u
         vnXpm2/hYVjxg==
From:   Felipe Balbi <balbi@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] usb: gadget: f_uac2: reset wMaxPacketSize
In-Reply-To: <20210106133652.512178-3-jbrunet@baylibre.com>
References: <20210106133652.512178-1-jbrunet@baylibre.com>
 <20210106133652.512178-3-jbrunet@baylibre.com>
Date:   Thu, 07 Jan 2021 11:24:20 +0200
Message-ID: <87v9c9aym3.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Jerome Brunet <jbrunet@baylibre.com> writes:
> With commit 913e4a90b6f9 ("usb: gadget: f_uac2: finalize wMaxPacketSize a=
ccording to bandwidth")
> wMaxPacketSize is computed dynamically but the value is never reset.
>
> Because of this, the actual maximum packet size can only decrease each ti=
me
> the audio gadget is instantiated.
>
> Reset the endpoint maximum packet size and mark wMaxPacketSize as dynamic
> to solve the problem.
>
> Fixes: 913e4a90b6f9 ("usb: gadget: f_uac2: finalize wMaxPacketSize accord=
ing to bandwidth")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl/200QRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQaszw//Rkf/fonDEKhNP8ob4K6KGuTstUlnUA6+
5Bq6gMUslRKebQ3bWc7w8fORsyu2fd4tDBfw1ZFLYFQRJAqdGaQBRv7fY0UBfIlu
p9AXaHYR2q3NAtsNDSk0O+xott32LtqxjzUT6wXLFXp7Y7lhCh8rcDZ/BzH9Xr5F
S8E6w8a0t4k/7Ykv66p+axLgg5h2DLAc9uqWSJClyjCjUdIloDSF+w5j7QOAE4pq
o3vIX5L/ooHDAZCshbzbwVegAreMRtARaJxv9wKs2hTIAS0BHw5PJi/w2ROSPLkT
NsY1jTl9YGAnTYa4v5zCtld9dZjJKJEZ0w7Q73I5byURJ2O0DARXi6yh+YxXB0qR
79veEcsUvydvwHpACbY8TQA+yt+jULhGDryIapYi2aifGiDsVT5pNoLitXUSUTN1
FrFQeLwexYJcOEBCRNkCGsp3WLjeTkDLGP/OCO6CNHUImZYm5X3vD8kwLmtvGyAx
jX+Zc3VPeNtNP0Qziot6fADhw0c1ePP1W9eCQYD6QzJcQqIhNAib0GyUXD8HmfMY
3g7bQbPRNWKgliov63KU9uMBHmMyXgwW4HrtiPihrt8tIkFAPshcqkMvqSZSNnWi
mYvzmCJqvv1eGXmY57JZcJWUkSTzPSjv/FwdDxVuLKJ8E1h/dfkPBL3LGzNfQ89U
n9hKMsYpuLQ=
=BGRF
-----END PGP SIGNATURE-----
--=-=-=--
