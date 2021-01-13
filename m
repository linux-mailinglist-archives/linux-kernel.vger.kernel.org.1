Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8AA2F4C87
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 14:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbhAMNwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 08:52:45 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:40890 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbhAMNwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 08:52:44 -0500
Received: by mail-oi1-f176.google.com with SMTP id p5so2140446oif.7;
        Wed, 13 Jan 2021 05:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iH2g7J4XG8RzNzVmZnHZVT+JqGY+hdY/33bx1pFnWwI=;
        b=DU0g64qB7czo0leXRwURFXJo4+gSyjAxjF5MrUjHkqPEPHtvNAZvdj+KSE13Pn3Z2a
         eX7JtUpTiRu9XJ80uxoTAxG2s5gSPrInDoVK6rm53Xg4cxPhv1pUIofdE5SM5LnNOIsX
         UDgjDDMOhqaBkMj9hOM28DZohl8ZxRZyob2mNY4yaUsSzXEgPrquHr2RzH3IRrmdEpH6
         yCnmTacMWddH172yhxAmwpT1wclZkE+f2AyuWPS8cMVbeB63KlipUDyq5k1VMjFL5S7r
         Kh4l1LzR20BJtzmh2uI57Mw8mnNuFyrHWwEktbtrGY5bRGYdakgvmB/T1GjDxKPIVuZI
         v6KA==
X-Gm-Message-State: AOAM531ZVX2z7eUbaP9P37BTKYRk71KQ/r0+FYyl7GoCPEFCyVgZKQs9
        NTItUuQFw8aa41Iq2fUYGA==
X-Google-Smtp-Source: ABdhPJx98abR7w2TYrwOdtJGzoId5Juzy7ogVrU/NhArH7rIk92RS8vLpVTjjAT53tqXpX3wkBqlnw==
X-Received: by 2002:aca:cd85:: with SMTP id d127mr1181720oig.59.1610545923888;
        Wed, 13 Jan 2021 05:52:03 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z38sm411622ooi.34.2021.01.13.05.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 05:52:02 -0800 (PST)
Received: (nullmailer pid 2331971 invoked by uid 1000);
        Wed, 13 Jan 2021 13:52:01 -0000
Date:   Wed, 13 Jan 2021 07:52:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Lee Jones <lee.jones@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com, linux-clk@vger.kernel.org
Subject: Re: [PATCH 04/15] dt_bindings: bd71828: Add clock output mode
Message-ID: <20210113135201.GA2328369@robh.at.kernel.org>
References: <cover.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
 <a91eb6288331bb80b30534a31049cde508307fc0.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a91eb6288331bb80b30534a31049cde508307fc0.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 03:34:16PM +0200, Matti Vaittinen wrote:
> The BD71828 allows configuring the clk32kout pin mode to CMOS or
> open-drain. Add device-tree property for specifying the preferred mode.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml         | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> index 3a6a1a26e2b3..cba085836bc0 100644
> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> @@ -44,6 +44,13 @@ properties:
>    clock-output-names:
>      const: bd71828-32k-out
>  
> +  rohm,clkout-mode:
> +    description: clk32kout mode. Can be set to "open-drain" or "cmos".
> +    $ref: "/schemas/types.yaml#/definitions/string"
> +    enum:
> +      - open-drain
> +      - cmos
> +

I think a boolean or tristate ((0/1/not present) if you need 'leave 
default') would be better.

>    rohm,charger-sense-resistor-ohms:
>      minimum: 10000000
>      maximum: 50000000
> -- 
> 2.25.4
> 
> 
> -- 
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
> 
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =] 
