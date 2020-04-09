Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E91E1A35D4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 16:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgDIO0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 10:26:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbgDIO0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:26:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 140AE208FE;
        Thu,  9 Apr 2020 14:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586442383;
        bh=KAuU4LsROjVwNT+2ctOKz1WF12YzGISTSOGVssQX45k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y0CFidbo/ENn5lsg9LyA49+IbA9G9xJJxRDRUiGRzFUfdJ5TEBLHWMiPqoyDGgQHx
         h4MQ2GwTv8Me9DMJtxB3Oh7bMMvyC0IWH9kDTti64O7xZUx93qBM3/9GxoB+6tOZSw
         qng3lai9zz8LJJGSp0KcS5+EVTIToUiWiG4MwQwM=
Date:   Thu, 9 Apr 2020 15:26:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] regmap: Add reg_update_bits() support
Message-ID: <20200409142620.GE5399@sirena.org.uk>
References: <cover.1586422035.git.baolin.wang7@gmail.com>
 <f48d3b98debe5b2c1cc9a384874d6032b051a4c5.1586422035.git.baolin.wang7@gmail.com>
 <20200409104546.GA5399@sirena.org.uk>
 <CADBw62p0O6dfiMF_r0SaN3cvrmcUdmnLm55gv_c=pywwzpTjoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KlAEzMkarCnErv5Q"
Content-Disposition: inline
In-Reply-To: <CADBw62p0O6dfiMF_r0SaN3cvrmcUdmnLm55gv_c=pywwzpTjoQ@mail.gmail.com>
X-Cookie: HUGH BEAUMONT died in 1982!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 09, 2020 at 10:12:44PM +0800, Baolin Wang wrote:
> On Thu, Apr 9, 2020 at 6:45 PM Mark Brown <broonie@kernel.org> wrote:

> > MMIO devices clearly don't physically have an update_bits() operation so
> > this should be implemented further up the stack where it applies to all
> > buses without physical support.

> I understood your concern. But the syscon driver need use the MMIO
> devices' resources (such as address mapping, clock management and so
> on), if move this to further up stack, I am afraid the update_bits()
> can not use the resources in 'struct regmap_mmio_context'. Do you have
> any good suggestion? Thanks.

If the syscon driver needs to be peering into the regmap implementation
that seems like there's a serious abstraction problem - users of the
regmap shouldn't be looking at the implmentation at all.  Why do you
think this is needed?

--KlAEzMkarCnErv5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6PMIwACgkQJNaLcl1U
h9DiSQf9Er73eud1mw7uVaHpJyWfwEmuyoeLfNuefeQcQpETnJg7YAuAcCseGZHN
UM+kej8y3G1gyxP5b1fW+YN4mMxsRUPAVpCwxLn7AZEfCuqFtCr2cvVatQ6mYztE
DWpGCTPrXQxkI9/O0Ip2y9fPYn0MJFvdeLswGMn/D+NrtHqDNv+zvcJhLzUlHFU5
zu28RQGZBAf26gmw6CfsTwBOFIgDCdHMv8CIow5rD0L2cJnAXO68h0kKDMkAVBY4
UtgWB2MEfpUfBWQb+WV+I2NK7Boh4/D8RAGglARZ1U9LYf5nk1bqDUctOfIy7t4/
Nrd3y0bAkb5188aK8WbNRvdbf3N+Ow==
=oOkv
-----END PGP SIGNATURE-----

--KlAEzMkarCnErv5Q--
