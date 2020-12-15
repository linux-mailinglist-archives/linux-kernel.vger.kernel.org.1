Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9123A2DB0EA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgLOQGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:06:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:38028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730697AbgLOQF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:05:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F095AC7F;
        Tue, 15 Dec 2020 16:05:17 +0000 (UTC)
Message-ID: <2f4968f856bb8d1181079869c0af6306b5cec8e8.camel@suse.de>
Subject: Re: [PATCH 0/6] Expose RPi4'd bootloader configuration
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     srinivas.kandagatla@linaro.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, robh+dt@kernel.org,
        tim.gover@raspberrypi.com, phil@raspberrypi.com
Date:   Tue, 15 Dec 2020 17:05:15 +0100
In-Reply-To: <20201215155627.2513-1-nsaenzjulienne@suse.de>
References: <20201215155627.2513-1-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5oO5LQrqVfQ3bn5VmD7J"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5oO5LQrqVfQ3bn5VmD7J
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-12-15 at 16:56 +0100, Nicolas Saenz Julienne wrote:
> Soon to be released versions of RPi4's firmware will take of care
> passing their bootloader's configuration to the OS by copying it into
> memory and creating a reserved memory node in the board's DT. In order
> to make use of this information, this series introduces a new generic
> nvmem driver that maps reserved-memory nodes into nvmem devices.
>=20
> An alternative approach, less nice IMO, would be to create a
> platform-specific 'soc' driver.
>=20
> Regards,
> Nicolas

There's a typo in the Subject, it should look like this:

'Expose RPi4's bootloader configuration'

Regards,
Nicolas


--=-5oO5LQrqVfQ3bn5VmD7J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl/Y3rsACgkQlfZmHno8
x/6Cpwf5AShEDaQQYrrvcFw3DE8yB82+JUYepLz5aJexh6Yl5KyPYIP/T5ulB8dG
c9G5xWPb14mEwcnE1RQwyhyFngJkOiEHjz14bJ3gSluHfWyNAycCEdJepuBxXC0g
lO7kpY/ED+e4uRpxvAQSpzX8RZhPMnyHIBTyXITvM1MeBYqrcRzLWK1sP5hFaAcT
pO1kOWWPrrptOrUNJ4O0KveNQT2IK0O5VzyI46+3QKcturZvQpuLdebjCCgRpT1/
bChv5mSdSsK2pwKvDhZHwAID4MEKfbFpMzQF5r/MzWoXkolijCN9vz/ypf8O6kek
6nPSh5j/9MLfnelXKy68BYTTHD9Jkw==
=DMyo
-----END PGP SIGNATURE-----

--=-5oO5LQrqVfQ3bn5VmD7J--

