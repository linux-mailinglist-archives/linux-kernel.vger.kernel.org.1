Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34682D41DB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 13:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbgLIMN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 07:13:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51326 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730428AbgLIMNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 07:13:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id v14so1271019wml.1;
        Wed, 09 Dec 2020 04:13:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vQr4kM4RX4rAp5j/qKDW+npGLeRnQffxCAXDPYe3mkw=;
        b=IQFAiiY99bvex3Ai8izFFG406qznuDIy/9hkhqx1XuYTts4PIu+OPyC5zybbs4+Qw+
         o9L5WvOEdSfdBfkyPmjFaqMPM+wIGCrcPGYxLMjIIRGUtD24e7/B/V26HrbDrVlGTaPs
         M7YEZSDE1iYgCfbSBz1WxXAAWhsl0Wp/MAtJujylURz9FNn1NzmQJPFVVmvbz2x5D3HF
         HqwYFQW+MXodBmIYxN+IZn/mcWTP4rSGAYz0W+VbL6MnxTwrMfJ6rVvCdguOkrVSSC/0
         KVzvlDgLamnmjTIJUpMoe5pF+lZyitHy38DWyIwuuPFB4QXvEQHyZK5rNKCOUFsJ9YfC
         CC+w==
X-Gm-Message-State: AOAM5305tf94h6uGKbGZefsQGDV+WVXYTXq4gA9Oo3dnIFaEg90+S9GS
        NLmhUERpCaqUaYaGy/U/Oi4=
X-Google-Smtp-Source: ABdhPJwaoDIcgfrg+ecoat6sonzdYokouAkiZQwpTX4sGEOgNsKCNcGr/SDr1PomqilqtE1wNLu82w==
X-Received: by 2002:a05:600c:22d9:: with SMTP id 25mr2437791wmg.158.1607515993634;
        Wed, 09 Dec 2020 04:13:13 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id v20sm3378527wra.19.2020.12.09.04.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 04:13:12 -0800 (PST)
Date:   Wed, 9 Dec 2020 13:13:11 +0100
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
        chao.hao@mediatek.com
Subject: Re: [PATCH v5 06/27] dt-bindings: mediatek: Add binding for mt8192
 IOMMU
Message-ID: <20201209121311.GB25951@kozik-lap>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-7-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201209080102.26626-7-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 04:00:41PM +0800, Yong Wu wrote:
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

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
