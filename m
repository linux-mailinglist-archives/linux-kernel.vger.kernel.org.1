Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0952840B0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 22:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgJEU3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 16:29:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729575AbgJEU3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 16:29:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 843522100A;
        Mon,  5 Oct 2020 20:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601929784;
        bh=d4XpU2Q/J1qRRrp5vOFYEOBeWqWUmEYKvsPjMR46CUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X0BNoMmbzt073ozAL6GqbsFEYoMwLBAX7Xy28FG81kawUIRlC72ZnxnHecrQ2JrxG
         C5Q+loCy83it5Fc9IxswLnN/w/hrpIWGtp0DefGZrkMLEBs8NEIh2I8JcY61VvQ0YT
         yv3KRp0BMnVcBd2xpxb/MNc9FdUPKjj0pxqnPbIA=
Date:   Mon, 5 Oct 2020 21:28:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        ardb@kernel.org, will@kernel.org, catalin.marinas@arm.com,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG][PATCH] arm64: bti: fix BTI to handle local indirect
 branches
Message-ID: <20201005202840.GJ5139@sirena.org.uk>
References: <20201005181804.1331237-1-jeremy.linton@arm.com>
 <20201005195957.GF5139@sirena.org.uk>
 <c554e7cb-2773-a49f-a126-fdc56be029ca@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LG0Ll82vYr46+VA1"
Content-Disposition: inline
In-Reply-To: <c554e7cb-2773-a49f-a126-fdc56be029ca@arm.com>
X-Cookie: Most of your faults are not your fault.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LG0Ll82vYr46+VA1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 05, 2020 at 03:10:42PM -0500, Jeremy Linton wrote:
> On 10/5/20 2:59 PM, Mark Brown wrote:

> > ...this is going to cause problems, SYM_CODE means that we should
> > assemble *exactly* what was written since it's some non-standard thing -
> > we use it for the vectors table for example.  Looking at the code it's
> > not 100% clear that the best approach here isn't just to change the call
> > to a regular function call, this isn't a fast path or anything as far as
> > I can see so it's unclear to me why we need to tail call.

> Well for some workloads its could be AFAIK. OTOH, Ard mentioned dumping the
> tail call too, and I think that is pretty reasonable. So it looks like that
> is a better plan since it also avoids all this SYM_ flailing.

Yeah, I think that's the easiest thing all round.

--LG0Ll82vYr46+VA1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl97gfcACgkQJNaLcl1U
h9AGKgf/TpwsU5LActmSW1rJZkGgZPIPBP+iIcOuBL8Y5mjrzR3NagJHB5Du4BwG
hgBKU5KYqasnZMpmoWOnjPY9j+N1KJmK3ew4VCHARKX4PSQN8KukRTCXWDmRe0UK
F6drKioPyA1gnLOAjfEkKiLIGwFPbU7/KFeOY9Oe8bUELZyBgz7Jta8ipXR7sX5F
sHcy3PXcPTqx3HUPYFtQHDZkECWL2/ckpdCsYfCj/iqald9xGo2PQiulZSWUfRxK
//tCe0g/kVn2aGqHMhjs02VP98n0tiO0Z6SnlJahmTtjvDluONtGIAKhYsPjOAs6
1Fc2NVJRnkghtsY6HaoX1WMS91ghkQ==
=SIFO
-----END PGP SIGNATURE-----

--LG0Ll82vYr46+VA1--
