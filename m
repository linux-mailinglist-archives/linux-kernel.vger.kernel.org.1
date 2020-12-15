Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BCD2DA72A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 05:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgLOEiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 23:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgLOEij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 23:38:39 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8AEC061793
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 20:37:56 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Cw58w4zYmz9sPB;
        Tue, 15 Dec 2020 15:37:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1608007073;
        bh=92QTNlRWTEpEVsaMoOeKhN/bpOIRb+FzQZilGRSEkIE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tf3+HzXyuY2V+8Y7rQzd3JF52NpAUfZ4v30SM7wQKAl3ZfyqhXj1fkrSdx5A8/Sjs
         SlPSEgIpJt+yyUU/9XwX0vvWle6+G7Ud6vZtiNg8vnZ/UcJzafNW8+wxMfjRWOuGd2
         GQufPJg8I4zSbov/b6N97fbKnZDrhaagkOXymlTjMnMeIGSTh7HKyz2axcaO48X/Cu
         b6bsAB4rp8xPImWcr5jvS8qDvEn4snwlFsKScxAYOAkd1vSQM3eTHNXvSINsaHyv9J
         wgsUazDIEqHAlANQqzsRMWl7AxI3Sksqt4LtN0YV/kSoa7lidkOyaC17ML0rQGjy6n
         bMUKoP59IHfDA==
Date:   Tue, 15 Dec 2020 15:37:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Some fixes for v5.11
Message-ID: <20201215153751.5150e00a@canb.auug.org.au>
In-Reply-To: <CAHk-=wic8QjSuwjwpk8oLvtgWWCGfAC72ojuAU3PwYr7CWHqHg@mail.gmail.com>
References: <20201214132745.3323776-1-christian.brauner@ubuntu.com>
        <CAHk-=wic8QjSuwjwpk8oLvtgWWCGfAC72ojuAU3PwYr7CWHqHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/X_BiPKbisepOxcNGs09Wqle";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/X_BiPKbisepOxcNGs09Wqle
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Mon, 14 Dec 2020 16:45:50 -0800 Linus Torvalds <torvalds@linux-foundatio=
n.org> wrote:
>
> On Mon, Dec 14, 2020 at 5:27 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > /* Conflicts */
> > At the time of creating this PR no merge conflicts were reported from
> > linux-next and no merge conflict with 2c85ebc57b3e ("Linux 5.10") when
> > pulling the tag. =20
>=20
> Really? It conflicted with your own time namespace fixes.. Was one or
> the other not in linux-next?
>=20
> Not that the conflicts were big or bad (free_time_ns() prototype
> changed right next to timens_on_fork() prototype), I'm just surprised
> you saw no conflicts..

The time namespace changes appear in linux-next for the first time
today - where I reported that 3 of them have no Signed-off-by from their
committer :-(.

--=20
Cheers,
Stephen Rothwell

--Sig_/X_BiPKbisepOxcNGs09Wqle
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl/YPZ8ACgkQAVBC80lX
0GzP4Qf7BNyr72l8kaX+mhdEBNJm8O8ru+xuM1MHZLI0DS1rLaTE3m7yC+7i80Kn
0VgRLu/+rr8IqEqs6D3C4sd8NQqOLsa8JL/BvM7a5WKit/Ld2ajGDTrpdiYvXlYL
Bdk5gvSeg2r3E7/tD3Jtl+3V/ZC2kQoF4A7+czfcp7NqoodX+HTrYiQrHtl/1ZIq
AUYQR+FrMo+2G40SQA2OPQZ7G8osIj0xJIa27qMj8WQ0wNDDyyA32Z3c4IdzJLO4
6fixKn/sjEInVk1IeMkS7s38YBnbtvcLxYxbjxAgQn+GNlF9dXepCBHoGbid0KHF
iLIh+jTMgfT7djBKmxRlaFNtUQkHRw==
=vpHS
-----END PGP SIGNATURE-----

--Sig_/X_BiPKbisepOxcNGs09Wqle--
