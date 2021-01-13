Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7622F46DA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbhAMIr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:47:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbhAMIr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:47:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1453A23357;
        Wed, 13 Jan 2021 08:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610527637;
        bh=L7wkA7tGkG9EaD6XHqcI9DqIQoV/UPxxN+MkO6L+n90=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jzA9AbFyFS16uysgJahZ7Gq1/l/BdDwQP0CfKej6vUMHocb3s150lcDJNcSV5WChG
         4fO7NkNsPCpeFP+zSqWNI+a0Kbr+241EcDNL/DmZCDf7qPkJOiYscLKoh1zVwPX1nR
         RVvKiuWI40o/WcY4ote6O/7M2qV9snHR9GqhmzOzbgeRfDw7dRiKBGI+3/Z5UNuSQX
         HfbNNEdyTHZG5gZu1/0mH2YXyKDg0p6t/oKyzoExOQNDTLJYHYQTwiw9T+pC+2Lgxn
         EI7fo1lGVn5w9tH4C1LgVTow6QvXBEGVWYob02O3d+YIcU/bZT4b7Ymri4BGrPyP1J
         8sPGXibigcHPg==
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
Subject: Re: [PATCH RESEND v4 11/11] usb: gadget: bdc: fix checkpatch.pl
 repeated word warning
In-Reply-To: <1610505748-30616-11-git-send-email-chunfeng.yun@mediatek.com>
References: <1610505748-30616-1-git-send-email-chunfeng.yun@mediatek.com>
 <1610505748-30616-11-git-send-email-chunfeng.yun@mediatek.com>
Date:   Wed, 13 Jan 2021 10:47:09 +0200
Message-ID: <87wnwh2pgy.fsf@kernel.org>
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

> fix the warning:
> WARNING:REPEATED_WORD: Possible repeated word: 'and'
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

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl/+s40RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQZYuRAAquol7LGOlU/bSyPZYQ2FDtfJjixnsQZ5
ULYdBj9C/SLkvwNZQsZSkjzV03WJngGZJTeKDurfykxoO/yZfFUeUd1Ihu9CwVkz
kGSOCmB3dkI+0Z3WH1LLdM1CQS1x97AzD7I3uucoIQmyvzXqRbByMXioUmlbgiv1
+tGnC6G4Pac6XnP3CpMzPtgCwGNqzIlNB+b25F8a9pzOJteV5TrWElmD1yKp+I5n
H1fSvdE5nvPUeL9hVxoDkX7Xdsg/9nB0j0NfP8/SQ6251auXJKFlcbnW2lyeBY7u
M17MzAbWGtxA6IfJqPM1oNWxiJ+QtJ8T4AcpU7CZr7vYyuAFyW/tAPsJGu5URWjg
AOhu2gzm/efoUaNt4NFpyCcO6gj2AKo7P1P35ANHnvMf36hZe2AkOp7G6txaMWEP
P1WTqOlLEM4Z2PatJXCbH/4jZMjzoLlehdZ/PfLKQWSUcTGSAqJXFgorb2ZnyXJI
MWRMnc7EPeLHIx8/XEUWDnK4t640rdjlRaH950ujediJp/mO5nmdBS6H8ZOlEuCx
PqODWpyBkONlnmzn1AqsWzbQfgT0Ezp0jgnAp9dsIdJtBe409TsRNkPVK50+uf62
TuxiSY46CYZHXNz0+rFWxgQBrSNEIDMBMfMtFcosxDUvv5msbOdwJChXuRN8JD0F
R/FDECyecnQ=
=Grxs
-----END PGP SIGNATURE-----
--=-=-=--
