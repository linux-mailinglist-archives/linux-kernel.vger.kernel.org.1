Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D8B2B2D86
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 14:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgKNN5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 08:57:11 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:19943 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgKNN5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 08:57:11 -0500
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j+IcfNBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id Z061efwAEDv5tLq
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sat, 14 Nov 2020 14:57:05 +0100 (CET)
Date:   Sat, 14 Nov 2020 14:56:59 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     nikitos.tr@gmail.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        Michael.Srba@seznam.cz, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/6] arm64: dts: qcom: msm8916-longcheer-l8150: Enable
 PM8916 vibrator
Message-ID: <X6/iK4p2lyNzZbv0@gerhold.net>
References: <20201113175917.189123-1-nikitos.tr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113175917.189123-1-nikitos.tr@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for sending these!

On Fri, Nov 13, 2020 at 10:59:12PM +0500, nikitos.tr@gmail.com wrote:
> From: Nikita Travkin <nikitos.tr@gmail.com>
> 
> L8150 has a vibrator connected to PM8916. Add it to the device tree.
> 
> Signed-off-by: Nikita Travkin <nikitos.tr@gmail.com>

For all 6 patches in this series:

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
> index 2c204d535d66..d106bdbfda68 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
> @@ -61,6 +61,10 @@ &pm8916_resin {
>  	linux,code = <KEY_VOLUMEDOWN>;
>  };
>  
> +&pm8916_vib {
> +	status = "okay";
> +};
> +
>  &pronto {
>  	status = "okay";
>  };
> -- 
> 2.25.1
> 
