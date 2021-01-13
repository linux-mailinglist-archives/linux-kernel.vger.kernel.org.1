Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E372F46C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbhAMIon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:44:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:42176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbhAMIol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:44:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 996AF20719;
        Wed, 13 Jan 2021 08:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610527440;
        bh=8vD1H3OBrji7Dv+kAqzSHBvZ1Y8zqi+AIhvBHvXdkAY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Dgci0hrZfjczwUjic4g0YR0DrOQaaJoxD6++1tHes235IYmqfyUXt9I1U7cRn/Ckh
         Q92XZgHLG6aDil4yb8JBhMKBdjD4FmDEW7TKVMRa7eMKwWMaRdnWdAVWd8wG17CODp
         bfKkvAUf0VL4jSNZfx9kz9NmNZNpxEE7wrEMb5pRtU1suphFbyPT+9TzpQ94jGDmwP
         i/otaCfe1pXFG5d22KQ8/BOFXMoKlN8NVlgGvzgHU50RVM56wHVbvI1fGfFXmYlOxA
         86V+fvRqPpbhTzbIdjHggKM0icJOBHmAklEXpGG/ZGOi2lwOxhhj9K6HmJLQFXdbI6
         jKHBrIgkyTMQA==
From:   Felipe Balbi <balbi@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: [PATCH RESEND v4 06/11] usb: gadget: bdc: add identifier name
 for function declaraion
In-Reply-To: <1610505748-30616-6-git-send-email-chunfeng.yun@mediatek.com>
References: <1610505748-30616-1-git-send-email-chunfeng.yun@mediatek.com>
 <1610505748-30616-6-git-send-email-chunfeng.yun@mediatek.com>
Date:   Wed, 13 Jan 2021 10:43:52 +0200
Message-ID: <87bldt446v.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Chunfeng Yun <chunfeng.yun@mediatek.com> writes:

> This is used to avoid the warning of function arguments, e.g.
>   WARNING:FUNCTION_ARGUMENTS: function definition argument 'u32'
>   should also have an identifier name
>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl/+ssgRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQazmQ//bb6xGov90wMn9log/XdzaOXit7VvKbXu
sWNfiu6HJMkqC1OicAh2Wdye5N7zM9+tBSCcQU9Yq792ftvN+9cAlpZS8qBBx/o6
J1A8+XIt591sOpVZi3qxxhzNwZrvsGsnFrUriNVB7YNuxwdfD8/syHMzZvIWXF9R
eZw89PWRbxMPGKDfLOxMLMoyGPdGJGOzzslBx0UXUQ58Fwr8wb/qePz7Gdy0MrLP
FBWniQnRU6KdRUAGC23duAP2bOcejXLwBoCVhaJ07hqoAnnvj5UOhO6UvFORGvCq
+knL/tkeSLUOXythEPBSTNQKAUlupuNGr+fGzg3ot5fETOKtFSJM/QfHKvSnHXO0
ItJiKSuL2RPJxsWzW6XS8856tUUmThheAuB7AY8GbihkuSDnsR7/Wd0aknbgCcRp
mhgO4YslYT+YlopeyT1WY/w0jtoa+aqW0rdiPzzl+sjgOr+k+VQFPsndHNg/eDL3
EjnSMZHUAvcL+ruocOsPPC8rgH9fP/fbBewLioSR4V90om0KyGC3ZEo0Y93qWY2d
3CsNaLw/p0BdZQK2fxyWAu1vw1CNW2RyuvZbidS8vEjM+MCEt73H3JQsxdDH/C3o
4bgPLciJSxfZUa2WC0ioM86aGIGsiEytfzr/VsqiZ/CQ36WLuNlLucz+TLs6pVe7
N9F/E1BXVeY=
=duvH
-----END PGP SIGNATURE-----
--=-=-=--
