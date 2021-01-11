Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CF02F0A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 01:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbhAKAac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 19:30:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:43416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbhAKAab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 19:30:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CA1721D40;
        Mon, 11 Jan 2021 00:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610324991;
        bh=YcwgXozQvhOiQVvPlE3Ckg1mnah2qwHq7PLu/Z0sCyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZVyyZ1O8vsORBMtSGo9LWl9fEA6tbL/a5XHCqDcLBX0RFSO0KwUedPHfa7rsqkJ5S
         PRHN+4T1oBimCofFrVLlq4o6L860jHCEtC1TsygX6901GbV+bCtGi8fpyIadfIvZoy
         tB+TFCXADxVOz0hUtxoDCzVYZ5YHwrbM6fWTdP6Bv/FVrs0VI1l8Jh+Q5JH8PJAxZE
         6k6iRRGWfs9R4R1stQ7hJnEX2F61GWwUASk2bw8d3hqROV+TCwiDoQAXMuvG5eL+RK
         zLtBBY/0PFAnNMnVVtVlPU94X5ZLX9Ph+D9rxo+ORsvfuAMrZqQImOjEqKF7D2K0WI
         sOqMdMerpqnMw==
Date:   Mon, 11 Jan 2021 08:29:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, festevam@gmail.com, kernel@pengutronix.de,
        linux-imx@nxp.com, krzk@kernel.org, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64: dts: imx8mq-librem5: add pinctrl for the
 touchscreen description
Message-ID: <20210111002942.GR28365@dragon>
References: <20201222151347.7886-1-martin.kepplinger@puri.sm>
 <20201222151347.7886-3-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222151347.7886-3-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 04:13:45PM +0100, Martin Kepplinger wrote:
> In order for the touchscreen interrupt line to work, describe it properly.
> Otherwise it can work if defaults are ok, but we cannot be sure.
> 
> Fixes: 8f0216b006e5 ("arm64: dts: Add a device tree for the Librem 5 phone")
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> index 55268fc0622e..a60df09d90f7 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> @@ -459,6 +459,13 @@
>  		>;
>  	};
>  
> +	pinctrl_touch: touchgrp {
> +		fsl,pins = <
> +		/* TP_INT */
> +		MX8MQ_IOMUXC_ENET_RD1_GPIO1_IO27	0x80

Miss indentation for these two lines.

I fixed it up and applied the series.

Shawn

> +		>;
> +	};
> +
>  	pinctrl_typec: typecgrp {
>  		fsl,pins = <
>  			/* TYPEC_MUX_EN */
> @@ -880,6 +887,8 @@
>  	touchscreen@38 {
>  		compatible = "edt,edt-ft5506";
>  		reg = <0x38>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_touch>;
>  		interrupt-parent = <&gpio1>;
>  		interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
>  		touchscreen-size-x = <720>;
> -- 
> 2.20.1
> 
