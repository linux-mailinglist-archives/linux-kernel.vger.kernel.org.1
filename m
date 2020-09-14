Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83388269922
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgINWoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:44:14 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42401 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgINWoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:44:12 -0400
Received: by mail-io1-f65.google.com with SMTP id u6so1925288iow.9;
        Mon, 14 Sep 2020 15:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ylUrEEmYi1EaiuhHEqxtgMvlCDH6vw+JSMpMqyXXaxw=;
        b=UexcQBz+unBFQ7HEOgOb9kUTivjWHGFMtZx1Gs88cNxTXXbWlpkR/TzBmK7xb8qo03
         K4w81eVK0DjW1DMOE8bQbSP8r1T0ysy7FgghZTvtUzNAkf/IR/e6W9Y0O58Ew8avGzxI
         FkobXcQo6+Bqm6tEteykqvNl1yEIUn+Td9v/xyfJC0yA2sG/uK9yyMp53SFh1JRGZc1v
         MzTX2WQVnvU2imjKYVWN89Nez+QiXj0yNWY7kIMqjquwnj261gM4XSloDrJ4Ij6OcwD7
         oCnC4sjrrzoUdDkL2CO/CFsLt+0Irr1yez/JtkX9Fq9BovfUosRYQEpCh93qw3ALE5WZ
         4wjQ==
X-Gm-Message-State: AOAM531bc2pjE/FvWXtmSBM5/Am5jaK6YQnxZMxQvxWFjQ6up0kpeFXR
        mhbnAKIuyhTubWfW6zqmgw==
X-Google-Smtp-Source: ABdhPJy0EiT7MplPn0+3By2fzZNnP/u2zfQZ44vJh5JI0TZD6SDZoEgp/wP3JFumGKjEqcEvAf3tFA==
X-Received: by 2002:a02:11c2:: with SMTP id 185mr14783901jaf.35.1600123451958;
        Mon, 14 Sep 2020 15:44:11 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id w15sm7629263ilq.46.2020.09.14.15.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 15:44:11 -0700 (PDT)
Received: (nullmailer pid 404103 invoked by uid 1000);
        Mon, 14 Sep 2020 22:44:07 -0000
Date:   Mon, 14 Sep 2020 16:44:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Li Yang <leoyang.li@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/13] dt-bindings: mfd: rohm,bd71837-pmic: Add common
 properties
Message-ID: <20200914224407.GA388924@bogus>
References: <20200904145312.10960-1-krzk@kernel.org>
 <20200904145312.10960-7-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904145312.10960-7-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 04:53:05PM +0200, Krzysztof Kozlowski wrote:
> Add common properties appearing in DTSes (clock-names,
> clock-output-names) to fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml:
>     pmic@4b: 'clock-names', 'clock-output-names', do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/mfd/rohm,bd71837-pmic.yaml          | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
> index 65018a019e1d..ecce0d5e3a95 100644
> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
> @@ -32,9 +32,15 @@ properties:
>    clocks:
>      maxItems: 1
>  
> +  clock-names:
> +    maxItems: 1

Needs to define what the name is.

> +
>    "#clock-cells":
>      const: 0
>  
> +  clock-output-names:
> +    maxItems: 1

Ideally this one too, but we've been more flexible on it.

> +
>  # The BD718x7 supports two different HW states as reset target states. States
>  # are called as SNVS and READY. At READY state all the PMIC power outputs go
>  # down and OTP is reload. At the SNVS state all other logic and external
> -- 
> 2.17.1
> 
