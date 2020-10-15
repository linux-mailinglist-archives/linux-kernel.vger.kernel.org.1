Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5C228E9F6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732197AbgJOBZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730375AbgJOBYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:24:37 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D63EC0F26EE
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 17:44:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CBVsx1g0Bz9sT6;
        Thu, 15 Oct 2020 11:44:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1602722678;
        bh=t8A6fO5tp/eZ5Re3BebrXOQ9Y1HSFZ6NL3ZxIK2cCE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=obFqOmefSwuDllvrpb013ifEj6EHy8Hj72S2yQ48kfm9ydFc8fVCwY6ndRMlhQq8F
         K3q3+MfVVhqIikGrA7N2k5Mv5FGppGjqiIRNggx5xtUXKn6xEBw7EpLPZcWAZ2PJQg
         +7Cz0ii+/Q3d7Ivggv09myKN5vClHc0PDq/t5H942tWOAB12QfskAyaCThGzZ/a8VB
         JkPUKoNzlcsoyY8dJXono6CcqtKRkQGawib428uF4KKjD9l4ndmtPMk2kN7fqKL+YQ
         jmfMISLgHsusege2uf0WrcTKfLItUMgWch5cn6KcMZTwCJJ04fKhrqpiUu39W6txK7
         MBwQ3ii4+ahtQ==
Date:   Thu, 15 Oct 2020 11:44:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>
Subject: Re: [GIT PULL v2] objtool changes for v5.10
Message-ID: <20201015114436.1a08d112@canb.auug.org.au>
In-Reply-To: <20201013103831.GB3933713@gmail.com>
References: <20201013082625.GA775379@gmail.com>
        <20201013204312.6052157d@canb.auug.org.au>
        <20201013101056.GA3933713@gmail.com>
        <20201013103831.GB3933713@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VQjlC3hCiiHrx2kc=OgYB_J";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VQjlC3hCiiHrx2kc=OgYB_J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

On Tue, 13 Oct 2020 12:38:31 +0200 Ingo Molnar <mingo@kernel.org> wrote:
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>=20
> > > This seems to be missing
> > >=20
> > > https://lore.kernel.org/lkml/patch-1.thread-251403.git-2514037e9477.y=
our-ad-here.call-01602244460-ext-7088@work.hours/
> > >=20
> > > or did that get sent in a previous pull request? =20
> >=20
> > No, that fix is still missing, thanks for the reminder. I overlooked it=
=20
> > thinking that it's a tooling patch - but this needs to be paired with:
> >=20
> >   2486baae2cf6: ("objtool: Allow nested externs to enable BUILD_BUG()")
> >=20
> > I'll send a v2 pull request in an hour or two. =20

Thanks for that.

--=20
Cheers,
Stephen Rothwell

--Sig_/VQjlC3hCiiHrx2kc=OgYB_J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl+Hm3QACgkQAVBC80lX
0GypZggAkSpDjR79HYNUU0g24TP6i+QtCvuMq031+2odhdiwIgCLvlb3tFlmrmeR
Fi3oHijDcdXnEHU+yVLHqxNB2GiIXDwawCFnK0F5JdlLFFFvRLyeyxgwCUI8BTtn
vCfEsSpZeouI2WvbHjyHGqgR+RhYw7ZisNhKHElsZhgvVwJiGKcqqKfrf+qPLEJP
MK5ov2sWnQsheIBtOEc2hYcQv4Mai1GHUJMQtqKreOeLxpeig26P3HBqaaaqIwuQ
CP0N7uKIrpPEBu02vpYoBTSNMKwuOc+d2g9IlecSxiisdm/A5op3A5FDr0WMJDLx
tRQPgNfubBGtb8C39Z3LI21QVnPyGA==
=iu2s
-----END PGP SIGNATURE-----

--Sig_/VQjlC3hCiiHrx2kc=OgYB_J--
