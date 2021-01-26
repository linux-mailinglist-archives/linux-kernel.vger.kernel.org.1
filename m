Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D29304582
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbhAZRjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731533AbhAZIBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:01:44 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0861C061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 00:00:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DPzgj5C9Vz9sSs;
        Tue, 26 Jan 2021 19:00:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1611648051;
        bh=H6AIkwMVmcNUMqcYZNv6i2PDekiR2N8Weacqx/lRuso=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QQTzeZSPVt19G/EhuC1FNOJtoSRF/Mti55ip2ymssvbOek3ahUG0OqvmXDJHARrWg
         3LE6XcdMcsqm5nBfwPT0QRl7gA/ZDQzyK+UxjkyOqgHjtcN+vBrcuGPe4/rZMLqM+n
         KWvwwFkFEjDHtL8CNRyZz+8fdzMEv3hEOtDaH6ThrHzfjbh2Xww1XJlX/bh7HOKHxw
         ZsTEisEiCc+z1JphEcuZjRw807Cvoc2GyHIPucDCiGxDivMuJsvJvT8qOCxMlvXck0
         6iivf67MVoFFJtQEnXcsW/wC01B0CRw4BhqPlcER30rp2yfiC8p9VgmdQMWRCvUdyM
         v63/tLblRvX8A==
Date:   Tue, 26 Jan 2021 19:00:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: Dealing with complex patch series in linux-next
Message-ID: <20210126190030.109f24d7@canb.auug.org.au>
In-Reply-To: <20210125094323.gz7g5p6xeifolf5v@wittgenstein>
References: <20210125094323.gz7g5p6xeifolf5v@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dwYo/3GJS.IXDhHaYhCUWEA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dwYo/3GJS.IXDhHaYhCUWEA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Mon, 25 Jan 2021 10:43:23 +0100 Christian Brauner <christian.brauner@ubu=
ntu.com> wrote:
>
> After having received another round of acks on the idmapped mounts
> series and other fses about to move forward with porting I moved forward
> with merging [1] into my for-next branch which is tracked by sfr in
> linux-next.
> Given the nature of the series I expected there to be a good chunk of
> merge conflicts including some non-trivial ones. But there proved to be
> too many conflicts or at least a few ones that sfr couldn't handle
> without more insight into the series. So after talking to sfr this
> morning we decided to drop the tree for today.

OK, so tomorrow, I will try merging your tree really early.  This will,
at least, spread the conflict pain out for me (yesterday it hit all at
once at 4pm and added an hour to my day before I gave up).  Lets see
how that goes.

Unless someone comes up with a better suggestion, of course :-)
--=20
Cheers,
Stephen Rothwell

--Sig_/dwYo/3GJS.IXDhHaYhCUWEA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmAPzB4ACgkQAVBC80lX
0GwO+Qf/bddgWmiMWClpz+v4qxnZKL2wMxc2CkwDfqER6EMwl4FEBIg4ZgOZ+a0i
KdEGtdAiAkbxHRleyWBwm3jlWpZq2UkuhKkf1Rm2EgmdzZ8uetZhAHQ12JnGwPtq
GmELdu+69usk0uQMiePNXcOr8H9SzmWONMNa1FIo8esbrWyrTPSRLypq56vOcZAR
ygQ3gm8pcWjj8apnoKWhloPrubWUBXhwVwYt3kbHSb8OmtMx4qqN6PCwNpyxJQg4
m2/othbbqWuflr/pARPSSxcVEQhldtR6vLmxBN0edv/YcJIVWqSO/nE+5oppu0O3
d8S9TCUy2HoC+3qZA4xboV4CFo0pDg==
=hkfw
-----END PGP SIGNATURE-----

--Sig_/dwYo/3GJS.IXDhHaYhCUWEA--
