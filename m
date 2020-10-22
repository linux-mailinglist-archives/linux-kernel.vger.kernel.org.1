Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9A1296230
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369036AbgJVP7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:59:49 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34611 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S368891AbgJVP7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:59:13 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4CBCF5C00AC;
        Thu, 22 Oct 2020 11:59:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 22 Oct 2020 11:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=G2jAYnLLHpqxnElk19VJKeBV6Wa
        dw7/+qTmz2pfi7rI=; b=Zu129rC65D3IoReyeyLuLMCq2KnrOHp6M5l35wl3w9q
        FkAfPUyfE5fxggfzAPHKlRi6fxuqPWC0wm6qE0PHs9JXpnkYX1ZSSJTSuGQcst0I
        Y3cRd7EAEQ6MpTM1RTSObLc/89SKLwxBjtiTvM+NebfGs1KHkqmv7YHMUd9rz7jn
        aEmkHql1if2s//oNoNrvgeQw9uu2xiyJapGx+lSgjhfzKb+hcNZl81/LRf1PJ7o7
        IWWe2BGc4ivW201vkzhwnOetE/YXQyNoVQE5jqMTvDb+k6XvBpRZuXYik/GYo76W
        txWUfrFMBtA6AfVHEXjPBQ6RSbF0218gwXZzXOq3/Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=G2jAYn
        LLHpqxnElk19VJKeBV6Wadw7/+qTmz2pfi7rI=; b=SvbsztDjC335d3C0zPVFG5
        ASFb2CIemFEPokULChL5O3hGCHiFptWRm1bSDCOhuLF3dNUUAcWKceRE/e7ufmUo
        DGbCV0pdMd6CnuIsbPDi++I6615K6hrIGTo44ba6J3Qpq6bbyebq97rzhWcOARmf
        HPI9TRO4/r38CDw6xqG8bYYtwcm53usNX/sJJJS1AgEz7lZyVvtU/5BLnaT0I/mJ
        RFhifGv3AsB+B1ECuNVyQJVmjr/tYv5EKahd0bTvvpldPuP+bHVoZ9MKkZaN0nKl
        SUDyQD5vucgJngtcesmnEOv7rqL780+zRmKJw6eJWB8FszxYVd488qIBhaJ6z2eg
        ==
X-ME-Sender: <xms:TqyRX29dBLKnfAegcL-e-f53mLBPqp0pVodzwOSJRNRjKWaVxx1joA>
    <xme:TqyRX2ueF2RpfGoO382CVl8bFXxu8X_QZEnpjxsc4KejWgVvmhoHRg8jmhB1UX48K
    Cnrm7s38MCpc-mtAhI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeekgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:TqyRX8DtZqI4n67yPJFBk-nFbnOj41a8GJdE1KZnK3T3RrgfxwCp-Q>
    <xmx:TqyRX-cmUZEUXxlZxK1tlKdZcixCpV0bCjOsfFWCWn8Z4gykv5M97w>
    <xmx:TqyRX7PeuDNfS8sOsttAvwG1BjXDOXcBGNVkgh4HWnRpzuWeb7Zusw>
    <xmx:UKyRX0rOCF-8vYAoKbR1j5TO2kTr-mZEmPYJBz-U9D0fQeCYB-mCeg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 99EF03064683;
        Thu, 22 Oct 2020 11:59:10 -0400 (EDT)
Date:   Thu, 22 Oct 2020 17:59:09 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: beelink-gs1: Enable both RGMII
 RX/TX delay
Message-ID: <20201022155909.tuewdjw2b2nowp3f@gilmour.lan>
References: <20201018172409.1754775-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w2egafvugvt4ffdd"
Content-Disposition: inline
In-Reply-To: <20201018172409.1754775-1-peron.clem@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w2egafvugvt4ffdd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2020 at 07:24:09PM +0200, Cl=E9ment P=E9ron wrote:
> Before the commit:
> net: phy: realtek: fix rtl8211e rx/tx delay config
>=20
> The software overwrite for RX/TX delays of the RTL8211e were not
> working properly and the Beelink GS1 had both RX/TX delay of RGMII
> interface set using pull-up on the TXDLY and RXDLY pins.
>=20
> Now that these delays are working properly they overwrite the HW
> config and set this to 'rgmii' meaning no delay on both RX/TX.
> This makes the ethernet of this board not working anymore.
>=20
> Set the phy-mode to 'rgmii-id' meaning RGMII with RX/TX delays
> in the device-tree to keep the correct configuration.
>=20
> Fixes: 089bee8dd119 ("arm64: dts: allwinner: h6: Introduce Beelink GS1 bo=
ard")
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Fixed the commit ID and queued as a fix for 5.10

Maxime

--w2egafvugvt4ffdd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5GsTQAKCRDj7w1vZxhR
xd64AQCIV33/bbhiLvFeqkPlc8SlHZDtO47jGB52Pmpa6cJO2wEAw6BEZrr3te7W
gwQEfE1QgXcQpxCN6jGY+g7okajOAwM=
=Utco
-----END PGP SIGNATURE-----

--w2egafvugvt4ffdd--
