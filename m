Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EA72F46CD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbhAMIps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:45:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:42706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbhAMIpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:45:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B74723357;
        Wed, 13 Jan 2021 08:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610527506;
        bh=J5AH/X5ZJBUjsFBjCNo6yI3/HraZf8H+zBvcMaxAtmQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=N6fF53sifO8+DCGfY0fcT5OU8GR24WjZMNjAWGec9gn90Hak4nyAdonHVZuV3R/75
         G5yck4bWvmuZzdpz68MYtW/1/ytZ8HL2S/nHS/cUFwwXRNgjwYeITWKjdU1abuu9f2
         +8WtVbWOseRanQuIO0lUc86Q/jQlOWjlSZQzUUmm+Yqbf3UKagv40F3vApOOtyArEp
         n9+GEPJPNnJ6lRasWKZ8dlCKh0POh/863Oxgbx2TRJKdoMmv71BWZsHUMUR3PDS7Ob
         G2lmjSsDFnCN7VGyEZUOJIYoLhONze1Pzk1QlgcPbmsYvj9ks4WXo0lHhk4qrg52Uj
         PlS0c1lLJCkiw==
From:   Felipe Balbi <balbi@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: [PATCH RESEND v4 08/11] usb: gadget: bdc: use the BIT macro to
 define bit filed
In-Reply-To: <1610505748-30616-8-git-send-email-chunfeng.yun@mediatek.com>
References: <1610505748-30616-1-git-send-email-chunfeng.yun@mediatek.com>
 <1610505748-30616-8-git-send-email-chunfeng.yun@mediatek.com>
Date:   Wed, 13 Jan 2021 10:44:58 +0200
Message-ID: <875z414451.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Chunfeng Yun <chunfeng.yun@mediatek.com> writes:

> Prefer using the BIT macro to define bit fileds
>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl/+swoRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQZIbBAAyDsUYaTfmSE3fF9yqrmSLkPRQtTqHDVx
FcKurpUr1GelJpfjnPV2JKcQpS/xnu7nVWAFyKfE4DQigYFp8AvfwHbf3HsduLYH
dclO9TNnOfqlbqxC4fg/9eO+rJjpl15N7q5lXl7fPrALP/5+AZltIsq4fhXWK/0q
naxmlM/9ay+ORf8YT9AABmUt6rcV2uN/MRRUGucff9Y6Q8RnvNCQ0ukkFlA2wuF/
mTfzR6o0j2/wUuCE3rU5BYcVUxE2hsaYu8Td5YBouQ3p0KAWFPUPe6j5KWVZ/QbO
tVKd0uHCxih/wMxoGJhF+vVcRH+Bch0G/207/kJL2pAZiIpjQD9bxGPZrB9ixF5u
CSvm7e/6j3whpoKlk3FgmGFVqS8zaoYOXp9FD1djbOi/GuXChYmVjFUQm4CT5Xgj
cHwik5skerDBtKOIkBLepRtuOEbslhsx5OK8fcqGrH1B+MAjYOa9HRel3iS05FYE
4S0BqRyE0p6DS9TQlsswiTRqpNttXolGCBh+g3NLDifp+MTsndgudjeArcCChmjr
7S7ZuPXRN1uhwQVXm6/To7alk/Kv7Ytmp8cPQtqMBDjg/bYkI/AS7b4CEnqXNuXE
ywS/QuONzokDS6rTtz5oIhMPx6ZksXfnvI0sWBJlTo7CBSrOcXws/60X8DrBDSNq
T2S+lGYI0Zc=
=i64L
-----END PGP SIGNATURE-----
--=-=-=--
