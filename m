Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA47F2FB311
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 08:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbhASHZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 02:25:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730135AbhASHUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 02:20:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80AF82312D;
        Tue, 19 Jan 2021 07:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611040781;
        bh=ux1lB6ubvrr4Q+uxH53HhzXK+GDcNZietyLsOMAyvjs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cKXnB3cSLh+lwsLjmsYqfkcX5uDNuY8rqiU5+SS1CxvMSnZSMtV2ucku9F2dx4KN6
         6kiKhpCKnxD3oApOfHOKVwUWPfsrGC4WdEKrHnmuhIcG+2HjJ6t97YzOJ4bEFS4/Oz
         HxWUWlcoZdvPiD2WIx92V9wWpAdc7cHiNIpgMvPm854j21kXswtMErjorbvU4rEha4
         F94D/6UkBcDnXTBBhkpL8iNH4zTM8KrjLtS0KUFXftKBazqiSYS+9jBbkSyy3cY1zA
         SefhcamiK/qHkwRVYpBNe6sbAsX6W1whLoTxyJ0EpE8Eq1dJWvkja/d1NPDO6q2uaz
         b33hkzQvkymLA==
From:   Felipe Balbi <balbi@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] USB: gadget: udc: Process disconnect synchronously
In-Reply-To: <20210119001653.127975-1-dave@stgolabs.net>
References: <20210119001653.127975-1-dave@stgolabs.net>
Date:   Tue, 19 Jan 2021 09:19:33 +0200
Message-ID: <87k0s9v1fe.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Davidlohr Bueso <dave@stgolabs.net> writes:

> As the comment in usb_disconnect() hints, do not defer the
> disconnect processing, and instead just do it directly in
> the irq handler. This allows the driver to avoid using a
> nowadays deprecated tasklet.
>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

You may have to deal with VBUS valid, but for now this is good:

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAmAGiAURHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQYu+Q/+KnveaJu1LiWSHJVYOUbZoe5zvRvU08KN
JIAYo6WDviUJPQiJy+MsPYVjVpQN8nxEMcQ/uwZkisF6cBt3xgVd3N8vFWTKioNe
kdrTD4sbTKnhACuAU+a1+bdrzRlWbY7WqDsOLSo4g4KWxkv8MCFH9W2lRp/ZtaBw
I61ZBdQdFHPxbyx4PTh0BZY52Q/OCbVzSpmyWhVVLr1MeF7ypgN1u/0QZdYW0/+C
I+9Rj7cRWrX+qnBsr+wuQIsi1JSgUO/C/YCx8IpBcdw7qW8xUrZ5e22SnGCHwrR7
DI9S5ecfUDCeTtPsh6WFqHLR8f0E89bsNGJxm4wjYF7wLAVSldTPpNY1pEarzr0T
Tj0MSNoSNUpXPyvLDVP18aw/gTzmebyWSdnB9FkgkzTkUJBwIGGejSwF2aG7bN3N
wsQJaFeosTxQQLquVy5K9xJneoKxs/w1//7Fp0t8a0c0tZrCbnRfiHps0i3CmTJU
enfOLCUuB0J4pl2OiCXaW/RS8+8tV5ZC676v/mEtts7ZAwTUaZeZBVdP1Sgr1uAi
u2DJx/qtOScnYXWIRYdxL5bPiyTZva11VBKJsNC087somzeH0q9M3EbV9BX288oi
jYS6I80qBdsvvJCgwwxqXNm/xuZH/gwAa5kYTHje2L+3I2c5VpVZsHOi/ej9A/ar
G4lmh2pbiQc=
=30wi
-----END PGP SIGNATURE-----
--=-=-=--
