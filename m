Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543BA2ECCC9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbhAGJ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:29:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:46092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbhAGJ3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:29:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A41523339;
        Thu,  7 Jan 2021 09:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610011722;
        bh=39pUrvxCbC9Wkr0010Izx9HXJg14yoHET4oVsBi2xW8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dZXWQ38mOAkMATPD6M6GS2xlLHw3yqibHA2su1HVPHrhXp0m4/9kq6HOtUSh4fIoX
         FGI6+BNE9uJ2rVoXb9ljxQPGMlHlUSr3d8C7sb00Xmt1bhaaNU7c91g3SwgyRG7t5p
         fqBp7EnKYPambWDNOdWYOZDPeW2eTqQ17JStRo45q6db4wbHq7DqHLSik4lrKVOMic
         Y7sHYQxvn4EwY5ozyTXsj2F4pBeqhyI50cDNrTVr97+9jb57/M30ucUTHV2qI2jWX0
         BocsqA8hASgUqGVJxQ5FaSZV5lKPL+K+XqJbZI/RCbwxE4gK2zM1lVZowenb28lQYR
         XZj7s7harruWQ==
From:   Felipe Balbi <balbi@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] usb: gadget: u_audio: clean up locking
In-Reply-To: <20210106133652.512178-6-jbrunet@baylibre.com>
References: <20210106133652.512178-1-jbrunet@baylibre.com>
 <20210106133652.512178-6-jbrunet@baylibre.com>
Date:   Thu, 07 Jan 2021 11:28:35 +0200
Message-ID: <87mtxlayf0.fsf@kernel.org>
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

> snd_pcm_stream_lock() is held when the ALSA .trigger() callback is called.
> The lock of 'struct uac_rtd_params' is not necessary since all its locking
> operation are done under the snd_pcm_stream_lock() too.
>
> Also, usb_request .complete() is called with irqs disabled, so saving and
> restoring the irqs is not necessary.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

This is nice!

Acked-by: Felipe Balbi <balbi@.kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl/21EMRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQaZhQ//dSDqt5D168uB96jpb4ZC8cDoi4s2IUpk
N/M8qPEz+moHdw3D6SMQ1g4ZTNWN0v/e3PV5yncqP67S2B6KcHk3nfY0nGb/CawG
qplJ+4lti6+Q95rytRAxHC8aRbmAB+xrcGXS3GJ7MehU+0TOs/d8VLOhAtCCC71c
VcG+jQ8LPBBweA3i8pntHVnirZYjX9jK8lyYw+Mfoj7C61dXTbvaRHF8qoZwfcNq
XCCQD2VfgME1Gf5vOs+lGAPTJHX2Z8jv/K5/k2cY4yKQOJFXPUE+UyHUNQsBTW03
GhRJd9z8I/Cmrw2j6+7oHSCX2IdcMySpzeUtEedmpB1l3o08mPcZQuoSE12/5sDq
JGcOyocXo67CCguTJ5BZK7oLteIWKcdeIOdTMZGnGt0kHZOmdYyaq7SdGUYSJoYe
E8KyzMjFhdSyR476VeSh/1yZ100STjviJ10jBBF/I0ecxkEa3kP48tzE5X9vrfwa
VjkW6eY7S48p9tPeHDjcvPUVTVxxEtcCJLD9GPYy8MHTa/ghlo7VVkvmoH4pv83O
EboBW5TiTFApaH0YnLZNyvQp0VIrXOwmDa6F2Xg58L1cNtsZD/bQchhJbmBlCVHG
4GfjsFvY3cdXySXS7ZmCj84wRw1pa/y7KC7sTKCfhQ39BpBbQQmvhRutnKkgwH/K
mF5tlQm16Ow=
=9Epe
-----END PGP SIGNATURE-----
--=-=-=--
