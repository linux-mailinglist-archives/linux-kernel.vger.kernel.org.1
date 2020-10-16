Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DE4290833
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 17:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409854AbgJPPSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 11:18:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395343AbgJPPSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 11:18:40 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E891C20897;
        Fri, 16 Oct 2020 15:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602861520;
        bh=rgeQjAZ0kzxnk8SwXsOvCKN7o5QSYlfcQcgpKjlVIBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xOFC0xX1gIoo4Cbk07OV9cXGBwYcCa9MigKKW1zmacVlTi811BbqPB4d805bK3D7z
         wEt5uMbXHm4huhSU6vgLL+2AtqkdgW1XoSV0iBeKGnzZ2ewKvOTR3rmYOHNW3rV/uQ
         Kg90usJVdKnr6IvoZcAkhmQNdFzSxraX4Q7b587A=
Date:   Fri, 16 Oct 2020 16:18:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     robh+dt@kernel.org, nsaenzjulienne@suse.de,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 0/7] Add dts for Rpi4 + Cirrus Lochnagar and codecs
Message-ID: <20201016151831.GE5274@sirena.org.uk>
References: <20201014145418.31838-1-rf@opensource.cirrus.com>
 <20201014185632.GD4580@sirena.org.uk>
 <b3376cd4-010f-cf72-8c81-1f5d22cb6454@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="10jrOL3x2xqLmOsH"
Content-Disposition: inline
In-Reply-To: <b3376cd4-010f-cf72-8c81-1f5d22cb6454@opensource.cirrus.com>
X-Cookie: Pournelle must die!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--10jrOL3x2xqLmOsH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 16, 2020 at 02:30:08PM +0100, Richard Fitzgerald wrote:
> On 14/10/2020 19:56, Mark Brown wrote:

> > Why extend simple-card and not the more modern and flexible
> > audio-graph-card?

> I'm struggling to understand how to use audio-graph-card where there are
> multiple alternative codecs. The host I2S endpoint has to point back to
> the codec endpoint, like this:

OK, this seems like a more urgent problem to address given that the
graph card is supposed to be able to support things like TDM.
However...

> 	cpu_i2s_ep_cs47l15: endpoint {
> 		remote-endpoint = <&cs47l15_aif1>;
> 	};

> But obviously that depends on which codec node was enabled. Listing
> multiple endpoints makes the whole port node disabled if any remote
> endpoint is in a disabled node. I've tried adding status="disabled"
> to endpoints or multiple port definitions with status="disabled" but
> I haven't figured out a solution.

...it seems like the issue here is that you're essentially trying to
define multiple cards at once in the same overlay.  TBH this feels like
you want two nested levels of overlay, with the extra layer patching the
CODEC compatible.  Or if this is mainly as an example for people you
could just pick one and use that?

--10jrOL3x2xqLmOsH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+JuccACgkQJNaLcl1U
h9AnaQf+LQ6dXnZyQXkJi780zdCEyQ12TcEOc3Mb5/WE51kiHuRDa4Luy5Xk97Gt
XI6V2WO9lJyYVgZt5BgLjAJJohah5WBPo+ShXgwgZI1bo4Y6N+6jctbqC6/DPtHe
yIKyeZMlemrwsqbuRJI937EZMfGRhdF5ba8JymF6N7K8xjjZyls0g/VE8KqOZjFr
7MUpgcSaWVeazF8LLRcQkhA8f4YT0mnMuFtvy07u4plMMyxRTtNdF2szMHNY9rTu
Lnhd8/OE6tNFNnoEeAzrREHbeuqtQ4NCSiTl3vEfO4yMR/cby7caXXdSqODGYhC9
gPAU+bIAOvQQV6vzj+AX9zbuVE/C2w==
=H9bK
-----END PGP SIGNATURE-----

--10jrOL3x2xqLmOsH--
