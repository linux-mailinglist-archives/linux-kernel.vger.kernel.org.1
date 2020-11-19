Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB312B9DBF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 23:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgKSWm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 17:42:59 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:54716 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgKSWm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 17:42:59 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 95BCD1C0BA2; Thu, 19 Nov 2020 23:42:56 +0100 (CET)
Date:   Thu, 19 Nov 2020 23:42:56 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Desmond Yan <desmond.yan@broadcom.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v7 02/13] misc: bcm-vk: add Broadcom VK driver
Message-ID: <20201119224256.GA16032@duo.ucw.cz>
References: <20201117232320.4958-1-scott.branden@broadcom.com>
 <20201117232320.4958-3-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <20201117232320.4958-3-scott.branden@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add initial version of Broadcom VK driver to enumerate PCI device IDs
> of Valkyrie and Viper device IDs.
>=20
> VK based cards provide real-time high performance, high throughput,
> low latency offload compute engine operations.
> They are used for multiple parallel offload tasks as:
> audio, video and image processing and crypto operations.
>=20
> Further commits add additional features to driver beyond probe/remove.
>=20
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

> +++ b/drivers/misc/bcm-vk/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Broadcom VK device
> +#
> +config BCM_VK
> +	tristate "Support for Broadcom VK Accelerators"
> +	depends on PCI_MSI
> +	help
> +	  Select this option to enable support for Broadcom
> +	  VK Accelerators.  VK is used for performing
> +	  specific offload processing.
> +	  This driver enables userspace programs to access these
> +	  accelerators via /dev/bcm-vk.N devices.
> +
> +	  If unsure, say N.

Could we

a) align the text the usual way

b) explain what the VK is here? What kind of offloads does it do? What
does "VK" mean?

c) explain where such accelerators might be found.

(Is remoteproc framework unusable for this?)

Thanks,
									Pavel
--=20
http://www.livejournal.com/~pavelmachek

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX7b08AAKCRAw5/Bqldv6
8sUPAKCpXNCUGytbE4HxieK989H9WXCQ6gCgwXNSMofODhkvkPGnBie/ycqIFkQ=
=nxou
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
