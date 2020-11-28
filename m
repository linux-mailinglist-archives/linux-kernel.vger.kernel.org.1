Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B704A2C7106
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391130AbgK1VwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732017AbgK1S52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:57:28 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF517C09426F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 23:32:50 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id v21so3705167plo.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 23:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XAzzW0mavnqneibsETK+KKX6CT9p1psP1fRJO3+Q4pY=;
        b=J39DEjXzV7H1ZDOzklWFMSJOyzibGMKIFkvFOg/2cKo3bWff4eZLjaBYnkVFQgFfEc
         a0j/WBXF/vNfd9KR6z3MH1asTgtpm0HlYgyWWbvIoer3aNk2e7mNN+Jzk7njlEYJyvlZ
         3L5pesIbjvkpbPkdyYJsZ6yjR8308YT0ZFa0XbH48yeEIAFXOxkjfv0VzsO+5TS5PsY3
         JV7Z6/yOklEJsVZihOQZ2i6RF6GnAWeV2rbtYLM3NYuJjIyXOrqQ882nckh4EhedU7zO
         CD3+K2pfl16kFeK5wTDDHrcu2vaJ4dJ0IcBd8VX/l2cPetzrcOFPsB3gNtrXGYcU6kmo
         d92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XAzzW0mavnqneibsETK+KKX6CT9p1psP1fRJO3+Q4pY=;
        b=erMFW6LaIeGWRN6ORXkDQFvbWoPJx9NH+zhfE6mEH6rMleCmKD/q21mT5lyZmro43R
         wjqZob7sq7qR2KvXmygtxfV1oKmtanGk8OQVnA6INgwon8KnAnPVCwrRHDtIMKOSqYSK
         IZOEFAlDZ3pfURlU/6k9SomajJ/7zcz3adNdX1DMDj3D2jpp23+7/zV+OlDz1gDuVy1v
         SEAZO6WOCSLojjouVvk/sgxrbJ06qCG74q+lA6NCUuHiU82VsCw9Pxnmsla7sRopUrW0
         l+lfIErhysBxty9AQLELggoSqE5TiKbR+utThHZCU0qnAfcARGjWxXMBIhP53IlZzXhF
         Q9AQ==
X-Gm-Message-State: AOAM533T8cgY3WlKOkC615iIwTXSxol0nory2YBWYccumLkV+Wt+4317
        WTopJ5XgDIqtnX6U8ubQ5w0u
X-Google-Smtp-Source: ABdhPJw1gMFLQnVw7U3VNOXKsSfMHwE3LZGNqKyXpik3yzK6QS6hCZ0koWP20Qzo1PTmrTJw3tZk3w==
X-Received: by 2002:a17:902:b18c:b029:d9:f:15fc with SMTP id s12-20020a170902b18cb02900d9000f15fcmr10099222plr.29.1606548770439;
        Fri, 27 Nov 2020 23:32:50 -0800 (PST)
Received: from thinkpad ([2409:4072:15:c612:48ab:f1cc:6b16:2820])
        by smtp.gmail.com with ESMTPSA id 196sm9860943pfz.11.2020.11.27.23.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 23:32:49 -0800 (PST)
Date:   Sat, 28 Nov 2020 13:02:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/18] arm: dts: owl-s500: Add pinctrl & GPIO support
Message-ID: <20201128073242.GW3077@thinkpad>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <d63b1486c93b4ccc1fca9b837b150acb67c6d402.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d63b1486c93b4ccc1fca9b837b150acb67c6d402.1605823502.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 01:56:01AM +0200, Cristian Ciocaltea wrote:
> Add pinctrl node for Actions Semi S500 SoC.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm/boot/dts/owl-s500.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
> index 449e9807c4ec..b16172615db0 100644
> --- a/arch/arm/boot/dts/owl-s500.dtsi
> +++ b/arch/arm/boot/dts/owl-s500.dtsi
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <dt-bindings/clock/actions,s500-cmu.h>
> +#include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/owl-s500-powergate.h>
>  #include <dt-bindings/reset/actions,s500-reset.h>
> @@ -208,6 +209,25 @@ sps: power-controller@b01b0100 {
>  			#power-domain-cells = <1>;
>  		};
>  
> +		pinctrl: pinctrl@b01b0000 {
> +			compatible = "actions,s500-pinctrl";
> +			reg = <0xb01b0000 0x40>, /* GPIO */
> +			      <0xb01b0040 0x10>, /* Multiplexing Control */
> +			      <0xb01b0060 0x18>, /* PAD Control */
> +			      <0xb01b0080 0xc>;  /* PAD Drive Capacity */
> +			clocks = <&cmu CLK_GPIO>;
> +			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 0 132>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>, /* GPIOA */
> +				     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>, /* GPIOB */
> +				     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>, /* GPIOC */
> +				     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>, /* GPIOD */
> +				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>; /* GPIOE */
> +		};
> +
>  		dma: dma-controller@b0260000 {
>  			compatible = "actions,s500-dma";
>  			reg = <0xb0260000 0xd00>;
> -- 
> 2.29.2
> 
