Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C02028CB4D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 11:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbgJMJ7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 05:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgJMJ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 05:59:00 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED88C0613D0;
        Tue, 13 Oct 2020 02:58:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4C9WGT1ztNz9sTv;
        Tue, 13 Oct 2020 20:58:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1602583137;
        bh=vQY2c9cN6FjoHPzgdROZih+fPjPHG6GUvQ/lO4cSMtg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ke2B61w+F3mXsTWMxeCsK/cZRpGO97Dg2xRVjQQzx6OTj8zDUk07NUREG5xLTDAo+
         61MVP5V1W5O5SAERIbuVta+fZxz9zsues81E5RuBcMUSCUABfUb0Udtj+7IzPdBlFN
         1H4EVEXRIdVqrHhnmHwG7IdMzOHi5T6sO/0Hq98hqvZgShbOgZGF/ujj0K2v6lxIXN
         Vbczm68x1711CxWnOEwPfvrzhV+FCNf1KFiqyChIELdtLf6LX5w54PHL848mc27fAk
         UkrsJF0e8d4oPOfXlKXFpCBMehfrUWLD9vFLV8BRd7A+AzQz+Fvi0RFz7psTTBAA2C
         mgzljjItaTZYQ==
Date:   Tue, 13 Oct 2020 20:58:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [GIT PULL] Documentation for 5.10
Message-ID: <20201013205856.21f762ff@canb.auug.org.au>
In-Reply-To: <20201013104950.25764be1@coco.lan>
References: <20201012133042.688ee6a6@lwn.net>
        <20201013104950.25764be1@coco.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bB.hnbahcrX3ELuO0ph/q23";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bB.hnbahcrX3ELuO0ph/q23
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

On Tue, 13 Oct 2020 10:49:50 +0200 Mauro Carvalho Chehab <mchehab+huawei@ke=
rnel.org> wrote:
>
> If everything goes well on tomorrow's next, I'll send you a pull request
> with those.

Sorry, bad timing, but there won't be a linux-next tomorrow (I have a
day off).

> The other ones depend on merges from DRM, hwmon and other
> trees. So, I'll keep rebasing them and should be sending you a late
> PR by the end of the merge window, fixing the remaining doc issues.
>=20
> We're aiming to have zero documentation warnings by
> the end of the merge window, when built with Sphinx 2.x,

That would be nice.  I am still getting about 35-40 each day.

--=20
Cheers,
Stephen Rothwell

--Sig_/bB.hnbahcrX3ELuO0ph/q23
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl+FemAACgkQAVBC80lX
0GxbPQf+PYl0U/k8bfj/UkPaN+G4xWrTRO4RRkyohzR7xMGeWZDQ8Ncvg+bzy+aJ
5wS8nshv5FlC0jrlNQkzqKabKV8FYcgROkoJDruJdD/cCQsD3PdQlf091YRlpJ04
BMSL8T0MiLkfYq10q6wIWbDTfLM2ZDEKduLTgUMgwwpJ8zs0bDnKnnE7a8bJiVC1
S9vYriZb0Ws0p8kxfQXmtUeBvnSE7auNg6Yopn1UuQM6SS9fvHjW1CAUQpoXr7vk
XDEJrgOqoDrrbaZWen01n//t0AEL/+MLYzmli88IBrKAQDiac/+IFEHpdAUzq+YC
vLLWT0znZGgkafCuRundJdllcSlt5g==
=jeTT
-----END PGP SIGNATURE-----

--Sig_/bB.hnbahcrX3ELuO0ph/q23--
