Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBE71EE803
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 17:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgFDPs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 11:48:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729302AbgFDPs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:48:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBA082065C;
        Thu,  4 Jun 2020 15:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591285708;
        bh=1Mv07Aauq/rZnpEpLfTWEgK7rGkDSSF3+UeXd/UsARs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eZeH1PpKKkarbufO7IK4JjaKzNOlUxbqMcnNnpXq0xOUT/JPphDwhYIi7XNNUqt8J
         ud/KnBJcYHZHlXpedTJZl2FBBWd25SPgPdDA22r1TI8x7i1LBL98RV809que/QlAq2
         QrtGJzWp1PHdymtvsJ6uKqHodNKsvy9WsefSkP3U=
Date:   Thu, 4 Jun 2020 16:48:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, kernel@puri.sm, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mchehab@kernel.org, Anson.Huang@nxp.com,
        agx@sigxcpu.org, angus@akkea.ca, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] arm64: dts: Add a device tree for the Librem 5
 phone
Message-ID: <20200604154825.GG6644@sirena.org.uk>
References: <20200604084756.586-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Zrag5V6pnZGjLKiw"
Content-Disposition: inline
In-Reply-To: <20200604084756.586-1-martin.kepplinger@puri.sm>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Zrag5V6pnZGjLKiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2020 at 10:47:55AM +0200, Martin Kepplinger wrote:

> +	reg_audio_pwr_en: regulator-audio-pwr-en {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_audiopwr>;
> +		regulator-name = "AUDIO_PWR_EN";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		gpio = <&gpio1 4 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_aud_1v8: regulator-audio-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "AUD_1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&reg_audio_pwr_en>;
> +	};

This looks broken - a combination of the structure, lack of any
references to reg_audio_pwr_en and the naming suggests that you have one
regulator here for a supply called AUD_1V8 which has a GPIO controlling
the enable.  I can't figure out any reason for reg_audio_pwr_en.

> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "wm8962";

You might want to put a more user friendly display name here (eg, one
mentioning Librem 5) - some UIs will show this string to users.

--Zrag5V6pnZGjLKiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7ZF8kACgkQJNaLcl1U
h9B2Rgf7BcAVHZFT0owBWhK+fsuc1IONX1cr5wau8snfBGsvoTLt0uLdGZ0Xb7fK
chYq/o+LSEBfkk7TQUWexT10FtKKf2m3ovnVk3XsfQK5nVrN4QWrysBZYZ61pBh7
7+oyR1tGi4JzMNmWbULl3PDgZxO8r42g25+6y+Hk99JuPE3Q19Q3/PKZ5bO+aMKt
Y5I3FydJnqY1TTnFd1+Yf4HDzrZ9twsSJXfoIHu72UBxevdtqh1hEMfbtWAEs2VR
Z01WVWsDZ1mynb9t96pTReMHgtPCIZn22nZICp9opnxGXKUIDX5HkSa+wyc+mRX2
NhsPyyuKiRgje3l+8vfCi2DlaUFtNw==
=JEWW
-----END PGP SIGNATURE-----

--Zrag5V6pnZGjLKiw--
