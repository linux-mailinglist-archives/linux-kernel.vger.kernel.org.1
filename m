Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127222F9E32
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388870AbhARLcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:32:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:59624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389854AbhARLbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:31:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BB88222B3;
        Mon, 18 Jan 2021 11:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610969443;
        bh=2yx1PP+7HxG9WpaJkcp3+1HSxgjL2NX9Ks3Bb0BI1+4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NzAy9GUmq4aReGw1IZH+mx+7wLolRtIrFWWhn6v6R1Kxi52Y6oPfgtO+sIarphpUC
         JkekuNnaovRdon0OJghyYDoEFaHB0ardXxnRUgZWks2JyTyBrukdsVYFR6r6FCU6To
         fd4oN3bodQpfEvVwbZ6W2hlnzFCEqcep3EQ0yPS25ih8aMec8VtEVuT6ysg53OAbzN
         ZzPx3EXez+/1oN2CGQM3l8fFHpKjqS6B1QJq9SdaaPOTBS9t/qiEEtaxNPk0U8wCs5
         hjJAXrNefMoTC1XTsfqnn9Ok3jttfein3/TAfA1257BFXGfHQ/R/3RNj0tJq8Is0bg
         Mu4vFmE2XE7Aw==
From:   Felipe Balbi <balbi@kernel.org>
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Subject: Re: [PATCH] usb: bdc: Remove the BDC PCI driver
In-Reply-To: <20210115213142.35003-1-alcooperx@gmail.com>
References: <20210115213142.35003-1-alcooperx@gmail.com>
Date:   Mon, 18 Jan 2021 13:30:36 +0200
Message-ID: <878s8qwkgz.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Al Cooper <alcooperx@gmail.com> writes:
> The BDC PCI driver was only used for design verification with
> an PCI/FPGA board. The board no longer exists and is not in use
> anywhere. All instances of this core now exist as a memory mapped
> device on the platform bus.
>
> NOTE: This only removes the PCI driver and does not remove the
> platform driver.
>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

It sounds like it could be used for pre-silicon verification of newer
Core Releases, much like Synopsys still uses the HAPS (with mainline
linux, mind you) for silicon validation.

Why would we delete this small shim if it *could* still be useful?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAmAFcVwRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQYV+xAAiQ5QnMQbi729VmLzXO75TZc0gYNdyt42
QfFnmmIYvILx8pXmGLx3CvMqwUmr+MziroTgD4/EI29ouh7XS0+xQTLomqEWCqZm
UJ8gKIFFlDbcsFeRdHl4ezTM4AeDLlnaCvl4Uhiv7/KOl8cNzxx8JN+v+YSQ1A3V
ClTPFDbf2hlZ5WcV4/V3EM9/UQInJYKCDcq4mUbtJo6+1Dy2Av70Vol6mAcOY6jH
LptSn+fCK4e5wyY1l15GGun7KjFcw3tdEqBKtgpMY2xzLuabzbVzufzRaBubm0qA
UtJ/tz8bFbx6ptu8cw0pqv56+62j06uK+57tlsZ33kcvikxKIzsnnm0qMIkpC462
Yx5OBJBhi4GsD1G6Pe48SVKx16PsE+pNtKOTI5x3D3E0NARzWvsHroQ7Xh6BHcqd
nFZQYXsEEPaCZXbWB/m+P6h145kUEgqNEGc7Vd1N//PoI6U863XQi+u+J8H8hdsy
oTrIiclXGkGg+FsshNVcjSAQ7bGA3E9vPvPyKX7iJXkI9jr2Z1kJjmfP28YI7xMU
SPXyJpUxakAQqT0SMxxzEe3sva1jSiVvY6zzaGLN9mxJHjb2gSe5vNBZTkNGJ7zJ
Kg6UL06lhaw9JGTRBPRgKpWzGSC0lq+YX5KMf1jALon9XTY5Eq0iPPVIys7Ltp0q
iRxKwlKUNws=
=TWmC
-----END PGP SIGNATURE-----
--=-=-=--
