Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4536A27C4E1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 13:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbgI2LRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 07:17:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729172AbgI2LRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:17:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 603C821D46;
        Tue, 29 Sep 2020 11:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601378226;
        bh=hI0i6iq8KBS5xcshw5o5PCNNOwrKpBjtblqgVD/O5qM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VY/kRn0Rp9wtMetOMZ4H8POmNk61b2oBEA+1NnW8R44ms7F9G00+zw+oRYEYCjztx
         M05XngGRuYBQetCW5IG9GanhpLUM8ObnGkrQ/vTbTbR7r/luK9pKTAzrybjLOoocGS
         nBSBrhkNWDW/9KiMGxvepvMqSrtoHZfw5TmBxKIU=
Date:   Tue, 29 Sep 2020 12:16:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: sound/soc/ti/j721e-evm.c:528:34: warning: unused variable
 'j721e_audio_of_match'
Message-ID: <20200929111607.GA4799@sirena.org.uk>
References: <202009271553.4OjMpGkX%lkp@intel.com>
 <76cae106-b643-57a9-e82e-48e46ebf1b70@ti.com>
 <CAKwvOdnsQY6S+3zAH6_SD0ifbUaSDFj9mBdhF4GVq6VB=tjFsA@mail.gmail.com>
 <20200928180412.GA4827@sirena.org.uk>
 <c97e8363-1e8e-38fe-3214-cff47f09e459@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <c97e8363-1e8e-38fe-3214-cff47f09e459@ti.com>
X-Cookie: I left my WALLET in the BATHROOM!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 29, 2020 at 09:00:02AM +0300, Peter Ujfalusi wrote:

> The ifdef would be preferred if the driver could work in non DT boot (to
> save few bytes) but since it is not the case here:

What I'd *really* like would be something in the of_match_ptr() that
flagged that there's a reference to the table for the purposes of the
warning but still lets the table be eliminated by the linker.

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9zF3QACgkQJNaLcl1U
h9CZuAf+Ij3HfuLkZJWbEfxbfM3dYO8XiA5hlj+nrX9Ct5qyHSq3IpRbuvLK3AN1
4dhUoXDHQlyDxLPLLQl6RRsJ6BkXj3ViS5shyt2TZKTSCMZ7FddMQeMB+n/GBonx
F/cg06ab2e6+i+f79QnHMBveNqmqvG7CfJyjeHviR731da4H4a+n/ZCTnGor+oF0
lccFHhSmWCQgT50CKcz+378ceVU2nESlTkgmCr+QNPKI3BHRmgZnt4OPDO3Ackvo
6epGaQB0MuM4vNA1iUoBLQZXx4JX2C7smvLJijjqXhRwF2j9HT5/HLT6H56o/iXo
EDYsLYxGZn8sycp08doT9QZyxjTxbQ==
=Fm8B
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
