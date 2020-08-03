Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B075123A4F7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 14:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgHCMb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 08:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbgHCMbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:31:53 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3B9C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 05:31:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BKy1c3Stbz9sWK;
        Mon,  3 Aug 2020 22:31:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1596457908;
        bh=A1RYpQrdZ8SRLEMPPRLnaD8brc08MDwIZqWIqkU3Rgs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RN7w1oMw6XcjGMfR7TB4ijQsBlMR4XTWWlqQHCYWI7rPdKDuhVf3mf1xJH4dCKvK6
         XAUtVLQllopcGiL1O5+K1/IoVxLu33I9uEPX/WECRZZLPtqkrBSmwEwmEgKPRaYMpR
         csm68F1yGYLkkrHJ2OJZCCprywMrMslVUR1CxGCPNHxDhEQXlfMy4GvK7+2HaqF/tF
         21yOmkkoWKvsoA4S/1widX/fK8PYJonub0DKeP4aGVBQSoQQFYDFi13mTvLzDus7Sj
         HKDARDhm3x4eo17XHW8Wf34v3DzLTPtyeJhvmzLQV8di/snc2cUriJhVE3j3GQj1LB
         K0eZD5WjF8Zlg==
Date:   Mon, 3 Aug 2020 22:31:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Willy Tarreau <w@1wt.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: powerpc: build failures in Linus' tree
Message-ID: <20200803223147.28adac79@canb.auug.org.au>
In-Reply-To: <87v9i0yo47.fsf@mpe.ellerman.id.au>
References: <20200802204842.36bca162@canb.auug.org.au>
        <20200802172019.GB26677@1wt.eu>
        <20200803034547.GA15501@1wt.eu>
        <87v9i0yo47.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gTzTE=0PurNyae0JTgphoQ1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gTzTE=0PurNyae0JTgphoQ1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Mon, 03 Aug 2020 21:18:00 +1000 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
> If we just move the include of asm/paca.h below asm-generic/percpu.h
> then it avoids the bad circular dependency and we still have paca.h
> included from percpu.h as before.
>=20
> eg:
>=20
> diff --git a/arch/powerpc/include/asm/percpu.h b/arch/powerpc/include/asm=
/percpu.h
> index dce863a7635c..8e5b7d0b851c 100644
> --- a/arch/powerpc/include/asm/percpu.h
> +++ b/arch/powerpc/include/asm/percpu.h
> @@ -10,8 +10,6 @@
> =20
>  #ifdef CONFIG_SMP
> =20
> -#include <asm/paca.h>
> -
>  #define __my_cpu_offset local_paca->data_offset
> =20
>  #endif /* CONFIG_SMP */
> @@ -19,4 +17,6 @@
> =20
>  #include <asm-generic/percpu.h>
> =20
> +#include <asm/paca.h>
> +
>  #endif /* _ASM_POWERPC_PERCPU_H_ */
>=20
>=20
> So I think I'm inclined to merge that as a minimal fix that's easy to
> backport.
>=20
> cheers

Looks ok, except does it matter that the include used to be only done
if __powerpc64__ and CONFIG_SMP are defined?

--=20
Cheers,
Stephen Rothwell

--Sig_/gTzTE=0PurNyae0JTgphoQ1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8oA7MACgkQAVBC80lX
0Gy0nggAjW0dxUlsqRQt/TwQPBQCCz/n8vIcBBuDcNL80vLeduZpiEP5v+/OEb+G
nmf5Usmxk7VkODd5OUKIVkU2+q3BET5QBwxQ/BjtOhTGFfxoWzz1Ki1Q4z8fr6gl
T8c0lwl2c9W4AUsaWIgroQR/KqVBkaPRhcEVcChBwdv1V4mqC61Xf6tsLouzEo8G
q3ymOVn8kA1UKG4A7Ivk6JI00SYy1nZvEKaN0YRKaZzLmyCkaLa2UVToaRx5fXJ2
LCTER0c4eNURY4AmGOulxANO2og1MGlU+n9J6zM7fiDb4lFCd5gI3IVQ9De6NAec
p/fzXpVwEMgp7J+aZ3CLNHrOgTsmzw==
=eLgV
-----END PGP SIGNATURE-----

--Sig_/gTzTE=0PurNyae0JTgphoQ1--
