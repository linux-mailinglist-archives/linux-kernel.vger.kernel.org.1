Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D638E2D6ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 04:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405284AbgLKDmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 22:42:11 -0500
Received: from mail-oo1-f65.google.com ([209.85.161.65]:36981 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405234AbgLKDlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:41:17 -0500
Received: by mail-oo1-f65.google.com with SMTP id t23so1817631oov.4;
        Thu, 10 Dec 2020 19:41:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rSxM3l6xp3sRDoOhEED+EOawS1LpcndGMhb9GwxCfww=;
        b=ASNoq+BEuZnfDpK4phmj9258ix1B4YLjGpd/Dy/HUxyE/AcTzvqImkmHl0GRPNQ1zb
         5g8yBMSX8fUwYueD2dM2NWG8f2ca9NmqxAw2msJmhW23lZVStdgVos4uR0z4JYG/Wbg6
         mKhJV57noWxoM0KRPcw3snZY9x8SWP4GH3sWnCmBqoEkQ1/Z/ZMrl9KmZ0kvfcrypmPg
         UmbexAALSzhghMkBy61Enmb+Mz1U1ZL81MnU+64j1RUbO8bS358HGDaUcAVh3ETUmM+i
         y8VeXNI5teL0bgNI1aYQJb9ACKUp52MF3oYVM218xgyBgY71Lx2uk4cUrNZQlIitqpvn
         HbEQ==
X-Gm-Message-State: AOAM532qwb6/UXraZTsxi7jabijeB46QInMX1OPlObfiU75aUI3jv4be
        G4yvDGniMBxb3u4IP/m18A==
X-Google-Smtp-Source: ABdhPJxFbPujw6YvZQNyAnC85BoyAfgK6ZSF1q6fK4C/+dHNlgwjupZdEhRXi5NgTGB3gwOUcW492Q==
X-Received: by 2002:a4a:b144:: with SMTP id e4mr8501118ooo.3.1607658035847;
        Thu, 10 Dec 2020 19:40:35 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z38sm1118026ooi.34.2020.12.10.19.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 19:40:35 -0800 (PST)
Received: (nullmailer pid 3594506 invoked by uid 1000);
        Fri, 11 Dec 2020 03:40:34 -0000
Date:   Thu, 10 Dec 2020 21:40:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8, 1/6] dt-bindings: mediatek: add rdma_fifo_size
 description for mt8183 display
Message-ID: <20201211034034.GA3593696@robh.at.kernel.org>
References: <1607591262-21736-1-git-send-email-yongqiang.niu@mediatek.com>
 <1607591262-21736-2-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607591262-21736-2-git-send-email-yongqiang.niu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 05:07:37PM +0800, Yongqiang Niu wrote:
> rdma fifo size may be different even in same SOC, add this
> property to the corresponding rdma
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  .../bindings/display/mediatek/mediatek,disp.txt          | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> index 1212207..64c64ee 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> @@ -66,6 +66,13 @@ Required properties (DMA function blocks):
>    argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
>    for details.
>  
> +Optional properties (RDMA function blocks):
> +- mediatek,rdma_fifo_size: rdma fifo size may be different even in same SOC, add this

mediatek,rdma-fifo-size

> +  property to the corresponding rdma
> +  the value is the Max value which defined in hardware data sheet.
> +  rdma_fifo_size of rdma0 in mt8183 is 5120
> +  rdma_fifo_size of rdma1 in mt8183 is 2048
> +
>  Examples:
>  
>  mmsys: clock-controller@14000000 {
> @@ -207,3 +214,12 @@ od@14023000 {
>  	power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
>  	clocks = <&mmsys CLK_MM_DISP_OD>;
>  };
> +
> +rdma1: rdma@1400c000 {
> +	compatible = "mediatek,mt8183-disp-rdma";
> +	reg = <0 0x1400c000 0 0x1000>;
> +	interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
> +	power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +	clocks = <&mmsys CLK_MM_DISP_RDMA1>;
> +	mediatek,rdma_fifo_size = <2048>;
> +};
> -- 
> 1.8.1.1.dirty
> 
