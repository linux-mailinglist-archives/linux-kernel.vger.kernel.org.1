Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7D02D282D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgLHJwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:52:50 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:43029 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726226AbgLHJwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:52:49 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1E492B2C;
        Tue,  8 Dec 2020 04:52:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 08 Dec 2020 04:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=asvG7QSfhF/2ylr+I3SRwx8CNZR
        8SPz/lWQtigkYbJI=; b=aU6K4ccvDLSSCwC2+rLB6ewF6wd8a4UosEx1db2jz/D
        po2Jke+fJPbNDiSRhtDWC6khrwtOD6w+8VsZMKVUtBocBs5xuD7UWdMC35siuTv7
        DqpXquizJARj5uxYgSBCdTf5bEIG/pJe9x2ARygLBFXrymfI47SFFezcVcfLTzIp
        dsREtMSS/7gkPLHgiiKukP93CeYzppEZkaUW8iyCNGi0QAXSrCjudT275u4voqb2
        5aShfbFBa5/0cSr24gRTFNij4rusU7MLBW9/g+nHwd7xG0o3e+bYbemLuEqK0Ms8
        D9kbACE32wGSsvotVdRVpac+4zBuP9CFYev7t9INqwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=asvG7Q
        SfhF/2ylr+I3SRwx8CNZR8SPz/lWQtigkYbJI=; b=WYYFVFRrpMqpIY07qups2Q
        UQ03srm/dFcd9obhMqcWEwcWF9yF/Rv+ewjK57TuJeZ8EDdbPjWG0Lv5TOI5581T
        orHi5ufbTdi29Z/Sd8zuPSWeWRWrX34snzo5cv7C8Zfd79YIPPNCduWaZVrQHM9M
        LpKgGnjzNCTEQMMf8TWiKgrgOmqrbUmWTa6mi1C1Z0Vj1s4yyZ9q4qNi61h9zsq2
        +WOPPRH3Yr7ifo8oMY9yi2Bg8MTlzm62BKUz1UF/olPDFp9vIxyH3p9pcaXO5t3G
        fIAcwzTx5NKxGhcdGv2qV3emmuVqfZEflqfkdfs6H3xvj4e+pJR5LQB5BglfMqSw
        ==
X-ME-Sender: <xms:wUzPX3GBqVVDdbsbYvQphPVZhlK6X8ZLYxsQmQAbpadxgper5rXYDA>
    <xme:wUzPX0QkGX6ctLnVkb_Qv2xiOd4KJtQKaZtF-PT5QOozQeyuYc2hHmX_LTLEn69hR
    aVf0A2tJ9szT37KHBI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejiedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:wUzPX2B-Hk_tmqbHXPYv-JN49dHPb9oIADzveXAwBU9A3naMuZdTKA>
    <xmx:wUzPX837sJeQIZUmOm88NQm_mxFxmjNV8aJmEKPXUhtixEfZvAuvUw>
    <xmx:wUzPX8VtkI4TgFaUGGcdJbqwng8obxxu9cO7hKJGwFB2upvfhx1-ig>
    <xmx:wkzPXwAYRYLdPqp3qRR8SRyz4VwXSKutgN9exgORA1B7wroT-nQSfA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9747D1080057;
        Tue,  8 Dec 2020 04:52:01 -0500 (EST)
Date:   Tue, 8 Dec 2020 10:52:00 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Shuosheng Huang <huangshuosheng@allwinnertech.com>
Cc:     robh+dt@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        tiny.windzz@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] arm64: dts: allwinner: a100: Enable cpufreq on
 a100
Message-ID: <20201208095200.lkyxqzgh5wzjjz7c@gilmour>
References: <20201208072138.9003-1-huangshuosheng@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oab6asfbiyrhkwmt"
Content-Disposition: inline
In-Reply-To: <20201208072138.9003-1-huangshuosheng@allwinnertech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oab6asfbiyrhkwmt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 08, 2020 at 03:21:38PM +0800, Shuosheng Huang wrote:
> Enable cpufreq for all CPU cores on a100.
>=20
> Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> ---
>  .../allwinner/sun50i-a100-allwinner-perf1.dts    | 16 ++++++++++++++++
>  arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi   |  6 +++---
>  2 files changed, 19 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dt=
s b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
> index 301793c72cb7..62a770f1a979 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
> @@ -21,6 +21,22 @@ chosen {
>  	};
>  };
> =20
> +&cpu0 {
> +	cpu-supply =3D <&reg_dcdc2>;
> +};
> +
> +&cpu1 {
> +	cpu-supply =3D <&reg_dcdc2>;
> +};
> +
> +&cpu2 {
> +	cpu-supply =3D <&reg_dcdc2>;
> +};
> +
> +&cpu3 {
> +	cpu-supply =3D <&reg_dcdc2>;
> +};
> +
>  &pio {
>  	vcc-pb-supply =3D <&reg_dcdc1>;
>  	vcc-pc-supply =3D <&reg_eldo1>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-a100.dtsi
> index 8f370a175ce6..c6ff172bf599 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> @@ -26,7 +26,7 @@ cpu0: cpu@0 {
>  			clocks =3D <&ccu CLK_CPUX>;
>  		};
> =20
> -		cpu@1 {
> +		cpu1: cpu@1 {

You're using these labels in the previous patch, it should be added there.

Maxime

--oab6asfbiyrhkwmt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX89MwAAKCRDj7w1vZxhR
xWNKAP4yfCNPd2/4gONFj9eKQi/Z/W1/z27q/e+221eheoo7vwEAyz+y6MQ9jK45
Asp+V8YjcJtbGuT9Dj41JLiO5omV9wo=
=RxVm
-----END PGP SIGNATURE-----

--oab6asfbiyrhkwmt--
