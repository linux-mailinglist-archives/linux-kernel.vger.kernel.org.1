Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D2F2959B3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509065AbgJVHzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2509056AbgJVHzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:55:23 -0400
Received: from saruman (88-113-213-94.elisa-laajakaista.fi [88.113.213.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADC3A222E9;
        Thu, 22 Oct 2020 07:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603353322;
        bh=d1bgd52qcrvHmLf6y4Sf3uxls4XbYPCmmdmANVvb0pU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=P5zTGyN0k1SHuSju513v5RMm7idT3w2mmOuuwWfkWKJtg37DgXaQQWzMtgCHUbhxA
         sdVhCa4s4vPa+O47lzDjYxtXofBu9dXJxnYW/8pWrrY1ZJV2mYp0ABVdkZQrEA3VMx
         X4J9f2AYtOI4fxSzGnbsBI4gc2prSy8coouWysEo=
From:   Felipe Balbi <balbi@kernel.org>
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Yang Fei <fei.yang@intel.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v2] usb: dwc3: Trigger a GCTL soft reset when switching
 modes in DRD
In-Reply-To: <20201021224619.20796-1-john.stultz@linaro.org>
References: <20201021224619.20796-1-john.stultz@linaro.org>
Date:   Thu, 22 Oct 2020 10:54:53 +0300
Message-ID: <87y2jyelv6.fsf@kernel.org>
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

John Stultz <john.stultz@linaro.org> writes:
> From: Yu Chen <chenyu56@huawei.com>
>
> With the current dwc3 code on the HiKey960 we often see the
> COREIDLE flag get stuck off in __dwc3_gadget_start(), which
> seems to prevent the reset irq and causes the USB gadget to
> fail to initialize.
>
> We had seen occasional initialization failures with older
> kernels but with recent 5.x era kernels it seemed to be becoming
> much more common, so I dug back through some older trees and
> realized I dropped this quirk from Yu Chen during upstreaming
> as I couldn't provide a proper rational for it and it didn't
> seem to be necessary. I now realize I was wrong.

This keeps coming back every few years. It has never been necessary so
far. Why is it necessary now? The only thing we need to do is verify
which registers are shadowed between host and peripheral roles and cache
only those registers.

A full soft reset will take a while and is likely to create other
issues.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl+ROs0RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQZ/Vg//ZRZX5T55gObmdwIFAhxCkKCehlJhwW2S
Lt1X5L2KsJhoa4OAme9nrS6d5wuEfMabymsqwPdcPOJQmKIVLQaX1o5N9JtNp+ju
7nkIBSQ1PtswV99RtKiccsHMwGG6R6AurZp3pYFkPG52j/fYVmkoqZHS0BZdjpXL
RwBC2SKMUdrEcUdRmcIoHnIwJGyClBf+hZyg4e3vLTVHU/u6O+f05Py+DZDaRXYB
i+Oi7qxWfyRZkUV6iaFThdEqBQAgTY7ddl1/7ypmubuZ83/RXaKFjBXACjND+Nl2
XXEgxlYY0Fnk/gQexUMvWrrM3gq64IeOpOh/ABJ26m2tUEJ7QPwjiQA0mJYjXApH
p+nB8ZSPQ8IdIcy+Gl+wMuka4Cw2NUH6rQX/+ufZZNH2o6fUhOoBySKjy4E1zGSa
96CAKrahemoQNxb5cprI1HODRmYCNHYxRcMTzUEJF9C6+AhjiVxcXjKCft+Gqh9c
fByEvJOzlD0cM0wf2wuy1uCuEE6mu0Ip7wQJSVRL9GEkjAmNItCqKAEXDRPu7Kwc
h/9LKWf/oX5IaeWm02eX/9DVUV9U1rSUTZP/LimRgbvXqMydSy6ra4xM+fTbUcHI
sUFTIWXApK6bQIwZ2i+J56bnV8Kw3vDU5Xqgx4mgGxjmHSKiU8IkD1EUp9pjSEsQ
AIrj0VBu+uU=
=QfqK
-----END PGP SIGNATURE-----
--=-=-=--
