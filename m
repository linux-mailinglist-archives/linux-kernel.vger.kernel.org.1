Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C1227612C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 21:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgIWThu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 15:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIWThu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 15:37:50 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAAFC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 12:37:49 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 77so1233811lfj.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 12:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcIspOz/xBFrhTBGUdPvbW8fyFPh/S83Nv87zjRg0X4=;
        b=HiOf6Frb3msBXibmsvCbJwZbkQY7kDjQTspDr8g6tOESvCgg0fWnhSjB3U8Y5f5qQq
         REG4i0JcYRqtw9yn+QnSOHyMw8weTSZl8IccFH5UZsP4MDZLjvFximMh3JefbS8B7HCX
         IiBULzVd4XBWT6ddpbh/gfOj15yege25LYJmKvjEEVaioYYiTXQehedcp3WBQOJG4nMe
         wB9DFza2VrdxRn/00+LULSkiVNiQWAQu8JTuu3ueiNXqV24GetRRKuqw4KKCsWXqNTsL
         TSEwqYCjcwNUSEeUYexd3bBy3ihCNOMILCshsTwsV4GMH0cSDisTbJdCfWXDPR0u1Qs+
         phDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcIspOz/xBFrhTBGUdPvbW8fyFPh/S83Nv87zjRg0X4=;
        b=kWijOy/0IPJVvmKjSldKu5owGOXDCEZ8ZB0OULSg97g1SyAQw9u+KlKooIMKgdmdLS
         sKHzPjgOqL5ifhdQUIX0dXjuGD0MOUsb+ddgXXUyLkkQvxIMquVXhMyEhC0arfFlZko/
         P+DVzC6x4CT2YTtxH6ME8jrUH/LwhGnJ3RnsTxKOLsYz6vX/pPe77kYoWPhqkYqGmscg
         Hz+JgwPbi921x5N5l48k4Nrqg0WmfR+Zx4IXM+shDlZjvc7yQgK48vVazlpUbAsM716Q
         fHT2OjBxec5ffMbuzMKoFed5g2b9ujVDR6HeTRrwRuJsOcn2calcDbsBq9yPGygnqaYs
         douw==
X-Gm-Message-State: AOAM5324xv3FEOm71RzapBDrHxSyPk8i1uKPlUTJH6+NlFcBdgvaCCMD
        qt5Vd74KGq8gxdBtLwDTEtbQFcsbWxErmVUVo819iA==
X-Google-Smtp-Source: ABdhPJwlkgQ9rjroTywAXtYnjoLLwDs82fzdzYgJhTnxhUz5cih/2XEnx+yR6xzh87LjbyI/IPZ6wagvb27yEMBkCR8=
X-Received: by 2002:a19:8906:: with SMTP id l6mr496502lfd.136.1600889867707;
 Wed, 23 Sep 2020 12:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200923184803.192265-1-gregkh@linuxfoundation.org>
In-Reply-To: <20200923184803.192265-1-gregkh@linuxfoundation.org>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 23 Sep 2020 12:37:10 -0700
Message-ID: <CACK8Z6FKgtFQU+0j1PMGqEwSi_9x9v-jJFFB4k5Ok-FCjpqVMw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_pmc_core: do not create a static
 struct device
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 11:47 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> A struct device is a dynamic structure, with reference counting.
> "Tricking" the kernel to make a dynamic structure static, by working
> around the driver core release detection logic, is not nice.
>
> Because of this, this code has been used as an example for others on
> "how to do things", which is just about the worst thing possible to have
> happen.
>
> Fix this all up by making the platform device dynamic and providing a
> real release function.
>
> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
> Cc: Vishwanath Somayaji <vishwanath.somayaji@intel.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Rajat Jain <rajatja@google.com>
> Cc: platform-driver-x86@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Reported-by: Maximilian Luz <luzmaximilian@gmail.com>
> Fixes: b02f6a2ef0a1 ("platform/x86: intel_pmc_core: Attach using APCI HID "INT33A1"")
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rajat Jain <rajatja@google.com>

> ---
>  drivers/platform/x86/intel_pmc_core_pltdrv.c | 26 +++++++++++++-------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_core_pltdrv.c b/drivers/platform/x86/intel_pmc_core_pltdrv.c
> index 731281855cc8..73797680b895 100644
> --- a/drivers/platform/x86/intel_pmc_core_pltdrv.c
> +++ b/drivers/platform/x86/intel_pmc_core_pltdrv.c
> @@ -20,15 +20,10 @@
>
>  static void intel_pmc_core_release(struct device *dev)
>  {
> -       /* Nothing to do. */
> +       kfree(dev);
>  }
>
> -static struct platform_device pmc_core_device = {
> -       .name = "intel_pmc_core",
> -       .dev  = {
> -               .release = intel_pmc_core_release,
> -       },
> -};
> +static struct platform_device *pmc_core_device;
>
>  /*
>   * intel_pmc_core_platform_ids is the list of platforms where we want to
> @@ -52,6 +47,8 @@ MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_platform_ids);
>
>  static int __init pmc_core_platform_init(void)
>  {
> +       int retval;
> +
>         /* Skip creating the platform device if ACPI already has a device */
>         if (acpi_dev_present("INT33A1", NULL, -1))
>                 return -ENODEV;
> @@ -59,12 +56,23 @@ static int __init pmc_core_platform_init(void)
>         if (!x86_match_cpu(intel_pmc_core_platform_ids))
>                 return -ENODEV;
>
> -       return platform_device_register(&pmc_core_device);
> +       pmc_core_device = kzalloc(sizeof(*pmc_core_device), GFP_KERNEL);
> +       if (!pmc_core_device)
> +               return -ENOMEM;
> +
> +       pmc_core_device->name = "intel_pmc_core";
> +       pmc_core_device->dev.release = intel_pmc_core_release;
> +
> +       retval = platform_device_register(pmc_core_device);
> +       if (retval)
> +               kfree(pmc_core_device);
> +
> +       return retval;
>  }
>
>  static void __exit pmc_core_platform_exit(void)
>  {
> -       platform_device_unregister(&pmc_core_device);
> +       platform_device_unregister(pmc_core_device);
>  }
>
>  module_init(pmc_core_platform_init);
> --
> 2.28.0
>
