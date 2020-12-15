Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B6E2DB434
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbgLOTDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 14:03:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:52666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731771AbgLOTCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:02:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 31A66ACC4;
        Tue, 15 Dec 2020 19:01:56 +0000 (UTC)
Message-ID: <1e0ad098ca7b1c13dbc6602285b77790b9cd54a1.camel@suse.de>
Subject: Re: [PATCH 0/6] Expose RPi4'd bootloader configuration
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     srinivas.kandagatla@linaro.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, will@kernel.org, robh+dt@kernel.org,
        tim.gover@raspberrypi.com, phil@raspberrypi.com
Date:   Tue, 15 Dec 2020 20:01:54 +0100
In-Reply-To: <20201215184407.GA44849@C02TF0J2HF1T.local>
References: <20201215155627.2513-1-nsaenzjulienne@suse.de>
         <20201215184407.GA44849@C02TF0J2HF1T.local>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-33igFDZ5wcGZ+YxGdMIV"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-33igFDZ5wcGZ+YxGdMIV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Catalin,

On Tue, 2020-12-15 at 18:44 +0000, Catalin Marinas wrote:
> On Tue, Dec 15, 2020 at 04:56:20PM +0100, Nicolas Saenz Julienne wrote:
> > Soon to be released versions of RPi4's firmware will take of care
> > passing their bootloader's configuration to the OS by copying it into
> > memory and creating a reserved memory node in the board's DT. In order
> > to make use of this information, this series introduces a new generic
> > nvmem driver that maps reserved-memory nodes into nvmem devices.
> >=20
> > An alternative approach, less nice IMO, would be to create a
> > platform-specific 'soc' driver.
>=20
> What kind of information is this and how would the kernel use it?

Sorry, I wasn't clear enough, the ultimate goal is to use this information =
from
user-space, through nvmem's sysfs interface. The kernel itself has no use f=
or
it.

Regards,
Nicolas


--=-33igFDZ5wcGZ+YxGdMIV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl/ZCCIACgkQlfZmHno8
x/5EWgf/TGaMzSV0k6I2BL4PJYiyOgo9Uq8iEQR3MAxBBSA9qoCwHPnqjElHIMg6
JsyizxB7068wZfkRFvl3V6qW9BqE+HtJvoeT6yHwNqxcV9E1vqWrg6iWIvVLT1kI
POU7D73OsKqjmIc2rjD+VEx5BZckvuGAOAncngk64f2MfUFKr5xCi5oj68jC8fXS
s+bWzrgXURYjcZKTkAsiDH6OodzkLMm1OOP/Mpp3y4yN314CebvH7h2TBSXEXiW5
0w5FxD9HndtTWhRX/pANNPmb+8ZhBKgfN2X2dUF2V+jgKHkXsj5Q5dUeYeH28nPl
MqfB0uhWKHPwiBc9ocDOC1vCDkd1vQ==
=2fYn
-----END PGP SIGNATURE-----

--=-33igFDZ5wcGZ+YxGdMIV--

