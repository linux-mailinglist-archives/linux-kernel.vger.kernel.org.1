Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADC32930AC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 23:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733310AbgJSVkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 17:40:49 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39936 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733236AbgJSVkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 17:40:49 -0400
Received: by mail-oi1-f194.google.com with SMTP id m128so1689048oig.7;
        Mon, 19 Oct 2020 14:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KwRHpeQcFYy7uhieySaYWDGx//hq6s67j0uXkg0vZ6A=;
        b=fNSMDk+0Fz2DCUsgFn0u3dEosPwv4JhR8Hr9pIq+ywY7tOeOYtuDbFuCccZ8J50aMy
         img2UVo8WKtYDG167ixw64RR8W8abAagqusqB0K/7PjQNYJAEHY1dXVBjScCqPUa6rsy
         HAEiu9/ytFYkyWSUJkiWw53jwGUZ7H7RoCOgez2Tt9EjbsGAO8GOIP8l03S9FhLxQgtL
         D0YmuMUJdVMtEr523xfArioIcInLjS9MCHw+LLMP/Ds86rUgeJMlIE97xPn4RXzxH216
         tYwDubCtPi7xhjPYH1LbFce+wYj6wyAJYuuX0U06Jd+E//LQrFYk7TKnjr6rTmMgfqWR
         8CVw==
X-Gm-Message-State: AOAM5338Y0X9pLEktRnLtxEyNbSc0BjxkddDFTAFy2B5bwRc+8v8/18o
        PaIekgf5GieXz3BN9GTU6A==
X-Google-Smtp-Source: ABdhPJy/3076rgDefQQMiCO3/USZa+uXB2reqghggQBkaNgWN9sQMyn0Q/I88mLdH9mwc3VyuJZ1uQ==
X-Received: by 2002:aca:2313:: with SMTP id e19mr1005812oie.14.1603143648260;
        Mon, 19 Oct 2020 14:40:48 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f70sm246135otf.32.2020.10.19.14.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 14:40:47 -0700 (PDT)
Received: (nullmailer pid 3648883 invoked by uid 1000);
        Mon, 19 Oct 2020 21:40:46 -0000
Date:   Mon, 19 Oct 2020 16:40:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, nkristam@nvidia.com
Subject: Re: [PATCH v4 10/16] dt-bindings: phy: tegra-xusb: Add nvidia,pmc
 prop
Message-ID: <20201019214046.GA3645734@bogus>
References: <20201016130726.1378666-1-jckuo@nvidia.com>
 <20201016130726.1378666-11-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016130726.1378666-11-jckuo@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 09:07:20PM +0800, JC Kuo wrote:
> This commit describes the "nvidia,pmc" property for Tegra210 tegra-xusb
> PHY driver. It is a phandle and specifier referring to the Tegra210
> pmc@7000e400 node.
> 
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> ---
> v4:
>    new change to document "nvidia,pmc" prop
> 
>  .../devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt      | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
> index 38c5fa21f435..ea559baeb546 100644
> --- a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
> +++ b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
> @@ -54,6 +54,7 @@ For Tegra210:
>  - avdd-pll-uerefe-supply: PLLE reference PLL power supply. Must supply 1.05 V.
>  - dvdd-pex-pll-supply: PCIe/USB3 PLL power supply. Must supply 1.05 V.
>  - hvdd-pex-pll-e-supply: High-voltage PLLE power supply. Must supply 1.8 V.
> +- nvidia,pmc: phandle and specifier referring to the Tegra210 pmc@7000e400 node.

'Tegra210 pmc@7000e400' is kind of specific. Going to update this for 
every address and chip?

If there's only one PMC, you can just find the compatible PMC node. Then 
you don't need a DT update.

Rob
