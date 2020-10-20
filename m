Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4512934B5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 08:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403820AbgJTGST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 02:18:19 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:53134 "EHLO
        fanzine.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403810AbgJTGSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 02:18:18 -0400
X-Greylist: delayed 1637 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Oct 2020 02:18:17 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; s=20170329;
        h=MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=x/eRqYEUAJTwTQVJeBJtXYVWyDhnDvhK+ld7kbGI87g=;
        b=PHo374iir3fmKo21d/pPDrh//XRnLrGm2UJH/gICw7R3OaD1miUZGD+hefe00o3jsspwvEbCl7xg916qK/GjYFExcPSF0xVRTQdSwYBlJc1Yv/wgPJJHyCLSyDdk4izGdchROI6aYVTWzk5KfqW27DjYBKqWGRMQ3BBqKu38r2H3pyJTPPahMEUU2gja2l+VKZj8p9gGlAYf8Csw5/DuPpB2IbZ/0oHAY91fwRqIu8a8snsoF3euCSVCVZblCFCn9gZg5NyN8crHgF2HngB6NYSb3VpwWEOziyLLTr3Qn8nxl1v/tMeQ8ergtVpQHcEkvK6DkG/oUObe4dyQwTOtFQ==;
Received: from 11.red-79-157-245.dynamicip.rima-tde.net ([79.157.245.11] helo=maxwell)
        by fanzine.igalia.com with esmtpsa 
        (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
        id 1kUkXp-0005l6-T2; Tue, 20 Oct 2020 07:50:49 +0200
Message-ID: <82a6b8eee085b0e6df7c89d64721c3fb6719ba89.camel@igalia.com>
Subject: Re: [Industrypack-devel] [PATCH] ipack: iopctal: remove unneeded
 break
From:   Samuel Iglesias =?ISO-8859-1?Q?Gons=E1lvez?= 
        <siglesias@igalia.com>
To:     trix@redhat.com, jens.taprogge@taprogge.org,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org,
        industrypack-devel@lists.sourceforge.net
Date:   Tue, 20 Oct 2020 07:50:39 +0200
In-Reply-To: <20201019193227.12738-1-trix@redhat.com>
References: <20201019193227.12738-1-trix@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-3j1qdGbXxHLIfTWKW4oU"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3j1qdGbXxHLIfTWKW4oU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tom,

Thanks for the patch!

Patch is,

Acked-by: Samuel Iglesias Gonsalvez <siglesias@igalia.com>

Greg, Would you mind picking this patch through your char-misc
tree?

Thanks!

Sam

On Mon, 2020-10-19 at 12:32 -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
>=20
> A break is not needed if it is preceded by a return
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/ipack/devices/ipoctal.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/ipack/devices/ipoctal.c
> b/drivers/ipack/devices/ipoctal.c
> index d480a514c983..3940714e4397 100644
> --- a/drivers/ipack/devices/ipoctal.c
> +++ b/drivers/ipack/devices/ipoctal.c
> @@ -544,7 +544,6 @@ static void ipoctal_set_termios(struct tty_struct
> *tty,
>  		break;
>  	default:
>  		return;
> -		break;
>  	}
> =20
>  	baud =3D tty_get_baud_rate(tty);

--=-3j1qdGbXxHLIfTWKW4oU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEQP+ZAvaXWkfuKXiEf/S6MvF9w0MFAl+OerAACgkQf/S6MvF9
w0MO5Q/9FKhMwojZjNKnyQi0ZoV1od5RWQqWv/T4zb9Paijt8ZH+rQezBq+iHAbf
0/dPG2epjQXauX7yFa3Gkto9org7CNjFNXUZ0TkVr6kgvBk+u6jp+5Ikyw35ozCV
XLP5oq+FAIjceP/CdsjYzdnz2CEFfGKdSYQcHF99KlcmBpC4YeO6h1gLJwOx7yrj
w2hStDN4r60J4DdZNaGa3AgZG7OuqYHE+FWtz2+X8mhANcSLE3KR/A4RCzglTrN2
fzOCF+cae0Ul92lR1JJZs4mJ2AW7rVg/PIEG1oGTh/8JpiC9i15nsoeeeHdki29u
8jL8mQECX9F9dQMOYFjqMCsehuuSJbSSRMpHkkXx+jUUjxx1lQ6i3FIAHZnsV2+X
9ChzymSpJmlYH28dQgFBbbvbNBdxAJbrQulwPHvuCOmmK8Dq6PlNmI/kNzEKxD4D
3cRykqtQb+hlCkHCQXiKNmmZyv7PtZuzPv8zCKuM0iD3N/wmrjnUC6Up32StUMuV
457BedL4p+wWIDfscrueIdyFO4yGdDR+7YyZ6t+QgCQFXzjk8jtTwE92LK17HiiL
dx7JBstZ1tHwK0TH7h/v0S9JjUudgDNKaVnjj/bmaeIxQcfaagJ17Uqm/M+JRU5G
V2vr2bYP/Nm/S6KQa4UAuvHLF634wNfzVSuSDkm7Yr2ZuvFWH/E=
=pSCA
-----END PGP SIGNATURE-----

--=-3j1qdGbXxHLIfTWKW4oU--

