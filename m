Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9CD27D697
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgI2TPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:15:45 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45032 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgI2TPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:15:45 -0400
Received: by mail-oi1-f194.google.com with SMTP id 185so6684981oie.11;
        Tue, 29 Sep 2020 12:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nhzCmY3+gzRAa6AJHi0QnmSEiU/cvXcJsfOn/d9+0Po=;
        b=t7mE2sNwkdVouDcJmfrMGK8mDeiQjNGY6Q3UxMtUdr7Yjb3CjuDqEcmyuVfnZYGudZ
         dOlzdgFvXBuuGpCpWWHhx1g77BDta+9W72FSe7gCwPPsfx6AAYBW2Vm2033Ko+MSm/7s
         3wNdgiutul7j0WtdlO6Pgs6DIQTaVM8HOE8V98iaWW7K13xVvGfWcv/zLvtxBnJbT+IW
         eOyTKwjNtMZS1YHS7J3v0SGeZf/B94fSrNvos6S3xOQOomPKmKCfMA3t7KP81IUIqLVz
         Wbmw8SqRiY1foBsSfhnB2wyDvwIQu7UdVBWIrelFCLFsQ/5HTDggEmTmcgcthK6SHvEk
         r32A==
X-Gm-Message-State: AOAM532GDW8g6EBYirGrSvcBm/a6uCZE2I2nNZ/3OT2dveXjFLTtf9yf
        7owh5oNib7cPBNlZskJcYw==
X-Google-Smtp-Source: ABdhPJxvF81mrS1YkbMIovAWaqSm+mXfxAjiDzoHK5gbodgALqfNfkVS0x4sPUlAlgKKujcrMGpshg==
X-Received: by 2002:aca:1015:: with SMTP id 21mr3332544oiq.11.1601406944323;
        Tue, 29 Sep 2020 12:15:44 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w12sm3108379oow.22.2020.09.29.12.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 12:15:43 -0700 (PDT)
Received: (nullmailer pid 992592 invoked by uid 1000);
        Tue, 29 Sep 2020 19:15:42 -0000
Date:   Tue, 29 Sep 2020 14:15:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Li Yang <leoyang.li@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Jones <rjones@gateworks.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/14] dt-bindings: vendor-prefixes: add iMX6 Rex Project
Message-ID: <20200929191542.GA992534@bogus>
References: <20200926162811.5335-1-krzk@kernel.org>
 <20200926162811.5335-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926162811.5335-2-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 18:27:59 +0200, Krzysztof Kozlowski wrote:
> Document vendor prefix for iMX6 Rex Project.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
