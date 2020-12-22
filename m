Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DF22E0876
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 11:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgLVKAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 05:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgLVKAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 05:00:15 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE45C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 01:59:34 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id a6so1348814wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 01:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1uWQ1lsamrDj670psBGhqmITnRdEWIGipMAwVhvN0IQ=;
        b=nzzFQvbCE9iM4gRr0OHBQhW95iPZnUHGIevbHh6G8/1DaGIs5orfQtZMKTjTyY2zjJ
         pltvHVHec5UsnNGgJJfthUftOsewWy8YhxnXYppOWmN7Y3UqFISq3+f0ocm6pWy6s+ao
         uaRBF2vgyNBikZ7ShJgESCzRRRySZbSAjnMwIBBn8PSrZQ33zLQZUN9iSC4x/lmTq981
         FJ2Ly2VqTgTlLk7P1ecU0mMa6SWh/a/ZrKv1GDXYGD51DpKiA1XsULU+2oq9wzAV5jgw
         +k0KhDI7UdHfo056NDutP99ttFQbtHZfAKQ81sHnq9JXVyK6fylkzXtS8AJ7ez5tMlJX
         s4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1uWQ1lsamrDj670psBGhqmITnRdEWIGipMAwVhvN0IQ=;
        b=KoU6jZAw9/ouYzs88ISh1oy5Y6pOpyI2S/TFAy11lw4asljaEX7Tm+57LXY3HQ6Pj0
         o2nyyu5BETQYVXhQ76CKxq/TJgGFhOOFr0HCRlJQcO9URSNJMR/h/Jq9xDnB7EC2Ge55
         27hGEC1MFgvZl6mHdauoMNLkrNgiDANw5N9mrNFiP6rUqdsy5oLl9bz3sWs8Qwz+Al5c
         vq5tSOwpYkgyYAUdoLErJF1LGY+pK/kmoeAuEDrfUWf9RpgNa6XPm82c77amcyenJYDL
         1saClcHlDKqwDbnu3JN0GDaDKbEWi/4GQBTPK6Sq2yLvFvey+kiGnqELntI20yhJk2vs
         xpRg==
X-Gm-Message-State: AOAM5313F2rCMQAbZnolsn3+SRl+h6SIkTcu3LROX+6nQ5K6buLZ57fh
        3V1W+SAuOZTCppQwGee9SqfedQ==
X-Google-Smtp-Source: ABdhPJyryip6dXlJcoBpock1PWleQBmbQZcocbzF4ei8MZdMG4Bgcp5A9SM4uCOXJeAM5U9qRO3loQ==
X-Received: by 2002:a1c:1d1:: with SMTP id 200mr21458882wmb.98.1608631173322;
        Tue, 22 Dec 2020 01:59:33 -0800 (PST)
Received: from dell ([91.110.221.175])
        by smtp.gmail.com with ESMTPSA id a65sm26056927wmc.35.2020.12.22.01.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 01:59:32 -0800 (PST)
Date:   Tue, 22 Dec 2020 09:58:23 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Drop unnecessary *-supply schemas properties
Message-ID: <20201222095651.GD53991@dell>
References: <20201221234659.824881-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201221234659.824881-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Dec 2020, Rob Herring wrote:

> *-supply properties are always a single phandle, so binding schemas
> don't need a type $ref nor 'maxItems'.
> 
> A meta-schema check for this is pending once these existing cases are
> fixed.
> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-iio@vger.kernel.org
> Cc: linux-input@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/bridge/anx6345.yaml | 2 --
>  .../devicetree/bindings/display/bridge/ite,it6505.yaml        | 2 --
>  .../devicetree/bindings/display/bridge/lvds-codec.yaml        | 3 +--
>  Documentation/devicetree/bindings/display/bridge/ps8640.yaml  | 2 --
>  .../devicetree/bindings/display/bridge/simple-bridge.yaml     | 1 -
>  .../bindings/display/bridge/thine,thc63lvd1024.yaml           | 1 -
>  .../devicetree/bindings/display/bridge/toshiba,tc358775.yaml  | 2 --
>  Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml   | 4 +---
>  .../devicetree/bindings/iio/humidity/ti,hdc2010.yaml          | 3 +--
>  .../devicetree/bindings/input/fsl,mpr121-touchkey.yaml        | 3 +--
>  .../devicetree/bindings/input/touchscreen/edt-ft5x06.yaml     | 3 +--
>  .../devicetree/bindings/media/i2c/maxim,max9286.yaml          | 1 -
>  Documentation/devicetree/bindings/media/i2c/mipi-ccs.yaml     | 3 ---
>  Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml  | 3 ---
>  Documentation/devicetree/bindings/media/i2c/sony,imx274.yaml  | 3 ---
>  Documentation/devicetree/bindings/mfd/st,stmfx.yaml           | 3 +--

Acked-by: Lee Jones <lee.jones@linaro.org>

>  .../devicetree/bindings/regulator/anatop-regulator.yaml       | 1 -
>  17 files changed, 6 insertions(+), 34 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
