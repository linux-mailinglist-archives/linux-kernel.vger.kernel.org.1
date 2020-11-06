Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251AE2A94B2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgKFKug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgKFKug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:50:36 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CABC0613CF;
        Fri,  6 Nov 2020 02:50:35 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1kazKC-002Ety-By; Fri, 06 Nov 2020 11:50:32 +0100
Message-ID: <f27aa23400f3481b5a6369af0b842da090f3928f.camel@sipsolutions.net>
Subject: Re: [PATCH 0/2] UCSI race condition resulting in wrong port state
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date:   Fri, 06 Nov 2020 11:50:26 +0100
In-Reply-To: <20201106104725.GC2785199@kroah.com>
References: <20201009144047.505957-1-benjamin@sipsolutions.net>
         <20201028091043.GC1947336@kroah.com> <20201106104725.GC2785199@kroah.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-gZBt+xPAMnT5YQuOUb0U"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-malware-bazaar-2: OK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gZBt+xPAMnT5YQuOUb0U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2020-11-06 at 11:47 +0100, Greg Kroah-Hartman wrote:
> Due to the lack of response, I guess they don't need to go to any
> stable kernel, so will queue them up for 5.11-rc1.

Sorry, forgot to reply.

Not including them in stable seems reasonable as I have not seen it
cause major trouble in the wild so far (i.e. only one user report that
seems related).

Benjamin

--=-gZBt+xPAMnT5YQuOUb0U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAl+lKnMACgkQq6ZWhpmF
Y3C+ExAAzkMLhyy2yTmk8rVa50dl3YJHDOiRPFcoacATqTDH7UmY6qYXdtGUz/oZ
0foVypY87yiL9O0M0uDv5QOkOe03lp7d8pDp2uROdTh+6TXuSaCTTMhbwVdPMmXl
ENtDma0ncgRHxVohDDulpLWqpN5yN9HxfyzXOJRf+EfbLgL4sZaI6napRbCHSbG1
OJfyB0KXISHlhIJ6BvsCPLwMVP3NXjyzOuYZ2dzRouS+h6mopb+b0klkJJiVDvIq
q0j/OQGq0qLthAIygMiO0/DXzhMaYA0UQT9JSukCSuOvQVzEgSW8aiQQnnT/sr0W
yS4Z+R7c/+vwrlZWNJYKvHV47c32+ttXP6JUrRBBB/RueK4RXILz5rBG4i9M0gzI
9DKTJZTfYoK6//+JjCaVAaKJ9EG0hn3UqI24tkE9gT4Ymbl+slwczK6VAuJM5viD
1P3I26Ckj6yoB9Fyy3DVU0HCv4CIt4Mg8ter9FWL/FowdYMFJpyytd8iB7YGtiPL
r42aOIyZCV0Rp00Tx9WFyEyFGDMzG9sAS46U2KeoXlrc4OGTldQwJVN7MsEUIUOG
XKZsSwSFH50dAe8v442+kr1n1e/AVRJ/zx/CkKsjACXFCI0Emo6O1FkA7DZ5jpeT
YlOU+EPzaHQAsbE4F0bBGtKUD8tV9VBDjksTvabAno4xNUuykWg=
=TFJ4
-----END PGP SIGNATURE-----

--=-gZBt+xPAMnT5YQuOUb0U--

