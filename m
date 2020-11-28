Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9F42C717D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391139AbgK1VwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732023AbgK1S53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:57:29 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE029C09425E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 23:25:21 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id m9so6043466pgb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 23:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c7NsYutrOMG2gc3KPcrY37eO1acPKlawoIfbxuUMWNE=;
        b=P7gsxcit6YLys/ql9E4BRgideOOQ/+h20Tbvy7s1bBvnkuw+zYRdw+qzlaxvNY69nu
         o8GuoJbUTLg4eg2SWqZ5FLwlRUNmJDrIHUsSBO6BezVMxyWSif+a3yujrplYoMjd3gEZ
         1eUCu2O7l6QnNhsn3II54LtkuWeJ59Hgn1OogEF3Dr1y6knEAA253GlBD2qsHRiw2R/e
         LhPTB9meHdZUzufEQUXs3U6byze1vmwc7EAo8w4Go5KmdZYXSXkT+oH3Hss0YTizYwDN
         Pr/seWzGFdvC1+ZflLjOoWphuyaQecZkK2GjZ1lrzbzheShhYx2pjEzpoiFz2QfY64VL
         TD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c7NsYutrOMG2gc3KPcrY37eO1acPKlawoIfbxuUMWNE=;
        b=h4WWuzFcr9aUoJ64pwXb0QUISTEoF6ldgvp/ag1uPrdJdv2XK+6IqDesKR/uvpLgis
         DbnulKL0i2Vz6K6GkUKdv8bctOic888XOnG6gO5oQAfglG4g6ihW5vA2eHaP/yHgyTnn
         xYtxsgL/g4hYJKtJx6pfOdCuS7aWcWCtD7YGbRyvFnv2dBUOG8dM3gHbOwC2ZMynfhUC
         D+FmL4bXGVPY02hKqg2zc64eCDyI7bNhOoj2JExQQ6ZOwdC+R3Ebf5hJUpwKbkr1FemV
         EBjnp7ZTEcbB8Z4vpMJ+aANEYNSHiZJ+D9JnYTlGvCGJxIn8Aa+3l7mdRGnIgOFd8lOn
         Koeg==
X-Gm-Message-State: AOAM531SdCTW/cOORmUK3fdOqR/+m7TPNnU144B9vZ0fBx/QRsgVHCjL
        we05ungJMguL/cxTxqtYhZVz
X-Google-Smtp-Source: ABdhPJxwcztlNsaEhlDuIFEe0FBAaomX2+dbcJSnbYrcYhtX/Ny2iLlhKiWnWiSJwYcWysidzzc+Pw==
X-Received: by 2002:aa7:8704:0:b029:18a:e2c9:c38 with SMTP id b4-20020aa787040000b029018ae2c90c38mr10242453pfo.79.1606548321323;
        Fri, 27 Nov 2020 23:25:21 -0800 (PST)
Received: from thinkpad ([2409:4072:15:c612:48ab:f1cc:6b16:2820])
        by smtp.gmail.com with ESMTPSA id b37sm1203298pgl.31.2020.11.27.23.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 23:25:20 -0800 (PST)
Date:   Sat, 28 Nov 2020 12:55:13 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/18] arm: dts: owl-s500: Set CMU clocks for UARTs
Message-ID: <20201128072513.GQ3077@thinkpad>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <1bd42cf44e5aaef1bb7e97e4e344444ddbfbb091.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bd42cf44e5aaef1bb7e97e4e344444ddbfbb091.1605823502.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 01:55:56AM +0200, Cristian Ciocaltea wrote:
> Set Clock Management Unit clocks for the UART nodes of Actions Semi
> S500 SoCs.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Also in this patch itself, you need to remove the dummy "uart3_clk" from
S500 dts. With that,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm/boot/dts/owl-s500.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
> index 5d5ad9db549b..ac3d04c75dd5 100644
> --- a/arch/arm/boot/dts/owl-s500.dtsi
> +++ b/arch/arm/boot/dts/owl-s500.dtsi
> @@ -131,6 +131,7 @@ uart0: serial@b0120000 {
>  			compatible = "actions,s500-uart", "actions,owl-uart";
>  			reg = <0xb0120000 0x2000>;
>  			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_UART0>;
>  			status = "disabled";
>  		};
>  
> @@ -138,6 +139,7 @@ uart1: serial@b0122000 {
>  			compatible = "actions,s500-uart", "actions,owl-uart";
>  			reg = <0xb0122000 0x2000>;
>  			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_UART1>;
>  			status = "disabled";
>  		};
>  
> @@ -145,6 +147,7 @@ uart2: serial@b0124000 {
>  			compatible = "actions,s500-uart", "actions,owl-uart";
>  			reg = <0xb0124000 0x2000>;
>  			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_UART2>;
>  			status = "disabled";
>  		};
>  
> @@ -152,6 +155,7 @@ uart3: serial@b0126000 {
>  			compatible = "actions,s500-uart", "actions,owl-uart";
>  			reg = <0xb0126000 0x2000>;
>  			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_UART3>;
>  			status = "disabled";
>  		};
>  
> @@ -159,6 +163,7 @@ uart4: serial@b0128000 {
>  			compatible = "actions,s500-uart", "actions,owl-uart";
>  			reg = <0xb0128000 0x2000>;
>  			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_UART4>;
>  			status = "disabled";
>  		};
>  
> @@ -166,6 +171,7 @@ uart5: serial@b012a000 {
>  			compatible = "actions,s500-uart", "actions,owl-uart";
>  			reg = <0xb012a000 0x2000>;
>  			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_UART5>;
>  			status = "disabled";
>  		};
>  
> @@ -173,6 +179,7 @@ uart6: serial@b012c000 {
>  			compatible = "actions,s500-uart", "actions,owl-uart";
>  			reg = <0xb012c000 0x2000>;
>  			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_UART6>;
>  			status = "disabled";
>  		};
>  
> -- 
> 2.29.2
> 
