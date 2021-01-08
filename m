Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90402EEF7E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 10:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbhAHJYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 04:24:01 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:56807 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728408AbhAHJX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:23:56 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 8713F1B55;
        Fri,  8 Jan 2021 04:22:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 08 Jan 2021 04:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=C
        cLW3YrDUWfQV+M9LUTFqkM9jX0hR+fDKHKNjmd4z6s=; b=LnEkdg5LCAbBJB/Ze
        hKGzh7aucUDO3u0GGw0rwD9654J55od0myUtPm+h6R5blLhnIvjuDACZXUrvlUb2
        DU4jdH/fff5YfEfdVcuDfolMAFNPXJJObrsd1uRQpNLnjdfOdd3XfjwFTeK44yX0
        auAIIjXB/KFh/oH+m44kVfzUJzuUYpu79QHG9oByr6786ausg5Lhmh8LlD3dFDAJ
        UAlAogBScHORkwsasfMHHr++5TrGJDEzF+wgEEcMrKntyFM2z6VM4GMd18Z79CdM
        uWfAsHV/pkpk1IO3HVAcypqv0tRTsuvbRB9ainUkjY+ALZWnEIEKcd6mdIL0+c12
        3bJGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=CcLW3YrDUWfQV+M9LUTFqkM9jX0hR+fDKHKNjmd4z
        6s=; b=kIKRePrmbybVJoadIfFsiGiqH2Um115HLdMNK1bjUZXACfyMUIzFzzY2M
        eV3yR+kAk3Mpbsqn3lnU7/bDEJMQnI+MtUfSywIEQ4/NHvUtMH2a5t/wV9lcp1Fj
        3kJVtaMJ0gI2aUzppkzXnzsZ6zFDV0s9QBHM/iAvtUgjTsbPlRh/EapFPoEsCxqb
        BuZ5Zfu6jZd88Db6kxllP2fqa9GgjoS7cMDOGNiF+ZhUv3C9+zJ/jA7lM9d7r77b
        ZdS1sWzBNuzYXv1npgndgxxlYut8CA6LWn2vw23c/MPORtuPOZd1hMzHshjl5J8S
        vneJ114+/HvCb0SccOw/RF6Alo54g==
X-ME-Sender: <xms:aST4X_OI3lbF3nTL26I_FJT11ur-aX7lzmfv0FwF_N0pMaHIT1tkBA>
    <xme:aST4X5-9xC1G0G7gxPHtZiTqaGerorHD-vowtkh4pHDH3kvzHa2x5jb21dMzp3oQO
    H11PNbLHh9B4O7ItUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeggedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpefgjeettdejgffgffdvteeutdehtdehgeehueetkeefgefhtdetjeekledu
    gedvudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:aiT4X-TuFefcuUV6ENB7WC7udKNOdrluKZRik0X8137IXnuqiQm9UQ>
    <xmx:aiT4Xzv7ClB4WN6eudzqE26CQA35V5ysuvF-mTMeyVG6IzBwoE9biA>
    <xmx:aiT4X3e-C_NMSKqpIHyd9Uj8FPG2iwkB_veg1JXt5rnCthASE9gGdA>
    <xmx:aiT4X-5oLgfO0PGGatf8XzVaTi0p5OF7hb3PhNc5OrDty0O6VPnYoA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id BE12C24005A;
        Fri,  8 Jan 2021 04:22:49 -0500 (EST)
Date:   Fri, 8 Jan 2021 10:22:48 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Sergio Sota <sergiosota@fanamoel.com>
Cc:     robh+dt@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun5i: add A10s/A13 display frontend support
 fallback
Message-ID: <20210108092248.c3pmjrextonnf33q@gilmour>
References: <20210107105927.2815198-1-sergiosota@fanamoel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210107105927.2815198-1-sergiosota@fanamoel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 07, 2021 at 11:59:27AM +0100, Sergio Sota wrote:
> The A10s/A13 display frontend driver is not implemented
> Set A10 display frontend driver as a fallback for A10s/A13
> Tested with Olimex-A13-SOM / Olimex-A13-OlinuXino-MICRO
> "modetest -M sun4i-drm -s 49@47:800x480-60"  ( 7.0" tft lcd)
> "modetest -M sun4i-drm -s 49@47:1024x600-60" (10.1" tft lcd)
>=20
> Signed-off-by: Sergio Sota <sergiosota@fanamoel.com>
> ---

You should mention the version number (using -v in git send-email or
format-patch), and add a changelog here

>  arch/arm/boot/dts/sun5i.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
> index c2b4fbf552a3..4ef14a8695ef 100644
> --- a/arch/arm/boot/dts/sun5i.dtsi
> +++ b/arch/arm/boot/dts/sun5i.dtsi
> @@ -734,7 +734,8 @@ timer@1c60000 {
>  		};
> =20
>  		fe0: display-frontend@1e00000 {
> -			compatible =3D "allwinner,sun5i-a13-display-frontend";
> +			compatible =3D "allwinner,sun5i-a13-display-frontend",
> +				     "allwinner,sun4i-a10-display-frontend";

The comment on the first version still apply here, even more so with the
additional details you provided in the commit message

Maxime
