Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC0E2E264A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgLXLYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:24:20 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:40022 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgLXLYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:24:19 -0500
Received: by mail-wr1-f54.google.com with SMTP id 91so1892830wrj.7;
        Thu, 24 Dec 2020 03:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D7nAycYA5Tou2eaZsXGtv/ZPTzAOMFWwsPdPF4SoL60=;
        b=S+1E7jiuF/zwEAXRxcchZ/hKUeVhF2oZxj1yfBsa7fL3yrnJ/rcOKfNcpluNXnzX9R
         KxlN76sC/ROp8l4hjKUJOYJL2T2aeEMPLw2LgbrgYXOodYH+3lkeOHARQr3bIwniwt3l
         7pumgqBvchpY4iRtOnhK8hZnSvC651J8YYacufIE5ghcFU9N+fw18LZx0HxRnOjcquqs
         nOZuJKbeWNPKQHTVwIneIxkcFLM8+G1HNRlqXTsmchnhVr69nycaezkZtamrtYwQ7ued
         1nMUszFLHJ5bmi46iMvvf0/dBIgVTcYZOOSS5ZorkXXXPT6z+AHfZglacJbMlhH5QQYV
         OctA==
X-Gm-Message-State: AOAM533j9Hkra+10semGdSzfrL5/OjJ0O2U1lmggA99uq4M5jFEc0Fsk
        i+KdUerWNS+LpdjTsPzzBfY=
X-Google-Smtp-Source: ABdhPJzq5eeLAD3GyV6H/yROJinYLxHNa5TAGM5O6TpO8vRwsS+qizRc2pbedcQNh5m5nEShGnHrNw==
X-Received: by 2002:adf:c642:: with SMTP id u2mr22963700wrg.243.1608809017410;
        Thu, 24 Dec 2020 03:23:37 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id e15sm39473199wrx.86.2020.12.24.03.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Dec 2020 03:23:36 -0800 (PST)
Date:   Thu, 24 Dec 2020 12:23:35 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: Add binding for Gateworks
 boards with IMX8MM
Message-ID: <20201224112335.GA15628@kozik-lap>
References: <1608762196-29871-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1608762196-29871-1-git-send-email-tharvey@gateworks.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 02:23:15PM -0800, Tim Harvey wrote:
> Add bindings for the Gateworks Venice Development kit boards with
> IMX8MM System on Module.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 1ca9dfa..705c6e8 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -405,6 +405,9 @@ properties:
>                - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
>                - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
>                - fsl,imx8mm-evk            # i.MX8MM EVK Board
> +              - gw,imx8mm-gw71xx-0x       # i.MX8MM Gateworks Development Kit
> +              - gw,imx8mm-gw72xx-0x       # i.MX8MM Gateworks Development Kit
> +              - gw,imx8mm-gw73xx-0x       # i.MX8MM Gateworks Development Kit

I think you should skip the wildcards in compatible and choose one
specific compatible. What if at some point you would like to add gw,imx8mm-gw7113-0x?

Best regards,
Krzysztof


>                - variscite,var-som-mx8mm   # i.MX8MM Variscite VAR-SOM-MX8MM module
>            - const: fsl,imx8mm
>  
> -- 
> 2.7.4
> 
