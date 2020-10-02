Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43C9281100
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 13:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387800AbgJBLKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 07:10:22 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:35056 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgJBLKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 07:10:20 -0400
Received: by mail-ej1-f65.google.com with SMTP id u21so1411012eja.2;
        Fri, 02 Oct 2020 04:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wDTKbdGBT6DJY0L4YlF2VzawALLmfAUZKYoHRF2W8hw=;
        b=hXroNN/mFxQJUDMMFc5Z7u97dUzd8NTuSEGTPkcvUzeM1mpAjV/oZKmGZ1LHHk96W/
         QD3mrCP9ilG3ZBhvonoXJUN28gt/4xLkT3I8qSN0lxhfCr/gFQJ/xlWOBcdKJF7+lsS9
         I2UJImiGv3zRI5fEgP+/4xD5CRsCh6Z+be/HAY3WzhUdXGj/nx9nZoHbwBR4+lGcUemn
         B/8LG3B81aUoVCkiYu/sYzwZI2oU2BMYuoL3CBe0sLbciMr25a8lyMqqbtELDDmzmRCH
         VQ79Aq5biPlkqQtYNrvCnKN0nvm9d0/u7jxQh2m2ycWkfc3/1p4R7OQW5/Ow+4bi9DDD
         r5Ow==
X-Gm-Message-State: AOAM533ZZiu7fVlSaNXf+X6fsmmvCs0zRFFbSXXz0EbjwttXS1I1t4kG
        7xQBG6JQvMKkE5739Hkpsec=
X-Google-Smtp-Source: ABdhPJyr+lz9aljZjSALIJLlmHUZmvPOwMjCcDNc2vDAAzSqnPdX/49XBEEsx1dw9329gDRVFsjj5w==
X-Received: by 2002:a17:906:2dd7:: with SMTP id h23mr302773eji.175.1601637018319;
        Fri, 02 Oct 2020 04:10:18 -0700 (PDT)
Received: from pi3 ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id v25sm906385edr.29.2020.10.02.04.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 04:10:17 -0700 (PDT)
Date:   Fri, 2 Oct 2020 13:10:14 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com,
        Greg Kroah-Hartman <gregkh@google.com>, kernel-team@android.com
Subject: Re: [PATCH v3 06/24] dt-bindings: mediatek: Add binding for mt8192
 IOMMU
Message-ID: <20201002111014.GE6888@pi3>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
 <20200930070647.10188-7-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930070647.10188-7-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 03:06:29PM +0800, Yong Wu wrote:
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
>  .../bindings/iommu/mediatek,iommu.yaml        |   9 +-
>  .../mediatek,smi-common.yaml                  |   5 +-
>  .../memory-controllers/mediatek,smi-larb.yaml |   3 +-
>  include/dt-bindings/memory/mt8192-larb-port.h | 239 ++++++++++++++++++
>  4 files changed, 251 insertions(+), 5 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h

I see it depends on previous patches but does it have to be within one
commit? Is it not bisectable? The memory changes/bindings could go via
memory tree if this is split.

Best regards,
Krzysztof
