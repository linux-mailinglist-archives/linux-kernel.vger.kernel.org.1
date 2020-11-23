Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F842C0525
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 13:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgKWL7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbgKWL7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:59:14 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CDCC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:59:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Cfm0D1R5lz9sRR;
        Mon, 23 Nov 2020 22:59:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1606132749;
        bh=C/02EMvW4o+WQSdThZBP7+ma8iXHpAXlIFsLEtjz06Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mfrjUAIFLQRg6Aj5Z9BjAisGK9DzYOlvkvNXTKvyOZIT0yLFqdYk5Z9aw8q3UZnvS
         uHLaFp++oe0OxVCaMl9svrAyB6Vd+KB21yY1fIgizLP6A7OqkkE5PAurJQNXjbznOr
         +yrxORNwjhPut7r4kqQKKfGFxAj2TqtRskwpAlHZkIZYuTsmJlVUm616c6A691W1DH
         b8RQl06XPPR6LJtdiUSUZtn2E0Fo9nRLUWQ9egRkJPi8ibdpNyH1sX7cP1Bl8POpue
         67/2aev2YLPgkJNb3kpaWWqKTrTLSiSb9P9jCtKhqQoebGVhUhMSNiFYBEJIxyRMUR
         qBzO46/N/qqMQ==
Date:   Mon, 23 Nov 2020 22:59:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: at91 git tree in linux-next
Message-ID: <20201123225906.7cd6d14e@canb.auug.org.au>
In-Reply-To: <CAMuHMdUkQqJ_+8xy3q7tjCXCU4cZsnT7EOHtfTDroc4Ke0yPrw@mail.gmail.com>
References: <551A9FAC.2010203@atmel.com>
        <f15a82c8-5960-34ea-e7fc-dffdfdd369c6@microchip.com>
        <20180823093045.00e751b0@canb.auug.org.au>
        <CAMuHMdUkQqJ_+8xy3q7tjCXCU4cZsnT7EOHtfTDroc4Ke0yPrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DvmE2Rgt16brmASEAq52yA+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DvmE2Rgt16brmASEAq52yA+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Mon, 23 Nov 2020 11:44:17 +0100 Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
>
> How is this working?
>=20
> From next-20201123:
>=20
>     Merging at91/at91-next (0698efbb33ef Merge branches 'at91-soc',
> 'at91-dt' and 'at91-defconfig' into at91-next)
>=20
> which is indeed a recent commit, while Next/Trees has the wrong repo
> (linux-at91.git instead of linux.git):

That is what happens when you store the (supposedly) same information
in 2 places :-(  I have fixed the incorrect one.

Thanks for letting me know.

--=20
Cheers,
Stephen Rothwell

--Sig_/DvmE2Rgt16brmASEAq52yA+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl+7pAoACgkQAVBC80lX
0GyJRAf/V/bhAYt+kbgrjswsfnSdam/Is8x0+KRy/IxG4qUvvsjGMM1sZRiC8cLj
EkjTiQH0bEXNHxq2R6vHVidcmZ/z6Gez08Ra8bRmdhGu7CFraRB43LU6yRYd+UWY
7SnDhWQP3jE1qMK1s2X/2cKJkmC7PW4e4ciG4TUjagyRexKb4wR+80P+jHZG/xqx
by//TMGl9buOy0X7woWmmc/onM3hZBJt6JQ8A++DyP7gSCw0CsDpfxxqqyF3+WGd
99EIZtXI5+qq+E8COHiQx1dI37ZZjlYAhE4mWejr/9lRjUOIJ0jzadwobX9FTghD
lUMaFwNVAbcreWnNA8iV0e8s/CNe2w==
=2oEC
-----END PGP SIGNATURE-----

--Sig_/DvmE2Rgt16brmASEAq52yA+--
