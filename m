Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D504B2F0D30
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 08:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbhAKH3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 02:29:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbhAKH3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 02:29:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0941E2255F;
        Mon, 11 Jan 2021 07:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610350116;
        bh=DSSaQNFPhfvcLUspAmLykuY2eCqXAhxWCb+AQdHx9qY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=B3HADyeyVUvjHbIVekCUm1yR+x67Pb6zORhvSO2v+3zP9MNGadZGRY6ewUH2jPz+k
         s9EnG6CB6p1kTEoouSa6oOz0d17++G94955n6hTOMNXHuoIyHOYnUN9EI5HJLFeSwK
         O4JmE82LMsM9L7E532a1F+6ZMjo9hHfrwosrBH12T6gcz1zB5NH9ncqmOtbyRBRgS9
         IzO61cfJM5+aalJpg/LdYRj/EYjgjfzVbtZTcVsFtRMTE+pcjGke2wrFm/WTm0FYMb
         yNmYQmZEriw08M4U85vpkfbDBlGUZRkO7lWLtJsn2crDQlFEsi/PSbcj0OgNEQ2BTq
         J2PwxcJ2zNSeg==
From:   Felipe Balbi <balbi@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] usb/gadget: f_midi: Replace tasklet with work
In-Reply-To: <20210111042855.73289-1-dave@stgolabs.net>
References: <20210111042855.73289-1-dave@stgolabs.net>
Date:   Mon, 11 Jan 2021 09:28:29 +0200
Message-ID: <87r1ms0w6a.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Davidlohr Bueso <dave@stgolabs.net> writes:
> Currently a tasklet is used to transmit input substream buffer
> data. However, tasklets have long been deprecated as being too
> heavy on the system by running in irq context - and this is not
> a performance critical path. If a higher priority process wants
> to run, it must wait for the tasklet to finish before doing so.
>
> Deferring work to a workqueue and executing in process context
> should be fine considering the callback already does
> f_midi_do_transmit() under the transmit_lock and thus changes in
> semantics are ok regarding concurrency - tasklets being serialized
> against itself.
>
> Cc: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl/7/h0RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQaP+w/+J5qh4pBcJtfTxO/pDGQ7dXVkNNtlPg6G
pshmJZJ/ZN4Zf49eVgMoL8YlJoWWvqOQ9OfPo+yba1/+Dw38X2Yyw6LlYDgL7Grj
m7tL/nxNTn5hYjOWSE7VXLrk3lz4m3JkOjyMoWiWNjHLf5HDT14vX3cVxUBxx8Md
zHNekHTMc4j0PjZjFf7cb5w6QqBxqFi6Hy41KtJZY85XTwm3dVxRksLISTBw7u2i
SHK5kLu0gAuiGRwPj9RCz2bbeGEAjLjzC/nefu3Dk5MbvH7X29VKBDzXAU2kGbCF
WPrLMoGn/8ls9phfqY9x0Fh0jkdG0wufBVAYZRqxJYWp7b0HuOLBGGa7c6BrEWLG
0Yguw9WOvT3Wa37Vwp3saKQUnB6IlBEA774ex3gzVButJ8cclf5ZRHAxEgocTU4a
GSdwTEkpuNUusbFpXARNDgIzlcVY7JWl8oRxYag3AYw1y05jsAK40kvOKAKmno0n
WaNkoBM9UnsQeN1sYa7C3VBUKg+uJI5J3DiXP0zVaJX/EWIHH9ZhbRiaWlXQrFc/
PVh4Soyb0rg+3+OIRpa71nZ6S+4dtHF2uJMd6JPSDOVMAzmOiCruC2q03fHWn8Zh
eEdCDW2emiowat3OXebB9tLaO9/blYN2F5ijf2yKbu8Dblj8G+ZQxP5WJuPZRMWD
SezH8MDE/5U=
=Cnux
-----END PGP SIGNATURE-----
--=-=-=--
