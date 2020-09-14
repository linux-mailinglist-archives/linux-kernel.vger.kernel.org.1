Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023FC2698D3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgINWbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:31:13 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:45591 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgINWbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:31:09 -0400
Received: by mail-il1-f195.google.com with SMTP id h2so1103267ilo.12;
        Mon, 14 Sep 2020 15:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nT6K1KQBj4W8IpGEQ4J6WYsBu8HZ684HxeYYE+eGjiY=;
        b=aQLYfPbFL0n3PHbhTJV6HttEGqgazcEivzcVk03pCAY3pYiPXiYsrT/uF5OPsB5d5i
         xsuOanFaqMv7mqf3fIk+I6Bcx0+qWdPBz0jLBHTcYCm4dl6CudhSPkIJDtrYyaoseYT1
         uE+SRFXL53cUj80m+9iDNk23s46kwKBEgCOk9vebZreXzOAMWu6NqC25UUKlhK/9sBC6
         rDZfPacY3pmg/lm2w99UpNNZfRwKNcGSe2isDv9u8cXA2pqd+zExkcoblo+7MoM/zcN3
         5529qeSJBpKKgzlo650ffBBujmTbf70cXzPKuMlA6WU4WqxBpPgEZHhUarfhhuk4cEf/
         Vjcw==
X-Gm-Message-State: AOAM531rOqteuk6BAC52S7bTg/OPffpMl75WobdE6C4EKJS+xamFj99Z
        g8SyjbRWQ1Ai5QMFC2gU0w==
X-Google-Smtp-Source: ABdhPJz21EfEdkgbUKk4Ay96aVETSaWe1zUZ+gDkOp3S2g9h0lxpKe8gdihfIGpebZrhD7CCljrBlQ==
X-Received: by 2002:a92:9ac7:: with SMTP id c68mr13567597ill.221.1600122666900;
        Mon, 14 Sep 2020 15:31:06 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id l14sm7668265ili.84.2020.09.14.15.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 15:31:06 -0700 (PDT)
Received: (nullmailer pid 382849 invoked by uid 1000);
        Mon, 14 Sep 2020 22:31:02 -0000
Date:   Mon, 14 Sep 2020 16:31:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, etnaviv@lists.freedesktop.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        devicetree@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 01/13] dt-bindings: power: fsl, imx-gpcv2: Document
 interrupt controller properties
Message-ID: <20200914223102.GA382796@bogus>
References: <20200904145312.10960-1-krzk@kernel.org>
 <20200904145312.10960-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904145312.10960-2-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Sep 2020 16:53:00 +0200, Krzysztof Kozlowski wrote:
> The i.MX General Power Controller v2 is also an interrupt controller so
> document additional properties to fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mq-evk.dt.yaml: gpc@303a0000:
>     '#interrupt-cells', 'interrupt-controller' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Applied, thanks!
