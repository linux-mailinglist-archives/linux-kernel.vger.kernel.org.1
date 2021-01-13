Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C58E2F46D7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbhAMIq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:46:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:42996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbhAMIqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:46:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3A9F23357;
        Wed, 13 Jan 2021 08:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610527574;
        bh=dWBhkEGaY1sKa/1IcotatPi+FviatCbdyCOdfaKKVyg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NKMshoGHMh7Fqj93A1DiYEHYG5m/IzIPYOAlCVtuM5yOHVehiW4I5OpXUPLVGqYXS
         7VXdojgtQG+B2YofPN3Y4RkTcWCvzcFDjQnEWatyvqBsaJlpIyHRYdvQldzjrpHN2E
         r3Ob5/InLfMMDSb3vCieaQNAQUUX3iCR/h3RyPO+DNlBiZWEX6WSXVmYuf+B7RjOqq
         8uw1FlEs4YR7cHQceKfdQIYAjgqcKH60TkNtkfoDtUH4HYniCOuE5AREu6KXEF3QK/
         V9gateFPL7psTDb1JTpVtixQYNJW22hHPlINi+eAZMncW8tCvlvDGlb1CN3BHdwPqy
         a1ko/Nt89qD+g==
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
Subject: Re: [PATCH RESEND v4 09/11] usb: gadget: bdc: fix checkpatch.pl tab
 warning
In-Reply-To: <1610505748-30616-9-git-send-email-chunfeng.yun@mediatek.com>
References: <1610505748-30616-1-git-send-email-chunfeng.yun@mediatek.com>
 <1610505748-30616-9-git-send-email-chunfeng.yun@mediatek.com>
Date:   Wed, 13 Jan 2021 10:46:06 +0200
Message-ID: <8735z54435.fsf@kernel.org>
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

> WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statemen=
ts
> WARNING:TABSTOP: Statements should start on a tabstop
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

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl/+s04RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQaARxAAkN8Iw5o5MHQ04cBBuO/bjxsg8XK9Sqmb
1xc7uQsIu6pveNQqvI/xMRFZj1CvxMriWutSTfm7S9pnNtpD63V2+LY3ORD6u/E/
eBKnGmqPIRoe5QV3//7U/cKB/cpg8aLJxRr6Aj1Y/PetuUfb1WiwP5xL5IdA2Sla
WLcg9y3it8WZ1qBwbFuU3M4hieVfV4FLxe7+75y3RILkRhxljY0D1ucpDhZldLRF
nL+nrvcgDWTpBxvehZKSsmgwG3vmMX2Rr113Vw0OE0yzZryJwgti5k2N53656I7P
qs2Fr/4KRdYi6DHL4jWj/+WYb4MByG3ZfjITRWft5DOwIusFt0YbbdC+uRbylmAv
4qcUlTBXd0NTGmHj4H7xbu68uvme0Bv0SSgt+Y0GgYk+Pq4+4zNNVFv6m7O49M+f
mxGUjL/VhED8aenSRka3MXSPrptdwiJs0SSu0Qudr53rTFeGn0+4CUX8GPVwOo5K
O42l9wwu09rICdfO1ZSHPy4O/Gu32gPcU7ee456uPmW3FdbddoZPrRwwFeDkSULG
bZ+ixR74omEy13iEsMa+dCyY47z/ohe1lhSYTHMtvIKcbuTJ1LLKEB8KfWhBaq0o
NyAnMK5buM4oriTSGviiBlZdBB7h9JLjNaRu0f++AQyHYqYg40TSOn5vvFz3rcc8
ZWDG5ChoESc=
=yHMR
-----END PGP SIGNATURE-----
--=-=-=--
