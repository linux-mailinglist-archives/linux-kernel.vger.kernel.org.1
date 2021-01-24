Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6DE301D3A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 16:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbhAXPcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 10:32:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:38348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbhAXPcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 10:32:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B6B422E03;
        Sun, 24 Jan 2021 15:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611502324;
        bh=PwDoPYgW9LO7FgyOPZr87SZGeRjmGhl4USmSUv2EDqI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TKCS4nas60Y+YAYAq8P0xAnbR2GMi3WSIPW9J0A1X6QyA1B0RkMjl8eu2szSJNCh/
         JjsAhxVVDay23vUU/iQM3Pst3Fedc4/9MnRHfZ3MU3XP9UX05gY7z+cPbCKKckIAG+
         CdNy8Sd/kbsK24jZvcMtqbCfta+q8YcJwsy2khn8bUHmDkd19VwGLK6lNEOADoLyLG
         YpCPW36VRrvVZMRuHE/sqmIAWybXXVSVMBRFqpz9hyW5XN0c9+IPqP0nzIDnkK5yb3
         fmNxGV2nYs3ZNAqLL51TpzVDwlDiTREMG8QdtIXMtXiiPDHDHiiigrz5zzonjsD8fO
         NBYg6uy84pCvg==
From:   Felipe Balbi <balbi@kernel.org>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Daehwan Jung <dh10.jung@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: usb: dwc3: gadget: skip pullup and set_speed after suspend
In-Reply-To: <1611113968-102424-1-git-send-email-dh10.jung@samsung.com>
References: <CGME20210120035123epcas2p2048f6d9896bd21f19d939a56fe0b6610@epcas2p2.samsung.com>
 <1611113968-102424-1-git-send-email-dh10.jung@samsung.com>
Date:   Sun, 24 Jan 2021 17:31:57 +0200
Message-ID: <87ft2qgxle.fsf@kernel.org>
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

Daehwan Jung <dh10.jung@samsung.com> writes:
> Sometimes dwc3_gadget_pullup and dwc3_gadget_set_speed are called after
> entering suspend. That's why it needs to check whether suspend
>
> 1. dwc3 sends disconnect uevent and turn off. (suspend)
> 2. Platform side causes pullup or set_speed(e.g., adbd closes ffs node)
> 3. It causes unexpected behavior like ITMON error.

please collect dwc3 trace events showing this problem.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAmANku0RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQYN6w//d5LpZhv51FK2WtDCapufYLZnl2Khk4g+
z4+23MAeN4veZJrVShGxmTbFT1n1sqhhfVLXEFtZhJrKx6HBkWrHsswpSxzUlp6J
KLhYoh+qs3j1/ZZtxgISSnV/uSMzKbtucmZbumROGG6+EeEU0CAZL4QKzCvXZnbv
6ikvlrEknbZaE3aEwI29A0PSnzsyB4kMEfEfW/W5msuUj57ZtoTqIdW2SDQdW312
XquDw+bUS7bIUz2RQ4IdiZRvgVm43BZp4V1P9wXS95omC+3eAoiS/muc2zGxG5Id
rC5M1aiyJ9zB260yolO9oe88eUIqsxomPdXMXL262icv1vufN4RqpnrURj227+dp
gV6cp1P8PudgLqsLmDzfb6BmU74IsTFZDx+0YhfUVyvFQJPoogyye7OMRl6fAmE/
SuabQzSFZ7kqBMGGdJ22v9EZfcT6XFTSTHTeD33zf4OHfcAnCcEenTliMS9p7rGg
qeSXA6CrYr8S+BFzflOQWyxfbpnU/uOBLo19XY799bUoyALIoSToRR8A3XCnoFqx
tQqBQi4MkJnVuELW+sQ/VaoFs852fEtgpXUBTrAQkqWEdCWx48akGryHU+C5gBoP
4Gnge7HA90wgOjCDOufCD9vyn9ggR5z4xSjeWmIl8JoIW2BXKrhAzv4kon4kvVhl
xExlQxCZZEw=
=DQQC
-----END PGP SIGNATURE-----
--=-=-=--
