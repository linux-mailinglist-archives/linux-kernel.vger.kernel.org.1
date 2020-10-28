Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6134B29D2AD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgJ1VeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:34:00 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53549 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgJ1Vdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:33:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CM1ZX30Xwz9sWH;
        Thu, 29 Oct 2020 08:15:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1603919748;
        bh=Odl+EFcAVABTumfQ8BQaRzjpGoHN+rUsQKG+dis+0Bs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HcuodH5cWtZtR1RWWV5U1uoljh7tQsT7VzoVhKGT9PQQHaoeqFKa/+bnbRnXu73Ws
         YRpiwbHsDmgnpzkwFjy+sEQVy7HL6Ye3d6Z9I5nO6h9WRJJh4sJukK5ZUUV/fvgq2Q
         teaLEK29z/xXVMZd9/5bTTRVZqMAR9wXss81u9N/BCSYdulPmFKNUgh5Wf3ZDWHUex
         bFZjYlr2gaHk1kUs9hyxSxXj0hbhqzlqte4i9060ur8MV8cMZWsfgJISmKu+GiM32+
         O3izm8vdCHZ34EUhpMivc30bRFj2gqz7dYacCC12DeDJ3Jx5fIb8LgUsMjb8rzrjQ9
         Z+BUbmjnA8RnA==
Date:   Thu, 29 Oct 2020 08:15:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Makefile: honor V=0 for docs building
Message-ID: <20201029081546.508a6922@canb.auug.org.au>
In-Reply-To: <20201028111142.7cc8833a@lwn.net>
References: <20201016165504.3cc33889@canb.auug.org.au>
        <478c114a2399b68a18de94ee5f98649304f3903b.1603796153.git.mchehab+huawei@kernel.org>
        <20201028111142.7cc8833a@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xlMsaUz+iRSh5XzFR3ydpDN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xlMsaUz+iRSh5XzFR3ydpDN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jon,

On Wed, 28 Oct 2020 11:11:42 -0600 Jonathan Corbet <corbet@lwn.net> wrote:
>
> Applied, thanks.  ...ahhh the silence....:)

Thanks, indeed.

For Aussies, though, the quote is "how's the serenity?"

https://www.screenaustralia.gov.au/sa/screen-news/2015/10-11-the-castle-top=
-10-quotes
(quote number 3)

https://www.youtube.com/watch?v=3DC8WLuQOLq5Q

:-)

--=20
Cheers,
Stephen Rothwell

--Sig_/xlMsaUz+iRSh5XzFR3ydpDN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl+Z34IACgkQAVBC80lX
0GxwoAgAlKVLI+xHdxpl7PuAL4AgOWlmvr9E/hQ48Uk3AhdtOJlb3KEMKbZ0yNti
8mqmIWNLmZGWqJvFWpjLeYb36foLf09fzgMQkIxN4B0FhDpIil+ekY6UZ7dRBlWQ
f+0m78jTuoYObEUynDsBRT/YghlOQ75pswGuqGa3M/2RyBwsCsq7BBRNZ+xOcMW4
7Y00kxGMBO0zC4JuUOLdUu7uYmoO0i5Kv9hNOYY02oKjcImmv05dq9OO+BLa1mVq
xmRKXZ8yijvxhpx1CmcKXYcMbjKOCnnrWt4YLuyTVzbsIzPEpXfvSinNSdVlg5yF
mepuR+gNzoJ9CrK0sx2vVn3+jNLKcA==
=B00H
-----END PGP SIGNATURE-----

--Sig_/xlMsaUz+iRSh5XzFR3ydpDN--
