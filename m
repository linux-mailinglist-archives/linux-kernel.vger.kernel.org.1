Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A41273B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 08:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgIVG6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 02:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbgIVG6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 02:58:44 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1E5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 23:58:44 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id jw11so996968pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 23:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mk/fMaiisStJZ+eXeroeNoarMmCiP2S7sKsiqrsdduk=;
        b=ZI2I3A+FjAgnP1cXGR3PslCfdiH9g5w0tXPci4401hJytPiSY4pry/LEjEi77uQPS8
         2JW8MNcX6gJjuFSXrxUL2r6NnU96PIRJ4MWouHvm9FiH8QoPW9IhAwJ9DgTjaO6ljYqn
         AT11HvdV2frVWOpHbNlg1/1TEXlizAajhDU3Q8+yqHwpQKcBv+VwnhMbHlu7QDhL8Sta
         QawTDXw4awlDtcXia2QtrOMhj0QEAMNeOE7hJWzkxpFYRXdD0JcWGAQ/rbgaYdc/pFnD
         Q16ZUGeTwlpsi05eCV0IVm6GZcY15a+jF6LzGh+5DUXFnz9p35Om2pu4p7GUg3h7HeT/
         Zqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mk/fMaiisStJZ+eXeroeNoarMmCiP2S7sKsiqrsdduk=;
        b=sC5oHggmA6Ke25iFChLsSC8LBCpglQDP72GHonc2y+VHZ88GtRB9yHueAuPx6F2muC
         lfsp0a3UmvOuJSkVfsdXICfkhslbiHX8jnMbhGmR56n6IZUC35AFX22YmsrDO1/27Oow
         r45R3TCtBq/SjHIhZPNw43oPq/5Ol9Yh4OVUeXv54RzlZLglq5m4hBqo047c4zj1mRmK
         rjJQiLFudACjVuPxpbb0/GQdWIzo0/winV5tU2yD56oo1ObRIChiYm1/SqmCQrKAGgbd
         RJd6ucbKD8ahwwgghPzV6DXBZIKJkWfMqvBFa7dN/BelMiJ5yQk9hbxF6+wt1EEeQqmM
         CCSg==
X-Gm-Message-State: AOAM5320r+WUjjXOIg4w+vuuVUOG/8AVPdXqwlLvRYNGGlWe7MSG1ekC
        MHL0+2HDPu9IWfl3a9plODy7
X-Google-Smtp-Source: ABdhPJzYXDkCWpSsQQwpumImuIQg+NKhaOHmsnp+NWmglbl2F3wo41wsAexxMwwBCEyoIgdXf2IVlQ==
X-Received: by 2002:a17:90b:510:: with SMTP id r16mr2566131pjz.75.1600757923416;
        Mon, 21 Sep 2020 23:58:43 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e1c:c062:1004:2ccf:6900:b97])
        by smtp.gmail.com with ESMTPSA id f4sm5290255pgk.19.2020.09.21.23.58.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Sep 2020 23:58:41 -0700 (PDT)
Date:   Tue, 22 Sep 2020 12:28:34 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, afaerber@suse.de, robh+dt@kernel.org,
        cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 05/10] arm64: dts: actions: limit address range for
 pinctrl node
Message-ID: <20200922065833.GF29035@Mani-XPS-13-9360>
References: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
 <1595180527-11320-6-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595180527-11320-6-git-send-email-amittomer25@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 11:12:02PM +0530, Amit Singh Tomar wrote:
> After commit 7cdf8446ed1d ("arm64: dts: actions: Add pinctrl node for
> Actions Semi S700") following error has been observed while booting
> Linux on Cubieboard7-lite(based on S700 SoC).
> 
> [    0.257415] pinctrl-s700 e01b0000.pinctrl: can't request region for
> resource [mem 0xe01b0000-0xe01b0fff]
> [    0.266902] pinctrl-s700: probe of e01b0000.pinctrl failed with error -16
> 
> This is due to the fact that memory range for "sps" power domain controller
> clashes with pinctrl.
> 
> One way to fix it, is to limit pinctrl address range which is safe
> to do as current pinctrl driver uses address range only up to 0x100.
> 
> This commit limits the pinctrl address range to 0x100 so that it doesn't
> conflict with sps range.
> 
> Fixes: 7cdf8446ed1d ("arm64: dts: actions: Add pinctrl node for Actions
> Semi S700")
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Suggested-by: Andre Przywara <andre.przywara@arm.com>
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
>         * Reordered it from 04/10 to 05/10.
> Changes since v3:
>         * No change.
> Changes since v2:
>         * this is no more don't merge and fixed
>           the broken S700 boot by limiting pinctrl
>           address range.
>         * Modified the subject to reflect the changes.
> Changes since v1:
>         * No change.
> Changes since RFC:
>         * kept as do not merge.
> ---
>  arch/arm64/boot/dts/actions/s700.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
> index 2006ad5424fa..f8eb72bb4125 100644
> --- a/arch/arm64/boot/dts/actions/s700.dtsi
> +++ b/arch/arm64/boot/dts/actions/s700.dtsi
> @@ -231,7 +231,7 @@
>  
>  		pinctrl: pinctrl@e01b0000 {
>  			compatible = "actions,s700-pinctrl";
> -			reg = <0x0 0xe01b0000 0x0 0x1000>;
> +			reg = <0x0 0xe01b0000 0x0 0x100>;
>  			clocks = <&cmu CLK_GPIO>;
>  			gpio-controller;
>  			gpio-ranges = <&pinctrl 0 0 136>;
> -- 
> 2.7.4
> 
