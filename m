Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFED2FA4AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405895AbhARP3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:29:42 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:58165 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405803AbhARP1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:27:34 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6403158012C;
        Mon, 18 Jan 2021 10:26:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 18 Jan 2021 10:26:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=HODlC4oTG9rxHBfdiZZiciw1z+S
        a9kzG9dx85WTpST8=; b=QKwHZwQ8RclPtWnI7UTVHiYmheg/iKTyobfbMmYCQqT
        l2XvK0H5RT4pKkfRx68yYI/YwkNx0To2SOcV7MlyrpUk/+Cgi8RFO1q94zNsXoY4
        fFlLWaXxMBlYDA+SxHTvouW+gE+Ah/nyur1Qa6yofpS5PQRXuUKjxpP4YZGuDIdy
        /9QqhROtpPCh2JiSenTHR/fSon5ZUsDRUDw1JJaVvLY2eD/LK7Zk3Td009nQa4Tp
        OjrWw2xggmAllSf4mS2n425eEFFajgQc0VCWZmgXMtaFagHs3RUZnCsJPdQsZkGw
        EOLxL44+K2l2LKrXZ+kAjB1pfbTfJcDju4ecyx0558g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=HODlC4
        oTG9rxHBfdiZZiciw1z+Sa9kzG9dx85WTpST8=; b=Ufp4fuduJH973pgc/PslyF
        ACS552VCBIEBiHuqRFq0SpAtJIFe9ZGnSLW2djmx6enEI0CxLomViaUqgPgcrnWM
        X9DJOfNa2zqDoUzUspYgCasxPQKqFAXFQSAmAccVT/r68AaEPqR9pRmgfntdSL+m
        OyDKMKh2DhTyhcFps7genTzK4o/mYVFw1ErtBnd4NXzd+kaT0TBWXHGbcufa92A2
        t3xlHwn/rmwfz/SXdz06HqYkiB+TAmAlOHcgWbzm3sFQ5ZjO/2ou/NqDd3wt1Dkw
        E9Vsc5peajULaqphiaXFaG25CVsKYfbqrFRqXZoEP8IF809sHq9RjwcQnTY4GDGg
        ==
X-ME-Sender: <xms:uKgFYBEF8VUjcTGRz5dkeRDTM4t30rAXvR5Q7pnxH43xZi4N6GQliA>
    <xme:uKgFYGWKztPn38mlut8j9_QRoYoPKFQDP29IfKrbSls_USWSPcn_7baOw1Q2tlwz4
    lAL06xXZpJVC3u_xkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:uKgFYDIDxOGSItK_1DTT7VwusKoQiq-NP2_lQHzx_xvwsU5TdbKEPg>
    <xmx:uKgFYHG0T86aW4oRXPt4sPx71w-Uahz75MWK5esjsUh7k4oNABLDXw>
    <xmx:uKgFYHUefQahap17-eWKC-pq-6jBTE9cQAKsKAK247mFNRKVDwkS7Q>
    <xmx:uKgFYIt4r7ymGuwkjN8TWwl7JExMPjJvb1MEZq4cO47XpnP3_gBldA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C3575108005C;
        Mon, 18 Jan 2021 10:26:47 -0500 (EST)
Date:   Mon, 18 Jan 2021 16:26:44 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 06/21] dt-bindings: clk: sunxi-ccu: Add compatible
 string for Allwinner H616
Message-ID: <20210118152644.ayjspu5iigajzooy@gilmour>
References: <20210118020848.11721-1-andre.przywara@arm.com>
 <20210118020848.11721-7-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4homvfvy5rvderye"
Content-Disposition: inline
In-Reply-To: <20210118020848.11721-7-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4homvfvy5rvderye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 18, 2021 at 02:08:33AM +0000, Andre Przywara wrote:
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--4homvfvy5rvderye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYAWotAAKCRDj7w1vZxhR
xUj2AQDTEh7XFrvhCU51en3SF2S3LO5VfcBMAAZy4fORoIVkMQD/RQ2P3XzLXZDc
WY2GYNmwgSWMX6Jpk5iqjrH/LkvjdQI=
=ILbj
-----END PGP SIGNATURE-----

--4homvfvy5rvderye--
