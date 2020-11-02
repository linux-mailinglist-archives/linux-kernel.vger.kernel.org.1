Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989D32A2B89
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgKBNbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 08:31:16 -0500
Received: from shelob.surriel.com ([96.67.55.147]:50374 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgKBNbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:31:15 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kZZvQ-0007GL-91; Mon, 02 Nov 2020 08:31:08 -0500
Message-ID: <73e01c4bbd7eb7ec543a145d35b4f38b44a162d6.camel@surriel.com>
Subject: Re: [PATCH] sched/fair: ensure tasks spreading in LLC during LB
From:   Rik van Riel <riel@surriel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, clm@fb.com
Cc:     hannes@cmpxchg.org
Date:   Mon, 02 Nov 2020 08:31:07 -0500
In-Reply-To: <20201102102457.28808-1-vincent.guittot@linaro.org>
References: <20201102102457.28808-1-vincent.guittot@linaro.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-eNwraMmbQH+v8b8zu4j0"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eNwraMmbQH+v8b8zu4j0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-11-02 at 11:24 +0100, Vincent Guittot wrote:

> Fixes: 0b0695f2b34a ("sched/fair: Rework load_balance()")
> Reported-by: Chris Mason <clm@fb.com>
> Suggested-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Tested-and-reviewed-by: Rik van Riel <riel@surriel.com>

Thank you!

--=20
All Rights Reversed.

--=-eNwraMmbQH+v8b8zu4j0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl+gChsACgkQznnekoTE
3oMJKQf/RivwAGLkgEoj5UMHH3UAQ3LwFI9BqE3/w2kpz9iuP9Hbri+6HMtY72z0
YR2QzWf2H18ZeoMTzc3VLdEnhpfGKdKelprUCSPmNTy+Ovyzqo7u/giJWZjtZhaQ
FXLvX3fo21H1GTYCYv+eykenIX9ZxB6kEEFQ3z+L7Hrs/4Dnf5LV6gUJNms1OW8L
wK6AVR3PNJT4VuIRJBn5kBst/4z1749ufFJkapTf2tTaT0BcqXTLXM2oe77rWSJC
F3ciHCKngaEXbKdzKX2izV8H3nnrW4X7kSA/o+afBGvMNP5xs2t5w60vdaEp6q62
h03hWzugJkmJO/Xze8lJWQElPsy4nQ==
=jUK+
-----END PGP SIGNATURE-----

--=-eNwraMmbQH+v8b8zu4j0--

