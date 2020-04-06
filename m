Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED9F19F41C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 13:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgDFLHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 07:07:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbgDFLHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:07:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31DE6206F8;
        Mon,  6 Apr 2020 11:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586171225;
        bh=MW0KG31dJrppaZHP8FQnU1F/hl4SWfSAkuygfDdzRsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vYBvA3+sGFhq3yTKh+ucCBVysSRVEhv8kbTZ7mUax4BlKAv3D4fK5qjUXj7Z5gLgl
         TISEdcdQC4Yw6kKUo0xsMd21GDTjBeoWPMIjRqPbpl8tuQjZBP5dWfsAI/LfpptVzJ
         V/SAs1M5qygo+k2m9swv+YpL4hpf8/q5LkRknr1E=
Date:   Mon, 6 Apr 2020 12:07:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     lgirdwood@gmail.com, heiko@sntech.de, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: sound: convert rockchip spdif
 bindings to yaml
Message-ID: <20200406110703.GA6837@sirena.org.uk>
References: <20200404115225.4314-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20200404115225.4314-1-jbx6244@gmail.com>
X-Cookie: Serfs up!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 04, 2020 at 01:52:23PM +0200, Johan Jonker wrote:
> Current dts files with 'spdif' nodes are manually verified.
> In order to automate this process rockchip-spdif.txt
> has to be converted to yaml.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6LDVQACgkQJNaLcl1U
h9At1Af9FC3z9FsNzTwUOLATMox+yRod2jIFEGJXPViju4E8V2EuoclTbhXAgNQ+
HpPLozVdeSMKzCNs57EAKph0W6rKpkaGz5R9NliqRohe0OiQpnIhftVJMHawgqCl
0e0hzX3E+R+1hOa6R2BDTdTHuA+xk2oni8V6w/MW4LVuZZ13fl2Pxa2y5dOdp+ER
woZL3J56Q1b6NkKdYWyCMZgj/GfOb8FFVfC0Dp4BTQh0VO0V2KvwCdklmWXqYC8D
kkHkggw+t/98qhSUrBu+L4FvXYwc17OzhJszkbJWGLoA83ogbf12Nqm4X2ftyteA
p+R0xiHc+axQuwhe8ch0Ei0ZBAJxvg==
=VqFs
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
