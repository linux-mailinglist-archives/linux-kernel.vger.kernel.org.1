Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1201A2AFA5D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 22:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgKKVar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 16:30:47 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:38432 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgKKVar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 16:30:47 -0500
Received: by mail-ej1-f65.google.com with SMTP id za3so4761384ejb.5;
        Wed, 11 Nov 2020 13:30:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z+ETELXno+NvRIRsDlBueAlts5jLlnpIbWvTkKx52dc=;
        b=AhN7npByf9ivdtrPXxFLQhikxYxeqGMbPlB1ZUfYOL88VcU/bLKj/Y0doro7GSFK4g
         PHrFvh4YtsUxnRbTkod8V3rVR39LZOTFx0R7RngPCum9yGUm3MDCoNqOBVVipKfGFXri
         l86DdGZZQh0/+ailu7WzC/YVt0UZJpksLbSL6NfiUfm2XhvgVB2gWSQXyVZDDm0Oh3YK
         0gxNSjTPV8aduNPeuwpe6XT/c6kaxxe15nKbX1gHqtydUOXQ2y92PoiEHjzdkxBQGxvy
         +wbgPMyss4f4qssXU91ZUhB20S+rQu6fjsyctyrTcwjkH54G5CFy74YjaBh83VGp1seN
         4y1w==
X-Gm-Message-State: AOAM530w4SXE/srQUY4i+AmWMT1K+jMIvWDP/zkjK/FU8C8m7FdHdBYl
        aNVHvv1O0pz2ppdtN81B8gE=
X-Google-Smtp-Source: ABdhPJyhZPk3FplV/r7GELuT8+cAZX7sxSAYu7E4SNmzzETHkXyXKEmJuKnrqs52+PR3B57lSpkvkA==
X-Received: by 2002:a17:906:f186:: with SMTP id gs6mr28257486ejb.171.1605130244772;
        Wed, 11 Nov 2020 13:30:44 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id c11sm1421524eds.62.2020.11.11.13.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 13:30:43 -0800 (PST)
Date:   Wed, 11 Nov 2020 22:30:41 +0100
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
Subject: Re: [PATCH v4 04/24] dt-bindings: memory: mediatek: Add domain
 definition
Message-ID: <20201111213041.GC287176@kozik-lap>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-5-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201111123838.15682-5-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 08:38:18PM +0800, Yong Wu wrote:
> In the latest SoC, there are several HW IP require a sepecial iova
> range, mainly CCU and VPU has this requirement. Take CCU as a example,
> CCU require its iova locate in the range(0x4000_0000 ~ 0x43ff_ffff).
> 
> In this patch we add a domain definition for the special port. In the
> example of CCU, If we preassign CCU port in domain1, then iommu driver
> will prepare a independent iommu domain of the special iova range for it,
> then the iova got from dma_alloc_attrs(ccu-dev) will locate in its special
> range.
> 
> This is a preparing patch for multi-domain support.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  include/dt-bindings/memory/mtk-smi-larb-port.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
