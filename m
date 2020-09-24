Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5380276AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgIXHWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:22:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbgIXHWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:22:45 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 049B220936;
        Thu, 24 Sep 2020 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600932165;
        bh=VoDQzBn28W/Kf+R2dL5h4s55F/0SLAG3ZhPE++y+2Iw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GzKu15K2/SCzdQVQn+HoZiHZ4hfy6c1vjiubYuR6qLPCBsrcg81ceGSqgMnsCaB3u
         OWjRuS4UFAjCO+GNJ66S1U/RRZ4yH6NRW/qn9XPlww/T/0RdVNZLurOXreZew67E5+
         0/9HMtskMxjTv56Q8/45rbtQw9T6ObK3jcLLnOgo=
From:   Felipe Balbi <balbi@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, matthias.bgg@gmail.com,
        swboyd@chromium.org, linux-arm-kernel@lists.infradead.org,
        alcooperx@gmail.com
Subject: Re: [PATCH] MAINTAINERS: Add entry for Broadcom BDC driver
In-Reply-To: <87r1qrej20.fsf@kernel.org>
References: <20200710034806.15650-1-f.fainelli@gmail.com>
 <830cd104-87de-4246-35ff-47a0ed5b05a9@gmail.com>
 <1600325394.20109.16.camel@mhfsdcap03>
 <20200917073831.GB3217334@kroah.com> <87r1qrej20.fsf@kernel.org>
Date:   Thu, 24 Sep 2020 10:22:37 +0300
Message-ID: <87o8lvej0i.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Felipe Balbi <balbi@kernel.org> writes:

> Greg KH <gregkh@linuxfoundation.org> writes:
>
>> On Thu, Sep 17, 2020 at 02:49:54PM +0800, Chunfeng Yun wrote:
>>> On Sun, 2020-09-06 at 12:55 -0700, Florian Fainelli wrote:
>>> >=20
>>> > On 7/9/2020 8:48 PM, Florian Fainelli wrote:
>>> > > The Broadcom BDC driver did not have a MAINTAINERS entry which made=
 it
>>> > > escape review from Al and myself, add an entry so the relevant mail=
ing
>>> > > lists and people are copied.
>>> > >=20
>>> > > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>> >=20
>>> > This patch still does not seem to have been picked up (not seeing it =
in=20
>>> > linux-next), can this be applied so we have an accurate maintainer=20
>>> > information for this driver?
>>> Ping
>>
>> Felipe should have picked this up.
>>
>> If not, please resend it again and I can.
>
> Applied

scratch that, it's already in Linus'

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9sST0RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQbGihAAp5fduyOtw+m+brb7qmckGTFWPkmjPLKp
kbMsYfCGfKzQX8dPOU7BitRHJTcC/+OcprvgKXM306tg7qdHBld+pypSbx9qhE27
qQ+5raHVpKTPF+tmjlk9Dd1QyYtQV2U2dNyCFZhwT7oRmFQuvcIuk30VS1f8Mtej
R4dOMKaUobQXD4fMD4OiwELVUzuKqcKuncByeMuvh5zOsAILykI9/k+p3KmeNmKG
lbsN78Sqnt+VxIDr/jRNuzWdnFEz9kO2yM/oZNPfo4GIXJwRgUXiouJpNv3Jnc67
gUt+PqDweQRhwa2aNR0Y3fn1oc5tsW6J3Ls2N6ODKKHcqrUr/9OC28kDULkfURRF
5gaC3S02clqRGrwa+0nNZLL8rzN8qOSqbVzMqV+DrZEibeRiZvcXTUXH5Y14l8SY
IofbZ3pGQ4KVPzyV9EoXa5DDgyWYZs5ej0B76Gf+Br1aM43Jph44L33n8OdAN6la
ZIL0EJ4FRJeu2UyGtnsE8HWyKk4euHNKRvmPaOcysrdJsJgjKYBoDWXtG9xGjcM0
QSpoqPuK1p2BiCUZWAMf7y8Mudm5eYBpekZw/v7SgyRQEidOXkv/jfMNe8nWg2yH
iRZuf2QjfxzarKCL6j5/l4eUV6oeG6Efe84y0FloKZO/WkSxG3SxgPYd9+kRu+zL
fkfFSqeYeV4=
=alAC
-----END PGP SIGNATURE-----
--=-=-=--
