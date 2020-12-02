Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A53A2CBE41
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgLBN1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 08:27:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729912AbgLBN1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:27:42 -0500
Date:   Wed, 2 Dec 2020 13:26:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606915621;
        bh=4SVKTK68z2uSzhZ3nL6cSTXQ057ruyqG7n6QRt1xlhk=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=yVIGf+IZC4u42UgWX+RWc46HStFhAhtelq83qpWXXS0d1sQWF6HUHCEFQkeVE8JeY
         9UBckd8/f960JEXXsfEN9d7EzLtcYcwPjN89n3ByYLCaKCDEr9HQH+xniVcBGCcAY5
         FJ+fyhmWYo6v0SiRsBDlrqN8OrYpMIqgD//vRvuo=
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH V2 0/1] regulator: da9121: add IRQ free to release
 function
Message-ID: <20201202132632.GD5560@sirena.org.uk>
References: <cover.1606908582.git.Adam.Ward.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Content-Disposition: inline
In-Reply-To: <cover.1606908582.git.Adam.Ward.opensource@diasemi.com>
X-Cookie: Sauron is alive in Argentina!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 02, 2020 at 11:32:46AM +0000, Adam Ward wrote:
> This patch fixes the DA9121 driver to disable the IRQ before cancelling
> the work, to be sure the IRQ doesn't restart it before all IRQs are
> masked

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/HlgcACgkQJNaLcl1U
h9BmZQf9GeH39vrg0+eYmxhxMsy91ajEH3BdGyWVn5CVbFfbqNatjWIn23SH5SGW
DAeP4VvvXdKELezwFvJEhFFEANthVlmzuaJkHrrXC0uNHwEL/qfSCR9pc4fLGDpm
f623FZUXt3L8cWa9AOLkX0txVRhTG3zqKCZAbx5LS2dTRSK3caD6lhBzbDX4/lzf
I5No1Uk8avGsxeeY7O48Dq16lXcdC2pmOc+1qR7TqgaYWQw95YPIJi2rOjAxiMbv
bJISgES8ETMVNBAThJw5CgDuZt6aO3AazH6C3qXECkthOyiHwZbKIb6U+WUjo7dp
u1GN9qEWb93VsLKloIDXvna9M67D4w==
=vC4H
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--
