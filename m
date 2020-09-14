Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7BD2698E9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgINWdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:33:51 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:46470 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgINWdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:33:49 -0400
Received: by mail-il1-f196.google.com with SMTP id u18so1098443iln.13;
        Mon, 14 Sep 2020 15:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LR2VIPk/kPTFwa8fumXMyfI9oQy0dFUpuBNhTXBXL14=;
        b=q2237n7v6M1zurWOiKz9l4VMMXpL0kflCuHVV8+x5FFzmoSgdqD3s+jmHud87nKQCb
         dlkTnAu/jbjJkPStL3xbl9pizyItmvionLhjqJNFHFPjiezRoECyqbOYTSgb18q9bR/Q
         cR+JyXy6YHZnpKGdwzwPn089HPYq3FAPZWwFNRT1QTacOBYeBXPiZjoudMvvnPuuLtq6
         1X3CFHUybGc0UsxHHFEMf7dl956RtUHruLwRHFRVS8oAcwT5QOXS1UctPHA63Cak9/em
         CHAP2LSqVP0cqZelp3dY9KQp/0nAASW4unCAQZ1mLEcoODJcGdtDbH5wLsUTLww9Pkyv
         UJmQ==
X-Gm-Message-State: AOAM533ucDi2m0DhM0dHlk1a4Ene6G4nVM7vVjNnHOZZvWzd9sMpzWeh
        DmkHC+PumI0GnhiA0AMkIQ==
X-Google-Smtp-Source: ABdhPJxhBwt+joy5rC6tCThb/a9SSzByv7xa3AAq7/kp6WACPc6nel+y3jAKE5+UNG5dyb3EK6b6HQ==
X-Received: by 2002:a92:98c5:: with SMTP id a66mr14220838ill.50.1600122828756;
        Mon, 14 Sep 2020 15:33:48 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id x185sm6810275iof.41.2020.09.14.15.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 15:33:48 -0700 (PDT)
Received: (nullmailer pid 387444 invoked by uid 1000);
        Mon, 14 Sep 2020 22:33:43 -0000
Date:   Mon, 14 Sep 2020 16:33:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
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
Message-ID: <20200914223343.GA386301@bogus>
References: <20200904145312.10960-1-krzk@kernel.org>
 <20200904145312.10960-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904145312.10960-4-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Sep 2020 16:53:02 +0200, Krzysztof Kozlowski wrote:
> All Purism Librem5 phones have three compatibles so they need their own
> entry to fix dbts_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml: /:
>     compatible: ['purism,librem5r2', 'purism,librem5', 'fsl,imx8mq'] is not valid under any of the given schemas
> 
>   arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml: /:
>     compatible: ['purism,librem5r2', 'purism,librem5', 'fsl,imx8mq'] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

I expect Shawn to pick this one up as this file gets touched a fair 
amount.
