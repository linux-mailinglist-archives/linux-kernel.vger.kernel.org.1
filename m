Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347A9276AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgIXHUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbgIXHUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:20:53 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A396B206B8;
        Thu, 24 Sep 2020 07:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600932051;
        bh=a3boahYY+bS1/3ZRRZ5pIrziFhmmowCQ1igHJkDY6jM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qnUbVLurpWTE/wcG8DFPoLzFnY/KFPdHboliqZc/auY6HYI7b4adpAZ2famHmdYCz
         omvI1Ezysxt/NpM9Ea0zslAtXTU2qCjEURUYX7TVwp+OUUfhlVwtjlWGAXuBxFn3nm
         cRSxliZ6JoyUcIIA1ytGUvCYrVpSyiJwcWt3jPPI=
From:   Felipe Balbi <balbi@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/7] usb: mtu3: convert to
 devm_platform_ioremap_resource_byname
In-Reply-To: <1600400313.20602.4.camel@mhfsdcap03>
References: <1595404275-8449-1-git-send-email-chunfeng.yun@mediatek.com>
 <87d02y1190.fsf@kernel.org> <1600400313.20602.4.camel@mhfsdcap03>
Date:   Thu, 24 Sep 2020 10:20:43 +0300
Message-ID: <87tuvnej3o.fsf@kernel.org>
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

> Hi Felip,
>
>
> On Mon, 2020-09-07 at 10:42 +0300, Felipe Balbi wrote:
>> Hi,
>>=20
>> Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
>> > Use devm_platform_ioremap_resource_byname() to simplify code
>> >
>> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>=20
>> why is it so that your patches always come base64 encoded? They look
>> fine on the email client, but when I try to pipe the message to git am
>> it always gives me a lot of trouble and I have to manually decode the
>> body of your messages and recombine with the patch.
>>=20
>> Can you try to send your patches as actual plain text without encoding
>> the body with base64?
> Missed the email.
>
> Sorry for inconvenience!
> Is only the commit message base64 encoded, or includes the codes?

The entire thing :-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9sSMsRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQZcxw/+ONb5c+++HB8zlI9JR9AsnkscALZgHSm8
OYOTF0Y9vLiuHbjLuSOOPdWdJyDlMoo+CYrHMV7jHsg6ojWjFGqIeZ7SOZqqLa2C
7Geg5kbbspYrR+ipwPvzCqU8Gnz9glIJJWW3tLA2Dw0hMdqYfJklqUM5i5j+/Fnc
zfUj60YtAWBlzAUC7shEXinexGFF2HiqduCc+qZTYO4sU0iEDT2RxS8TY1u0Tg8N
6zj2QOoB5yGhPwAz9QlQvfj0R5RG6SB+C5VjUJsl+fPquWggz8Zg0fdJ9DZTdmaH
mr4YgOWvJ9SDwI6apEaUd7z8CJ9gCX4ODQ4zM7DPTdGhhEgEL2+F7+brKiGxllEe
YVkScEl2xjqZ+AkAtp064WXsyO9aLncgRvlDl8Le9Md/I9q9XNaC+qgNSZIGYfqJ
wCqEldL2sBdtUMIJnOrMeXHut+Bdenn+/mWLKld8+Qq7g+D+0f9cH675iwwVztHv
riJnFJqzzqwFaHhTfCtzPyTp0l/XBR/0biUpW8o8l+6fGszG857Emfp+NCiQaRLb
/rGOMR5WuWRlJSmbrsDHxl1YUbqg6EcC/63GPJWReHdkagiZzIvUKAIguhPgLXiY
vGl5ebDhHbhFLko/gKgBBCMuZVsxT43FmPZ2ymoOldDG7YP6mmw4fP5DKIHFFZln
DcXZSvCWtAI=
=t7ts
-----END PGP SIGNATURE-----
--=-=-=--
