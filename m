Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6DD295B68
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 11:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895624AbgJVJGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 05:06:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40664 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502494AbgJVJGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 05:06:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id p13so994359edi.7;
        Thu, 22 Oct 2020 02:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fZGbnwkshp84ij+8oovQIfaXlT5PG5oa571s9jNq+hc=;
        b=tMpmjtLRSEoJ1SFcmOmdXa5cGFSaFH3kwvdfueiCUS+TlSBfqgOt7JXcWDBzQ3pZGn
         KXO1S5Zl7hmHCCkPulXh5Rl4rTYTB200Ar3ON5sTnHkRjVCx+zxpcKSg4/z0ildzRcnt
         3gsAQLWIuHaDyMlQ/jQkoWrpBgUSM4xBK8zaQlw46l9uRbuBxHdBstpDCmH70PKI5t+u
         yyjkAdchJbUhDC5/Yb8d/F2Wjut5Z22kW5UwCZzU5gPFmRYffyXoxFMoqMCAJoQ63+c6
         P4lzDMoyGA1J9hsKxOjLJGurLT2uFXj431ILBDy/3pjTee425fE6sgqmgHY169QMLxBC
         LV5g==
X-Gm-Message-State: AOAM5325Mn8h7gcAnUHqnFEvCQyf8Ncmx09WV3b/9wZhqdQRT606Gqek
        C8lW10Vo/hWTapuIpAvLQyA=
X-Google-Smtp-Source: ABdhPJwkzrYN1/YM2CA/N54L1mckIQL98gnTZsx9ddMzgYootNQkfjZbP+blLlNQ3DjUFj+lCkAF6w==
X-Received: by 2002:a05:6402:b72:: with SMTP id cb18mr1229049edb.129.1603357611891;
        Thu, 22 Oct 2020 02:06:51 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id v14sm402047edy.68.2020.10.22.02.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 02:06:50 -0700 (PDT)
Date:   Thu, 22 Oct 2020 11:06:46 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     peng.fan@nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, marex@denx.de
Subject: Re: [PATCH] arm64: dts: imx8m: use generic name for tmu
Message-ID: <20201022090646.GA90867@kozik-lap>
References: <1603351278-8198-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1603351278-8198-1-git-send-email-peng.fan@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 03:21:18PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per devicetree specification, generic names are recommended
> to be used, such as temperature-sensor.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index b83f400def8b..327f1d44ced9 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -404,7 +404,7 @@ gpio5: gpio@30240000 {
>  				gpio-ranges = <&iomuxc 0 119 30>;
>  			};
>  
> -			tmu: tmu@30260000 {
> +			tmu: temperature-sensor@30260000 {

No, TMU is not a temperature-sensor. It does much more. TMU is quite
generic name for this class of device.

Best regards,
Krzysztof
