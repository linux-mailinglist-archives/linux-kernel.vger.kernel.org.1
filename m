Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D29C2AFA63
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 22:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgKKVeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 16:34:03 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33551 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKVeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 16:34:02 -0500
Received: by mail-ed1-f66.google.com with SMTP id v4so3903755edi.0;
        Wed, 11 Nov 2020 13:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vk3KrPrkDYUVNZL3DTlHOE1fBCf+cXVmLxTYq4r55Ss=;
        b=bMpvmwSSatnVMT4GF0rmgPqr3XGOGfLGQzEzqYaBm+XRNHSe/CbwKKHx8Ra4VRkWxq
         FiOg74MBuY+38Tk+L2sMBK25R9l2xlCUJnpZu24tTuJ50Y6YQbswXzW3NLfDxpITcIXO
         9aSM7CYwRB2geOxVeItjQL2CKW+pA2b3eyBAisjQ3Y9QHmAfUWm8ax1A3X6hbSia/gxJ
         aBSf9brbyMk8tL5kisf+r/BxUQ4FmDxqkQeMAekfvnyQkQtf/8RSzbQ4eeaypV2hbttK
         3GlVSKJvpMrB77bIILahJh2TBTg2uRC56mj5R7sDnCUzocC5ZAzAPG1Dv5lhv3KMSCi8
         mcNQ==
X-Gm-Message-State: AOAM531eVEHffuP/GrOHbwbbG3jhglKXyRiWAMCi9c138ZJCNsgbvCx+
        JutI0GS4SbLa0fKj+wdLtMg=
X-Google-Smtp-Source: ABdhPJzQP5o5OyQRS7gplBPAqdIpxUsSbwg2yAx1u1p6taNhLhBL8e677pIbq0t1wfjyEtnXAmYO4Q==
X-Received: by 2002:aa7:de95:: with SMTP id j21mr1711074edv.199.1605130440472;
        Wed, 11 Nov 2020 13:34:00 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id x1sm1437502edl.82.2020.11.11.13.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 13:33:59 -0800 (PST)
Date:   Wed, 11 Nov 2020 22:33:57 +0100
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
Subject: Re: [PATCH v4 06/24] iommu/mediatek: Use the common
 mtk-smi-larb-port.h
Message-ID: <20201111213357.GE287176@kozik-lap>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-7-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201111123838.15682-7-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 08:38:20PM +0800, Yong Wu wrote:
> Use the common larb-port header in the source code.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c  | 7 -------
>  drivers/iommu/mtk_iommu.h  | 1 +
>  drivers/memory/mtk-smi.c   | 1 +
>  include/soc/mediatek/smi.h | 2 --
>  4 files changed, 2 insertions(+), 9 deletions(-)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
