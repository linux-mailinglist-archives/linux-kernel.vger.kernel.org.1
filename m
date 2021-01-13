Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2601E2F46D9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbhAMIrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:47:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:43062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbhAMIrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:47:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A91A23340;
        Wed, 13 Jan 2021 08:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610527598;
        bh=dvlIFZW/v/8cgdLks+xrLXcyEhYDYffORyHMzvY1ylA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=t1vFmES09YRatSVr75TolkW5vOOSrAAYyz3Q9L67MQosdM40DMcpy6gsX04xkGPeM
         2hmtnpshNQi9H8bHwnkYsUeyL7FMJKWf8dwjTeXcU3jph09G3wbcAaJxzt/YbVRiRG
         mCiyUQUOSl0pEVYSa4PIpERBbKC5A6gbqEoyIbvj+f+girbcroD5XNL5BfZOFO6N3+
         vYASUwXOgwIxPiNz74zzYrH0uoTA9qI7BCzeca5NasncJ4kARbidVt/Qn3vkMTBqEw
         g7w/EakR7HaxCzMWVaSSGZz31AanRUScd16Ed7j/4/Q3aqzi8QnCOEJCOTdw3hbd3F
         1CIOT9h/5y29A==
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
Subject: Re: [PATCH RESEND v4 10/11] usb: gadget: bdc: fix checkpatch.pl
 spacing error
In-Reply-To: <1610505748-30616-10-git-send-email-chunfeng.yun@mediatek.com>
References: <1610505748-30616-1-git-send-email-chunfeng.yun@mediatek.com>
 <1610505748-30616-10-git-send-email-chunfeng.yun@mediatek.com>
Date:   Wed, 13 Jan 2021 10:46:30 +0200
Message-ID: <87zh1d2pi1.fsf@kernel.org>
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

> fix checkpatch.pl error:
> ERROR:SPACING: space prohibited before that ','
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

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl/+s2YRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQZJ0g//ZKkaFJWIXeYBbd6HHFD9Bo+s4ejSf4av
PUs4UZFEkJe+A+WFCQvbhYPMjL5ABLRMI/maXVQmcTJbpkJdQUc1qtkbNG3nLRBb
pjNKsmNZXDp/xXEZgQfQj/99QLz08insMN6XLc+WPSNdYX+9UchOhRlM0hrVQWgf
Je2OSeK7ETkfRFO0QP/BBfBzh/ujITOs1OdOcqLQyu1ULAoR5BSKD4albIalido3
j/rW7ZPNyThLCKYBjTu/sTQFlTkjgjoF7i9TU/MX7ZuHth3TY+/xnjFQFMCDMkDa
lnC3pVJda/6TjDGguGrNJjq60Nqx6muPvwYRXyUInMRuuoR5BCW2rYvwYw/yhxNw
nKVsPb+0e48L1zL7gSgS9nrnlN19pt8Rg6kJfpEFPY+Ax2EAq1N0lIzV09+jhrfU
KAqSWZNnwpg5C12fUMnra+5dqS+xUBu7FWHAXPI4oXoxtfUuA4i982wcYPsgpImn
VxZhhsVJtpqiAf2B1g4WfgIO0xY1mes8jjNVrDLQFdggeSzuIQtTst9SPly2c1GB
6BMUlqcHaNC7eGOrKrexj/aSExl3pSA5lPEVifE6d/91dv6YKvFb2Q8n5kErRhXl
GYQfwqqxqAmxpjtuMxGhhxAxIu8saGVbPps8EY5PYMTpzlP49hKnSlZMsKFQ33y+
TkPF2A7WDdk=
=AcrB
-----END PGP SIGNATURE-----
--=-=-=--
