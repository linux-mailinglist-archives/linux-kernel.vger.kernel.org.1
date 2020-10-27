Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4381229A514
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 07:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732055AbgJ0G64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 02:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgJ0G6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 02:58:55 -0400
Received: from saruman (88-113-213-94.elisa-laajakaista.fi [88.113.213.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C19120B1F;
        Tue, 27 Oct 2020 06:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603781935;
        bh=RamkjBG+ES+esN9QzAUVFGHCL9QxB93W5Vxkt02/DNE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YRHeohhkTtmIkSjNa3HcGNkyXb/GC8JC7/7hfjYTHeZIZZWr+4df5oPcE32BqqdE8
         VXzYwNhkh0fc7ipeoleXkkMS9YWF2Pr/etF9x1R/dBzqvE6KKi1whJilJ/ZdKU/NM3
         nKXP6oCPJEj8GKQBdfYA2ff0VKmsCsWPfLGVt6io=
From:   Felipe Balbi <balbi@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 31/56] usb: dwc3: fix kernel-doc markups
In-Reply-To: <0b964be3884def04fcd20ea5c12cb90d0014871c.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <0b964be3884def04fcd20ea5c12cb90d0014871c.1603469755.git.mchehab+huawei@kernel.org>
Date:   Tue, 27 Oct 2020 08:58:47 +0200
Message-ID: <87ft60dujc.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi Mauro,

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> There is a common comment marked, instead, with kernel-doc
> notation.
>
> Also, some identifiers have different names between their
> prototypes and the kernel-doc markup.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/usb/dwc3/core.c        | 2 +-
>  drivers/usb/dwc3/core.h        | 2 +-
>  drivers/usb/gadget/composite.c | 2 +-
>  drivers/usb/typec/mux.c        | 2 +-
>  include/linux/usb/composite.h  | 2 +-

mind breaking this into 4 commits? One for dwc3, one for
gadget/composite, one for type/mux, and a final for composite.h.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl+XxScRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQa7/RAAtsPISo0jvA38qvCiaBG+0xB2vH45RPzI
IB7UCKT0xkEo9Vonh3ub5KtgVL78H3U5HLYUWIqc2hhZlxRRyQaU2JZo+sDUwepx
u6Hf/a4vR2AkDFaz3ZR3/S0ZhH1GGMGSUbPucJwGG7fz8BzQcBORQ845wRqKfZ/9
8SB5Cr7Y4zgzf4hLe1pvfHgmROfpDuJfSf6lKq8FXHuKA+e7BgWxvIR4io5VGRFj
AtqFX6sfWScuP77Rr6xM39SNAm3nAZ0TnhRtfhivaUqn6/PgHS/VLRKvSZ1ycQ1u
g7X4736zyRHHbMnAWKSUrAZocubceU7HthLZPAhrRohvvRqwcX/B54iWKHn29I4p
eBAEMw9LeWmHz7XuWPMFdgG+11SQG9s1Ah0Eh9z4uGeeTtRaDqzKFwTnIG75i4MK
F4JwqRBZGKsH8JFq5kr2x6RT8hx1w/w7BCgY8yWs2XgcT3T1uSkwDb6n+I45mxg8
Q3IKaER4GPcM4JUjV/3sCgPpHHpEY+/LfW4EIKFVXyGu8ohfEDsqQlSkZFr8FKBB
FLZOnE2sUzbJVdxRJpfRWbApAJqMFDh4VZn5PmiXjPxtD5ckp903uctpJK3iPEBY
FFofoeDmau1rIjYZVFhQVQcmSk1xaZCAUdkgXqCp/kK0Msv3R07WHNVrfaOFBtBa
7I+hgoGT9/8=
=oidC
-----END PGP SIGNATURE-----
--=-=-=--
