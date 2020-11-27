Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3169E2C6AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbgK0Rf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731761AbgK0Rf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:35:28 -0500
X-Greylist: delayed 103329 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Nov 2020 09:35:28 PST
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473ACC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1606498525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TRZqemWaOhYT7No0jAIADxHkJYRzEpFq4s+Pznmd268=;
        b=xnH3Mpdn/b9LKnKOH5BHXnlUFYof9GEI5VOcfPZs8EOKAP1mrSGJ54f7bHzd9WDOMBTQbo
        LrPMEUAmBK6B+k0+fiB3oPc8ewU73hsByh7WN7PmxVSBJKN0TpR02DTa4ir6jR/XSaqRau
        Jbhxa4sSUP1L/HRNPpcKfBgztnaX+4I=
From:   Sven Eckelmann <sven@narfation.org>
To:     ron minnich <rminnich@gmail.com>
Cc:     linux-mtd@lists.infradead.org, John Audia <graysky@archlinux.us>,
        Adrian Schmutzler <freifunk@adrianschmutzler.de>,
        jstefek@datto.com, Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ron Minnich <rminnich@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] mtd: parser: cmdline: Support MTD names containing one or more colons
Date:   Fri, 27 Nov 2020 18:35:18 +0100
Message-ID: <2124367.HovnAMPojK@sven-edge>
In-Reply-To: <CAP6exY+hHrVvaMcF2tWUUJT=JS_J9NHx=92DzO=GAN==ACSh1Q@mail.gmail.com>
References: <20200429165347.48909-1-rminnich@google.com> <2666350.AiC22s8V5E@sven-edge> <CAP6exY+hHrVvaMcF2tWUUJT=JS_J9NHx=92DzO=GAN==ACSh1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3050561.0WQXIW03uk"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3050561.0WQXIW03uk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: ron minnich <rminnich@gmail.com>
Cc: linux-mtd@lists.infradead.org, John Audia <graysky@archlinux.us>, Adrian Schmutzler <freifunk@adrianschmutzler.de>, jstefek@datto.com, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Marek Vasut <marek.vasut@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>, Ron Minnich <rminnich@google.com>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] mtd: parser: cmdline: Support MTD names containing one or more colons
Date: Fri, 27 Nov 2020 18:35:18 +0100
Message-ID: <2124367.HovnAMPojK@sven-edge>
In-Reply-To: <CAP6exY+hHrVvaMcF2tWUUJT=JS_J9NHx=92DzO=GAN==ACSh1Q@mail.gmail.com>
References: <20200429165347.48909-1-rminnich@google.com> <2666350.AiC22s8V5E@sven-edge> <CAP6exY+hHrVvaMcF2tWUUJT=JS_J9NHx=92DzO=GAN==ACSh1Q@mail.gmail.com>

On Friday, 27 November 2020 18:16:54 CET ron minnich wrote:
> What none of the people involved in the original patch knew was that
> there would be other ':' in use. Sorry!
> 
> But you are right, my idea is a complete non-starter, don't know what
> I was thinking.

I am still not sure because I still didn't get what you actually wanted to 
change. I first thought that you wanted to change

    mtdparts=spi0.0:256k(0:SBL1)

to

    mtdparts=spi0.0!256k(0:SBL1)

which wouldn't work for me when ":" is not supported anymore. And it would 
break a lot of already working installations.

But maybe I completely misread it. Maybe you wanted to introduce an 
optional(!!!) stop marker like !

    mtdparts=spi0.0!:256k(0:SBL1)

to inform the parser that it doesn't have to search for : before the !. While 
this could work for me, I am not qualified enough to say which character is 
not yet used and can be utilized.

But the note about [ and ] at least makes sense to me (if it is optional):

    mtdparts=[spi0.0]:256k(0:SBL1)

But I am not sure if this will be a problem for people which already adopted 
PCI IDs inside the mtdparts without [ and ].
 
> So it seems your patch, if it works, is the way to go?

At least this is a workaround [1] which can be pushed to all the stable 
kernels which broke with the "Support MTD names containing one or more colons" 
patch. And the one which OpenWrt adopted now to get the devices booting again. 
It is only waiting for a Tested-by from you.

> I can't think
> of anything better that lets us preserve current behavior and support
> PCI device specifiers?

I am not that deep in this topic. So I am not sure what else could be done.

Kind regards,
	Sven

[1] https://patchwork.ozlabs.org/project/linux-mtd/patch/20201124062506.185392-1-sven@narfation.org/
--nextPart3050561.0WQXIW03uk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl/BONYACgkQXYcKB8Em
e0YqYQ//eZ0ELo+2rGIVY7/IGWv75TByV0jRWWSx4r+P86XbsVZ1m4wS0NV4c3+H
3HbLgvNe3F3JNJLOusL86+ycVOXSmSSqNrFIv8wR/QJDGlMMNHfGX4f5pmFzx3Ut
ubxOd2tKRKfvEjLhHllZPYyUU+xwMx2xm7KGS0A38+0g4M9KsWavXbbqOjK+c2hZ
vEagwsFdGaogYQagv8qllAgJG+Qf/7e9azcFIXM9g6V1C4QpsodnpPZh8Ro7SG3r
Ev4p4falqGb5jd0ajCNnVATpLvQCCSqEGf5UsdzcGd+kwMzYn+30lZe1Wo3eiwO9
sEfnwdyJINTJu9uPQihuYd9V51uP2i0mnNBOEnrCTVMhEMV4gMFMNPUIgrj6vPQi
YnPx4EbkRSeX1XESX5/crdTQTDrodfzHEXxcbuCEbJgMXOlF7F1gWiUlj+wTSXP5
Zg08AeIFR0AM7lV2zLfNmxLQrF8kj4n3pCUfI3ArDYmqkw4VdUPkl0XSSmNZFcvQ
e3NTslUuUtNk4Q/QD6746Ol8e0kIA88JR48RueRrtvy6AmYKN6I4ypoWrATpgsq1
jt+ZNDXuaofGmsrPhqoBcAskat25ZRXCdr9MqD2TBoRLxkAsfmVrqEpS94WWejqe
JRdTcZI8VHlP/agPF1FBnLOY5JkRt9tgBH7ma0jH2CEK+LrYEaE=
=Yxrb
-----END PGP SIGNATURE-----

--nextPart3050561.0WQXIW03uk--



