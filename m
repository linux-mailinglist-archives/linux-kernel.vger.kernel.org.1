Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8662AFA60
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 22:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgKKVdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 16:33:43 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:44358 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKVdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 16:33:43 -0500
Received: by mail-ej1-f66.google.com with SMTP id o23so4736738ejn.11;
        Wed, 11 Nov 2020 13:33:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sK4IhYZOOZRYi+a2OxHEj++JSexEzteTRg9o9l5Xmmc=;
        b=G63srIaXyd/OKFwJHa5yXLLcrkO8TfvloT5q5KYd3DEZDc5CI0If5xud27Qe+Lvdjo
         v7uMaO+TyksNc01IyJxT/20MAzzUdq2KuZvS2EEu5+hbgaA2oyuxybcp+uqQoZ0tMw/J
         3FO9WdzRwgrc8Bx+QL+Saasane+BTS2otMWXUK1T55XrrNFuMZPK8mBCE9VUejazEua3
         O9PjVHTULZBsjcDpP3sQ2Py6inRaOOo/yfLEKUNV0/cSdR6zeZ9++8MaZahxXRehZili
         GSZxyydBPLNsE7nUXtRxFCVoezSq3ck2CQqsY13LiZKiRGsuCaJP9+L4zqtA/5FFw/Oo
         M+9Q==
X-Gm-Message-State: AOAM532t7X90L0Drw1svNtu5Lk2GZg9OE+ZA6cHBWAtOizpLQBLc7Tl9
        htrXPn4CuAVasTsaLyamR+k=
X-Google-Smtp-Source: ABdhPJyWmV5IHVA2ohdCwF8JXc37esFq7vT8fy5Vv2WHPBbGSRTGdwBIKtPRn5OWSNwKiPjundijtg==
X-Received: by 2002:a17:906:ca83:: with SMTP id js3mr28371238ejb.42.1605130421152;
        Wed, 11 Nov 2020 13:33:41 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id y15sm1439123eds.56.2020.11.11.13.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 13:33:39 -0800 (PST)
Date:   Wed, 11 Nov 2020 22:33:38 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, Greg Kroah-Hartman <gregkh@google.com>,
        kernel-team@android.com
Subject: Re: [PATCH v4 05/24] dt-bindings: mediatek: Add binding for mt8192
 IOMMU
Message-ID: <20201111213338.GD287176@kozik-lap>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-6-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201111123838.15682-6-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 08:38:19PM +0800, Yong Wu wrote:
> This patch adds decriptions for mt8192 IOMMU and SMI.
> 
> mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
> table format. The M4U-SMI HW diagram is as below:
> 
>                           EMI
>                            |
>                           M4U
>                            |
>                       ------------
>                        SMI Common
>                       ------------
>                            |
>   +-------+------+------+----------------------+-------+
>   |       |      |      |       ......         |       |
>   |       |      |      |                      |       |
> larb0   larb1  larb2  larb4     ......      larb19   larb20
> disp0   disp1   mdp    vdec                   IPE      IPE
> 
> All the connections are HW fixed, SW can NOT adjust it.
> 
> mt8192 M4U support 0~16GB iova range. we preassign different engines
> into different iova ranges:
> 
> domain-id  module     iova-range                  larbs
>    0       disp        0 ~ 4G                      larb0/1
>    1       vcodec      4G ~ 8G                     larb4/5/7
>    2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20
>    3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
>    4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5
> 
> The iova range for CCU0/1(camera control unit) is HW requirement.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        |  18 +-
>  include/dt-bindings/memory/mt8192-larb-port.h | 240 ++++++++++++++++++
>  2 files changed, 257 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index ba6626347381..0f26fe14c8e2 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -76,6 +76,7 @@ properties:
>            - mediatek,mt8167-m4u  # generation two
>            - mediatek,mt8173-m4u  # generation two
>            - mediatek,mt8183-m4u  # generation two
> +          - mediatek,mt8192-m4u  # generation two
>  
>        - description: mt7623 generation one
>          items:
> @@ -115,7 +116,11 @@ properties:
>        dt-binding/memory/mt6779-larb-port.h for mt6779,
>        dt-binding/memory/mt8167-larb-port.h for mt8167,
>        dt-binding/memory/mt8173-larb-port.h for mt8173,
> -      dt-binding/memory/mt8183-larb-port.h for mt8183.
> +      dt-binding/memory/mt8183-larb-port.h for mt8183,
> +      dt-binding/memory/mt8192-larb-port.h for mt8192.
> +
> +  power-domains:
> +    maxItems: 1
>  
>  required:
>    - compatible
> @@ -133,11 +138,22 @@ allOf:
>                - mediatek,mt2701-m4u
>                - mediatek,mt2712-m4u
>                - mediatek,mt8173-m4u
> +              - mediatek,mt8192-m4u
>  
>      then:
>        required:
>          - clocks
>  
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - mediatek,mt8192-m4u
> +
> +    then:
> +      required:
> +        - power-domains
> +
>  additionalProperties: false
>  
>  examples:
> diff --git a/include/dt-bindings/memory/mt8192-larb-port.h b/include/dt-bindings/memory/mt8192-larb-port.h
> new file mode 100644
> index 000000000000..7437fa62654e
> --- /dev/null
> +++ b/include/dt-bindings/memory/mt8192-larb-port.h
> @@ -0,0 +1,240 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2020 MediaTek Inc.
> + *
> + * Author: Chao Hao <chao.hao@mediatek.com>
> + * Author: Yong Wu <yong.wu@mediatek.com>
> + */
> +#ifndef _DTS_IOMMU_PORT_MT8192_H_
> +#define _DTS_IOMMU_PORT_MT8192_H_

Not accurate header guard. Shoud be:
_DT_BINDINGS_MEMORY_MT8192_LARB_PORT_H_

Probably you copied it from some other Mediatek headers - all of them
have header guard pointing to different directory.

Best regards,
Krzysztof
