Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AE22F1C73
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389602AbhAKRdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:33:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:57282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbhAKRdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:33:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6262229CA;
        Mon, 11 Jan 2021 17:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610386378;
        bh=hyGDZq6kMN0yigBwko6XGQtHj+etriDMlw1WV1/9RXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jcalTuYvWqJYgm5VZptCl+bzwPy2lL7keSdOsAlROQEP685Z5yhfb9S+iJ4ttRE2B
         e3l+9eISGtdJvIDtYrA8OexbkNXmYM6NS3BR+xC0PAWzQxvRuMsQGJ0dWQGF9QThch
         28+iSNAkXTedRRzAJtu7JxRfoYindNvMAWamEwzGhYpapp8IxWVZNlayH6mFQX3qBc
         ocJMzBnWcImLplV5s0Mbajuyqhxgntf/rUlwu+euVoOtQrfMZqCKIKDZp4Z+NQk+hw
         r6/qF7+tlKKhzH2lBGDwuTUaoPQvpAW1PrwnKRHGiTHlFpQ4HKzq1VJlcwr2mgTKOJ
         /1UJNA6nrtq6A==
Date:   Mon, 11 Jan 2021 17:32:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/6] regulator: dt-bindings: pf8x00: remove
 nxp,ilim-ma property
Message-ID: <20210111173224.GJ4728@sirena.org.uk>
References: <20210108225006.153700-1-adrien.grassein@gmail.com>
 <20210108225006.153700-4-adrien.grassein@gmail.com>
 <20210111172019.GH4728@sirena.org.uk>
 <CABkfQAGUkUwS9UKOVY5xP2UYc+zUHL=t7EMPYWTyQ_Pw-v3TOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jIYo0VRlfdMI9fLa"
Content-Disposition: inline
In-Reply-To: <CABkfQAGUkUwS9UKOVY5xP2UYc+zUHL=t7EMPYWTyQ_Pw-v3TOA@mail.gmail.com>
X-Cookie: Too much is not enough.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jIYo0VRlfdMI9fLa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 11, 2021 at 06:27:52PM +0100, Adrien Grassein wrote:
> Hello,

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> Is there a way to declare it deprecated in the DTB ?
> I never saw a deprecated value.

If nothing else you can put a note in the text description, I don't know
about the YAML format stuff.

--jIYo0VRlfdMI9fLa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/8i6cACgkQJNaLcl1U
h9Dl3gf/b3QcaKDXLrWh3AZs05YqrmkEY7DpqI+GVNudEYbBsJAX7MGdDaHoOmid
CoGmBy/PWlFbSeIiefEhoFKEB0OYU81yhxZickh8ejqh+6wWeemCQ0gVo8DyovlP
oU+I5IrJuo//X1QvcEAFaUCtr8TFD12pbFPXexyg2PLkqeLyDz+Fo1IUnTd4e+g0
WrGRxr7j8it4M/l+ErcITgNCzMQJECWwRS9WwJ2bVvA8JINdekqyPlOWdm2beC7i
LVrZMZMta6TnJeqxfBkz4DbxPv5XQSjqBUNpDwvVhtc7UfSU4mu4qCJbZx/bvf4P
QVLnWXaM+GZ/9SLfxRI9bwWsZEZcFg==
=4Fh5
-----END PGP SIGNATURE-----

--jIYo0VRlfdMI9fLa--
