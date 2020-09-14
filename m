Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434B42698D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgINWbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:31:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40916 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgINWbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:31:36 -0400
Received: by mail-io1-f65.google.com with SMTP id j2so1906215ioj.7;
        Mon, 14 Sep 2020 15:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/pD/h9E35swAdheWUiJTW2U8mtD3mvR4TbFwObgRqNQ=;
        b=s7eke34TMsW035nc80TIYPkq2ySlz4V07pj+Zf9awkmCUsVcyQ/TXMdaZamZLBdYg1
         tv0iE5aCF3x5cZ3e3PUyfzs/WHsIiQTEsPCmUURILy1xglSc4HgDLJCRuWgonYupdY4r
         73PEAsmEVCcKQaVRO4+ylTW3VbnzCFcNdDBgc8/V/DbYRyIVOPAsDLqHq3DdnU+R3vQH
         9cIuQxd387YfE13seKPO9mkWuKR4825eW55Gliv/bibYm7TDTV9Ux0+41RbtspPzj+hK
         UJuCY2jIhu4lwZv6pZd73HNBl0XtIxdcHQuhqyiN7a46LCK3Cg6hfbiepxcOXdhOmz3E
         twLA==
X-Gm-Message-State: AOAM532fU7nqt7wTdg0itPuYf2nIDzBX9RTDIkzU/ACnMD0PjJqorbPH
        RUVAev00QBtfDXWxwIdpsJu74IPPPEZw
X-Google-Smtp-Source: ABdhPJxo23QcjWKVaJTELcfH6zvKBCo6gLwUuumBxvcGYu10LcMbvle/m6Ht8hvnRhQrVk6QQijdPw==
X-Received: by 2002:a02:6043:: with SMTP id d3mr15339291jaf.122.1600122694328;
        Mon, 14 Sep 2020 15:31:34 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z10sm6559662ioi.13.2020.09.14.15.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 15:31:33 -0700 (PDT)
Received: (nullmailer pid 383796 invoked by uid 1000);
        Mon, 14 Sep 2020 22:31:32 -0000
Date:   Mon, 14 Sep 2020 16:31:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yang <leoyang.li@nxp.com>,
        dri-devel@lists.freedesktop.org,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Robert Chiras <robert.chiras@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        etnaviv@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 02/13] dt-bindings: display: bridge: nwl-dsi: Add common
 properties
Message-ID: <20200914223132.GA383744@bogus>
References: <20200904145312.10960-1-krzk@kernel.org>
 <20200904145312.10960-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904145312.10960-3-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Sep 2020 16:53:01 +0200, Krzysztof Kozlowski wrote:
> Add common properties appearing in DTSes (assigned-clocks and others) to
> fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mq-evk.dt.yaml: mipi-dsi@30a00000:
>     'assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' do not match any of the regexes: '^panel@[0-9]+$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Applied, thanks!
