Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DC32ECCB5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbhAGJ2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:28:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:45866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbhAGJ2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:28:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5898623333;
        Thu,  7 Jan 2021 09:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610011654;
        bh=v6tvU4u75O87XGVKqhuOgv2RQDTCtSf4BgDyD57m030=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Y8jTbsUXH5iyZAabxfYOFhllsKQo77IH4SzINhJ/wQrMUJA/sDLCg9EpoLvKvAMSn
         MPEWbzMZJpiDububonhNxNxzZHUhUsF8EbBYUIdSo/EDDFdFKsri2TWBG7DndgCfda
         Mu48kd6UacKCzEXUZ4warblVeMRUtSUrvgWkwvb2NUl3gcWUmIFIg+vIDxaBzptVyR
         fjIwowTk+gYlauQ76i3r5+R/qHKLOlvMii4b9j4EGq3fJMHYT5k2nTzSKOIClqmox2
         DM2pOsI5BMJUuU+r0gx4KAkauYW24OpYIwhl1IxJJJPPDo03xq1TesOPCSK7Yx6Qgb
         6QGv2Fd2C/+bQ==
From:   Felipe Balbi <balbi@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] usb: gadget: u_audio: remove struct uac_req
In-Reply-To: <20210106133652.512178-5-jbrunet@baylibre.com>
References: <20210106133652.512178-1-jbrunet@baylibre.com>
 <20210106133652.512178-5-jbrunet@baylibre.com>
Date:   Thu, 07 Jan 2021 11:27:26 +0200
Message-ID: <87pn2haygx.fsf@kernel.org>
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

> 'struct uac_req' purpose is to link 'struct usb_request' to the
> corresponding 'struct uac_rtd_params'. However member req is never
> used. Using the context of the usb request, we can keep track of the
> corresponding 'struct uac_rtd_params' just as well, without allocating
> extra memory.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl/20/8RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQazkQ/9FhF2BPE1CNXYaihR2W9A8AQb1CalTw3y
El25MMwd6mbleUenrL6MKOnZln+ObUHfj7f6bYnEX+7w4MGBdYtXIgPV7HMoaSMF
Z+vL+uoQMwHmHksLgmJzs1X2QSV4ZRYEqA9dlhxY7tipzAhI+aDudIrtiiH0c7Km
5wspdF1tk7SapK3d0wdwBEQI1o8D58Uer0ULp8p6ODYhEhennIN+wfLm2J5sEkZp
pgtETuzFxe04kz14vtkD3flhHsqDGl8M640s56sqR12nXU9Gqk7zI2qPjC7WW0Kr
FTXyod8BStK/nBZOHfWiXDFYinrVNeIMTfuwhUX7vTGzcabE6d8ySIzP46BgKBWO
Fc9NnBKFypNDZ0zlTBI1SjVlo+61QvBk2Z3mj9DOoD0l5zLHgKlrotUJcn0Mefpw
h+z/l3cqp2HOZa1/sQ/s/2cBxhbx7Sm9kx/FbKsMvR7+J+3EuKHGktbonBCjNku8
mZzGIcsbRBsnADTdLUR4WFL5TPsyNv0wSEr4WCYUV1sSC5+ZLgFYryGx16EePtmo
CAxzDCV6/qges6cTph4ujw3EvOzeN0Eq6DbdyoXPWszgp1UXjBEtj7JXhns0akBc
Ezn0rZl81/PeTI9D/0Ut2MieNKNffjRQU7fAxMr7IM2ENFA7p8mXRgAAcdj2zUrt
jsode1yCWVQ=
=Ylh8
-----END PGP SIGNATURE-----
--=-=-=--
