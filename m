Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64532D0B5A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 08:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgLGHxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 02:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLGHxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 02:53:37 -0500
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EA9C0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 23:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1607327573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jw0hmNVD3o/YIEzBj3Wlqbm+6DzSZmM6Avc5truSmuI=;
        b=j/pKRLvxISdrk+CuUzj2CMzXMTSulhLUbic7V7QoMo2LVC2SyVb/S2LyI8nSfWi/VAkESe
        DWYa9iWfnrkqYhNczvs+Ge02GcyoDrTlxkfB3tZHGMdAXpMe8fhaJ0h02F0U36981TJghb
        5zE15ZHSPVUGhO2amAJF8hd3zc/Bf64=
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
Date:   Mon, 07 Dec 2020 08:52:50 +0100
Message-ID: <2560223.mvXUDI8C0e@ripper>
In-Reply-To: <CAP6exYJ7QR+Y7Vsumecx_3rUC4cNY4xJj4e6759S8US6FX7ADg@mail.gmail.com>
References: <20200429165347.48909-1-rminnich@google.com> <2124367.HovnAMPojK@sven-edge> <CAP6exYJ7QR+Y7Vsumecx_3rUC4cNY4xJj4e6759S8US6FX7ADg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11652155.O9o76ZdvQC"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart11652155.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: ron minnich <rminnich@gmail.com>
Cc: linux-mtd@lists.infradead.org, John Audia <graysky@archlinux.us>, Adrian Schmutzler <freifunk@adrianschmutzler.de>, jstefek@datto.com, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Marek Vasut <marek.vasut@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>, Ron Minnich <rminnich@google.com>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] mtd: parser: cmdline: Support MTD names containing one or more colons
Date: Mon, 07 Dec 2020 08:52:50 +0100
Message-ID: <2560223.mvXUDI8C0e@ripper>
In-Reply-To: <CAP6exYJ7QR+Y7Vsumecx_3rUC4cNY4xJj4e6759S8US6FX7ADg@mail.gmail.com>
References: <20200429165347.48909-1-rminnich@google.com> <2124367.HovnAMPojK@sven-edge> <CAP6exYJ7QR+Y7Vsumecx_3rUC4cNY4xJj4e6759S8US6FX7ADg@mail.gmail.com>

On Friday, 27 November 2020 19:54:30 CET ron minnich wrote:
> Thanks, Sven, for your patience, I will indeed try to test this next week.

Any test results?

Kind regards,
	Sven
--nextPart11652155.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl/N31IACgkQXYcKB8Em
e0a2tRAAgxxINqPYhc87CiLq1z8QpLubdnCWBYkNk2KCnD2ynM+mXDZDTq/YIwYf
0BEworh5+po4ruUOQhfMFWidN5VakghJEbOUU8hbPg8qC5KQpYu3UIZPHqyxW2/E
Yygl5wqramKD+OArdBkiRr0l5dc7vcW9UFPCUU3VR0RKsXUoONQsVFcRkmnadFUU
lQ2XiQizmjdJIyEszdLvddOoH9gvlpClwirDl7qPeMBCR0SfSTgcqFrGV4Rr2hg2
IdKihxKupQzHKtzgD/ExncQyUYafKEAsu5nf7DN5lDSskY5d+PEj2dXeCZBXNPSM
W6/tL92fOnuqoGWYAuKmDfh51PtH1Gs3mHyXoRZ+uM6kwCMul+gDRGGXek0z9Arg
bmcQUplWaQ6Wn5wGW8hzc6bSTuPyHBsCAds3ZZxQxxMpR60yUXVQ10UwhUFN+vjd
YdbL7Qf2oI4QgLdsi4zVZaxzvp+hjZZJODdXxcaNTb9fcZVSJIWwSUsvxh28MFl1
RoM8HSTXUFKKdM2shN6YDuPt/JCF1HNlJDu1l2jbeU5omtgPMM0XM5AIj5t+fzb7
YyJBrhB+PAMnKAc+55brT61JamUMSHAR3jPYyQhxVu3dOzCcXKl7QnTjTmFQz5B9
LMU8nlyxqJqhbMIXCXoC0b1dhBE94hT7WxHCDyyrjnFm9Mpm3w8=
=wEB5
-----END PGP SIGNATURE-----

--nextPart11652155.O9o76ZdvQC--



