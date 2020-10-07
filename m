Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5777285D45
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 12:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgJGKtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 06:49:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbgJGKtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 06:49:42 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C902C20870;
        Wed,  7 Oct 2020 10:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602067782;
        bh=1wuWrBxTStM0az/awlDUjLP9jEWZ5Wpim0mWksWSOUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cPmVZRUwByaoivWI1uqYU7zS5g9j5p/qV2QRVTG29W6uwF5tMLyYP3nNpY1J4NUTX
         7JMG/znA/bnbXIHJWikzQM73gt6MQd5pa/TdAklZizIUrmK5f7cYYxo0S/43gypMtr
         +jKrye872fH2qRyuYsmcN8LAF434DjiLsK9L6arg=
Date:   Wed, 7 Oct 2020 11:48:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: Add support for SMCCC TRNG firmware interface
Message-ID: <20201007104838.GA5030@sirena.org.uk>
References: <20201006201808.37665-1-andre.przywara@arm.com>
 <20201006201808.37665-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20201006201808.37665-3-andre.przywara@arm.com>
X-Cookie: Two heads are more numerous than one.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 06, 2020 at 09:18:08PM +0100, Andre Przywara wrote:
> The ARM architected TRNG firmware interface, described in ARM spec
> DEN0098[1], defines an ARM SMCCC based interface to a true random number
> generator, provided by firmware.
> This can be discovered via the SMCCC >=v1.1 interface, and provides
> up to 192 bits of entropy per call.

Reviewed-by: Mark Brown <broonie@kernel.org>

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl99nQUACgkQJNaLcl1U
h9ALVAf/RE8cMKM1nbggP3489Btap0JuTt7uhwVRspEJ7WG/WHEeSWvW6tTQZhCf
A+HVamghoOcekfVOT9QFFiN1Z8WdMsXcFOkmdAb6IonVGL7qz+d3f47wbjk2LnE6
Fucf5tZ3VKJ0FePTC3CkFu3zPnJYqGtEi5DX0krnTWy3hXDcVk+KeJsaK4g9VUak
Jh6YZvzVbZPgtvN06klk30W40cN1mFTpuiF+vx/tjh24cAkOZ0hSwNAzsd0ZxyMO
DYA5stPpUTa9WDqPTura3byuDUvhwWy7Xktb//zC6aJcg1bCoblr8x/SNbXNgeHu
3X8l7zZx0VwsECUOUe9jqc5bh2Lh2Q==
=QBrs
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
