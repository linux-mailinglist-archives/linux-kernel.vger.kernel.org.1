Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A7527E8BD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbgI3Mno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:43:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36265 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgI3Mnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:43:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id w1so1689428edr.3;
        Wed, 30 Sep 2020 05:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Cg7FivcS7H1NBHoHG94ZTrqhSjBiBXvF64iDStcR1M=;
        b=tih6L+dGfrfbysoPVaWpd3jbsBa/TBaJjJoewRqDRzP7AkvntQzXHdeJYwT9VIH5Rg
         KejeFvcHhJWqbPmfTzQ6zPBuIdkCyM1lvmAmjFDw6jZ/kf0t6kouWc7vqQ0zM4tm0jHS
         xci8xahwr6Uz86F31HxyBc9h3pQ0jUJNi1G/4qctH62jMWuUsXS5GHhwmh07thkD1D0f
         bP3KStzW35lMVJzuBtGpO3pvUIkY8keoFqFgFGKZTh25V/HCYg4WwOaGbq8uDnwVweDF
         Ak5woo2AwmSaOMBC6ys/JFZ0PshY4X36bNMuDyAjW7QqcydmusGUtj5CyZnKme6IObOw
         5n7Q==
X-Gm-Message-State: AOAM531qHj/QTmBPPVc3A4gBgugxdh+8CCKXrUD5EgV652qg0tSr4pws
        qp+ZsgpfEcCccG873aH47wI=
X-Google-Smtp-Source: ABdhPJyaYhT+JDglD8EISNiLrkqaJKZpQv/UaWsk5W8/iVfeuccCOVcQ6IlsG4oRdN/TsVfvI1Z40A==
X-Received: by 2002:a05:6402:187:: with SMTP id r7mr2402133edv.360.1601469821955;
        Wed, 30 Sep 2020 05:43:41 -0700 (PDT)
Received: from pi3 ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id jp7sm1489468ejb.76.2020.09.30.05.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 05:43:40 -0700 (PDT)
Date:   Wed, 30 Sep 2020 14:43:38 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/14] dt-bindings: arm: fsl: document i.MX53 boards
Message-ID: <20200930124338.GB1368@pi3>
References: <20200926162811.5335-1-krzk@kernel.org>
 <20200926162811.5335-8-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200926162811.5335-8-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 26, 2020 at 06:28:05PM +0200, Krzysztof Kozlowski wrote:
> Document and adjust the compatibles for i.MX53 based boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index b6e5691ddbd1..812e8d8babd8 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -164,7 +164,16 @@ properties:
>                - fsl,imx53-evk
>                - fsl,imx53-qsb
>                - fsl,imx53-smd
> +              - ge,imx53-cpuvo                # General Electric CS ONE
> +              - inversepath,imx53-usbarmory   # Inverse Path USB armory
>                - menlo,m53menlo
> +              - voipac,imx53-dmm-668          # Voipac i.MX53 X53-DMM-668
> +          - const: fsl,imx53
> +
> +      - description: i.MX53 based TQ MBa53 Board
> +        items:
> +          - const: tq,mba53
> +          - const: tq,tqma53
>            - const: fsl,imx53

I missed few i.MX53 boards, so there will be a v2 for this one.

Best regards,
Krzysztof
