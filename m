Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D690127AAFA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgI1Jko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgI1Jko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:40:44 -0400
Received: from saruman (85-76-46-49-nat.elisa-mobile.fi [85.76.46.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1C252076D;
        Mon, 28 Sep 2020 09:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601286043;
        bh=hSGfZeW58XRQdp9ylXAlrT1ip9UCkq8zaOka6WESr+g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lxVoTomA5SN77FHXbS9WlPs3YwUF++X6eTOAyBMaTRgu7PXacB7WUccBI3d2zEFQB
         HHyS8hS9QLAZzIHiw+o82ZoyI7iTpNlmrs6je+88KULRGnNbtys+bSxYBe0MfQNXHX
         jRSY36MdlvedD9lGPj7EtdeAO92l89ADT8VAaqD0=
From:   Felipe Balbi <balbi@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] usb: bdc: Remove duplicate error message in bdc_probe()
In-Reply-To: <e895f44b-2c53-a883-322b-e3768fdb6733@cmss.chinamobile.com>
References: <20200927134218.20028-1-tangbin@cmss.chinamobile.com>
 <20200927134550.GA302849@kroah.com>
 <e895f44b-2c53-a883-322b-e3768fdb6733@cmss.chinamobile.com>
Date:   Mon, 28 Sep 2020 12:40:35 +0300
Message-ID: <87sgb29r3g.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

Tang Bin <tangbin@cmss.chinamobile.com> writes:
> Hi Greg KH:
>
> =E5=9C=A8 2020/9/27 21:45, Greg KH =E5=86=99=E9=81=93:
>> On Sun, Sep 27, 2020 at 09:42:18PM +0800, Tang Bin wrote:
>>> In this function, we don't need dev_err() message because
>>> when something goes wrong, devm_platform_ioremap_resource()
>>> can print an error message itself, so remove the redundant
>>> one.
>>>
>>> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
>>> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
>>> ---
>>>   drivers/usb/gadget/udc/bdc/bdc_core.c | 4 +---
>>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget=
/udc/bdc/bdc_core.c
>>> index 02a3a7746..9454f179e 100644
>>> --- a/drivers/usb/gadget/udc/bdc/bdc_core.c
>>> +++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
>>> @@ -508,10 +508,8 @@ static int bdc_probe(struct platform_device *pdev)
>>>   	bdc->clk =3D clk;
>>>=20=20=20
>>>   	bdc->regs =3D devm_platform_ioremap_resource(pdev, 0);
>>> -	if (IS_ERR(bdc->regs)) {
>>> -		dev_err(dev, "ioremap error\n");
>>> +	if (IS_ERR(bdc->regs))
>>>   		return -ENOMEM;
>> Why not return the error given to us?
>
> Because when get ioremap failed, devm_platform_ioremap_resource() can=20
> print error message
>
> "dev_err(dev, "ioremap failed for resource %pR\n", res)" in it's called=20
> function. So I think this's place's
>
> dev_err(dev, "ioremap error\n") is redundant.

that's not what Greg point you at, though. Greg's concern is valid in
that instead of passing along the error within bdc->regs, you always
return -ENOMEM. OTW, your code should read like so:

	if (IS_ERR(bdc->regs))
        	return PTR_ERR(bdc->regs);

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9xr5MRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQae9hAAj/+MYvC3rd9Nw/wUBLQM1T9brS0TlurW
OsJ9eISOUrxX+DKJps0sap2htm0L9mde6DANQJZhr/1REnMOQbuI9XYgIeTHI6eN
ox/caGdUdknen9xtllm09HXiGHUgWzsV2vIaLBOVuyU/pFQarjYQwophzlX2H9KC
rbHEyN1RozfONjgPiy4TPTWN9EydKqMWQedD79VbBw8zNJ4N3nfPU5NCLEBGbl/M
ZcttW1IAHAN5kbZToHEeEJyXBq+BkEyP7e6hPOcWiavWOKFsfrGYWdsfrKp+jiWc
JFmND9bi7xEz6UlqBpR0Z6R+t7k1GEXmvx7Y3ooB0lWrzbvI9Prbq3AnZSsJt1nn
7ypAZykvGCBx2P59GvGu6/Rcf1fD8PYIvKj07HV0aUy4a6r5SxWOXM2dINjgIng0
zgx5Tb6mHFmVg1vK0byPNV587dS3LLWmt9b6oqozItjx8PecqWjx8vEL2DrmzXoz
zRVQsAQBn8KCn7oqgnHVlYs6oROsw92WLOjMQagmS+p5a2NPSISFmFPsSTSrBgFD
FjYn/kSdJvFOqgYo0wRGwpaOz/kj6vXHVpfu6Ug6oLawlIBr/5YNGVZo6XGWAY9w
nyMGlWNai7hJLSrJ0VMvdJUxoRnJt+7SgEgMuAEBfRdV0TqnBfujdgeAihMt1Skj
TRozmt22FBY=
=iFro
-----END PGP SIGNATURE-----
--=-=-=--
