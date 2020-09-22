Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DC1273B55
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgIVHAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729168AbgIVHAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:00:17 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27429C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 00:00:17 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f18so11570602pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 00:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1riZ7Z/9tZgL3nmfTee4EgVhiaYJKLe7/kK8pfyHkYY=;
        b=FzMOkmpMt/LE7b5jOP9WlYDNkoWYirZri8Ol4qyzRkm/RhPswjOWYf5Mx0njRhPW8l
         KQsS2woXe2fqk5KyOQCiK3M0Q1tI0y7O+BROmqgi2eU7w4YkS8DrdZf0hVFk+b+yH3ug
         p33wHS5SXvQ2TerIigL/htg4sXXRQUWJqx9H9Cz6TPOlWPTDYbu0YRP84FLV/Zwhb9w5
         w910blqLI8vuf2AZ+wQ91engczvCE/fFomvhFgVwuNuSFa3L54lFsuOXDNWJ+2b3Hzbr
         caiZKFVjNaxJ0+6ddMmUvP3XwqpWR6Ug3VS2Tir6Pjuq3Mx0kVCDP93IQE6MM50wkw0x
         1KIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1riZ7Z/9tZgL3nmfTee4EgVhiaYJKLe7/kK8pfyHkYY=;
        b=IPkOezioV3AIMurrvBhfSBzyYFFMQjaim0pblTbGHwVtsfpAhpQ5Rq+HmE0GeC9KsH
         3HUuirzDjUDiWHYAPrElttfma+bWPWmVMx+0Xl2jn76dwpU5DVnHDo0F0AOIpinoiZP7
         F65VZfdDAG/kqPhmI5hhexgxI53QFYFtHhJxwLDZ3MQNTIO6c0XVRBMrR3IWhbpLAmAm
         m5lmYQc9X6ha4aPdTyFLBmDLrJDMaXW2uh2S3IkavgAgePaJUPdei3ntHwrVxDAIw/f5
         PVzJUpU9CNa/DgjDytqZtk8N7dsV4R7TRhymXoEUTNKHECLoOWWuYjtrGnenPZbmGgBq
         IfEw==
X-Gm-Message-State: AOAM533nwMZG8/bsa4Rq0FFI3cv76jV7qFXTvd8IyTb0qUotb5n0KuSi
        oq+QH8uD3halnNv/dAY1m5KD
X-Google-Smtp-Source: ABdhPJyUlpRaJM3tp2vMj9eH1VjMGwQM/ZgkaXoFNB+l8crc6I5GjqoFTbfnIlx39czJd7cmo/CsVw==
X-Received: by 2002:a17:902:ac97:b029:d1:f367:b51a with SMTP id h23-20020a170902ac97b02900d1f367b51amr3378864plr.20.1600758016632;
        Tue, 22 Sep 2020 00:00:16 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e1c:c062:1004:2ccf:6900:b97])
        by smtp.gmail.com with ESMTPSA id k3sm14142185pfp.41.2020.09.22.00.00.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Sep 2020 00:00:16 -0700 (PDT)
Date:   Tue, 22 Sep 2020 12:30:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, afaerber@suse.de, vkoul@kernel.org,
        robh+dt@kernel.org, dan.j.williams@intel.com,
        cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 06/10] arm64: dts: actions: Add DMA Controller for S700
Message-ID: <20200922070003.GG29035@Mani-XPS-13-9360>
References: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
 <1595180527-11320-7-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595180527-11320-7-git-send-email-amittomer25@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 11:12:03PM +0530, Amit Singh Tomar wrote:
> This commit adds DMA controller present on Actions S700, it differs from
> S900 in terms of number of dma channels and requests.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>

Applied for v5.10!

Thanks,
Mani

> ---
> Changes since v6:
> 	* No change.
> Changes since v5:
>         * Added Mani's Reviewed-by: tag.
> Changes since v4:
>         * No change.
> Changes since v3:
>         * Fixed typo in commit message.
>         * Placed owl-s700-powergate.h in alphabetical order.
> Changes since v2:
>         * added power-domain property as sps
>           is enabled now and DMA needs it.
> Changes since v1:
>         * No Change.
> Changes since RFC:
>         * No Change.
> ---
>  arch/arm64/boot/dts/actions/s700.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
> index f8eb72bb4125..2c78caebf515 100644
> --- a/arch/arm64/boot/dts/actions/s700.dtsi
> +++ b/arch/arm64/boot/dts/actions/s700.dtsi
> @@ -5,6 +5,7 @@
>  
>  #include <dt-bindings/clock/actions,s700-cmu.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/owl-s700-powergate.h>
>  #include <dt-bindings/reset/actions,s700-reset.h>
>  
>  / {
> @@ -244,5 +245,19 @@
>  				     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
>  		};
> +
> +		dma: dma-controller@e0230000 {
> +			compatible = "actions,s700-dma";
> +			reg = <0x0 0xe0230000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			dma-channels = <10>;
> +			dma-requests = <44>;
> +			clocks = <&cmu CLK_DMAC>;
> +			power-domains = <&sps S700_PD_DMA>;
> +		};
>  	};
>  };
> -- 
> 2.7.4
> 
