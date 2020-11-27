Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C1F2C6A63
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbgK0RGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:06:06 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:49680 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730985AbgK0RGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1606496763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ApdXLLCo2ftbSslD3CiTtwOwkkM/Xi+DO5JZlq3AnXI=;
        b=GXpeoeRhdKDRv+PJzx+f0ywR4NFkbgICRjEtuZ7IYO3wPR5MkXMn18Bl+jlMGV9zO19Dr0
        hVhz8BDkoldZv1+dWcqoicbkhuIbGzEe4n77if8SVI6g8ZiiZdkUpmsO8QvI7HzEDzpnco
        NGIVdGM6Fp6ZLhmI3kkbplfAjXV/4x8=
From:   Sven Eckelmann <sven@narfation.org>
To:     ron minnich <rminnich@gmail.com>
Cc:     linux-mtd@lists.infradead.org, John Audia <graysky@archlinux.us>,
        Adrian Schmutzler <freifunk@adrianschmutzler.de>,
        jstefek@datto.com,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ron Minnich <rminnich@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] mtd: parser: cmdline: Support MTD names containing one or more colons
Date:   Fri, 27 Nov 2020 18:05:55 +0100
Message-ID: <2666350.AiC22s8V5E@sven-edge>
In-Reply-To: <CAP6exYKEN-sQXGxTC1CSzfyuYmbbMPHKEosCP7DciFTLOhAFCQ@mail.gmail.com>
References: <20200429165347.48909-1-rminnich@google.com> <7171837.EvYhyI6sBW@sven-edge> <CAP6exYKEN-sQXGxTC1CSzfyuYmbbMPHKEosCP7DciFTLOhAFCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1733315.QZUTf85G27"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1733315.QZUTf85G27
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: ron minnich <rminnich@gmail.com>
Cc: linux-mtd@lists.infradead.org, John Audia <graysky@archlinux.us>, Adrian Schmutzler <freifunk@adrianschmutzler.de>, jstefek@datto.com, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Marek Vasut <marek.vasut@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>, Ron Minnich <rminnich@google.com>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] mtd: parser: cmdline: Support MTD names containing one or more colons
Date: Fri, 27 Nov 2020 18:05:55 +0100
Message-ID: <2666350.AiC22s8V5E@sven-edge>
In-Reply-To: <CAP6exYKEN-sQXGxTC1CSzfyuYmbbMPHKEosCP7DciFTLOhAFCQ@mail.gmail.com>
References: <20200429165347.48909-1-rminnich@google.com> <7171837.EvYhyI6sBW@sven-edge> <CAP6exYKEN-sQXGxTC1CSzfyuYmbbMPHKEosCP7DciFTLOhAFCQ@mail.gmail.com>

On Friday, 27 November 2020 17:32:02 CET ron minnich wrote:
> I'm a bit worried about how tricky this starts to get. I'm inclined to
> go back to an earlier implementation which used a character that had
> not yet been used (iirc I used [] around the PCI ID in a very early
> version). What if we used, e.g, a single ! and searched for that? It
> need not be !; pick a character. Just something not already in use, as
> the ambiguity around which ':' delimits the device has become an
> issue, as you show.
> 
> Almost nothing in the original patch would change, save the character
> being searched for. By using a character we'd never used, we'd avoid
> breaking existing usage.

What? Doesn't make any sense to me. The mtdparts shown in the the commit 
message is as it is. I cannot simply change it because it is in the control of 
the bootloader - not the linux kernel or me. So I can also not introduce a 
different character like ! for separating things.

KInd regards,
	Sven


--nextPart1733315.QZUTf85G27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl/BMfQACgkQXYcKB8Em
e0ZTIQ//UHqFRKnJ1Uwupj9kBv6+9klmGzPptfBdx8T92GKLoRbmp5VprWR5KByY
sKC5q+XdXn7MVfcAZUA8WCwrJBW+yq6FkC8gYdSZkrvm/ZFCsDWXhLwFnmDuAUhJ
103VyP5OnsrKowBYgiGxaV+A/xKRzBMaEuKooTiSk6oUrETXOxKYUl6SGwoOKZ4G
faxoMyMFzGdC42SIZIclJqc3Vtg2MGJ6bX+jEJc7NlEFYrGDGKBGfoueYXGV4NUF
soqJ7RiftWB/XqtpCsIEKL4viZqMxjkl28pV2UbqrOxsFInvFNpI/Q0uUyXlDV0F
EFW3532oNBITOKAY7uBPFxJZMlNscIrD380CUvtNpppAAKyFOkTqhFzbuWrMwwCr
0nCVaOyhageznzkpyZT1AEqx/z3F7xEOx0vBjL4JhTek09cIJp4EP4mGimRujGfK
2BUAYnWYy1+tdBvXVx/mZFZWHb2W+farCUsytJdKH8IiGE5SrwYo2CC2Z+lL8Rut
9jvZRYuozMF0eSo7iDUmAf+jSP35iBvjJGJbNmm9E9b+hQmbYlbBZ+0CPxc087LN
L7vh8dV5F8zUf0UAwZPfbRxukvULn5KYXjDlm5VYBGhwhtZFMclCLcBAuk6Ly65M
B+Mu56txrHUbWrf1C95ghPfEvM18INnQVrzJzuckQU2V3/MRJ0o=
=GJxP
-----END PGP SIGNATURE-----

--nextPart1733315.QZUTf85G27--



