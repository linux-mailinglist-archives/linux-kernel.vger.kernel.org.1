Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB34273B38
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 08:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgIVGwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 02:52:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbgIVGwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 02:52:00 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42AF723A1D;
        Tue, 22 Sep 2020 06:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600757520;
        bh=JnaH/Lzy9XWhZv0oVsAhoE9/bIpHFaDYdQurdsgJI1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vaQd9HZpp45uT0Zt7mQ8lqxa4O+g9jT9vl3xJgGKGgIzbNzvamhf9KjeIh+J6sOs3
         o4G/ukVBR5eq68ty6mWdhZrxsO8weMlE1tF6zF29HtCh7FTxGkcGNIdhww3vGBzkW5
         eCunpTLfu1Mz2UbSXqTZ3RIyKgmdGdpqn2YpTBBs=
Date:   Tue, 22 Sep 2020 14:51:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] arm64: dts: imx8mq-librem5: align GPIO hog names
 with dtschema
Message-ID: <20200922065154.GH25109@dragon>
References: <20200920195749.26952-1-krzk@kernel.org>
 <20200920195749.26952-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200920195749.26952-2-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 09:57:48PM +0200, Krzysztof Kozlowski wrote:
> dtschema expects GPIO hogs to end with 'hog' suffix.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Ping me after dtschema gets accepted.

Shawn

> 
> ---
> 
> Changes since v2:
> 1. None, split from previous patchset using common GPIO schema
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> index e4dedcb58f76..6cbcee2fb938 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> @@ -249,7 +249,7 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_pmic_5v>;
>  
> -	pmic-5v {
> +	pmic-5v-hog {
>  		gpio-hog;
>  		gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
>  		input;
> -- 
> 2.17.1
> 
