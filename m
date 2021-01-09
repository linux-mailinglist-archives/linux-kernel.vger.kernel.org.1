Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD092EFFD0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 14:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbhAIN2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 08:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbhAIN2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 08:28:18 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E906C06179F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 05:27:38 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id e2so7127804plt.12
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 05:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=V6kzdP2xat9iocod2DKVN/cLtAYKJvORnSBIgaoo6+I=;
        b=d72Tkx0cui223Epc1i+fCO9dgKUqSalR/M1wfB7aVXhtEABiBc7ENn3RbKglOeEP4K
         Ixoms7B+P/DWWZnYP1IythsQgOnqWaTbaA0zESykWSbCrr5TuwXZAo6knFHbAnPkr9zg
         vmIW1nM4yuT4tZNIWxxwp3KP8sckmbcWWglhxJwle1ZfwwSjFhKRnFl5SJeq0v35CewY
         O4NMvcitKG31FUGmAbuT+G/2rTnXQQjvTkZ+5JCyPptgaeCdXnS1JgNjxWfH1xGhZL6r
         EymHjqsMVLcB2iOvgQISvOL7rzSoqeCvV8gnxaaPEJRPBCyjr6PCIPe3CxA85GsJIJNm
         GsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=V6kzdP2xat9iocod2DKVN/cLtAYKJvORnSBIgaoo6+I=;
        b=svvVd05sAR//rvMik3J3r9scUJXMZ80PXw74Pez92evKqMzgUUS76tEN02GwMImJT6
         gKxpQNM+IDxw1isMdqw8mfuCsIF2FusthaoLleF7bxcKHf34Z7BZxDn2iFzv7U+YbIug
         V2VkUcP5UVQPC4H05pDhrx5fLiQvG0JvgU+rPXg3S7x/X+oR+Qs303rz6dbSr5duAayD
         b71dcdm3CyNuNkB7pJ9bxAawCcHDXVU5Cwq8AZHJzQaipMzj39+SKk8Dkz+4Up8RcS7K
         ABwiqpA33J6iYVT/ongspzn8NQpPJr1qLXx4na2EplpIdshJpHCRctqMV4TCgEdgrE2i
         DQbw==
X-Gm-Message-State: AOAM531rrxbwLMSTCiqXIuKyY3Oo4CT8jHK1y9uzY7Yie2qs+k/6CF95
        rcAXSuIsJW+hKL3HrM7WSNCtZg==
X-Google-Smtp-Source: ABdhPJx1E81FOsQLowFml13y0YFhYGLrEGX3Ic1/SX3apoOBMdw/Q7kEnIKPs5jtNJMvGZI6o2Uc7A==
X-Received: by 2002:a17:90a:c306:: with SMTP id g6mr8986891pjt.104.1610198857739;
        Sat, 09 Jan 2021 05:27:37 -0800 (PST)
Received: from localhost ([2406:7400:73:4813:5519:9c74:24bc:5cec])
        by smtp.gmail.com with ESMTPSA id y5sm8053301pjt.42.2021.01.09.05.27.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Jan 2021 05:27:36 -0800 (PST)
Date:   Sat, 9 Jan 2021 18:57:31 +0530
From:   B K Karthik <bkkarthik@pesu.pes.edu>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: audio_helper.c: Replace strlcpy() with
 strscpy()
Message-ID: <20210109132731.tczawd5p74xnfz7p@pesu.pes.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kls55wqpg7fma2yb"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kls55wqpg7fma2yb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In gbaudio_remove_controls() , replace the usage of strlcpy() with
strscpy() because strlcpy() only limits the *destination*
size, and the source is always read fully.

https://lore.kernel.org/r/CAHk-=3DwgfRnXz0W3D37d01q3JFkr_i_uTL=3DV6A6G1oUZc=
prmknw@mail.gmail.com/
was quoted by checkpatch while showing this warning.

Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu>
---
 drivers/staging/greybus/audio_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greyb=
us/audio_helper.c
index 3011b8abce38..1ed4772d2771 100644
--- a/drivers/staging/greybus/audio_helper.c
+++ b/drivers/staging/greybus/audio_helper.c
@@ -166,7 +166,7 @@ static int gbaudio_remove_controls(struct snd_card *car=
d, struct device *dev,
 			snprintf(id.name, sizeof(id.name), "%s %s", prefix,
 				 control->name);
 		else
-			strlcpy(id.name, control->name, sizeof(id.name));
+			strscpy(id.name, control->name, sizeof(id.name));
 		id.numid =3D 0;
 		id.iface =3D control->iface;
 		id.device =3D control->device;
--=20
2.17.1


--kls55wqpg7fma2yb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEE88CpXiCXh4Qs88cHZmzYLLde5wcFAl/5r0MACgkQZmzYLLde
5wc1MQwAxhSWhwtY2mD97K2T1quipOm7mKH5OHygx9T/aAr8t5k92DznAVswiHV1
KE/jBYTfu1P0MYp/74rWvcb8fm5+fKoICSu5WIn6XIbiuIw010CY48QJilmcyDp5
Kq2UNpmGtCrE2eI8ePFnkiRgK7Y3KVS/OlMoVLd+msLevI+Rf/Is/RsV1UARHb9t
uQed1rw//LB8qM2FV+MpoY5z9a8kcohX10TPTbsepXr0TRqpkdvAFcDNbg2+kdHr
UIXCinZXW6vpN9+YoxfMndrFHqUjj0mAEW42pNhA4Kd61+kXW4BJgEWhch/naERx
SdSxQDaU547U0vqoaYsbIiAEF5M0nVmcsSaqFO33GHSDYy11QmyIGYbh9mHhe/u5
KYaVd/geKHpFk014AmdBnKlSZ9zc7GkxSF56AU0S2Uwu+mcic0lTLUfMkLIpxxNL
oxZO2c0bxUNVDQutoTsF4idVSc5rFwBAKD+iby3x7smxeZpSQ/GhVchG4FWTGxgc
eSfg+mBK
=6954
-----END PGP SIGNATURE-----

--kls55wqpg7fma2yb--
