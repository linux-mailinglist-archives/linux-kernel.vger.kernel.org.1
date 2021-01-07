Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26E62ECCA4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbhAGJXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:23:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:45260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbhAGJXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:23:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46E4B2312E;
        Thu,  7 Jan 2021 09:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610011378;
        bh=PWhxceFaa1LusoST+AkkvR/w0cZYCzP3CGTKZ792m6s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QGgf7tC7IAgPTL924EcC4J/m9V3fGnqNcS/9E/dBGmmLDqPxwJO8ngsC58JyVfA3w
         56tJ2CD1Rv6Yo0LHGlm4ObjBO/WluOzqtcPOxN5r1usB+QGtt4J+35GP+URuI5PK0U
         ai26fiJeE41sr1zcdPk0xV1eHn7PlqHQtfu075PGRcnF2yN556m9tuJufByPZd2HQe
         LyohYY86rUTfupbV6iHr3R7shVpP6g5cMERams0uhqX5FRo98AYc4pXy1uAHv7taot
         RUzuwrhwtjh89ERazNFRUYumrUOFBgLUiSQHEKRm4fujWrfVO1qmCPbMSoh4KyVeFx
         m1B1mS+mdOLMQ==
From:   Felipe Balbi <balbi@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jack Pham <jackp@codeaurora.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ferry Toth <fntoth@gmail.com>, Peter Chen <peter.chen@nxp.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 1/5] usb: gadget: u_audio: Free requests only after
 callback
In-Reply-To: <20210106133652.512178-2-jbrunet@baylibre.com>
References: <20210106133652.512178-1-jbrunet@baylibre.com>
 <20210106133652.512178-2-jbrunet@baylibre.com>
Date:   Thu, 07 Jan 2021 11:22:50 +0200
Message-ID: <87y2h5ayol.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Jerome Brunet <jbrunet@baylibre.com> writes:

> From: Jack Pham <jackp@codeaurora.org>
>
> As per the kernel doc for usb_ep_dequeue(), it states that "this
> routine is asynchronous, that is, it may return before the completion
> routine runs". And indeed since v5.0 the dwc3 gadget driver updated
> its behavior to place dequeued requests on to a cancelled list to be
> given back later after the endpoint is stopped.
>
> The free_ep() was incorrectly assuming that a request was ready to
> be freed after calling dequeue which results in a use-after-free
> in dwc3 when it traverses its cancelled list. Fix this by moving
> the usb_ep_free_request() call to the callback itself in case the
> ep is disabled.
>
> Fixes: eb9fecb9e69b0 ("usb: gadget: f_uac2: split out audio core")
> Reported-and-tested-by: Ferry Toth <fntoth@gmail.com>
> Reviewed-and-tested-by: Peter Chen <peter.chen@nxp.com>
> Signed-off-by: Jack Pham <jackp@codeaurora.org>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Looks good to me, just one comment below:

> @@ -336,8 +341,9 @@ static inline void free_ep(struct uac_rtd_params *prm=
, struct usb_ep *ep)
>=20=20
>  	for (i =3D 0; i < params->req_number; i++) {
>  		if (prm->ureq[i].req) {
> -			usb_ep_dequeue(ep, prm->ureq[i].req);
> -			usb_ep_free_request(ep, prm->ureq[i].req);
> +			if (usb_ep_dequeue(ep, prm->ureq[i].req))
> +				usb_ep_free_request(ep, prm->ureq[i].req);

do you mind adding a comment here stating that this is coping with a
possible error during usb_ep_dequeue()?

Other than that:

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl/20uoRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQYcqBAAmQJdLHjWNl1F+yEyLaW9Dy+9wcx5fHmQ
QaH8H4BTROvcOvGYK1fg3vkGiqdqeq/f3OOUTP+aCSAASTV5GF6pToeQkBfCME1l
5wjFKJ5dSI39IbLUAo0sg3hiKkNO5AzLOHYkOUtmZjjnJIAi5G80CfSHEZ9dyo+r
oP7mSysBWhcnlWEkeCAu5FvsM1qkM/MTkh6WVkztPXLG1FclOBjcE3WVvsumd+T5
hm0dwn11fdrF/C+XBrSR+nc+wEcbzQs9Hb55mSqllEKkcPvUU8cjkh99Pec/EJ+q
9Zh8e7+lRmMX9dvAyRo739vf5Xnrzjq2l3zWJjrYyt2BySgszlPMuFla7MxZoS1j
z62dVEeV8mVFFfz4Bcan7YS4NxWIQIvjcgTt/X2TC0TpayNVh1T1sn6PcKEUYr8O
R/4NF5HHuTQevhdETDKaYyG0HL7IZ7k+VgBytaCA3IMSFvaCzSdiNtML/Ogfk+W8
eWjZpm92EFEOo7DogvbAAM+YfnSet8r5j4mOPXCJy44XIAg2XvHu+l+lRnfQhOTh
XYdiR2KvEYAqnH2ELCkM2q7lA8EehpDZ33CZ3P4gAuCJv3K/ey8IGQE2H9Y1PCDL
2wvi2K8BwSWPyGS0VlEeVDx9ZinsWSRqLGMQkukUCN1b4ty7Fo6mevXj9DRulcan
WUMpLhhOPZ8=
=BPM/
-----END PGP SIGNATURE-----
--=-=-=--
