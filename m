Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7492A9DED
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 20:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgKFTXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 14:23:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbgKFTXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 14:23:13 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32F5321556;
        Fri,  6 Nov 2020 19:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604690592;
        bh=Y3ut59jXHtQp0vLc+aZd5HvHs4ChF7J8vM/b0O7PlIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1645cjuCx2YwVQ4o1kng4ghs8JFBUvMbavw1EIZ+8y0DktvT3g0zi2czdXllZHn08
         Wkl2GfYilaEpdf0BOs8Zgg5f/x6polzhfMCUsr0nPkMSGRWELkVaohX5DFu4VHhCt1
         eTw6iK9Usc6rp6KIc0ppFmOcUNLLxpOdFB6doS98=
Date:   Fri, 6 Nov 2020 19:23:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Mentz <danielmentz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH RFC] driver core: Ensure DT devices always have fwnode set
Message-ID: <20201106192300.GG49612@sirena.org.uk>
References: <20201106150747.31273-1-broonie@kernel.org>
 <CAGETcx-abGAgYrHM0jm6hVkrJ5KvfhK6gCZ4Y6RY0msPJDCuQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Content-Disposition: inline
In-Reply-To: <CAGETcx-abGAgYrHM0jm6hVkrJ5KvfhK6gCZ4Y6RY0msPJDCuQg@mail.gmail.com>
X-Cookie: When does later become never?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0z5c7mBtSy1wdr4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 06, 2020 at 11:09:17AM -0800, Saravana Kannan wrote:

> If you want to do this in "one common place", then I think the way to
> do this is have include/linux/of.h provide something like:

> void of_set_device_of_node(dev, of_node)
> {
>     dev->of_node = of_node;
>     dev->fw_node = &of_node->fwnode;
>    /* bunch of other housekeeping like setting OF_POPULATED and doing
> proper of_node_get() */
>    // Passing NULL for of_node could undo all the above for dev->of_node.
> }

That also sounds good, particularly if we have a coccinelle spatch or
some other mechanism that enforced the usage of the function where
appropriate, my main concern is making sure that we do something which
ensures that the boilerplate stuff is handled.

--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+lopMACgkQJNaLcl1U
h9DUQwf/V0RSkpyIL4FEcj3BUW/M22qomf9RcalybT/vs4vdIQaiAlhX/OM6dX/1
Wfrq3dNmTQNqiwaWALRSYOUDZUAf/SGkT9uAzLCNDq1U3Y58CCBVxm04/olb7p97
b6PIMdNXjeUlnxC+llq5JsRxzkKpvXF0kcKiCIAy61OsuVRRlzF30GXNejZIu+v9
H+qlGDQBIgR+MKHilNDx8ejYGxTtxtttd6MdBzQxMpop4QK/lddpdtaWOHZWh7mP
mtO7T9fWCDM2X5flpLQFZllLjtaVAd3JhDt4vhlgpuevBnUQ9o7nmBJZhapuYziP
OJwsk/SKxB7xHHGnoeAxKkIzupQ1jA==
=Jznh
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--
