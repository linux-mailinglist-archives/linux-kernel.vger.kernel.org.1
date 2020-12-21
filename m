Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5572DFC63
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 14:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgLUNrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 08:47:10 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:44945 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgLUNrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 08:47:10 -0500
Received: by mail-wr1-f45.google.com with SMTP id w5so11099607wrm.11;
        Mon, 21 Dec 2020 05:46:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SSC69sqSTAtXz3ORBoKJ4J9VIQbqZBX9JkA4+Zy5GlY=;
        b=kETRLj17iJhI7wJAM0FVPHS+rkDzUXdi8HgSpfRzLtDFOu750kVx5SnZI2R6tEvwSo
         zj9vEkz57q2Fi4qAkFFp9/z1e5MR0o7l53NzTFWYwjitvBupS7HYCqKgqaPlMu5mtR93
         96OoEMATiMeJciImlL0fg1CoGkHDlhusa2U949iBvJrs3mZE+vdUdILmSHisoRiHZnbw
         SgqCxwuYk1TyHacM7TzowAVOmRfdRfyrHAGO+Ch9QkEdAjS29wKMOS7ihvz4UcyMWmxI
         Zn/4GDneYKRAPujIVnh3O/MNaCg/rvAqGyelYifvmbexKSbyadc5JYLglvuMFD5BX3dQ
         yjXA==
X-Gm-Message-State: AOAM533gqdtvQYBPDTsDSy/QnPSapNOAX7l/5oqETXGnpCqJftyAzJx7
        cMX60ZoOUTx1GxoQcnDRL0U=
X-Google-Smtp-Source: ABdhPJza3lVI0zWGWhX0jF0YW5IGMbac9DO0I+4ghGPltDS708DNOoXxrmVj8SI6Kpds8XcHkv2dyw==
X-Received: by 2002:adf:c14d:: with SMTP id w13mr18456141wre.383.1608558388333;
        Mon, 21 Dec 2020 05:46:28 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id g78sm23111818wme.33.2020.12.21.05.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 05:46:27 -0800 (PST)
Date:   Mon, 21 Dec 2020 14:46:25 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: arm: fsl: Add Engicam i.Core MX8M
 Mini C.TOUCH 2.0
Message-ID: <20201221134625.GB31176@kozik-lap>
References: <20201221113151.94515-1-jagan@amarulasolutions.com>
 <20201221113151.94515-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201221113151.94515-3-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 05:01:47PM +0530, Jagan Teki wrote:
> i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.
> 
> C.TOUCH 2.0 is a general purpose carrier board with capacitive
> touch interface support.
> 
> i.Core MX8M Mini needs to mount on top of this Carrier board for
> creating complete i.Core MX8M Mini C.TOUCH 2.0 board.
> 
> Add bindings for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - updated commit message
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 67980dcef66d..e653e0a43016 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -667,6 +667,8 @@ properties:
>          items:
>            - enum:
>                - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
> +              - engicam,icore-mx8mm               # i.MX8MM Engicam i.Core MX8M Mini SOM
> +              - engicam,icore-mx8mm-ctouch2       # i.MX8MM Engicam i.Core MX8M Mini C.TOUCH 2.0

Please test your DTS against new schema with dtbs_check. This won't
match.

Submitting bindings and DTS which fail on day 0 is the same as sending
code which does not compile.

Best regards,
Krzysztof


>                - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
>                - fsl,imx8mm-evk            # i.MX8MM EVK Board
>                - kontron,imx8mm-n801x-som  # i.MX8MM Kontron SL (N801X) SOM
> -- 
> 2.25.1
> 
