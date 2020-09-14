Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DEF2698F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgINWeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:34:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44672 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgINWe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:34:27 -0400
Received: by mail-io1-f68.google.com with SMTP id g128so1876542iof.11;
        Mon, 14 Sep 2020 15:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qawHL//JCsl3s+o/MBQptvseieD2pIXqGeERB4s68y0=;
        b=CcK3A6n6Uh1ZymP1sAKpoF2nwMsb31UvsjhinXgNv+Xio+knZBijOUsrJeXt8CKguW
         k8NBLpBu7YPO5x1QP7+WFZOZJ7lfkNRWhgnixvQw+6CEeNknxMPsPw8UD+e9fOavux+A
         VrVOWvLDZ9xtf43eyOZ20+0GWNIYletT1rLuWhCbvJoROoBYwdk2PKLJPjkKGqMU8X6x
         bNsEfh/utwnudENkjUWPERSVo96TLJxTu31X7z8oyqFu/IxDvt+QGnz9TpzD7UCYHUCF
         pdB2CbAo7rrHP1Bb/Auyhc/UEj/BY3JMvOHV827quY2ThCw27WJetsu3y2ABcO6fa1bj
         UjoA==
X-Gm-Message-State: AOAM5334POMcFLeL+wUAWI0E1OIKgpSRHrlK5jvJK7tVh6uqYizXSFMC
        PBeQ0EL7G6jYnx3kdkuxuQ==
X-Google-Smtp-Source: ABdhPJzIqAUlesX+PcK3HAo1XZVOGkzfK7XNe09zz72N2Yn2JpGtqmogpPHH5kwRGbL/iuCPfuI3Fw==
X-Received: by 2002:a05:6638:22ba:: with SMTP id z26mr15372869jas.55.1600122866346;
        Mon, 14 Sep 2020 15:34:26 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id w15sm7615180ilq.46.2020.09.14.15.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 15:34:25 -0700 (PDT)
Received: (nullmailer pid 388721 invoked by uid 1000);
        Mon, 14 Sep 2020 22:34:22 -0000
Date:   Mon, 14 Sep 2020 16:34:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        David Airlie <airlied@linux.ie>,
        Fabio Estevam <festevam@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-arm-kernel@lists.infradead.org,
        etnaviv@lists.freedesktop.org, Shawn Guo <shawnguo@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Robert Chiras <robert.chiras@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 05/13] dt-bindings: gpu: vivante, gc: Remove trailing
 whitespace
Message-ID: <20200914223422.GA388670@bogus>
References: <20200904145312.10960-1-krzk@kernel.org>
 <20200904145312.10960-6-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904145312.10960-6-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Sep 2020 16:53:04 +0200, Krzysztof Kozlowski wrote:
> Remove whitespace at the end of line.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/gpu/vivante,gc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
