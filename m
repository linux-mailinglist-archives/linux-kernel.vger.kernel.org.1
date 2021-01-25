Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6DE302D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbhAYVKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:10:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:55462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732514AbhAYVGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:06:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 19402ACF5;
        Mon, 25 Jan 2021 21:04:36 +0000 (UTC)
Message-ID: <cd1a0145d12a70e89eea7aca49533c56ed24753f.camel@suse.de>
Subject: Re: [PATCH v3 0/5] Expose RPi4's bootloader configuration
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, tim.gover@raspberrypi.com,
        catalin.marinas@arm.com, linux@armlinux.org.uk, robh+dt@kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        phil@raspberrypi.com, linux-rpi-kernel@lists.infradead.org
Date:   Mon, 25 Jan 2021 22:04:34 +0100
In-Reply-To: <20210112142342.7290-1-nsaenzjulienne@suse.de>
References: <20210112142342.7290-1-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-t1ncgtAfbkcNLrE7vV3a"
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-t1ncgtAfbkcNLrE7vV3a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-01-12 at 15:23 +0100, Nicolas Saenz Julienne wrote:
> Soon to be released versions of RPi4's firmware will take of care
> passing their bootloader's configuration[1] to the OS by copying it into
> memory and creating a reserved memory node in the board's DT. By
> modeling this reserved memory node as an nvmem device using
> 'nvmem-rmem', which this series introduces, user-space applications will
> be able to query this information through nvmem's sysfs interface.
>=20
> An alternative approach, less nice IMO, would be to create a
> platform-specific 'soc' driver.
>=20
> Regards,
> Nicolas
>=20
> [1] https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm271=
1_bootloader_config.md
>=20

Applied patches #3 to #5 for next.

Regards,
Nicolas


--=-t1ncgtAfbkcNLrE7vV3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmAPMmIACgkQlfZmHno8
x/5KRgf9GfjvLYrrrCBNQPi/hEIjYx4XMShjEs5cQxguoN86J1nUqasvWZb7jU0t
kr3oOWV5Lz+U+REX2B19Pg8czeRs6RF8CgojV0h0BYhVrbIRV2yw25dzY6tJ5yob
a+oL/v8VlHVNC800sqdS+eRNYQTKv2auoeOhjAh4TXD4Pr553G1nbsVAtZvTY+g8
NgECnnfg5ucKIad3rQqKEVpiDCd7MzdcLl94/iDh/IV0qq1bydVmSbiIL11UUOoh
UB8AbIm19NMF4BakAIBak0YrDXMEXsylq+8UJb2/4II0WSAKELBEa6oLqFblB560
vlNR9n/H1sXk1ZK6EBCk9y0F7q1ClA==
=y/5r
-----END PGP SIGNATURE-----

--=-t1ncgtAfbkcNLrE7vV3a--

