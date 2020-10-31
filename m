Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE3C2A1AA8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 22:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgJaVM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 17:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgJaVMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 17:12:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D70C0617A6;
        Sat, 31 Oct 2020 14:12:55 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g12so10173595wrp.10;
        Sat, 31 Oct 2020 14:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/x8kMzw5Ihywao6dWaDN2k8sN8fgLV92I+v5HRzyRxY=;
        b=N0P248Vui+hq7vxQYCkiqw2JVYCk2q2G6ReqQfoljvKDlVSba5OvZgTay8KCkK1eo2
         tcmcHzx/Re9pf3twvJhyQdPpnCFZm887LYh3OgSLTR7iX/sr1DYx+u0hehaqSH6aOlbb
         FTxDW89wQGvgJaTHzPUtp8tZnakwbomsit03iMJ3IiJjQe9QoahnXDACJyrMcMPDzyqf
         bvMfWRoAQAzR076KehK7eES1P9hEyGDNEbRQ7pOihaKHEVn9ikOPrCkzlOYI9KHLN/w4
         LjI++/DHoPANlSUumN1g6L8kQ0Vr8xU73cosJXqT160qIvH7TQr3yV7p/KLNwpFwMLNz
         X/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/x8kMzw5Ihywao6dWaDN2k8sN8fgLV92I+v5HRzyRxY=;
        b=miP3klMRofwQ1zZoA5L0rQfou91ovYN5CqYJcYWheknsl6NOt+AeXlmmWgEbi/M3oq
         mpCQyB/A0T+mOEJOrUxpkiSLSyHph9ZF0VX+wIyjp04Aa9p/wqEHsYAKo6AueHWGxTsH
         khx7m3pYCAuPURyJrsxh4Y+Q1k5x2lw48aY4Z9NCIFmORbRvQLPdvvNb7y8TTesGVpsU
         qIVAGFUgDOts+JTRWuL55iYH+7yjsS8EWc/aRrSckVuNJmcjGnAg7sODnnpc9EJgZe94
         0CBszHOc0hnLpkDerADG+V4G4V9Sijv/8ska/gkJiqYdOMN2IO7nHj9zF0+q3YkGzwW3
         W4Iw==
X-Gm-Message-State: AOAM530/7kO+Kpdr9jXcnD1AeeJR6jAlCu7gLLuZKWKYZk/lLEtIaYDe
        SJv2FNWeN0R0+9Cwz7A+I6CO8dJCxC0=
X-Google-Smtp-Source: ABdhPJzq5z+zKMjVoWRrBn64KG2nFk3R2F2HGaZ26M5P3CXEZ+dckrgjCPgV6+xjDK5eCwAdlb4Mxw==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr11860930wrm.251.1604178774101;
        Sat, 31 Oct 2020 14:12:54 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id e2sm16880196wrr.85.2020.10.31.14.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 14:12:53 -0700 (PDT)
Date:   Sat, 31 Oct 2020 22:12:51 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH v2] arm64: dts: allwinner: h6: PineH64
 model B: Add wifi
Message-ID: <20201031211251.GA6511@Red>
References: <20201030172530.1096394-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030172530.1096394-1-jernej.skrabec@siol.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 06:25:30PM +0100, Jernej Skrabec wrote:
> PineH64 model B contains RTL8723CS wifi+bt combo module.
> 
> Since bluetooth support is not yet squared away, only wifi is enabled
> for now.
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
> Changes from v1:
> - added Chen-Yu tag
> - added vqmmc-supply
> 
>  .../dts/allwinner/sun50i-h6-pine-h64-model-b.dts  | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> index f4c8966a6497..7fea1e4e2d49 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> @@ -10,6 +10,12 @@ / {
>  	compatible = "pine64,pine-h64-model-b", "allwinner,sun50i-h6";
>  
>  	/delete-node/ reg_gmac_3v3;
> +
> +	wifi_pwrseq: wifi_pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
> +		post-power-on-delay-ms = <200>;
> +	};
>  };
>  
>  &hdmi_connector {
> @@ -19,3 +25,12 @@ &hdmi_connector {
>  &emac {
>  	phy-supply = <&reg_aldo2>;
>  };
> +
> +&mmc1 {
> +	vmmc-supply = <&reg_cldo3>;
> +	vqmmc-supply = <&reg_aldo1>;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	bus-width = <4>;
> +	non-removable;
> +	status = "okay";
> +};
> -- 

Hello

Tested-by: <clabbe.montjoie@gmail.com>
RTL8723CS driver probe and related iwlist commands works. (like listing availlable channels)
But connecting to a wireless network was not successfully tested yet. (I need to set a test network).

Regards
