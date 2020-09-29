Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079E027BD04
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 08:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgI2GVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 02:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI2GVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:21:51 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C12C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 23:21:50 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u4so3004750ljd.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 23:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xScgugWUI7XPriw4lHg9Y3x0ePJygxK+gWE0slOgaQw=;
        b=LAl5lvFQchm49TQAHMsx3c1dikcC7cb3THCmfMsDrigijcL/jG9L1vZ29VZlXg3xZp
         X8Gw/VBPkU/1+wB6IQBAtZFpPoZ2n+mQIwhPmnmLZ/ZUxT78TF1hsit5ieR4j103gpKF
         RTTz3W14zq4MGly44cIBGCShuQzCF/7avtyjpWLR7MlGVl06pS1hdAaj07ZOyuRuaxaz
         WTt6j1xzAxNGWl13glCcT3Qkw8tc/uctxi1iLV1/OaqgOAWGRlzZV/4lA5lYg5+i/m+a
         Omz5q3ejnPsU1axVJ0wVsCGqbXjZowZDj8XMemktnp3tgZ23p0ItbCSXR162kTvoEbGO
         WtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xScgugWUI7XPriw4lHg9Y3x0ePJygxK+gWE0slOgaQw=;
        b=YlnhQoemEEpQumzybL05DfX58C9z1SKd9BxSM2fxOspCp1m+AROKXgUPRZSemJ5/Qo
         /uV6m5xY4TUGrSuxlSDwF67uEydzZ5Xh4buR+yBTFW+DvY5eSDQIWLC1yufU4hWiYuoA
         wO2QIAeYVIlnMjo97rBCa5Zfw610caBZ8tmDVvKj1n9t1kVEMEuThaV6tPMPX3cBxpIh
         F8O1hsc2yCX2HL4IAP9hwP9VwBtYHaFty6VqiAQJa9929fV9+83g+GvFBtGQppmtilfr
         jwegid4decxeInndh0sIsC5oXDw+KWXeUWiDpLCuXTimyqK+2wc4xMTLPeomlI9Bfkis
         uvgA==
X-Gm-Message-State: AOAM533pvPH5CccCSvFKMyL6wmhr98UHThIMhC0WXvUHVVRshoMb57dz
        yv5CTB31eHIgnHYCn0SS4QnsPgVqu/8Tdaeu4jo=
X-Google-Smtp-Source: ABdhPJxayp1GMZkZ4bH2XDWkc61FhC/N6Nzt20fyYUquGrWTWv61orr9z+CEFZMHzgdHWrXjmTPPSl0Gq3xiuUuYMSY=
X-Received: by 2002:a05:651c:28c:: with SMTP id b12mr682984ljo.293.1601360509052;
 Mon, 28 Sep 2020 23:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200920113808.22223-1-vichy.kuo@gmail.com> <20200920113808.22223-2-vichy.kuo@gmail.com>
In-Reply-To: <20200920113808.22223-2-vichy.kuo@gmail.com>
From:   pierre kuo <vichy.kuo@gmail.com>
Date:   Tue, 29 Sep 2020 14:21:37 +0800
Message-ID: <CAOVJa8F+NZQM4H=1Y683g7DTZQ2z1YSH0pKRCVcN+JmQfEi81g@mail.gmail.com>
Subject: Re: [PATCH 2/2] driver core: platform: provide devm_platform_iounremap_resource
To:     Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg and Rafael:
Would you please help to review these 2 patches?

https://lkml.org/lkml/2020/9/20/112
https://lkml.org/lkml/2020/9/20/113

Appreciate ur help in advance.

>
> Combine platform_get_resource() and devm_iounremap_resource() to release
> the iomem allocated by devm_platform_get_and_ioremap_resource().
>
> Signed-off-by: pierre Kuo <vichy.kuo@gmail.com>
> ---
>  drivers/base/platform.c         | 24 ++++++++++++++++++++++++
>  include/linux/platform_device.h |  4 ++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index e5d8a0503b4f..e2655c00873f 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -84,6 +84,30 @@ devm_platform_get_and_ioremap_resource(struct platform_device *pdev,
>  }
>  EXPORT_SYMBOL_GPL(devm_platform_get_and_ioremap_resource);
>
> +/**
> + * devm_platform_iounremap_resource - call devm_iounremap_resource() for a
> + *                                   platform device with memory that addr points to.
> + *
> + * @pdev: platform device to use both for memory resource lookup as well as
> + *        resource management
> + * @index: resource index
> + * @addr: address to be unmap.
> + */
> +void
> +devm_platform_iounremap_resource(struct platform_device *pdev,
> +                                unsigned int index, void __iomem *addr)
> +{
> +       struct resource *r;
> +
> +       r = platform_get_resource(pdev, IORESOURCE_MEM, index);
> +       if (!r)
> +               dev_err(&pdev->dev,
> +                       "MEM resource index %d not found\n", index);
> +       else
> +               devm_iounremap_resource(&pdev->dev, r, addr);
> +}
> +EXPORT_SYMBOL_GPL(devm_platform_iounremap_resource);
> +
>  /**
>   * devm_platform_ioremap_resource - call devm_ioremap_resource() for a platform
>   *                                 device
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 77a2aada106d..75da15937679 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -67,6 +67,10 @@ devm_platform_ioremap_resource_wc(struct platform_device *pdev,
>  extern void __iomem *
>  devm_platform_ioremap_resource_byname(struct platform_device *pdev,
>                                       const char *name);
> +extern void
> +devm_platform_iounremap_resource(struct platform_device *pdev,
> +                                unsigned int index,
> +                                void __iomem *addr);
>  extern int platform_get_irq(struct platform_device *, unsigned int);
>  extern int platform_get_irq_optional(struct platform_device *, unsigned int);
>  extern int platform_irq_count(struct platform_device *);
> --
> 2.17.1
>
