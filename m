Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE65C278C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 17:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgIYPNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 11:13:17 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:47891 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728806AbgIYPNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 11:13:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 2DBC8419;
        Fri, 25 Sep 2020 11:13:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 25 Sep 2020 11:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Wel/51zD9H4ipns1IHhugzt5jIN
        W7SH1XQEXE43bnAQ=; b=JBJiba3InAR4HbNUA+z1sX9YvQAqoy77SS9sjGEQ+Rt
        pzwK6xioTNJc6P13WOfKonQtPtHaZfUkp6Neg+rOUsbUxCnpwlhEqkglWcoGu6BI
        1LG8mksPcTZm0KIjZ0JWKU8ifkdgfcjTev7EVyjGWJ+oqRqNWM4WLF8SeRyVCYdb
        qtgTV+CBQBCBh90GkrrPDuNiqP8PmyrrthxiPRDxLHa/QDBRaMUy7AVAO4KY9rlj
        m5Tf11rKuVc4oLEQSUw9S6DIinQsXyVdcsSyw8K8AOOm+Fne61PTY5ptlQH3qvIP
        h0ZcvwG6ZvQA+e28JJHutAD5g+tuuhXzkzw4OUnATgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Wel/51
        zD9H4ipns1IHhugzt5jINW7SH1XQEXE43bnAQ=; b=jR8dlmjjxkdxWD/MlbVmwt
        nOsJuTPWvcgmitaEVgVULhDHLNDzvtRJoyh4M1lK3YMZZ25l83Z9iqCB6rlfL7Mr
        lSFQVo6KTEGYgsuBCTLmsKa62cEeEyQdwGaXXv5N74e4b9kSGlPxdb+gezPd7RIA
        vZIEE4asfwCVlO55WZUrtnsxUgpIFbV4TIrpy0uS6sgJWlXqVTJoUpUTu9OAMqNl
        fR10RCNTrnJpWEF20SilqiHN1DHEnndw1OWWH5et1VMBUd84Vqr0uV8LDk0gFz0h
        7Rv6RnVoGlYXHe5jj0WoOSKuG8vL+UNdD24dbGJNZqRLnuFCbe4icYbKBp1hzzag
        ==
X-ME-Sender: <xms:CQluX7GTxdO_2tR6-gvzBPAJ7vz9CBUb-ZWv1JBqR7dhspFyXuedhg>
    <xme:CQluX4UE85r7Tnptlfo2mTAYIDWVBe1sO-xGXkHI28U6At2wJKJ4j1_dmw1C10Pec
    ulgzIBeY1LQUlcJKNk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddtgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:CQluX9LChMf7scD1--Fb-Xsq33oBnSbXz-6hR_aZbpj56QRuQyNrXg>
    <xmx:CQluX5ELCzUY2_gvNBU6UG39D_z2kHKAUqGWsqjHnSx8YNqDLsRDrQ>
    <xmx:CQluXxX3ByaBUHnsJ7kmcHrXdV60eb-SLQl120BoOewvAJPLW4vUsQ>
    <xmx:CgluX0R5rCftH3xqMtPzb-UBtWAcZvn4nuVfnb4x-skLz45n8fOiGA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id AA41C3064680;
        Fri, 25 Sep 2020 11:13:13 -0400 (EDT)
Date:   Fri, 25 Sep 2020 17:13:12 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Martin Cerveny <m.cerveny@computer.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] ARM: dts: sun8i: v3s: Add simple-framebuffer
Message-ID: <20200925151312.a6s7zixuxh6pnslu@gilmour.lan>
References: <20200916175941.8448-1-m.cerveny@computer.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="etda3pozoahqmjs6"
Content-Disposition: inline
In-Reply-To: <20200916175941.8448-1-m.cerveny@computer.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--etda3pozoahqmjs6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 16, 2020 at 07:59:41PM +0200, Martin Cerveny wrote:
> Add support for "allwinner,simple-framebuffer"
> with "mixer0-lcd0" pipeline from boot loader (u-boot).
> It depends on boot loader implementation of DE2/TCON0
> setup with LCD.
>=20
> Signed-off-by: Martin Cerveny <m.cerveny@computer.org>

queued for 5.11, thanks!
Maxime

--etda3pozoahqmjs6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX24JCAAKCRDj7w1vZxhR
xVWRAP42WcMnMXDkUoy4kqVW5psOofYCHVclAA0rOieQA+WaegEAgzJQ7/+8Hg/h
gmDw7ok8hmvqslff9aqjlR9ODT0j2wE=
=c6Nw
-----END PGP SIGNATURE-----

--etda3pozoahqmjs6--
