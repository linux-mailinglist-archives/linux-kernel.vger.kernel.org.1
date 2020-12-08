Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5EF2D2A72
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 13:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgLHMOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 07:14:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:50552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbgLHMN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:13:59 -0500
Date:   Tue, 8 Dec 2020 12:13:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607429599;
        bh=mLvA4FB9gzMsXJ8QIezTtXurSP32ina1dgLS7P/tnCs=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZMVHeQyHNSPwCQMbCqYhkTXnoF9Z0QSIOtBEpu8fRMHacmE3u67zGCIb5ThVu1RDq
         vx9/bw7vyu4AOMfQfGcw0JJbrvDtOMBSxVvumIhLuvhrkd0mGhlby6plAJp2GVYPh1
         RrJ2fW2vF0y5dvorTHyn4QwahvD3EH/FikvL63w7v7dnQxaNgw1irKUt4MyUJ5GBhq
         9r3bJfmuDklX/Gu7uAJmWcceeN9m6IOquI/OZ/ex3N7kNjdXBaAMhC8otrZlzCtoQM
         znyHuaX31VvvRQO4Znt/z/ZzBRAsyfnfuEmyxh2BxpVHCKDS0x10yO1x0qxCYzij+y
         QqTB79P6JCkkQ==
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, sharadg@nvidia.com,
        jonathanh@nvidia.com, kuninori.morimoto.gx@renesas.com,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: Re: [PATCH v6 0/6] Tegra210 audio graph card
Message-ID: <20201208121312.GB6686@sirena.org.uk>
References: <1606413823-19885-1-git-send-email-spujar@nvidia.com>
 <160683107678.35139.14772386553150233276.b4-ty@kernel.org>
 <a3541d83-1f2e-c60f-05f8-4fdd8c8f4175@nvidia.com>
 <20201207123131.GB5694@sirena.org.uk>
 <14d2a6cc-9ca6-f6dd-ae83-6fc75d5361eb@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <14d2a6cc-9ca6-f6dd-ae83-6fc75d5361eb@nvidia.com>
X-Cookie: Do not dry clean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 08, 2020 at 09:24:47AM +0530, Sameer Pujar wrote:

> > No, this was sent by a b4 bug - notice the "no commit info" there, they
> > weren't applied.

> Oh I see! I guess review would be still pending then.

I don't seem to have them in my backlog so either there was feedback
=66rom someone else I was expecting to see addressed or some other issue.

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/PbdcACgkQJNaLcl1U
h9CqnQf/eMYjgDWfCNyswXGemvr7kIq6mU3xUpEyqfZR+q62DDj64lzHbDh+56qf
IQR1LbQUCVgzig4dhU3+Sz6/mjZx7kxCac+Gp//Px7tcGoG0h5vaCHszxguqF/7Y
TnHTOm76s06tVl8eS9eZf4sN0xbWQWNaq7wk1KYxorUAqpAjQU0giDPhXHDwRJWw
ogelYbCNvEVqxHTKRn8ZoMQsdatgxiyUiUu+ZXHKbUUHhAAqUhxs0cAbSdI5KDOy
Ijqlx7oYx1m6IRQpEJDonQPe4K3EYbZz5umZKB9S8zOYDmd0cGFWpbVhjZfQ/nYx
1uf+VdF8gSYdWzAYO6jkUKPEXF+eVA==
=ZNIG
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
