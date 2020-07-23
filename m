Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE4B22B80F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 22:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgGWUrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 16:47:33 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:39192 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgGWUrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:47:32 -0400
Received: by mail-il1-f194.google.com with SMTP id k6so5497582ili.6;
        Thu, 23 Jul 2020 13:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/ykIh0i0xy9qqdWkp/0xl4AY6xx/230nGu1DDjaI5lo=;
        b=ia6JJF9GPGzyOOL+z+bCioEzpwnTufIoSgmRqABFHpqgl02jc0gLPnmHlqjeK7M9yw
         tcHSDyfBsjMvZuLdjS5kzXUUYGHc37HrRz+nuxj5TqHQqprYqHEVC//7BufK3fO5Pkiy
         KKtBbeL3ouDRKxYNXDc747Ehm/CQzFDZDVcDk0C8OXFX/ffBiLNmBhxm7cQBz7pSFa7S
         p43XIVLB7btqVKLET1S52C4qGdOJjizORlm9m7J4kqSY3bwsAdDOfuB9w/6yPO5VwMcg
         iYxFezlp9LF+DLKSfgo8+foMZB/myxzlbpVkYhHpNw7tlGe7raOWugBGYdwWVWOw+664
         d6Cg==
X-Gm-Message-State: AOAM531qS0JhyBkmsFKiZW3y/1i+eKuIxzMbqLNg77k0VLPFsGQkOOuR
        ojGAo+ePpE2VH2yVMLPk/4b2eRSadg==
X-Google-Smtp-Source: ABdhPJxj977xyK987KA25YXvHJw0KF0pYIdsSwCRmIfXKkWWW85uigcOZS4pmbBfQX5gRynZmqjiXQ==
X-Received: by 2002:a92:c792:: with SMTP id c18mr7006999ilk.223.1595537251697;
        Thu, 23 Jul 2020 13:47:31 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w5sm2032325ilm.46.2020.07.23.13.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 13:47:30 -0700 (PDT)
Received: (nullmailer pid 833108 invoked by uid 1000);
        Thu, 23 Jul 2020 20:47:29 -0000
Date:   Thu, 23 Jul 2020 14:47:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        cui.zhang@mediatek.com, chao.hao@mediatek.com,
        ming-fan.chen@mediatek.com
Subject: Re: [PATCH 18/21] iommu/mediatek: Add support for multi domain
Message-ID: <20200723204729.GA823856@bogus>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
 <20200711064846.16007-19-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200711064846.16007-19-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 11, 2020 at 02:48:43PM +0800, Yong Wu wrote:
> Some HW IP(ex: CCU) require the special iova range. That means the
> iova got from dma_alloc_attrs for that devices must locate in his
> special range. In this patch, we allocate a special iova_range for
> each a special requirement and create each a iommu domain for each
> a iova_range.
> 
> meanwhile we still use one pagetable which support 16GB iova.
> 
> After this patch, If the iova range of a master is over 4G, the master
> should:
> a) Declare its special dma_ranges in its dtsi node. For example, If we
> preassign the iova 4G-8G for vcodec, then the vcodec dtsi node should:
> 	dma-ranges = <0x1 0x0 0x1 0x0 0x1 0x0>;  /* 4G ~ 8G */

BTW, dma-ranges should be in the parent node of the vcodec.

> b) Update the dma_mask:
>  dma_set_mask_and_coherent(dev, DMA_BIT_MASK(33));

This should happen for you automatically. The DMA PFN offset 
should also be 4GB here.

> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 49 ++++++++++++++++++++++++++++++++-------
>  drivers/iommu/mtk_iommu.h |  3 ++-
>  2 files changed, 42 insertions(+), 10 deletions(-)
