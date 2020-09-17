Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED52926E027
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 18:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgIQP7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 11:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728097AbgIQP66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:58:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEB372220F;
        Thu, 17 Sep 2020 15:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600358228;
        bh=0R8wQ8wtOhNvgIX+2H28XDlxNwOFHmlyptZe/q+b84M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=prSjxzW19p/f7/IiwXidlQxWIH4yvQe3YiglaEZOzU+xmrU8Rdom+UWXBbTRDidKX
         47oehxQHgFGKaSQk54UP3d5JFCxVhVjp7Z2ltXy9Ke6DVUeKqG61MIDETd/c0i8zSC
         hjUAYjlLMOFUMr0yoF6qhtl/U0F7s3ucTW+AdapM=
Date:   Thu, 17 Sep 2020 16:56:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, camel.guo@axis.com
Subject: Re: [PATCH 5/6] dt-bindings: tlv320adcx140: Add slot programming
 property
Message-ID: <20200917155618.GG4755@sirena.org.uk>
References: <20200915190606.1744-1-dmurphy@ti.com>
 <20200915190606.1744-5-dmurphy@ti.com>
 <20200917130236.GA2954@sirena.org.uk>
 <f4a83c01-58e2-1b7a-677e-44d5bde7b175@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+sHJum3is6Tsg7/J"
Content-Disposition: inline
In-Reply-To: <f4a83c01-58e2-1b7a-677e-44d5bde7b175@ti.com>
X-Cookie: If you fail to plan, plan to fail.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+sHJum3is6Tsg7/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2020 at 10:15:27AM -0500, Dan Murphy wrote:
> On 9/17/20 8:02 AM, Mark Brown wrote:

> > This is something I'd expect to be done by the machine driver rather
> > than in the CODEC specific DT bindings, and apart from anything else

> Customers need the ability to not transmit on a TDM slot, since another
> device could be using the slot.

TDM is not an issue, we already have the set_tdm_slot() API.  The issue
is how you're configuring it.

> The dai-tdm-slot-num would be a good candidate to add to the sound card to
> define the slot number but it's definition is "Number of slots in use." So
> it is not really setting the needed slot.
> I am not finding any good way to assign specific slots to specific channels.

If the generic features are not sufficent then please extend the generic
features rather than bodging around them in individual drivers.

--+sHJum3is6Tsg7/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9jhyEACgkQJNaLcl1U
h9B6/Qf+M5hvEXVKhLg+PkuggYW/zHPqIs79pJjddV/tkBhy612mpeKAAj8Crp4G
WTsAdCZ8gh0xhUu5quFCArp73bD+tVGMcp2OidYjpG9sZ/4sBW36oYeBRei3zPw0
531VEYn5lS95/BbYlXyTJGT09zHbPRIv2PReev6s+3pUmK1DFsgaLitDRwLz+Ndt
DiJLHewySrOXdvwg3VBE04nQjYW5qAgkF9EVKAyKU68NKpAw3NAYcaIlOe7KFubg
Gy1yyCiYFNmdfDGcGJ+H8JdhpvUKc8fh4dUbNJGl5n1X3S4R78IunjNw9fnR/l3U
yiO+EE3d5A1qgWqlUDXSOLr+om19xA==
=OC0y
-----END PGP SIGNATURE-----

--+sHJum3is6Tsg7/J--
