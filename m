Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C782D45B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbgLIPnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:43:53 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38647 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbgLIPnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:43:51 -0500
Received: by mail-oi1-f194.google.com with SMTP id o25so2145101oie.5;
        Wed, 09 Dec 2020 07:43:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xyemNnhjU5il7k21qT33cjQLp+UyBWVDuSCqb0RQaW0=;
        b=neWw6ajrwrzMigvC9QVr5cZc2RARIam1ro4wrn0rcyKbFrZ3oGU6DmIxJTvn9qBGul
         g/eklB4MsnAWtHnondlRvTjPnjqzE+eLkliUbdA2SY6UiVzAsjugFjCNjDYii6e5xyQK
         X00RCOSgPfJrikHNaXceMU1sNbLdkzeJmkQI6zr9hbwNJgA55uiitmWPcEaRpStOdKww
         XVdZx0C2mxuK3Z7nHQMxcoC6ARaw/O4DHv+riULe1+QN4caYnrzvx3IhGezmHlTvdg8b
         Yh3bMNgVF3jgoJ/dl0g3elCTXMQyu0f6egVIqWRkiGS3J4uh5EUSGXoOf6Q+F3ihQPSe
         IcGA==
X-Gm-Message-State: AOAM530WZ5nJlqa2l/HaL8PtFtwV1vOFl4nbDb9FFTJu51s5eBXpKtt1
        8Z459uIMx/wAYHuaRl6XqmlmdlhGwg==
X-Google-Smtp-Source: ABdhPJw+I7ALAWStRGDmlteVb/Vljx/8sw65lDYOkrkf8fkklwf/YjhJDiwRixQBGRFFBra705lMog==
X-Received: by 2002:a05:6808:6c2:: with SMTP id m2mr2141071oih.123.1607528590434;
        Wed, 09 Dec 2020 07:43:10 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j46sm391734oof.36.2020.12.09.07.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 07:43:09 -0800 (PST)
Received: (nullmailer pid 500102 invoked by uid 1000);
        Wed, 09 Dec 2020 15:43:08 -0000
Date:   Wed, 9 Dec 2020 09:43:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 2/5] dt-bindings: arm: fsl: add Kverneland UT1, UT1Q
 and UI1P boards
Message-ID: <20201209154308.GA495323@robh.at.kernel.org>
References: <20201201072449.28600-1-o.rempel@pengutronix.de>
 <20201201072449.28600-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201072449.28600-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 08:24:45AM +0100, Oleksij Rempel wrote:
> Add Kverneland UT1 (imx6dl), UT1Q (imx6q) and UT1P (imx6dp) based boards
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 490cbc75b18a..7b2f83bb56cb 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -210,6 +210,7 @@ properties:
>                - kiebackpeter,imx6q-tpc    # K+P i.MX6 Quad TPC Board
>                - kontron,imx6q-samx6i      # Kontron i.MX6 Dual/Quad SMARC Module
>                - kosagi,imx6q-novena       # Kosagi Novena Dual/Quad
> +              - kvg,vicut1q               # Kverneland UT1Q board
>                - logicpd,imx6q-logicpd
>                - lwn,display5              # Liebherr Display5 i.MX6 Quad Board
>                - lwn,mccmon6               # Liebherr Monitor6 i.MX6 Quad Board
> @@ -331,6 +332,7 @@ properties:
>                - fsl,imx6qp-sabreauto      # i.MX6 Quad Plus SABRE Automotive Board
>                - fsl,imx6qp-sabresd        # i.MX6 Quad Plus SABRE Smart Device Board
>                - karo,imx6qp-tx6qp         # Ka-Ro electronics TX6QP-8037 Module
> +              - kvg,vicutp                # Kverneland UT1P board

Should be kvg,vicut1p?

>                - prt,prtwd3                # Protonic WD3 board
>                - wand,imx6qp-wandboard     # Wandboard i.MX6 QuadPlus Board
>                - zii,imx6qp-zii-rdu2       # ZII RDU2+ Board
> @@ -364,6 +366,7 @@ properties:
>                - fsl,imx6dl-sabresd        # i.MX6 DualLite SABRE Smart Device Board
>                - karo,imx6dl-tx6dl         # Ka-Ro electronics TX6U Modules
>                - kontron,imx6dl-samx6i     # Kontron i.MX6 Solo SMARC Module
> +              - kvg,vicut1                # Kverneland UT1 board
>                - ply,plybas                # Plymovent BAS board
>                - ply,plym2m                # Plymovent M2M board
>                - poslab,imx6dl-savageboard # Poslab SavageBoard Dual
> -- 
> 2.29.2
> 
