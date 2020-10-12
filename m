Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0A128BC8C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390853AbgJLPlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:41:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390298AbgJLPkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:40:00 -0400
Received: from saruman (88-113-213-94.elisa-laajakaista.fi [88.113.213.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F29FA208D5;
        Mon, 12 Oct 2020 15:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602517200;
        bh=pXjYnodGKT31pxw4McVgCRDMJZ9+6CNCCIWwEIQu/gI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mibUuWdilDLPpFgfUC5jP5SbDtbLACMnIXY3wiUL42E9mZjmpSbE+vS39+ER3iFqk
         +d9+dn8+ExijWDt6cGKDtXbzo7l8EHbmdYTZIAJxOzr/uCfNqXtbZEgCAMvtuqNSdt
         pgRTwstQYUknFZZMTBhRIq7DYF8bhldluq0hQL2w=
From:   Felipe Balbi <balbi@kernel.org>
To:     rickyniu <rickyniu@google.com>, gregkh@linuxfoundation.org,
        astrachan@google.com, rickyniu@google.com, amit.pundir@linaro.org,
        lockwood@android.com, benoit@android.com, jackp@codeaurora.org,
        vvreddy@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        kyletso@google.com
Subject: Re: [PATCH 0/3] f_accessory upstream
In-Reply-To: <20201012111024.2259162-1-rickyniu@google.com>
References: <20201012111024.2259162-1-rickyniu@google.com>
Date:   Mon, 12 Oct 2020 18:39:52 +0300
Message-ID: <87eem3lagn.fsf@kernel.org>
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

rickyniu <rickyniu@google.com> writes:
> Below commit is to add log and send uevent:
> 0003-ANDROID-usb-f_accessory-send-uevent-for-51-52-reques.patch

if you're sending something new...

> Benoit Goby (1):
>   ANDROID: usb: gadget: f_accessory: Add Android Accessory function
>
> Vijayavardhan Vennapusa (1):
>   ANDROID: USB: f_accessory: Check dev pointer before decoding ctrl
>     request
>
> rickyniu (1):
>   ANDROID: usb: f_accessory: send uevent for 51,52 requests

why do you send me a broken version with two fixes? Send me a single
patch. Also, please correct the subject line for the patch to match
what's used in the framework. Something like:

	usb: gadget: function: add Android Accessory function

should do the trick

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl+EeMgRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQbCZxAA2S4smOmwKpTF1vu+EAZs+iMXhGMnVMim
HNQaodbCpLJkyqePitIrmTRg23rg/zPw6r3HWlIYeMY2sXJIfS9xBSXrn0CM6FVm
/YTIAeLeZ7cEqiaTt/ApTugn0sr7iFCowuP15PzmkJ77Yuuylaa67bAu0w6njwGK
HLAdaa+EUHY3eYGs9PCKulHPE601Z2M8mv9SD8QlPEN45OQeC3+LaMQZBRAR8ix6
6Wyl97ygzBVbEAoBV2HzYpI9yWpaxcP6qV45H3r5GBdF0vs/Zg01HBJybXluMLtF
kGDPSxd1rAoQFsIMfmiEncupneIKVEt98d1ew5UUpEWHYAeolZ9ICfSupiznYQAB
1OGORGVxpIkaF77V0JBTafYSEbwLnFLd3yT72gGjB2L0B6Qj5PNsTGkpLPsH4ko6
mw3xVgUMru5FqdI8IEiI6UjZqRmuQ6zZFhU0jgqCz7QxFhKtLEv2RgAXznF0+D3B
AGQKAsen3h91YKIFoFwsZKdblLtA9+2dihsSHWdpF9p+8lgihKdeElsVvZnNtbzS
rHV0x7rIcznngKUfqB8cqAY/dv3GmijkTlV2DFJ9h2LdvMaxcMRrarNnO/OKgAfh
mV7VVKRS57YNxaJ6ADmYFCDzWJKtn+GNc9SdirOajA9T2eGw9/XOAByBuFomx8X4
U6CZNcb0dks=
=70gn
-----END PGP SIGNATURE-----
--=-=-=--
