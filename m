Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DE12D11B9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgLGNW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:22:26 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53205 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGNWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:22:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id a6so11451489wmc.2;
        Mon, 07 Dec 2020 05:22:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MJwMrUj3WNQ0Z6JF3rMMT8PRx7qig2o2mEv5ta9FJhk=;
        b=iPJwYcwjjFrBn3UILT6Ut20S2nzO+hxf+Kk52/R5f5e0smBaU1Z/PeyVMDiL7t+1kg
         eg27v6L2dOZ0bHO085FQxYAg7YiZi5AF4Juy6ergY6vTWUj9RGQpVkTYExcghp1u+V+e
         rSGaCgGQ+HYeDk8P4sfxJ2+mTsx8mmXeM1Xae+ukHaP53SFa0zssqyWA7JEC+zW9wjIc
         SOtan1b+JH0SmCREKHap6795F9FDJ/++gmkKfRgu0BVAtpviNrnRyMRbLcNQ5SQ82g5E
         hjxl2UFhX9vKMeQ1leAu5pwrx58rqgE44lcUy72zUV9nFart5We8lg9qMuDZl7aluXwI
         YHtg==
X-Gm-Message-State: AOAM533KQJE+Hs+2z0s4iB5Ja83FrQLa/0cTfDCPY3x3sGKSy/HKAXCl
        U4ZfAdjTMHF6BI1xkziDVgA=
X-Google-Smtp-Source: ABdhPJyO70ZClWQf3G0rlUyq9BYbIJl9dRorKgaLYiVZ7ua/tO2HTRt3sifgwB+7CESnraCvF7RTjg==
X-Received: by 2002:a7b:c2e8:: with SMTP id e8mr18172792wmk.103.1607347303289;
        Mon, 07 Dec 2020 05:21:43 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id y6sm15005491wmg.39.2020.12.07.05.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:21:41 -0800 (PST)
Date:   Mon, 7 Dec 2020 14:21:40 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mn: Fix duplicate node name
Message-ID: <20201207132140.GA31982@kozik-lap>
References: <1607324004-12960-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1607324004-12960-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 02:53:24PM +0800, Shengjiu Wang wrote:
> Error log:
> sysfs: cannot create duplicate filename '/bus/platform/devices/30000000.bus'
> 
> The spba bus name is duplicate with aips bus name.
> Refine spba bus name to fix this issue.
> 
> Fixes: 970406eaef3a ("arm64: dts: imx8mn: Enable Asynchronous Sample Rate Converter")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index fd669c0f3fe5..30762eb4f0a7 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -246,7 +246,7 @@ aips1: bus@30000000 {
>  			#size-cells = <1>;
>  			ranges;
>  
> -			spba: bus@30000000 {
> +			spba: spba-bus@30000000 {

The proper node name is "bus" so basically you introduce wrong name to
other problem.  Introducing wrong names at least requires a comment.

However the actual problem here is not in node names but in addresses:

	aips1: bus@30000000 {
		spba: bus@30000000 {

You have to devices with the same unit address. How do you share the
address space?

I think this should be rather fixed.

Best regards,
Krzysztof


>  				compatible = "fsl,spba-bus", "simple-bus";
>  				#address-cells = <1>;
>  				#size-cells = <1>;
> -- 
> 2.27.0
> 
