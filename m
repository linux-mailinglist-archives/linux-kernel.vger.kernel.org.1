Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBB9296C63
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461799AbgJWJzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:55:25 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:36132 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461791AbgJWJzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:55:24 -0400
Received: by mail-ej1-f66.google.com with SMTP id w27so1548337ejb.3;
        Fri, 23 Oct 2020 02:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ICcLjBaaZNrzw4RPAfBJmgQhH+Q612qy3XI9y9+bUfI=;
        b=g1B2Pf/U1Oo/AzQzlUtKnT3Kb81+9OVG5/zgwn0obgnpPd+CUHFj6OfykitjneGZLy
         K9AKA/nmU0H3MBF0e/iscvAWJcTQNBWZlnDvj5lyREh9fkrNS0cwMJqMFIz8U1rJfp3n
         1wka1YZq7GfJjnuGrcOqVQn+IXvG9UUTacWjKpSMTfw5tM5fRbenu+ykGfWo20XliDag
         96AE4r5Hh3G4DWOGuFmNXtkor3xSYXfCIjekNNzLCjHQza4YOQgxQ6+LQVkBR3vwBc2Q
         ebUkUrMx/fdTDwLYNH0QdQCuZfSVQhf/YEGJd6fFd2/cPy+ympoz1S6ekHiGddVNDFB/
         VYaQ==
X-Gm-Message-State: AOAM532sxLWYOyahDlgZIujpkSve//baJOOYpGt4i6qEF0ihTl7OOIkB
        16u4xHuTfC2+XNv8iAp/sL5B977g0hU=
X-Google-Smtp-Source: ABdhPJw3q2Nkzuq76xfLHtJmgVPKBaXvvka62mUYASOerJeHFiUWZbbgxMgWzqU275sIbgATDb7C2w==
X-Received: by 2002:a17:907:435b:: with SMTP id oc19mr1065718ejb.311.1603446922526;
        Fri, 23 Oct 2020 02:55:22 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id h4sm531741ejk.71.2020.10.23.02.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 02:55:21 -0700 (PDT)
Date:   Fri, 23 Oct 2020 11:55:18 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, marex@denx.de,
        l.stach@pengutronix.de, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: imx8mn: Add power-domain reference in
 USB controller
Message-ID: <20201023095518.GF42872@kozik-lap>
References: <20201022150808.763082-1-aford173@gmail.com>
 <20201022150808.763082-5-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201022150808.763082-5-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 10:08:07AM -0500, Adam Ford wrote:
> The USB OTG controller cannot be used until the power-domain is enabled
> unless it was started in the bootloader.
> 
> Adding the power-domain reference to the OTG node allows the OTG
> controller to operate.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 

I wonder, why your patches do not have usual Git trailer with summary of
changes (after '---')?

> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index 27733fbe87e9..605e6dbd2c6f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -979,6 +979,7 @@ usbotg1: usb@32e40000 {
>  				assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_500M>;
>  				fsl,usbphy = <&usbphynop1>;
>  				fsl,usbmisc = <&usbmisc1 0>;
> +				power-domains = <&pgc_otg1>;

I guess you need it also for the usbphynop1 and usbmisc1.

Best regards,
Krzysztof
