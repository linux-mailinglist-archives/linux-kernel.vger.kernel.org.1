Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8280B2698EE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgINWeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:34:17 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46779 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgINWeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:34:13 -0400
Received: by mail-io1-f66.google.com with SMTP id g7so1866001iov.13;
        Mon, 14 Sep 2020 15:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y8CcCumFrbE5PKVVcgSzK63UfLfmY/dLPnUgvKfkKuc=;
        b=MtH3q1bGzn3ZjB0IxLnkmgYUhkYyZ2q9SjKDM1MRVg3TeVffrqiOiIh8NzltSw4TwU
         Fpb7aMF2ukrZ3snY3/L99wGCptgjxd8h8TyVte2m6MKlK9GXInkBawa9J84bB8eq0kMK
         8IlSjIcPhPGpngCtr2bYJ1II+WCvZi0KUiSEIfyQCsmDXaDwXzdQ70FGmCq5KN5cM82H
         YOIcYB9xfmb5w7y4xSeIMbxz04vx7eAfjNlYBLhLzXUmwkK/vRTxi77A3qnJ8XaA/UA9
         3QJgFJ72QfLH9b8uBN+6kZy59rMvDfkP3np8iLROePQ1jjEjBGM9+LSev5rw3p8h8eCu
         1FeA==
X-Gm-Message-State: AOAM5325vPtnG1lkjLJSmp/+kH5UZtmI3ITn5iS4iJg23uQkFN7IwBC1
        OCIVDyWGM0h2d02slA1E7Q==
X-Google-Smtp-Source: ABdhPJxkJI1Dnvq9CIPCPn7djiuA/dt7rMR/n9Kj9F9jKovXNxk79GoqzQUeW7MO3YeVHTB9EZIsug==
X-Received: by 2002:a02:ab85:: with SMTP id t5mr15077114jan.51.1600122852853;
        Mon, 14 Sep 2020 15:34:12 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id g1sm7631220ilh.12.2020.09.14.15.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 15:34:12 -0700 (PDT)
Received: (nullmailer pid 388187 invoked by uid 1000);
        Mon, 14 Sep 2020 22:34:08 -0000
Date:   Mon, 14 Sep 2020 16:34:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        etnaviv@lists.freedesktop.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Li Yang <leoyang.li@nxp.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH 04/13] dt-bindings: gpu: vivante,gc: Add common properties
Message-ID: <20200914223408.GA388135@bogus>
References: <20200904145312.10960-1-krzk@kernel.org>
 <20200904145312.10960-5-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904145312.10960-5-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Sep 2020 16:53:03 +0200, Krzysztof Kozlowski wrote:
> Add common properties appearing in DTSes (cooling-cells, assigned-clocks
> and others) to fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mq-evk.dt.yaml: gpu@38000000:
>     '#cooling-cells', 'assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/gpu/vivante,gc.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Applied, thanks!
