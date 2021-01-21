Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913AE2FE325
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbhAUGol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbhAUGoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:44:34 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F45C061575;
        Wed, 20 Jan 2021 22:43:52 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4DLtCC0BvQz9sWX; Thu, 21 Jan 2021 17:43:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1611211431;
        bh=nQDC/wmZYqnoqYr1PmTT88Ea9/jxlkKKWJCgaWBIglc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CdWb5nsbkIiZrwyD53R2mqBb8CJB1UOsrD81hFlAKSA2r9NpzTknyEuvF85mQLsoP
         fcv1z/MrSsDlbN5jdQiaQFW0M+EHpxTui/2ZtMyWhxntLyziSUeD0pCMK1NA5SBza4
         5gc11P/VVlopgHTZ4adyWWG/A5zZVBsftZY8IMgg=
Date:   Thu, 21 Jan 2021 17:26:22 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bill Mills <bill.mills@linaro.org>, anmar.oueja@linaro.org
Subject: Re: [PATCH V5 3/5] scripts: dtc: Remove the unused fdtdump.c file
Message-ID: <20210121062622.GI5174@yekko.fritz.box>
References: <cover.1611124778.git.viresh.kumar@linaro.org>
 <f63b3fd7fadf8912e8e7e8653df45b5b78f5d005.1611124778.git.viresh.kumar@linaro.org>
 <20210121004457.GD5174@yekko.fritz.box>
 <20210121041757.cskxlai5e7a2pfgb@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="16qp2B0xu0fRvRD7"
Content-Disposition: inline
In-Reply-To: <20210121041757.cskxlai5e7a2pfgb@vireshk-i7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--16qp2B0xu0fRvRD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2021 at 09:47:57AM +0530, Viresh Kumar wrote:
> On 21-01-21, 11:44, David Gibson wrote:
> > On Wed, Jan 20, 2021 at 12:36:45PM +0530, Viresh Kumar wrote:
> > > This was copied from external DTC repository long back and isn't used
> > > anymore. Over that the dtc tool can be used to generate the dts source
> > > back from the dtb. Remove the unused fdtdump.c file.
> > >=20
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >=20
> > Doesn't this make updating the kernel dtc from upstream needlessly
> > more difficult?
>=20
> Hmm, I am not sure I understand the concern well. The kernel keeps a
> list of files[1] it needs to automatically copy (using a script) from
> the upstream dtc repo and fdtdump.c was never part of that. Keeping it
> there isn't going to make any difficulty I believe.

Hm, ok.  Seems a bit clunky compared to embedding the whole directory,
but whatever.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--16qp2B0xu0fRvRD7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmAJHo4ACgkQbDjKyiDZ
s5I1xA/9EJDA4Nt8h0Mbv9yNudzEgWXMyIRKZwLTz3REASSjqVdDk1ZAkct3o0H0
lMWxlzYI9nqxSTzH3JO3G3zxRArN8EzQsPh6lmqtV32lbI3NhrrSZzpVeQ5E3Qsg
u1O0MUbQQbBraVV/nFAitNAI7Qe3LVqC4hN8iM8WLNf6GHZLKgC8E4UFPjH3nUG0
gfeQK5DQ6zbzaO2T/ZG+y8vj5+wwFEbHgp63CwNJAKNioGc2EgzD2h/LvAU/8dkt
V5JIram9xo0D4S7tnNKTvqyFzwjFUnMIXB3bPaw59F/ZLBdKWPjw7c/aeCCvfI43
TKO/LWsNmgCDEC5pgYS65uULt6EFyua+kN9S1NUrEdQ2bgq5ghtcNNIiTNor3YBa
TZCsUgjCTPR+qdRjjPPM2Sf5Zgo2clWWa8VDBElLrH/2aalotrw+4rvCa81VyGLj
0Sctbq/0ZGaOHMDDNs6aneaJTimTLyyJOhVZohURIqkgdLXoomVfYnIO1BoFASO5
J6g8QAofOAYcy1i7PxowO72VVli1gnQ5rBpw6ijrAI7HCiXrIJa6MiMscMY5cEBr
Z6NaKFxiSfmj9IeLHP6kgT134V2wSFI+gQK/S9GIU9OjGeJSSqxrxq0UvlPxG2FG
Y3Hq6iEGgKMl32hcVTrLlaYAOg2bvFO0EG9N6Ex2+ohj7gpN2ts=
=nzK+
-----END PGP SIGNATURE-----

--16qp2B0xu0fRvRD7--
