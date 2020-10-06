Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86732852A8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 21:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgJFTtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 15:49:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgJFTtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 15:49:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8579D206F4;
        Tue,  6 Oct 2020 19:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602013751;
        bh=R2q/mfvkScKT8OF+sG32Zftoq0jL1opdo71Jm2tm6gU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AYWhfzovLnaDoIyndpCrBOUxSQyNlQSAFCLRlEms+6kZoAV8uLVyIqUC4F5p7jSAI
         w9/ufh9r33ywM76TkqwTM6KAt2/vumW66BkuTos0A0rpYDVGugqmTqbbdRhTcLGeHw
         LlERyMUyFLKErJU/PNnMP7ukojHvj7mWmk7tPEAM=
Date:   Tue, 6 Oct 2020 20:48:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] arm64: random: Remove no longer needed prototypes
Message-ID: <20201006194806.GE5259@sirena.org.uk>
References: <20201006194453.36519-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J4XPiPrVK1ev6Sgr"
Content-Disposition: inline
In-Reply-To: <20201006194453.36519-1-andre.przywara@arm.com>
X-Cookie: Will it improve my CASH FLOW?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J4XPiPrVK1ev6Sgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 06, 2020 at 08:44:53PM +0100, Andre Przywara wrote:
> Commit 9bceb80b3cc4 ("arm64: kaslr: Use standard early random
> function") removed the direct calls of the __arm64_rndr() and
> __early_cpu_has_rndr() functions, but left the dummy prototypes in the
>  #else branch of the #ifdef CONFIG_ARCH_RANDOM guard.

> Remove the redundant prototypes, as they have no users outside of
> this header file.

Reviewed-by: Mark Brown <broonie@kernel.org>

--J4XPiPrVK1ev6Sgr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl98yfUACgkQJNaLcl1U
h9B1Pwf+OLhjyzRF2lkNPf4Y+CmWvzZjq2ZGfpjlevCMeaCDlTeh85Chgwj2pJW+
ztEAboFon7CZnnWWL0AQfzRr55U7uIAiXZXXmGYYSQDO3R5vfwYrwH5UvuhfWCVv
f0Cgep/Alq1dBn6GFnArnrwj6g8o7+OPlG3oQdCKSd7Ul/PLu8mH9oleyKTJQdm1
InpofV8Msi/tae39UBg78+nb8Wbr3qK2J8o8mRpS3h2Q/dyDn1WzBYPjzzMuZtLk
G6acrHYZVnbINeLrXFWbpdy8kKHNy4aEIUiJqjlTJGAxXwf3UDfwkEVBy0TfwE/j
31uKdjOf6kbzAaEAi9puyKEeJ8nAuA==
=fAYO
-----END PGP SIGNATURE-----

--J4XPiPrVK1ev6Sgr--
