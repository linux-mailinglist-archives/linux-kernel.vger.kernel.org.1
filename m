Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D44D27FFA3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732094AbgJAM7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:59:39 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46679 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731952AbgJAM7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:59:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id 33so5159963edq.13;
        Thu, 01 Oct 2020 05:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rQ7jHY0ZRCMlx0zXiTjI/QguQ2YMXm5QIyvy0QxW/xY=;
        b=nBszPBVwQtTT0n7txTALtiC7mjwRfpzmlc6JJiUbmIajwYVgz8475Cs3Kw0k2dGeUy
         JbazzQlDA8ecpF/jBgF94WhVxRAdbHGUHaR/z2KNjB1gMxXggilB0dC2qcotahfU8yTy
         UIh0XkAE9+5ftG9YJE+7xajPwwQl16wO1Bf4M1w1QxsP8Gq68ZGQTKhdDB+MxzhLT76m
         ClGusB6dcDKtR04X/JckVB0VpPgtQ8M+3LxlKZ3IcYrB4U6fnWOk+YOlkiHeOpaafTMa
         95GoZwK1t7Ell8354YnA4qwAIvCCxKXaCCVNdAW4+47ubXF2OLomNL6I2y7svYU5d1OS
         S1aw==
X-Gm-Message-State: AOAM531iUVYjw3ucpt+jirLy2qB5N4lCo1NO+GSpJnAfbmPLyy8YFbeY
        7xPN2FrDrzs2o5ExgXSg0/0=
X-Google-Smtp-Source: ABdhPJy7OOmaJR3OND9SUszrHV0LLqAIYbSXivIJEB4fYZOOwXEy8z0K2VZIHVejW3EnWS/7RrOMqQ==
X-Received: by 2002:a05:6402:354:: with SMTP id r20mr5271407edw.332.1601557176243;
        Thu, 01 Oct 2020 05:59:36 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id r13sm4124131edo.48.2020.10.01.05.59.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Oct 2020 05:59:35 -0700 (PDT)
Date:   Thu, 1 Oct 2020 14:59:32 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Li Yang <leoyang.li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?utf-8?Q?S=C3=A9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: arm: fsl: Add Kontron i.MX8M Mini
 SoMs and boards
Message-ID: <20201001125932.GB6082@kozik-lap>
References: <20201001120717.13027-1-frieder.schrempf@kontron.de>
 <20201001120717.13027-2-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201001120717.13027-2-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 02:06:59PM +0200, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Add entries for the SoMs and boards based on i.MX8MM from Kontron
> Electronics GmbH.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes for v3:
> * None
> 
> Changes for v2:
> * Merge the SoMs and baseboards N8010 and N8011 into a single
>   configuration (N801X).
> * Add Rob's R-b tag
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 6da9d734cdb7..4217c61e3048 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -345,6 +345,13 @@ properties:
>          items:
>            - enum:
>                - fsl,imx8mm-evk            # i.MX8MM EVK Board
> +              - kontron,imx8mm-n801x-som  # Kontron N801X SOM
> +          - const: fsl,imx8mm
> +
> +      - description: Kontron N801X S Board
> +        items:
> +          - const: kontron,imx8mm-n801x-s
> +          - const: kontron,imx8mm-n801x-som
>            - const: fsl,imx8mm

You will need to rebase it on next or Shawn's tree, as new board came
here. Please add it then in alphabetical order, so:
  - description: i.MX8MM based Boards
  - description: Kontron N801X S Board
  - description: Variscite VAR-SOM-MX8MM based boards

Best regards,
Krzysztof
