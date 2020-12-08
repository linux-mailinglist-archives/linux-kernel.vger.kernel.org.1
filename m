Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0248E2D282A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgLHJwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:52:15 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:49571 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgLHJwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:52:14 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C82839F3;
        Tue,  8 Dec 2020 04:51:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 08 Dec 2020 04:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=2Gak1qiZW0dpp2vMBPgxczXXbri
        NORxQyc2JXCqhMqg=; b=nwP/WvDTQ3TdtdsPKHa9It+54p+uyj4L6coAwv8b1N4
        YY3j7h1KhxQy8oqSXvnFkoanHGmOZTX1Mp7zIpSInGOAc5NDjfHbZUWVhtn1g2az
        l5lxK1SmCCG1BNYooXouoD0bO9PJCRHioDdZj5Vq4f7TTz1ezuQeFaXWrJo0UpN3
        MD53y846B+5wz+9kCFqTYQ+3N5xZrjjn1xUjvb8jSw79307dNsO36bmifCJRna7C
        NwdFR6uLo8U16fxQ+lYepjrYqUJGC20IEt6ukCORnx6XEYGpYMzG/2WcVTTobc10
        gmkwwOHXOGR7nyPEQaPtgRS3jkgJMaYYWO4Q945uGaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=2Gak1q
        iZW0dpp2vMBPgxczXXbriNORxQyc2JXCqhMqg=; b=Q0xUPpQiJPSlGfr3Mgfh2y
        X9fGUT+y3h1MYcG+69TA6WRjTbSv/1ecvi0fG0DCjJPdmmAy5NyjEmrmQ+P6ktjn
        G2yw/bneVr9dQzN8Ud3HwAiMbjskTj9mK7uEZxF27UPF7b3oqjSKb7GzU5mx/tLd
        ohtRrZ4ewUM88MdsywSh8pgAF+R6tLmSPTwgQIAX8aF26E1Bv/B8Ps7dacd44Fqv
        Z1wZ3WbTAAX+oKTTT83ChioXXjbndTbjI/xzFQ6ACWkMVrtzrqOHiY8+z/hahfkG
        wc1RKxrO8UsLx8KnluYL3+vqfwHlAUYXF7+uvCHlmMIK3st3Gk18e3lDd+65ebBQ
        ==
X-ME-Sender: <xms:nkzPX1z55BP5Myd-ofWmsGO8wWr7FQXSw2YQALbNYWIC0XieCKT4mA>
    <xme:nkzPX1TwTCH9OPTIP_0JlAdsT6YcgE20M0HZ1hxTn0B0AWbzZgpcezlut3u0EHwFu
    L-wZgYqPu8XBTWJRu0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejiedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepveegudetkeethfetgffgtdekkefghefhffefgeduleehgeehieeuveefgedv
    ieegnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepledtrdekledrieekrd
    ejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    rgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:nkzPX_Ujfqpu6opVa4ZMM20sgLvqhYwHcDtYly4_3ZCYAJxD4DQr3Q>
    <xmx:nkzPX3jZwsxQuyZDvvdO5CXIaeWyVH8HaOfjlxh3RJ5wxAIXBGYtQw>
    <xmx:nkzPX3AsPAVlynP8KMlK97dAOjNbUE8oovLf8OZSc2RFdgvya0yQ-A>
    <xmx:n0zPXy6R1E2SRnQ6FAHJuy3BYeRzS-UnMkYMJend3ujpO4bD40EdGA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3C75524005C;
        Tue,  8 Dec 2020 04:51:26 -0500 (EST)
Date:   Tue, 8 Dec 2020 10:51:23 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Shuosheng Huang <huangshuosheng@allwinnertech.com>
Cc:     robh+dt@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        tiny.windzz@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] arm64: dts: allwinner: a100: Add Add CPU
 Operating Performance Points table
Message-ID: <20201208095123.guu7zqskxckd5vsc@gilmour>
References: <20201208072046.14186-1-huangshuosheng@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gq44mz5gfrr6gubq"
Content-Disposition: inline
In-Reply-To: <20201208072046.14186-1-huangshuosheng@allwinnertech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gq44mz5gfrr6gubq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 08, 2020 at 03:20:46PM +0800, Shuosheng Huang wrote:
> Add an Operating Performance Points table for the CPU cores to
> enable Dynamic Voltage & Frequency Scaling on the A100.
>=20
> Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> ---
>  .../allwinner/sun50i-a100-allwinner-perf1.dts |  1 +
>  .../dts/allwinner/sun50i-a100-cpu-opp.dtsi    | 90 +++++++++++++++++++
>  2 files changed, 91 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dt=
s b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
> index d34c2bb1079f..301793c72cb7 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
> @@ -6,6 +6,7 @@
>  /dts-v1/;
> =20
>  #include "sun50i-a100.dtsi"
> +#include "sun50i-a100-cpu-opp.dtsi"

