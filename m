Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097682E19EA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgLWI0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbgLWI0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:26:14 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0958C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 00:25:33 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id g15so5252987pgu.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 00:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WThy4tT62F3b3zf0PgQRiQWDvTgvmZESA9P7XUtvIQc=;
        b=lm/gAASMc8UZvLfJCPhTrygCJnvjXm/AgIJtR846gqbmtV/Z9xMScDs4z2klDYCZXa
         xitLyUpJQ7GhOJ4B/3K9Bn/OGgr46nwQda0iPJyr/MPDZ/E4Jlfcgu5f3ieDmOgniDjp
         VYvE8Ofugj7cXljMRJQzCHIZhclSCNeJ4ktpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WThy4tT62F3b3zf0PgQRiQWDvTgvmZESA9P7XUtvIQc=;
        b=UMdjjBabjXlDtYNIjmdYaYAYsisFHT/lF92asXwkk5l1okcMFvPNlfkLubBkogRZ0U
         J670Z3wpn3h87vjOgCefXdK111IeHiJOzoZmXXFBxTU+E4SKcawz6sFP3s5MvauFgxv8
         BfY7TwytRBzH/125O1qeXxAdGJ0Rdhu3Tn2o6VJ2cGyFrTfF16ttSLI4I/u6uPwaDt0k
         CKl5iOQ3IBIbEYMqWHr9STFVpVUDw7ZXtWiVbnSRYAqAzHOYM6fRrJrP8KciJdNfN250
         H8pQEGgDmG7zM1Q9UhJgjQbsg+FUjmJfV2W/ZEAfPou4MwnFlkMh529SfjkprYEYS4mk
         IcUg==
X-Gm-Message-State: AOAM531CwtxAGyWjkfa8cl6Pxp3eXIylwnp2oDB/y2S2Ax97cmpWueFY
        zVR99wqzSXKbQHyvt74gc8yZ3A==
X-Google-Smtp-Source: ABdhPJypg4hGOlyNgx6/zOot9YXwUix2EbRuZvx1p0wnv9B3ytcx7t9ecSD2W9nXEkM/rMgQwZKs4w==
X-Received: by 2002:a05:6a00:1392:b029:1a3:c284:521f with SMTP id t18-20020a056a001392b02901a3c284521fmr23329507pfg.81.1608711933463;
        Wed, 23 Dec 2020 00:25:33 -0800 (PST)
Received: from chromium.org ([2401:fa00:8f:2:a28c:fdff:fef0:43bf])
        by smtp.gmail.com with ESMTPSA id p9sm22298444pjb.3.2020.12.23.00.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 00:25:32 -0800 (PST)
Date:   Wed, 23 Dec 2020 17:25:27 +0900
From:   Tomasz Figa <tfiga@chromium.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, youlin.pei@mediatek.com,
        devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream@mediatek.com, chao.hao@mediatek.com,
        linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>, anan.sun@mediatek.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 15/27] iommu/mediatek: Add fail handle for sysfs_add
 and device_register
Message-ID: <X+L+97OBxC6I5pUv@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-16-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209080102.26626-16-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 04:00:50PM +0800, Yong Wu wrote:
> Add fail handle for iommu_device_sysfs_add and iommu_device_register.
> 
> Fixes: b16c0170b53c ("iommu/mediatek: Make use of iommu_device_register interface")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 39478cfbe0f1..09c8c58feb78 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -746,7 +746,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  
>  	ret = iommu_device_register(&data->iommu);
>  	if (ret)
> -		return ret;
> +		goto out_sysfs_remove;
>  
>  	spin_lock_init(&data->tlb_lock);
>  	list_add_tail(&data->list, &m4ulist);
> @@ -754,7 +754,16 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  	if (!iommu_present(&platform_bus_type))
>  		bus_set_iommu(&platform_bus_type, &mtk_iommu_ops);
>  
> -	return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
> +	ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
> +	if (ret)
> +		goto out_dev_unreg;
> +	return ret;
> +
> +out_dev_unreg:

Shouldn't other operations be undone as well? I can see that above
bus_set_iommu() is set and an entry is added to m4ulist.

> +	iommu_device_unregister(&data->iommu);
> +out_sysfs_remove:
> +	iommu_device_sysfs_remove(&data->iommu);
> +	return ret;
>  }
>  
>  static int mtk_iommu_remove(struct platform_device *pdev)
> -- 
> 2.18.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
