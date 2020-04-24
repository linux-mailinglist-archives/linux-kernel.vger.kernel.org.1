Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB771B71FD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 12:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgDXKaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 06:30:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbgDXKaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 06:30:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3461720736;
        Fri, 24 Apr 2020 10:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587724207;
        bh=+OdtIIFccCHjI9Scq9RWg/K1sKwriEJe9pYwL6WklQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tB3jgjqTSqyeMwjFp/sCwpodyEYMHWn2ebZxkdCp+vZ4OrHZzSagHHyAW/B896CQN
         9D7jMldhUHCa0mbKxI7y4rs6XZvKJq/lKCsnFFbzSPzhFrfgd8egg8sFg2DaJfaLhB
         t1+kC4Sk/nCYJNdcFIcedEjdPj/7XSTA8aXMjTgM=
Date:   Fri, 24 Apr 2020 11:30:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] regmap: mmio: prepare/unprepare clk only when read/write
Message-ID: <20200424103004.GB5850@sirena.org.uk>
References: <1587620791-5279-1-git-send-email-peng.fan@nxp.com>
 <20200423104000.GD4808@sirena.org.uk>
 <DB6PR0402MB27600084E4A040609EF620A088D30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200423112244.GH4808@sirena.org.uk>
 <DB6PR0402MB2760FBCA05C1BADB27F0356488D00@DB6PR0402MB2760.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB2760FBCA05C1BADB27F0356488D00@DB6PR0402MB2760.eurprd04.prod.outlook.com>
X-Cookie: Information is the inverse of entropy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2020 at 01:27:29AM +0000, Peng Fan wrote:

> If we not pass clk to regmap, accessing regmap registers will hang system=
 with
> Debugfs enabled.

If you're not using a cache then that'll be a problem, however there is
a flag runtime_pm in the regmap config which when set should cause the
device to be runtime PM enabled when it's accessed so if you do your
clock management in runtime PM it should still get enabled.  I *think*
that interacts OK with being in an atomic context but I can't say I've
verified.

> If we pass clk to regmap, it will make the runtime pm power high, because
> regmap mmio will call clk_prepare at the beginning.

> That's why use clk_prepare_enable and clk_disable_unprepare.

> Thinking about another direction, how about add clk_prepare and clk_unpre=
pare
> into debugfs ops open/close?

Something still has to prepare the clocks for normal operation... =20

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6iv6sACgkQJNaLcl1U
h9B1EQf+IpIBHjl3zQPdZQUD7pfBppcj+Dl0tgehdNFc5OK9GhSsWC8S04JOZXI/
LRccR9Xb6DjvKvPo7szhgF4ITiCYpgmI/OjjoLiXK2zpIHW9jcay7TiurUG8RehO
578eP3OZGzoMzCx+CDdf4t12uE2E7WMcwZge9ofgok6TAsBZG4cbCPNaqsvVwksb
M6FoMbVJUbjcxMr/555r3whUKm6szcNnH+sZa0ZOGH/dir3B5XonCsCL1QDHRn8o
BE067LLusQvrpN1+rYqIBfL01WZ1McLyDEmsRtpqoQPUOwYe+74CbtzFuHKpyF3D
SFCx5uPGcEZcCudFLc9lnff/DkGkNw==
=WuaN
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
