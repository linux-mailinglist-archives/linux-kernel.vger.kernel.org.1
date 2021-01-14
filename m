Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1432F6AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbhANT2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:28:15 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:45417 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbhANT2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:28:15 -0500
Received: by mail-ot1-f53.google.com with SMTP id n42so6227982ota.12;
        Thu, 14 Jan 2021 11:27:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VEeqdZkDifn0VyJEJKrWR4ztWRK6vfNBUVg/0z1SB/E=;
        b=gjx4xyDZJHjp5pQEKM4eIrncsn8uhTrQOeOPtYGuIkyutl0GMpb1uJpoDbjJY9CIze
         dQc0w60jQrt5uk2cmzZ2ktI33gGMeG0Qxf8Nv6M3BNwf4x5C5nTHUImXYq9u1p0tgWJe
         Waz3/gpmhQALZaIa+k3wm+AaMkASJFGK9GRQuJQqX77B+31u9oTc78m2RR41dz+286Ec
         /rJjszFOBdCf5X9dAKVsriNn+oFSdrAJhPCKbfk4O0NPfsI7WREei3qEtGewqnL/coVq
         CwoTmZlDf2tlO+WFrF1UA08uddQ0lBIkjWVRSzMuo7QsWTSgasHMumWX9W5IJBBBCiKZ
         Cz4A==
X-Gm-Message-State: AOAM531EQudWYGA+zIjlbCKV+Coe+V9JWCTLfscQjVcDNwOfUlEiFKPP
        uAdGbM96H0hK0DD2X+RFXg==
X-Google-Smtp-Source: ABdhPJyYwiGGmezeN+wyEHvNPOPyKigxB7dYEfZtRaxnNgEofQKzxycwX+PBMxfL7z5b0J6I8OHScA==
X-Received: by 2002:a05:6830:19da:: with SMTP id p26mr5479965otp.80.1610652454370;
        Thu, 14 Jan 2021 11:27:34 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z189sm1222803oia.28.2021.01.14.11.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 11:27:33 -0800 (PST)
Received: (nullmailer pid 3425359 invoked by uid 1000);
        Thu, 14 Jan 2021 19:27:32 -0000
Date:   Thu, 14 Jan 2021 13:27:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v6 06/33] of/device: Move dma_range_map before
 of_iommu_configure
Message-ID: <20210114192732.GA3401278@robh.at.kernel.org>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
 <20210111111914.22211-7-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111111914.22211-7-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 07:18:47PM +0800, Yong Wu wrote:
> "dev->dma_range_map" contains the devices' dma_ranges information,
> This patch moves dma_range_map before of_iommu_configure. The iommu
> driver may need to know the dma_address requirements of its iommu
> consumer devices.
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/of/device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index aedfaaafd3e7..1d84636149df 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -170,9 +170,11 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>  	dev_dbg(dev, "device is%sdma coherent\n",
>  		coherent ? " " : " not ");
>  
> +	dev->dma_range_map = map;
>  	iommu = of_iommu_configure(dev, np, id);
>  	if (PTR_ERR(iommu) == -EPROBE_DEFER) {
>  		kfree(map);
> +		dev->dma_range_map = NULL;

Not really going to matter, but you should probably clear dma_range_map 
before what it points to is freed.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

>  		return -EPROBE_DEFER;
>  	}
>  
> @@ -181,7 +183,6 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>  
>  	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
>  
> -	dev->dma_range_map = map;
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_dma_configure_id);
> -- 
> 2.18.0
> 
