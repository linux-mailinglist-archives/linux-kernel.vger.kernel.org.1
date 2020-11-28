Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBD22C7183
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391224AbgK1VwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732403AbgK1TAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 14:00:14 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E97EC09426C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 23:31:43 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id x24so6402742pfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 23:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZnxKHrct1cvxNtNqNcl6uCXJBiv2C9CvIc5DUO6nA0I=;
        b=i1rtn+mcaF7kkwH3qlZfzxUllj9ZlZibQvsjMw2wgYuZ9DHIsKUG3IRerfc1nzIjDG
         /PZhUuOYtmmJ7qxCoP+85IDg6dycqqDaYuGrY1scw34/SpKsRp+E0GDRMiXXPxaTRgm2
         W/IgWUpq5c/dX/mavlWt17RDGr6VKxb8jvNK2zCbnuLBVmcSeScUs780rafWTSAlEeDb
         p44nAbOD1PwiLpTDZrCCna219Liz7/K3xYal3yRkdhDufjOY6j4dKan9HuLRuHINWLFJ
         TN1qaziXWoCUlfFBUu9e6/5fIbkuNEQbuZlNy/hWvWEbGYZlH9cajIx9hUCTXISBXoE5
         OxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZnxKHrct1cvxNtNqNcl6uCXJBiv2C9CvIc5DUO6nA0I=;
        b=ZPM6w8ERAm8y5vRo3jmPL34bGYj0v9lWQ/IsZTvyEwz0G7otaCtjVSN9mZwgNaKZSP
         ub+f0z+ukWZM3yR+EfF9W2hOlKiuYWRzG9lsfJ76IimqtrdoUTis8KVTOTuUnpyh2roF
         0RY1vuvLqGruHFAJgt+5ZsGFoLlQkroZlWaevWEoEQJH6jMPSDF387rnVyuADX/ezt/7
         TIPvXiW0YiykQWDgwPWbX3B9jp6bDdGcL2+7ahjh0nGz9JxeqX1z+hnhtzaKjxKN0dna
         sRKCOhDG48e/6zf38ABau/npCYD0otRdWkii5CGG1RLLzDKRX+K/sbI5MLHGHFq0C5ac
         L7XA==
X-Gm-Message-State: AOAM5319oKrXeqf7mO3NtN2lARJ0LxTzvXbSgCvbc6qxQPz5kMsT8ROz
        lhF5x+7ytBz2ocUhs0cyhJly
X-Google-Smtp-Source: ABdhPJx1BNlR0UDn+00ASz2EXwou3WLBK0ieiGY2VCQLyhXFuUl4w8LWp7KbcZfFA+/WNob66zOb6w==
X-Received: by 2002:a17:90b:4b87:: with SMTP id lr7mr14379315pjb.40.1606548702794;
        Fri, 27 Nov 2020 23:31:42 -0800 (PST)
Received: from thinkpad ([2409:4072:15:c612:48ab:f1cc:6b16:2820])
        by smtp.gmail.com with ESMTPSA id fu5sm13564487pjb.11.2020.11.27.23.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 23:31:42 -0800 (PST)
Date:   Sat, 28 Nov 2020 13:01:34 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/18] arm: dts: owl-s500: Add DMA controller
Message-ID: <20201128073134.GV3077@thinkpad>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <543eadc1e3005ecdca780266ef148518b5091377.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <543eadc1e3005ecdca780266ef148518b5091377.1605823502.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 01:56:00AM +0200, Cristian Ciocaltea wrote:
> Add DMA controller node for Actions Semi S500 SoC.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm/boot/dts/owl-s500.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
> index a57ce7d6d745..449e9807c4ec 100644
> --- a/arch/arm/boot/dts/owl-s500.dtsi
> +++ b/arch/arm/boot/dts/owl-s500.dtsi
> @@ -207,5 +207,19 @@ sps: power-controller@b01b0100 {
>  			reg = <0xb01b0100 0x100>;
>  			#power-domain-cells = <1>;
>  		};
> +
> +		dma: dma-controller@b0260000 {
> +			compatible = "actions,s500-dma";
> +			reg = <0xb0260000 0xd00>;
> +			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			dma-channels = <12>;
> +			dma-requests = <46>;
> +			clocks = <&cmu CLK_DMAC>;
> +			power-domains = <&sps S500_PD_DMA>;
> +		};
>  	};
>  };
> -- 
> 2.29.2
> 
