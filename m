Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB55B2F53BF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 20:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbhAMT5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 14:57:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728712AbhAMT5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 14:57:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEC642074A;
        Wed, 13 Jan 2021 19:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610567795;
        bh=9jQZjFnRRXETKWmHlHdcb266jCQ0g5AH3jf+EwgTbiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lHjrij22PtUHViWHFwAIiyKbKCk63PJk5WmUsrxKmQK5DybhTKrSF79NQMUnD2/ZE
         cwIerK1W6kZydKyEYwAJJmMQiXWamRkDXFC15R9mR7INZOQkQqrvjLbnivZar5Ayad
         oZmRdsNWT9gASnyuKFewZH2R21awNvInl2C8uCuU59B5MUutdKKUaeAoaZIKQpFRi4
         kLSSCDe3Kl7+Szf38kXqDgW2Dl1WmvvMswASWqwskibNtFQJCJZN51CDCk4aEe3mOk
         MHHuvdf5i47IHfYzH6jtk8cvx58pmKde4vfgg64SuoqyjZUqN0FxwP8jV/SvI8B7WF
         uLrrb1z00obeQ==
Date:   Wed, 13 Jan 2021 19:56:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: asm-annotation: clarify .L local symbol
 names
Message-ID: <20210113195601.GH4641@sirena.org.uk>
References: <20210113165923.acvycpcu5tzksbbi@treble>
 <20210113174620.958429-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mhjHhnbe5PrRcwjY"
Content-Disposition: inline
In-Reply-To: <20210113174620.958429-1-ndesaulniers@google.com>
X-Cookie: Ignore previous fortune.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mhjHhnbe5PrRcwjY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 13, 2021 at 09:46:20AM -0800, Nick Desaulniers wrote:
> Use more precise language and move the text to a region in the docs to
> show that this constraint is not just for SYM_CODE_START*.

Reviewed-by: Mark Brown <broonie@kernel.org>

--mhjHhnbe5PrRcwjY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl//UFAACgkQJNaLcl1U
h9BIVAf/WpmBBmie3tfOZiThvDtrWYEWvmxUIzs/fQpmCJgRU6VMXCEyvJME9Zm4
9GG0PRk7OgBZJEfRnrR6ObHe1kzItzYYqM1eDOqaN6WVR4hFU0eS6u62OM12K/pX
T86Zan3bnKeY/ojPiwSDngTbfH7vwFkw/4hJaU0EisF60J0xPG0+KvkS9kl5mIut
aznGysyovGjwTPTsLF9c/rD3HwOkvt/oCsGE8SKpT5FwsNXUhNvCVE9iGYvCOrsD
duTSOQxJn4sPldBsCanOW6IokAkCcgqvsdkCLuOhy4SnNFTMtu8+igzaZ3+OnGA5
/F9fsrjAvMNN/vMDKzkWgvcMw6csHA==
=aXmY
-----END PGP SIGNATURE-----

--mhjHhnbe5PrRcwjY--
