Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BF02A84D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbgKER1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:27:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:59862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgKER1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:27:19 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D23A2072E;
        Thu,  5 Nov 2020 17:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604597239;
        bh=JVyaK2Bc+3BkcXl4M6uXDnBk+5oS5ZI21JmwYz628WA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o5B7FAL9v3LzHw6/5YkZUC5Xs79j+7XEW4Rg9fgEvOZSSKTEddHftksj49lvIG3cs
         L0J+ab7qIQzj24xDJTxFPr79AI6DGjV+a+NkpcR8qO4+4jgbvPXPAyi12TIJr9c283
         A48gsSZVckOf4u6j6PyJcm1hOf1FXNe958gP2EG4=
Date:   Thu, 5 Nov 2020 17:27:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>, lgirdwood@gmail.com,
        mripard@kernel.org, linux-kernel@vger.kernel.org, wens@csie.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] regulator: debug early supply resolving
Message-ID: <20201105172707.GA4362@sirena.org.uk>
References: <7ede83e8d78414d8618e1044fd8fd11e8ed7a09f.1604544767.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <7ede83e8d78414d8618e1044fd8fd11e8ed7a09f.1604544767.git.mirq-linux@rere.qmqm.pl>
X-Cookie: Sigmund's wife wore Freudian slips.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2020 at 03:54:07AM +0100, Micha=C5=82 Miros=C5=82aw wrote:
> Help debugging the case when set_machine_constraints() needs to be
> repeated.

This doesn't seem to apply against current code for some reason, git am
can't find the SHA1 it's based on.

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+kNeoACgkQJNaLcl1U
h9A8IQf/SlNkNhXB5bJvzN8QMoDCSxD82Zs4kyisWxTnEXVit+JxydCI4yHs9Pi6
+galPeEaMhHjRizn9RTmlEZ8o4QVEegPdyOcyEFBZWASpzDvLZImhZasgpNHB2n7
T1C5wASEAzkhSu9bW22KzVAEykxhb0EinforCVj3xTWEKJMZhZ+qL4W4pROO8vw9
AqHdVt2MSSWQEhiWnDRzW/qaei0cVPqx3NSi8i4SEyLJanuGV7tiyRA0uNbNlfXM
+Bx8gtrroqe0UyjDggaxPYxD+2VKDlsdjPkJBOsSRpa+0sMrMZnAgPZrmDOwJKqX
TzPE1V7bdMb+TGUDZxllugHj7siRCA==
=yHXF
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
