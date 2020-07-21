Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8CB2286E3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 19:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgGURNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 13:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbgGURNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:13:18 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6782FC0619DA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:13:18 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b92so1984839pjc.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=E/evRAxQv9wC1IBTfLSSH1C/LoK52iYqFAGcwxLVcvM=;
        b=vl1y61irQ6IqN1iXXdBBp6aGkbn7nsuUYwWsR7kbkuwgM+AI+1GwgK6wq9n1UaibBl
         OJ5u0HKV0wfUOMN2htBwMp1qN9FtsfT25h6sAvVnaSBIr9cP8CQSud5AJCotMd8z/jJj
         MyEyBMjR53T9MlusrkP1o/y7UirwLkHXzi8NYTZ3FPynDj0UMZ2MJFNjMQeTsQy1q2yA
         oz98dleZSAJJGjNe/XRok54J4wwlMZwzrfuAhqO4SXm0ugGbuF2o2iAa9i/uk+AHSsij
         NdsPzWy0UpvxW6qdAif/byOa2sjP+y4WT7AymmvjC4hb5mgZJM16zb4yqRMzKidg+4Fp
         WybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=E/evRAxQv9wC1IBTfLSSH1C/LoK52iYqFAGcwxLVcvM=;
        b=kBJxk2GpIPaQGZ3iAoGSa+QJYACPSsJcOS2ZufVITEWv0UAqLkmWCip70PLroCXVDy
         nFTGQFIh0Mmha5M1EBSMWp7/epg5V+OCkrcoVF0mZ54PXT2s97HJ4Z8ymAiPlj5OSEJx
         ZzcXfgG/blZNukFrCohVbuKJH321wRvcNBTD8ln9Kvz8Qt6mEAOcMnAYIJRl6OnxYCY4
         +dbEyLI6DvdLHTAI9U59nc0Nv7iDqgHtgv6mlqglE3oS3RxCKTrmZ07j4zQOARc49pqW
         YLu8TQAjY8Mutv1DRjD38bZCcDhCvjhF3ECPchmmw8Z3yriggDguNNTBHK4p4BK23N6J
         weog==
X-Gm-Message-State: AOAM532jF7uDhdVIAucu5xurdKM34mgaCrxzcRWrtdpo0H3WOpXG+qRj
        hikZgoA5qs/B6OUzSygQhbI7vQ==
X-Google-Smtp-Source: ABdhPJwdOFfbigDBGE8Fvtv0h2GqbL4mnhEqW8RFMW9+XZ5hgHXm4e5NPSNleXYpxdVALCWXwYVfyg==
X-Received: by 2002:a17:902:8c86:: with SMTP id t6mr23782766plo.41.1595351597828;
        Tue, 21 Jul 2020 10:13:17 -0700 (PDT)
Received: from localhost ([2406:7400:73:d7b6:d055:3e56:d1e4:ce99])
        by smtp.gmail.com with ESMTPSA id j3sm20361061pfe.102.2020.07.21.10.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 10:13:16 -0700 (PDT)
Date:   Tue, 21 Jul 2020 22:43:11 +0530
From:   B K Karthik <bkkarthik@pesu.pes.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tty: serial: fsl_lpuart.c: prevent a bad shift operation
Message-ID: <20200721171311.xlt256fq2qmw4e6p@pesu.pes.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pjqqqiiuizvpdnsc"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pjqqqiiuizvpdnsc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

prevent a bad shift operation by verifying that
sport->rx_dma_rng_buf_len is non zero.

Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu>
---
 drivers/tty/serial/fsl_lpuart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuar=
t.c
index 7ca642249224..0cc64279cd2d 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1168,7 +1168,8 @@ static inline int lpuart_start_rx_dma(struct lpuart_p=
ort *sport)
 	 * 10ms at any baud rate.
 	 */
 	sport->rx_dma_rng_buf_len =3D (DMA_RX_TIMEOUT * baud /  bits / 1000) * 2;
-	sport->rx_dma_rng_buf_len =3D (1 << (fls(sport->rx_dma_rng_buf_len) - 1));
+	if (sport->rx_dma_rng_buf_len !=3D 0)
+		sport->rx_dma_rng_buf_len =3D (1 << (fls(sport->rx_dma_rng_buf_len) - 1)=
);
 	if (sport->rx_dma_rng_buf_len < 16)
 		sport->rx_dma_rng_buf_len =3D 16;
=20
--=20
2.20.1


--pjqqqiiuizvpdnsc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEIF+jd5Z5uS7xKTfpQZdt+T1HgiEFAl8XIicACgkQQZdt+T1H
giGZOgv+L8g4Jh6L37Ro8HsApiPYnD387kVOAC6akZXRFY/zZJiRUaG252xkBX2e
3EJFeBipsM4mm/+z3ABf+53dsqXdD0BctquGN+vopi990RUtsGzIIL9fY9AIiO5f
VWUl7HdJ12Sa3GzTWXs1BWnRJePAe6gOthS89dJSD63NttrOgflsKUtyybXRcLbf
TJt2WyOJ6OTPRUVXkK6KLrkd622+ggfW48Rk3SSTkgJVDBBatAxPNIzTy8WQJm2K
J5pGLOmh9qauLHtbzpM1WLwXFD2yIMwPeiztWNTnqKlV5bGbDEm9GWZqsWaBje3L
2tK3y0ozsoZyGcat8O0Tc6zupwgpriDqS6Vkf9J3n0Ik/PkPwzkn9O5UOwnT3iJW
V7BlOARoAMru8J3vlSESGbgk44z4V4Ob7cae4pl019F3EV8z6i9vexRs9e8Cq/zU
4GLvLa/hvX9WqNPRZfuJYSWtflCjw8N9U5A8nlQeNWbouzy/2K2SN3aDf9cbLm3y
a71rzsqk
=7KTV
-----END PGP SIGNATURE-----

--pjqqqiiuizvpdnsc--