This should be on the next patch

>  /{
>  	model =3D "Allwinner A100 Perf1";
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi b/arc=
h/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi
> new file mode 100644
> index 000000000000..e245823d70e8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// Copyright (c) 2020 Yangtao Li <frank@allwinnertech.com>
> +// Copyright (c) 2020 ShuoSheng Huang <huangshuosheng@allwinnertech.com>
> +
> +/ {
> +	cpu_opp_table: cpu-opp-table {
> +		compatible =3D "allwinner,sun50i-h6-operating-points";
> +		nvmem-cells =3D <&cpu_speed_grade>;
> +		opp-shared;
> +
> +		opp@408000000 {

This node name will create a DTC warning if compiled with W=3D1, since the
unit-address doesn't match the reg property (there's none), and it's
supposed to.

> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +			opp-hz =3D /bits/ 64 <408000000>;
> +
> +			opp-microvolt-speed0 =3D <900000 900000 1200000>;
> +			opp-microvolt-speed1 =3D <900000 900000 1200000>;
> +			opp-microvolt-speed2 =3D <900000 900000 1200000>;
> +		};
> +
> +		opp@600000000 {
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +			opp-hz =3D /bits/ 64 <600000000>;
> +
> +			opp-microvolt-speed0 =3D <900000 900000 1200000>;
> +			opp-microvolt-speed1 =3D <900000 900000 1200000>;
> +			opp-microvolt-speed2 =3D <900000 900000 1200000>;
> +		};
> +
> +		opp@816000000 {
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +			opp-hz =3D /bits/ 64 <816000000>;
> +
> +			opp-microvolt-speed0 =3D <940000 940000 1200000>;
> +			opp-microvolt-speed1 =3D <900000 900000 1200000>;
> +			opp-microvolt-speed2 =3D <900000 900000 1200000>;
> +		};
> +
> +		opp@1080000000 {
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +			opp-hz =3D /bits/ 64 <1080000000>;
> +
> +			opp-microvolt-speed0 =3D <1020000 1020000 1200000>;
> +			opp-microvolt-speed1 =3D <980000 980000 1200000>;
> +			opp-microvolt-speed2 =3D <950000 950000 1200000>;
> +		};
> +
> +		opp@1200000000 {
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +			opp-hz =3D /bits/ 64 <1200000000>;
> +
> +			opp-microvolt-speed0 =3D <1100000 1100000 1200000>;
> +			opp-microvolt-speed1 =3D <1020000 1020000 1200000>;
> +			opp-microvolt-speed2 =3D <1000000 1000000 1200000>;
> +		};
> +
> +		opp@1320000000 {
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +			opp-hz =3D /bits/ 64 <1320000000>;
> +
> +			opp-microvolt-speed0 =3D <1160000 1160000 1200000>;
> +			opp-microvolt-speed1 =3D <1060000 1060000 1200000>;
> +			opp-microvolt-speed2 =3D <1030000 1030000 1200000>;
> +		};
> +
> +		opp@1464000000 {
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +			opp-hz =3D /bits/ 64 <1464000000>;
> +
> +			opp-microvolt-speed0 =3D <1180000 1180000 1200000>;
> +			opp-microvolt-speed1 =3D <1180000 1180000 1200000>;
> +			opp-microvolt-speed2 =3D <1130000 1130000 1200000>;
> +		};
> +	};
> +};

Can you run cpufreq-ljt-stress-test from
https://github.com/ssvb/cpuburn-arm and paste the result in the cover
letter to make sure all the OPPs are working fine?

Also, at what frequency is the bootloader expected to set the CPU when
booting? If it's anything lower than 1464MHz, we should separate the
OPPs higher than the initial frequency.

A board without the regulator set would try to use those OPPs without
raising the voltage of the CPU, resulting in fairly hard to debug
crashes.

Maxime

--gq44mz5gfrr6gubq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX89MlwAKCRDj7w1vZxhR
xaeyAP9GN0sGhqg4JuuYlpeuXRIyO8epgKKhxD+AQxx0P2cmEwD/UNmIlBryIwrG
iibJaHv5wMmH8r+2x8r/y+nVQQbD7wY=
=6V2S
-----END PGP SIGNATURE-----

--gq44mz5gfrr6gubq--
