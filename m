Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5946E2ECCAE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbhAGJ0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:26:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:45622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbhAGJ0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:26:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C032E2312E;
        Thu,  7 Jan 2021 09:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610011535;
        bh=1aJhxIDD2Vnut5LarTGoKaEJliwkbJvwXYSuBMBrGZs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JQRxFcEIL48LnXgW+dc8pOdNhle3qErICG8D7mONmBbWkkrH4bZAaMDeFf/nQUx9Z
         Mt1VKi4NGttt6aFTbL9WTX/4eJzHOcCITcG7Zjr2qywDAp2x03/2hIWg13g+BbicSN
         X43UKTnt0818Kf9QXw5qkl59/kQtgzUw5eAkicw1vok/Q4lGUHVmCy9rJIonNjxwi8
         meZF2ApzWiMRSGj6qHXid1VZems+zzWoLvzVj6xrLmZ0g9TPTxFfmjc1Z7e/XhLM8h
         Ht9QvZONdvK+e+TMf8RxQEVVXt9FmaR5HAbW0yEmmlkzE+BKAvKHGdj+ce8Yp0qhqH
         V6J6K3heNbbuA==
From:   Felipe Balbi <balbi@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] usb: gadget: u_audio: factorize ssize to alsa
 fmt conversion
In-Reply-To: <20210106133652.512178-4-jbrunet@baylibre.com>
References: <20210106133652.512178-1-jbrunet@baylibre.com>
 <20210106133652.512178-4-jbrunet@baylibre.com>
Date:   Thu, 07 Jan 2021 11:25:28 +0200
Message-ID: <87sg7dayk7.fsf@kernel.org>
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

> Factorize format related code common to the capture and playback path.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

It's never a good idea to send fixes and cleanups/refactors in the same
series as that can confuse the person applying your changes.

In any case:

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl/204gRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQYfmQ//T8FZigoooZYq/9Mjn79TiP+AZEY1Rfth
JVyyKtPVtwYDY8zDfEgQGqu3IIG0oOiuhVBegSCnIsg4UxqNFAqFQS7N0SUdlEmU
CROwa7p9hBJkGIHI49zs7R9gvaT19ngnM20pPDBa1o7xVMIOPb3bqmFMfxChSq/S
LrFbqQThhvx+635ndaN+6suMZOGzYQ5PR383i++u1cWvouuASt329BwZlh2S3MjA
hDFpkKNyFdnwRRS+Ndyi9G2NF59NRcSpTA8tMyiTksjweKdT75eZSCJmMlBTMof5
3nzRe6zrTCtjld80/GTrcLAQjTu/hFRXt2wwHs9TMZrc0H28+MU1SvxYaqvjWcbk
Hi2OmTcVqi75rnIgVE+OWeCgBeI3SmUoxRpDK1CUxKuMq70wRt1l2KqU93PIBakE
W3T6+f0z+8PB8il1KTVHT5WCa5sa4bWV/D0vrUWOhujxuXtppbduHi6hz9sA2s/o
23xhD9LLu1lABjOZ1RCYf2AL3379EsvogOXj/NqKXRAuFXGPONJlwFmP1bxZ+jwj
nTsJwcivE6eQMu3U4ycx4Y51qBqnhMyHr/RJUBcm/4hXc6O+bMLggSvMM+fSDsGK
c0ppj716R6ZRPBr13diQFZejum441ZXO2ftn7cptDGwtI+/iNYdOlAQecLyTVsj9
Uxwu8VTtMOc=
=e1QP
-----END PGP SIGNATURE-----
--=-=-=--
