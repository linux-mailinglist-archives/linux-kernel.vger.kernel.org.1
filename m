Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9296D2CC902
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 22:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgLBVjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 16:39:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:52512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgLBVjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 16:39:22 -0500
Date:   Wed, 2 Dec 2020 22:38:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606945121;
        bh=iIe1gAuOR+SptbL3N66ii+6qlvJFb69mEQmMW1jiGJs=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbE4eyUqy9auVcbmUNHu6bXtCp4Nx8zY7KzZHrNvoPptdpDpHRZe0GZ8ysaeObwY2
         u0TDtCHjiAphWjDPHLYU+8j+T0kJcu7qp0QsDZOL01Lv99tR4Emrc47YKVflhF4k88
         CwnNYlmqujnUoZrWS2FVXBptV8+17SujlshfAlHOO79fOrE6f5sfPjsr1vXnULK4mK
         GVxkvxdQiZIv8kgJzTikHum6g+OSB0X4C/q3S7WbMrvS9u8Aad67+BRK8qifYeZJ4H
         3dq60dALAL4zERtz07y3z50bSlXqn6xnW3dJQFraMWep19JlgC2d9vg1IDqMuamQJ4
         KANKTGlH19Jsg==
From:   Sebastian Reichel <sre@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/16] HSI: fix a kernel-doc markup
Message-ID: <20201202213838.5wgnkb4zgw3mynuj@earth.universe>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
 <a921e2212afc39f562a8015104e107665ca495da.1606823973.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sngbhji54ilx3bah"
Content-Disposition: inline
In-Reply-To: <a921e2212afc39f562a8015104e107665ca495da.1606823973.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sngbhji54ilx3bah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 01, 2020 at 01:08:54PM +0100, Mauro Carvalho Chehab wrote:
> A function has a different name between their prototype
> and its kernel-doc markup.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---

Thanks, queued to HSI tree.

-- Sebastian

> [...]
>  /**
> - * hsi_unregister_port - Unregister an HSI port
> + * hsi_port_unregister_clients - Unregister an HSI port
>   * @port: The HSI port to unregister
>   */
>  void hsi_port_unregister_clients(struct hsi_port *port)
>  {
>  	device_for_each_child(&port->device, NULL, hsi_remove_client);
>  }
>  EXPORT_SYMBOL_GPL(hsi_port_unregister_clients);
> [...]

--sngbhji54ilx3bah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/ICVYACgkQ2O7X88g7
+ppNlQ/+IRn74BUBYU0emWmvMLRfs16uihIAP1WRsqNKZG9Gp05a15HpAsHtqGRD
nDuEKoYMv4gYuFha8O8+yBNs9aKNkT+RYsnDPEE9kcFZOQU38oixKhuLFQW2BzPr
YPxu61i/sHZsq7q6GkRjzfYksNHOUUAIFMePFzelvClIaNLOmQARe7Kh2/M7+sXS
q6hxLH/zozwgbV+dq5tIIC84L9MBS6auuoY0YL4Ql1c2cfZylQY8vj2qqqrQjmyP
m3xegxHlH0o7DmhcpqDfw/nlwDrFu5Y/if/TFKeH90iG9pkLzZdKbizUylcrNkJ6
uVA9S8zjIDF7dC2d7gxzJyIaM7UzX9e8l4gpRDTU9uJlhfxH5E1GXgD+ooZXXHto
U3Vak4pebO8usIUI9dALjWqRsyOT9/yy7WD9+GzO+StLeI2+IvVSkb+9AibO6qP4
q/lsXSg86PlMf1GrxXTRjrJ0u2m8CY2kPU1FOEkz6xHBb2PBRbVEt/9lP5RhII6q
lXlnyud6CjbW2M8aL7+Ijzad92RDFMTggLEP/JvX8eP0PzAMYr9iF3KYVkE6QXvc
jN4Rv8kntcso+mLIeMgxoaC1pINlZF72fgYfr2HK/pEB4DP3Ciq4v9QGgXiLZx2J
9Nqa041efc2widIqXB5FPeTD0FWlEgXVBjBVM7HqvdNEEoLjdkE=
=WWQE
-----END PGP SIGNATURE-----

--sngbhji54ilx3bah--
