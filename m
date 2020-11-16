Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624252B4E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387666AbgKPRoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:44:09 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38221 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387659AbgKPRoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:44:05 -0500
Received: by mail-oi1-f195.google.com with SMTP id o25so19691831oie.5;
        Mon, 16 Nov 2020 09:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aDraipXgK+j9ThnWRAuoxovGZzBsfeJ+1er3RHu2IRg=;
        b=HS7Rv8SN9c40WqIlZgs8x6gNpbLHpB3kiOfCReYV6Ub2Jj1XbdMDYgd6SwOJme6uqG
         sOsnY4KTPnOkWX9heSfM3KD2vwvjh0769wzRzfJRKeSkstl2qppJnUcAKK+rjWzBUFEk
         wZ75QAnaykAt/AiMBZMVfvTD95IPs9zm+C2T0vYzSxdc6eBmoUBvYrkWDaX2JTl1YawS
         c3e/HAE84SsPUZWCV4lzDONcVnYcswbI9Wo8PERtjf8xud/jSm+HaqIPApXDHlvNOCGy
         Q9sUcpGw7UZVYD01V9/USWh/mthf6S1PfmvR2pWw6Q+8Q9ODz2NbfwUX2hufcD1BEpDH
         TDMw==
X-Gm-Message-State: AOAM531z1HJwHeeB/cPfN2EpMrp4g0PKYVkKGST35DnSNwL1KGJIPoP1
        9a7xngDHa6+NWYk4bjfFM5x6+mKtog==
X-Google-Smtp-Source: ABdhPJyGW1TUwaevOXIBOiYNkYrlF4+cuSOA6lvXI2KLAfneT0Oy+X6YDbPqkJCXzeLvwXi5szqGJg==
X-Received: by 2002:aca:bbc2:: with SMTP id l185mr424763oif.172.1605548643381;
        Mon, 16 Nov 2020 09:44:03 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k11sm4871965otr.14.2020.11.16.09.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:44:02 -0800 (PST)
Received: (nullmailer pid 1862027 invoked by uid 1000);
        Mon, 16 Nov 2020 17:44:01 -0000
Date:   Mon, 16 Nov 2020 11:44:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, youlin.pei@mediatek.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        Evan Green <evgreen@chromium.org>, anan.sun@mediatek.com,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chao.hao@mediatek.com, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@google.com>,
        srv_heupstream@mediatek.com, kernel-team@android.com,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 04/24] dt-bindings: memory: mediatek: Add domain
 definition
Message-ID: <20201116174401.GA1861980@bogus>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-5-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111123838.15682-5-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 20:38:18 +0800, Yong Wu wrote:
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

Acked-by: Rob Herring <robh@kernel.org>
