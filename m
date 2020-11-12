Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2F22AFCA1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgKLBlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbgKLBLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 20:11:00 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71140C0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 17:11:00 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id e8so944109vkk.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 17:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jz5kAZbrArqI0Wtmw+vtyP3p8jdhel21wmv2CFUUROo=;
        b=kDnlXe7tyEixWf+480/PTLTVkBUYGbtBisgVqL6qcQgy4sPKvzTV6/tSw83j47RD7q
         Rf9VAXW9kIm4P+pX/HXhGKwX9LVFIVmcuHv/6Jag9gPlQcBFdbxZcRC33/54CUyQozsU
         NIphtyIs1Otvd9bO8oM70co0kkF3ZZXDKONwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jz5kAZbrArqI0Wtmw+vtyP3p8jdhel21wmv2CFUUROo=;
        b=gzIYwPmCrffaPgiLJX6kPNrkeQTVnXDeYY8T2ORqL7RH5VVsYieTP6sBRAOP03H3Ru
         E56qnTxpBaejtI9t0WO+Kh2D4bSfe1YHLoWxUUOtxTRqsBNEi8uexzOH0trl8quZOJSe
         oUZXc1NHm1auopE/fDrszqyyVkhxa6etbX5V/178SmJ7tTnnc61bRTP86S29KYokXwWX
         NKJeKM9ySlNqH7u9ODeIVdheMRKO35KXMP+8a2GotMHD23HCXSitdpl7bPt81M7r5clP
         cxU0bV0UEo+e2rdmv7KQOftEVxnoU9i+I15VzXQ0g84kZ1yelDMg/y7yIygF7o8BSYIT
         JTfA==
X-Gm-Message-State: AOAM532nWR1sJs1Ml2pcnNdn6g6Qj+wd/YsR9St1vXmCmrkmjGpbtYJx
        M6uZurHcH0bQ4dbtbx/9FukQXBMRAfCJWVvhyarDtQ==
X-Google-Smtp-Source: ABdhPJw+9rZ4nbhsdwX6zx9uimjIrtTve1brVMfTJF95tCZp/3u+DvsL8qx0usBjUpgCHUXOc17+xjTd7E+Sg/oGTEc=
X-Received: by 2002:a1f:cd07:: with SMTP id d7mr16387452vkg.10.1605143459607;
 Wed, 11 Nov 2020 17:10:59 -0800 (PST)
MIME-Version: 1.0
References: <20201111123838.15682-1-yong.wu@mediatek.com> <20201111123838.15682-14-yong.wu@mediatek.com>
In-Reply-To: <20201111123838.15682-14-yong.wu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 12 Nov 2020 09:10:49 +0800
Message-ID: <CANMq1KBrnhAbGdKbsSmFJWONe-mkG6TJsN_jp2xuJ=4MiPyapQ@mail.gmail.com>
Subject: Re: [PATCH v4 13/24] iommu/mediatek: Add device link for smi-common
 and m4u
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, chao.hao@mediatek.com,
        Greg Kroah-Hartman <gregkh@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 8:40 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> In the lastest SoC, M4U has its special power domain. thus, If the engine
> begin to work, it should help enable the power for M4U firstly.
> Currently if the engine work, it always enable the power/clocks for
> smi-larbs/smi-common. This patch adds device_link for smi-common and M4U.
> then, if smi-common power is enabled, the M4U power also is powered on
> automatically.
>
> Normally M4U connect with several smi-larbs and their smi-common always
> are the same, In this patch it get smi-common dev from the first smi-larb
> device(i==0), then add the device_link only while m4u has power-domain.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 36 +++++++++++++++++++++++++++++++++---
>  drivers/iommu/mtk_iommu.h |  1 +
>  2 files changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index cfdf5ce696fd..4ce7e0883e4d 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -20,6 +20,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> @@ -705,7 +706,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>                 return larb_nr;
>
>         for (i = 0; i < larb_nr; i++) {
> -               struct device_node *larbnode;
> +               struct device_node *larbnode, *smicomm_node;
>                 struct platform_device *plarbdev;
>                 u32 id;
>
> @@ -731,6 +732,26 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>
>                 component_match_add_release(dev, &match, release_of,
>                                             compare_of, larbnode);
> +               if (!i) {

Maybe more of a style preference, but since you are actually comparing
an integer, I prefer seeing i == 0.

Also, might be nicer to do

if (i != 0)
   continue;

And de-indent the rest.

> +                       smicomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
> +                       if (!smicomm_node)
> +                               return -EINVAL;
> +
> +                       plarbdev = of_find_device_by_node(smicomm_node);
> +                       of_node_put(smicomm_node);
> +                       data->smicomm_dev = &plarbdev->dev;
> +               }
> +       }
> +
> +       if (dev->pm_domain) {
> +               struct device_link *link;
> +
> +               link = device_link_add(data->smicomm_dev, dev,
> +                                      DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
> +               if (!link) {
> +                       dev_err(dev, "Unable link %s.\n", dev_name(data->smicomm_dev));
> +                       return -EINVAL;
> +               }
>         }
>
>         platform_set_drvdata(pdev, data);
> @@ -738,14 +759,14 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>         ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
>                                      "mtk-iommu.%pa", &ioaddr);
>         if (ret)
> -               return ret;
> +               goto out_link_remove;
>
>         iommu_device_set_ops(&data->iommu, &mtk_iommu_ops);
>         iommu_device_set_fwnode(&data->iommu, &pdev->dev.of_node->fwnode);
>
>         ret = iommu_device_register(&data->iommu);
>         if (ret)
> -               return ret;
> +               goto out_sysfs_remove;

Technically, this change is unrelated.

>
>         spin_lock_init(&data->tlb_lock);
>         list_add_tail(&data->list, &m4ulist);
> @@ -754,6 +775,13 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>                 bus_set_iommu(&platform_bus_type, &mtk_iommu_ops);
>
>         return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
> +
> +out_sysfs_remove:
> +       iommu_device_sysfs_remove(&data->iommu);
> +out_link_remove:
> +       if (dev->pm_domain)
> +               device_link_remove(data->smicomm_dev, dev);
> +       return ret;
>  }
>
>  static int mtk_iommu_remove(struct platform_device *pdev)
> @@ -767,6 +795,8 @@ static int mtk_iommu_remove(struct platform_device *pdev)
>                 bus_set_iommu(&platform_bus_type, NULL);
>
>         clk_disable_unprepare(data->bclk);
> +       if (pdev->dev.pm_domain)
> +               device_link_remove(data->smicomm_dev, &pdev->dev);
>         devm_free_irq(&pdev->dev, data->irq, data);
>         component_master_del(&pdev->dev, &mtk_iommu_com_ops);
>         return 0;
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index d0c93652bdbe..5e03a029c4dc 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -68,6 +68,7 @@ struct mtk_iommu_data {
>
>         struct iommu_device             iommu;
>         const struct mtk_iommu_plat_data *plat_data;
> +       struct device                   *smicomm_dev;
>
>         struct dma_iommu_mapping        *mapping; /* For mtk_iommu_v1.c */
>
> --
> 2.18.0
>
