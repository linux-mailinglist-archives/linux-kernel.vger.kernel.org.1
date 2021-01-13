Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263932F4A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbhAMLpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:45:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:52826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbhAMLpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:45:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0243DAD29;
        Wed, 13 Jan 2021 11:44:36 +0000 (UTC)
Message-ID: <712cb4237f1dbb8d1104736e20713ba457444650.camel@suse.de>
Subject: Re: [PATCH v1 0/5] Enable fw_devlink=on by default
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Date:   Wed, 13 Jan 2021 12:44:34 +0100
In-Reply-To: <20201218031703.3053753-1-saravanak@google.com>
References: <20201218031703.3053753-1-saravanak@google.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-3ktaYI/BoNRYuZDJlXYu"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3ktaYI/BoNRYuZDJlXYu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-12-17 at 19:16 -0800, Saravana Kannan wrote:
> As discussed in LPC 2020, cyclic dependencies in firmware that couldn't
> be broken using logic was one of the last remaining reasons
> fw_devlink=3Don couldn't be set by default.
>=20
> This series changes fw_devlink so that when a cyclic dependency is found
> in firmware, the links between those devices fallback to permissive mode
> behavior. This way, the rest of the system still benefits from
> fw_devlink, but the ambiguous cases fallback to permissive mode.
>=20
> Setting fw_devlink=3Don by default brings a bunch of benefits (currently,
> only for systems with device tree firmware):
> * Significantly cuts down deferred probes.
> * Device probe is effectively attempted in graph order.
> * Makes it much easier to load drivers as modules without having to
> =C2=A0=C2=A0worry about functional dependencies between modules (depmod i=
s still
> =C2=A0=C2=A0needed for symbol dependencies).

FWIW I don't see any issues with this on Raspberry Pi 4 :).

Regards,
Nicolas


--=-3ktaYI/BoNRYuZDJlXYu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl/+3SIACgkQlfZmHno8
x/4+gAf+ODvW0k+2NFesNUHkZDUmwmw0AfqYMR1Wq+517LgapfyMQLVAg8HJc2MB
uzOKOZHNxLCuu2azlyfxqPNs7VojvekpNZLheHQUAhYDLsxcEq7vDb/ZuMemul11
T2NqPU2yeVKcHSqUlY2O9+K+X/VZ4vXJY5MOJBtWvRPkOJ07tZGvRw9brYwlOnpj
mbOh4MuzGFDQBv1zzH27wEFz7qWfxc+7eVXFGfJVLUIRzNZMhhwWEfwW0hrzRB0C
cBg2rJjhdsq3sLXCCTyEgPnARlwl0USAHmj6ikEy1hvwTXX/D35xAvawIjgSNJKY
k5NppJvoDLoCb8LDVaQ26FNEMmMhWQ==
=gILd
-----END PGP SIGNATURE-----

--=-3ktaYI/BoNRYuZDJlXYu--

