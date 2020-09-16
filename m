Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A3626BD5C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgIPGi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:38:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43521 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIPGiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:38:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id k15so5603880wrn.10;
        Tue, 15 Sep 2020 23:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OIJLGGGniVhQVtQMrqVCccoyI58LfU7rsBw2hzyYuuI=;
        b=HLljIdornHtRj2Jq/h73nvjIlh8BtfpPrxEihiwWtQnS4jDdS1NAoMapDjfh4xArLr
         /DfgoSd6uSIj3V7qiYCked9Romadt8VNpVYXE1/4qX3P5qk/iXbb76D6SL4mWRV2ewdl
         mwSTD0d4LOipDaaO61D4jPKbEt1KZCQK3aPksBOBkoEiMoz0mFatmRNppfjA82vXXStq
         UuTd7La3jwkr7Rc/KczKr7SUnpVWQh8m1F2DLTjy7/ILc/BAXpHr4ucMvWgV/69YUVtD
         m2sNwarTuGWAshgfoo45mjly1Ln/iLLSQDnkZ+MWlbFJwUUov502higrYEIyscGh2hXu
         DMrQ==
X-Gm-Message-State: AOAM533gWmxRHKxyvXiY61dyft7O2mVyGHTv5la86TsHcnQEnhuH9Ddl
        sltNZ+1M9Hljx4Udo436Qnw=
X-Google-Smtp-Source: ABdhPJyQlteL0N/pU4eGx+adqZwehoEnOdIRonAvDPv+rO2M8s8kM/CkVEgxf3jd4rBP/JE1VfY6cg==
X-Received: by 2002:adf:f3c6:: with SMTP id g6mr27189618wrp.340.1600238303133;
        Tue, 15 Sep 2020 23:38:23 -0700 (PDT)
Received: from kozik-lap ([194.230.155.124])
        by smtp.googlemail.com with ESMTPSA id 18sm3308363wmj.28.2020.09.15.23.38.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Sep 2020 23:38:22 -0700 (PDT)
Date:   Wed, 16 Sep 2020 08:38:19 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        David Airlie <airlied@linux.ie>, Li Yang <leoyang.li@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 03/13] dt-bindings: arm: fsl: Fix matching Purism Librem5
 phones
Message-ID: <20200916063819.GA6687@kozik-lap>
References: <20200904145312.10960-1-krzk@kernel.org>
 <20200904145312.10960-4-krzk@kernel.org>
 <20200914223343.GA386301@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200914223343.GA386301@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 04:33:43PM -0600, Rob Herring wrote:
> On Fri, 04 Sep 2020 16:53:02 +0200, Krzysztof Kozlowski wrote:
> > All Purism Librem5 phones have three compatibles so they need their own
> > entry to fix dbts_check warnings like:
> > 
> >   arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml: /:
> >     compatible: ['purism,librem5r2', 'purism,librem5', 'fsl,imx8mq'] is not valid under any of the given schemas
> > 
> >   arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml: /:
> >     compatible: ['purism,librem5r2', 'purism,librem5', 'fsl,imx8mq'] is too long
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> I expect Shawn to pick this one up as this file gets touched a fair 
> amount.

Hi Shawn,

Could you pick up this patch as well?

Best regards,
Krzysztof

